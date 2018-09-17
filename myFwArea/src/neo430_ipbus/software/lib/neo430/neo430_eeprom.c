
// I2C routines modified from I2CuHal.py

// Libraries
#include <stdint.h>
#include <string.h>
#include <stdbool.h>

#include "neo430.h"

typedef struct int48 {
	  uint16_t bit[3]  ; 
} uint48_t;

// Global variables
uint8_t wb_config = 1;

// Prototypes
void setup_i2c(void);
int16_t read_i2c_address(uint8_t addr , uint8_t n , uint8_t data[]);
bool checkack(uint32_t delayVal);
int16_t write_i2c_address(uint8_t addr , uint8_t nToWrite , uint8_t data[], bool stop);
void dump_wb(void);
uint32_t hex_str_to_uint32(char *buffer);
void delay(uint32_t n );
bool enable_i2c_bridge();
int16_t read_E24AA025E48T();
uint16_t zero_buffer( uint8_t buffer[] , uint16_t elements);
int16_t write_Prom();
int16_t write_mac();
uint32_t read_Prom();
int16_t  read_i2c_prom( uint8_t startAddress , uint8_t wordsToRead , uint8_t buffer[] );
int16_t write_i2c_prom( uint8_t startAddress , uint8_t wordsToWrite, uint8_t buffer[] );
void uint8_to_decimal_str( uint8_t value , char *buffer) ;
void uart_print_uint48(uint48_t w);
uint16_t hex_str_to_uint16(char *buffer);
uint48_t hex_str_to_uint48(char *buffer);

// #define DEBUG 1
#define DELAYVAL 512

// Configuration
#define MAX_CMD_LENGTH 16
#define BAUD_RATE 19200

#define MAX_N    16

#define ENABLECORE 0x1 << 7
#define STARTCMD 0x1 << 7
#define STOPCMD  0x1 << 6
#define READCMD  0x1 << 5
#define WRITECMD 0x1 << 4
#define ACK      0x1 << 3
#define INTACK   0x1

#define RECVDACK 0x1 << 7
#define BUSY     0x1 << 6
#define ARBLOST  0x1 << 5
#define INPROGRESS  0x1 << 1
#define INTERRUPT 0x1

// Multiply addresses by 4 to go from byte addresses (Wishbone) to Word addresses (IPBus)
#define ADDR_PRESCALE_LOW 0x0
#define ADDR_PRESCALE_HIGH 0x4
#define ADDR_CTRL 0x8
#define ADDR_DATA 0xC
#define ADDR_CMD_STAT 0x10

// I2C address of Crypto EEPROM on AX3
#define MYSLAVE 0x64

// I2C address of UiD EEPROM on TLU
//#define EEPROMADDRESS  0x50

// I2C address of UID EEPROM on ATFC
#define EEPROMADDRESS  0x53

// PROM memory address start...
#define PROMMEMORYADDR 0x00

uint8_t buffer[MAX_N];
char command[MAX_CMD_LENGTH];


bool checkack(uint32_t delayVal) {

#ifdef DEBUG
uart_br_print("\nChecking ACK\n");
#endif

  bool inprogress = true;
  bool ack = false;
  uint8_t cmd_stat = 0;
  while (inprogress) {
    delay(delayVal);
    cmd_stat = wishbone_read8(ADDR_CMD_STAT);
    inprogress = (cmd_stat & INPROGRESS) > 0;
    ack = (cmd_stat & RECVDACK) == 0;

#ifdef DEBUG
    uart_print_hex_byte( (uint8_t)ack );
#endif

  }
  return ack;
}

/* ------------------------------------------------------------
 * Delay by looping over "no-op"
 * ------------------------------------------------------------ */
void delay(uint32_t delayVal){
  for (uint32_t i=0;i<delayVal;i++){
    asm volatile ("MOV r3,r3");
  }
}


/* ------------------------------------------------------------
 * Zero buffer
 * ------------------------------------------------------------ */
uint16_t zero_buffer (uint8_t buffer[] , uint16_t elements) {

  for (uint16_t i=0;i<elements;i++){
    buffer[i] = 0;
  }

  return elements;
}

/* ------------------------------------------------------------
 * INFO Configure Wishbone adapter
 * ------------------------------------------------------------ */
