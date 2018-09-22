#include <stdint.h>
#include <string.h>
#include <stdbool.h>
#include <stdio.h>


typedef struct int48 {
	  uint16_t bit[3]  ; 
} uint48_t;

#define PROMMEMORYADDR 0x00

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
          //printf("%d \n",k);
         dbuffer[j-4*i]=buffer[j];
         }
      } 
  res.bit[i]=hex_str_to_uint16(dbuffer);
  if(k==length-1){
   //printf("%d,%d \n",k, length);
   //printf("b2 \n");
             break;
     }    
  }
      
return res;
}

	
uint32_t prng_next(){
uint32_t x;
x = rand() & 0xff;
x |= (rand() & 0xff) << 8;
x |= (rand() & 0xff) << 16;
x |= (rand() & 0xff) << 24;

return x;
	}
#define REG16 (volatile uint16_t*)
#define REG32 (volatile uint32_t*)

#define USI_CT      (*(REG16 0xFFA0)) // r/w: control register
#define USI_SPIRTX  (*(REG16 0xFFA2)) // r/w: spi receive/transmit register
#define USI_CT_SPIBSY     6 // r/-: spi transceiver is busy

uint8_t spi_trans(uint8_t d) {

  USI_SPIRTX = (uint16_t)d; // trigger transfer
  while((USI_CT & (1<<USI_CT_SPIBSY)) != 0); // wait for current transfer to finish

  return (uint8_t)USI_SPIRTX;
}

int main(void){

printf("%x\n",spi_trans(8));

//printf("%x \n",number);
//printf("%x \n",WB32_LRA);
//printf("%x",WB32_RA_32bit);

/*
char buffer[8];
buffer[0]='1';
buffer[1]='2';
buffer[2]='3';
buffer[3]='4';
buffer[4]='f';
buffer[5]='f';
buffer[6]='f';
buffer[7]='8';
*/
/*
int buffer[8];
buffer[0]=1;
buffer[1]=2;
buffer[2]=3;
buffer[3]=4;
buffer[4]=5;
buffer[5]=6;
buffer[6]=7;
buffer[7]=8;
/*
int a=5;
int* p1;
int *p2;
p1= &a;
p2= &a;
//printf("p=&a %d \n",p1);
//printf("*p %d",*p2);




/*
buffer[8]='9';
buffer[9]='a';
buffer[10]='b';
buffer[11]='c';

uint48_t a=hex_str_to_uint48(buffer);
printf("%X \n",prng_next());


uint8_t a[10];
uint8_t i;
uint32_t data = hex_str_to_uint32(buffer);
printf("%X \n",data);
  // Pack data to write into buffer

   a[0] = PROMMEMORYADDR;
  
  for (i=0; i< 4; i++){
    a[i+1] = (data >> (i*8)) & 0xFF ;
    printf("%d %X \n", i+1, a[i+1]);    
  }
*/
//printf("%X \n",prng_next());
return 0;

}