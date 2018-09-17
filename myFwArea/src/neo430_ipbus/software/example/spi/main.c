
#include "../../lib/neo430/neo430_eeprom.c"
#include "../../lib/neo430/neo430_ipbus.h"

bool ConfigurationSpace;
bool incrementing; 
//uint32_t Address;
uint32_t reply;



/* ------------------------------------------------------------
 * INFO Main function
 * ------------------------------------------------------------ */
int main(void) {

  //uint16_t length = 0;
  uint16_t length = 0;
  uint16_t selection = 0;
  uint32_t uid;
  uint32_t Data;
  uint48_t uid_mac; 
  // setup UART
  uart_set_baud(BAUD_RATE);
  USI_CT = (1<<USI_CT_EN);


  uart_br_print("\n--------------------------------------\n"
                  "--- I2C Wishbone Explorer Terminal --\n"
                  "--------------------------------------\n\n");

  // check if WB unit was synthesized, exit if no WB is available
  if (!(SYS_FEATURES & (1<<SYS_WB32_EN))) {
    uart_br_print("Error! No Wishbone adapter synthesized!");
    return 1;
  }


  //wb_config = 4;

  setup_i2c();
       
  for (;;) {

    uart_br_print("\nEnter a command:> ");

    length = uart_scan(command, MAX_CMD_LENGTH);
    uart_br_print("\n");

    if (!length) // nothing to be done
     continue;

        // decode input
    selection = 0;
    if (!strcmp(command, "help"))
      selection = 1;
    if (!strcmp(command, "enable"))
      selection = 2;
    if (!strcmp(command, "id"))
      selection = 3;
    if (!strcmp(command, "write_prom"))
      selection = 4;
    if (!strcmp(command, "read_prom"))
      selection = 5;
    if (!strcmp(command, "write_bus"))
      selection = 6;
    if (!strcmp(command, "read_bus"))
      selection = 7;
    if (!strcmp(command, "reset"))
      selection = 8;
        // execute command
    switch(selection) {

      case 1: // print help menu
        uart_br_print("Available commands:\n"
                      " help        - show this text\n"

                      " enable      - enable I2C bridge on Enclustra\n"
                      " id          - Read from E24AA025E48T Unique ID\n"

                      " write_ip    - write 8 hex char (32 bit)  \n"
                      " read_ip     - read IP address  \n"
                      
                      "write_mac    - write 12 hex char (48 bit)"
                      "read_mac     - read mac address"
                      
                      " write_bus   - write to Bus memory \n"
                      " read_bus    - read from Bus memory \n"

                      " reset       - reset CPU\n"
                      );
        break;

      case 2: // Enable I2C Bridge
	     
	enable_i2c_bridge();
        break;

      case 3: // read from Unique ID address
	uid = read_E24AA025E48T();
	uart_br_print("\nUID from E24AA025E48T = ");
	uart_print_hex_dword(uid);
	uart_br_print("\n");
        break;

      case 4: // write to PROM
	write_Prom();
        break;

      case 5: // read from PROM
	uid = read_Prom();
	uart_br_print("\nData from PROM = ");
	uart_print_hex_dword(uid);
	uart_br_print("\n");
	uart_br_print("\nIP Address = 192.168.");
	uint8_to_decimal_str( (uint8_t)(uid>>8)&0xFF  , command);
	uart_br_print( command  );
	uart_br_print( "."  );
	uint8_to_decimal_str( (uint8_t)(uid)&0xFF  , command);
	uart_br_print( command  );
	uart_br_print( "\n"  );

        break;
        
        case 6:
   write_mac();     
        break;
        
        case 7:
   uid_mac = read_mac();
   uart_br_print("\nData from PROM = ");
	 uart_print_uint48(uid_mac);
	 uart_br_print("\n");
     
        break;

      case 8: // write to Bus memory 
        uart_br_print("\nIPBus write");
        uart_br_print("\n Enter hexadecimal data address on A32: 0x");
        uart_scan(command , 9); // 8 hex chars for address plus '\0'
        uint32_t Address = hex_str_to_uint32(command);
        
        uart_br_print("\n Incrementing ? (Y/N)"); 
        uart_scan(command,MAX_CMD_LENGTH); 

        if(!strcmp(command,"Y")){ 
           incrementing = true;
          }
         else{
           incrementing = false;
          };

          uart_br_print("\n Use Configuration Space ? (Y/N)"); 
          uart_scan(command,1); // 8 hex chars for address plus '\0'

         if(!strcmp(command,"Y")){ 
           ConfigurationSpace = true;
           }
          else{
           ConfigurationSpace = false;
           };
         Data=read_Prom();
          spi_ipbus_write (Address , &Data  , 1 , incrementing , ConfigurationSpace );
         

        break;

      case 9: // read from Bus memory 

        uart_br_print("\nIPBus Read");
        uart_br_print("\n Enter hexadecimal address on A32: 0x");
        uart_scan(command , 9); // 8 hex chars for address plus '\0'
            Address = hex_str_to_uint32(command);
        
        uart_br_print("\n Incrementing ? (Y/N)"); 
        uart_scan(command,MAX_CMD_LENGTH); 

        if(!strcmp(command,"Y")){ 
           incrementing = true;
          }
         else{
           incrementing = false;
          };

          uart_br_print("\n Use Configuration Space ? (Y/N)"); 
          uart_scan(command,1); // 8 hex chars for address plus '\0'

         if(!strcmp(command,"Y")){ 
           ConfigurationSpace = true;
           }
          else{
           ConfigurationSpace = false;
           };
          spi_ipbus_read (Address , &reply , 1 , false , true );
          uart_print_hex_dword(reply);
         
        break;

      case 10: // restart
        while ((USI_CT & (1<<USI_CT_UARTTXBSY)) != 0); // wait for current UART transmission
        //soft_reset();
        break;

      default: // invalid command
        uart_br_print("Invalid command. Type 'help' to see all commands.\n");
        break;
    }
    

  }
return 0;
}