void setup_i2c(void) {

  uint16_t prescale = 0x0400;

  uart_br_print("Setting up I2C core");

// Disable core
  wishbone_write8(ADDR_CTRL, 0);

// Setup prescale
  wishbone_write8(ADDR_PRESCALE_LOW , (prescale & 0x00ff) );
  wishbone_write8(ADDR_PRESCALE_HIGH, (prescale & 0xff00) >> 8);

// Enable core
  wishbone_write8(ADDR_CTRL, ENABLECORE);

  // Delay for at least 100us before proceeding
  delay(1000);

  uart_br_print("\nSetup done.\n");

}


/* ------------------------------------------------------------
 * INFO Read data from Wishbone address
 * ------------------------------------------------------------ */
int16_t read_i2c_address(uint8_t addr , uint8_t n , uint8_t data[]) {

  //static uint8_t data[MAX_N];

  uint8_t val;
  bool ack;

#ifdef DEBUG
  uart_br_print("\nReading From I2C.\n");
#endif

  addr &= 0x7f;
  addr = addr << 1;
  addr |= 0x1 ; // read bit
  wishbone_write8(ADDR_DATA , addr );
  wishbone_write8(ADDR_CMD_STAT, STARTCMD | WRITECMD );
  ack = checkack(DELAYVAL);
  if (! ack) {
#ifdef DEBUG
      uart_br_print("\nread_i2c_address: No ACK. Sending STOP and terminating read.\n");
#endif      
      wishbone_write8(ADDR_CMD_STAT, STOPCMD);
      return 0;
      }

  for (uint8_t i=0; i< n ; i++){

      if (i < (n-1)) {
          wishbone_write8(ADDR_CMD_STAT, READCMD);
        } else {
          wishbone_write8(ADDR_CMD_STAT, READCMD | ACK | STOPCMD); // <--- This tells the slave that it is the last word
        }
      ack = checkack(DELAYVAL);

#ifdef DEBUG
      uart_br_print("\nread_i2c_address: ACK = ");
      uart_print_hex_byte( (uint8_t) ack );
      uart_br_print("\n");
#endif
      
      val = wishbone_read8(ADDR_DATA);
      data[i] = val & 0xff;
    }

  return (int16_t) n;

}

int16_t write_i2c_address(uint8_t addr , uint8_t nToWrite , uint8_t data[], bool stop) {


  int16_t nwritten = -1;
  uint8_t val;
  bool ack;
  addr &= 0x7f;
  addr = addr << 1;

#ifdef DEBUG
  uart_br_print("\nWriting to I2C.\n");
#endif

  // Set transmit register (write operation, LSB=0)
  wishbone_write8(ADDR_DATA , addr );
  //  Set Command Register to 0x90 (write, start)
  wishbone_write8(ADDR_CMD_STAT, STARTCMD | WRITECMD );

  ack = checkack(DELAYVAL);

  if (! ack){
#ifdef DEBUG
    uart_br_print("\nwrite_i2c_address: No ACK in response to device-ID. Sending STOP and terminating.\n");
#endif
    wishbone_write8(ADDR_CMD_STAT, STOPCMD);
    return nwritten;
  }

  nwritten += 1;

  for ( uint8_t i=0;i<nToWrite; i++){
      val = (data[i]& 0xff);
      //Write slave data
      wishbone_write8(ADDR_DATA , val );
      //Set Command Register to 0x10 (write)
      wishbone_write8(ADDR_CMD_STAT, WRITECMD);
      ack = checkack(DELAYVAL);
      if (!ack){
          wishbone_write8(ADDR_CMD_STAT, STOPCMD);
          return nwritten;
        }
      nwritten += 1;
    }

  if (stop) {
#ifdef DEBUG
    uart_br_print("\nwrite_i2c_address: Writing STOP\n");
#endif
    wishbone_write8(ADDR_CMD_STAT, STOPCMD);
  } else {
#ifdef DEBUG
    uart_br_print("\nwrite_i2c_address: Returning without writing STOP\n");
#endif
  }
    return nwritten;
}


/* ---------------------------*
 *  Read bytes from PROM      *
 * ---------------------------*/
int16_t  read_i2c_prom( uint8_t startAddress , uint8_t  wordsToRead, uint8_t buffer[] ){

  bool mystop = false;

  buffer[0] = startAddress;
#ifdef DEBUG
  uart_br_print(" read_i2c_prom: Writing device ID: ");
#endif
  write_i2c_address( EEPROMADDRESS , 1 , buffer, mystop );

#ifdef DEBUG
  uart_br_print("read_i2c_prom: Reading memory of EEPROM: ");
#endif
  zero_buffer(buffer , wordsToRead);


  read_i2c_address( EEPROMADDRESS , wordsToRead , buffer);

#ifdef DEBUG
  uart_br_print("Data from EEPROM\n");
  for (uint8_t i=0; i< wordsToRead; i++){
    uart_br_print("\n");
    uart_print_hex_dword(buffer[i]);    
  }
#endif

  return wordsToRead;
}

/* ---------------------------*
 *  Read UID from E24AA025E   *
 * ---------------------------*/
int16_t read_E24AA025E48T(){

  uint8_t startAddress = 0xFA;
  uint8_t wordsToRead = 6;
  //  int16_t status;
  uint16_t uid ;

  //status =  read_i2c_prom( startAddress , wordsToRead, buffer );
  read_i2c_prom( startAddress , wordsToRead, buffer );

  uid = buffer[5] + (buffer[4]<<8);

  return uid; // Returns bottom 16-bits of UID

}

/* ---------------------------*
 *  Read 4 bytes from E24AA025E   *
 * ---------------------------*/
uint32_t read_Prom() {

  uint8_t wordsToRead = 4;
  //  int16_t status;
  uint32_t uid ;

  //status =  read_i2c_prom( startAddress , wordsToRead, buffer );
  read_i2c_prom( PROMMEMORYADDR , wordsToRead, buffer );

  uid = (uint32_t)buffer[0] + ((uint32_t)buffer[1]<<8) + ((uint32_t)buffer[2]<<16) + ((uint32_t)buffer[3]<<24);

  return uid; // Returns 32 word read from PROM

}

uint48_t read_mac() {

  uint8_t wordsToRead = 6;
  //  int16_t status;
  uint48_t uid ;

  //status =  read_i2c_prom( startAddress , wordsToRead, buffer );
  read_i2c_prom( PROMMEMORYADDR , wordsToRead, buffer );

for(uint8_t i = 0;i<3;i++){
  uid.bit[2-i] = (uint16_t)buffer[2*i] + ((uint16_t)buffer[2*i+1]<<8);
}
  return uid; // Returns 32 word read from PROM

}

/* ---------------------------*
 *  Write to E24AA025E   *
 * ---------------------------*/

int16_t write_Prom(){

  uint8_t wordsToWrite = 4;
 
  int16_t status = 0;
  bool mystop = true;

  uart_br_print("Enter hexadecimal data to write to PROM: 0x");

  uart_scan(command, 9); // 8 hex chars for address plus '\0'
  uint32_t data = hex_str_to_uint32(command);

  // Pack data to write into buffer
  buffer[0] = PROMMEMORYADDR;
  
  for (uint8_t i=0; i< wordsToWrite; i++){
    buffer[i+1] = (data >> (i*8)) & 0xFF ;    
  }

  status = write_i2c_address(EEPROMADDRESS , (wordsToWrite+1), buffer, mystop);

  return status;

}

int16_t write_mac(){

  uint8_t wordsToWrite = 6;
 
  int16_t status = 0;
  bool mystop = true;

  uart_br_print("Enter hexadecimal data to write to PROM: 0x");

  uart_scan(command, 13); // 8 hex chars for address plus '\0'
  uint48_t data = hex_str_to_uint48(command);

  // Pack data to write into buffer
  buffer[0] = PROMMEMORYADDR;
  
  for(uint8_t i=0;i<3;i++){
     for (uint8_t j=2*i; j< 2*i+2; j++){
        buffer[j+1] = (data.bit[2-i] >> (j*8)) & 0xFF ;    
     }

  status = write_i2c_address(EEPROMADDRESS , (wordsToWrite+1), buffer, mystop);

}
return status;
}


/*
int16_t write_i2c_prom( uint8_t startAddress , uint8_t wordsToWrite, uint8_t buffer[] ){

  int16_t status = 0;
  bool mystop = true;

  buffer[0] = startAddress;

  for (uint8_t i=0; i< wordsToWrite; i++){
    buffer[i+1] = wordsToWrite;    
  }

  status = write_i2c_address(EEPROMADDRESS , (wordsToWrite+1), buffer, mystop);

  return status;
}
*/



/* ------------------------------------------------------------
 * INFO Hex-char-string conversion function
 * PARAM String with hex-chars (zero-terminated)
 * not case-sensitive, non-hex chars are treated as '0'
 * RETURN Conversion result (32-bit)
 * ------------------------------------------------------------ */
uint32_t hex_str_to_uint32(char *buffer) {

  uint16_t length = strlen(buffer);
  uint32_t res = 0, d = 0;
  char c = 0;

  while (length--) {
    c = *buffer++;

    if ((c >= '0') && (c <= '9'))
      d = (uint32_t)(c - '0');
    else if ((c >= 'a') && (c <= 'f'))
      d = (uint32_t)((c - 'a') + 10);
    else if ((c >= 'A') && (c <= 'F'))
      d = (uint32_t)((c - 'A') + 10);
    else
      d = 0;

    res = res + (d << (length*4));
  }

  return res;
}

uint16_t hex_str_to_uint16(char *buffer) {

  uint16_t length = strlen(buffer);
  uint16_t res = 0, d = 0;
  char c = 0;

  while (length--) {
    c = *buffer++;

    if ((c >= '0') && (c <= '9'))
      d = (uint16_t)(c - '0');
    else if ((c >= 'a') && (c <= 'f'))
      d = (uint16_t)((c - 'a') + 10);
    else if ((c >= 'A') && (c <= 'F'))
      d = (uint16_t)((c - 'A') + 10);
    else
      d = 0;

    res = res + (d << (length*4));
  }

  return res;
}

uint48_t hex_str_to_uint48(char *buffer){

  uint16_t length = strlen(buffer);
  uint48_t res;
  uint16_t i,j,k;
  k=0;
  for(i=0; i<3;i++){
  char dbuffer[4];
      for(j=4*i;j<4*i+4;j++){
          if(j<length){
          k=j;
         dbuffer[j-4*i]=buffer[j];
         }
      } 
  res.bit[i]=hex_str_to_uint16(dbuffer);
  if(k==length-1){
             break;
     }    
  }
      
return res;
}


/* -----------------------------------
 * Convert uint8_t into a decimal string
 * ----------------------------------- */
void uint8_to_decimal_str( uint8_t value , char *buffer) {

  uint8_t hundreds = value / 100; 
  uint8_t tens =(value / 10) - (hundreds*10);
  uint8_t ones = value % 10;

  buffer[0] = '0' + hundreds ; 
  buffer[1] = '0' + tens; 
  buffer[2] = '0' + ones; 
  buffer[3] = 0;

}

/* ------------------------------------------------------------
 * INFO Print 16-bit hexadecimal value (4 digits)
 * PARAM uint16_t value to be printed
 * ------------------------------------------------------------ */
void uart_print_uint48(uint48_t w) {

  uart_print_hex_word(w.bit[0]);
  uart_br_print( " "  );
  uart_print_hex_word(w.bit[1]);
  uart_br_print( " "  );
  uart_print_hex_word(w.bit[2]);
}

bool enable_i2c_bridge() {

  bool mystop;
  uint8_t I2CBRIDGE = 0x21;
  uint8_t wordsToRead = 1;
  uint8_t wordsForAddress = 1;
  uint8_t wordsToWrite = 2;

  uart_br_print("\nEnabling I2C bridge:\n");
  buffer[0] = 0x01;
  buffer[1] = 0x7F;
  mystop = true;
#ifdef DEBUG
   uart_br_print("\nWriting 0x01,0x7F to I2CBRIDGE. Stop = true:\n");
#endif
  write_i2c_address(I2CBRIDGE , wordsToWrite , buffer, mystop );

  mystop=false;
  buffer[0] = 0x01;
#ifdef DEBUG
   uart_br_print("\nWriting 0x01 to I2CBRIDGE. Stop = false:\n");
#endif
  write_i2c_address(I2CBRIDGE , wordsForAddress , buffer, mystop );

#ifdef DEBUG
  zero_buffer(buffer , sizeof(buffer));
#endif

#ifdef DEBUG
   uart_br_print("\nReading one word from I2CBRIDGE:\n");
#endif  
  read_i2c_address(I2CBRIDGE, wordsToRead , buffer);

  uart_br_print("Post RegDir: ");
  uart_print_hex_dword(buffer[0]);
  uart_br_print("\n");

  return true; // TODO: return a status, rather than True all the time...
 
}

