
#ifndef NEO430_SPI_H_
#define NEO430_SPI_H_

#include "spi.h"


typedef void ( *spi_cb ) ( uint8_t xFlags );


// For now we'll clock the SPI bus at 12.5K
// It can probably run up to around 4MHz
#define SPI_SPEED_12_5K 12500
#define SPI_SPEED_1M 1000000

#define SPI_MEM_CMD_READ  0x03
#define SPI_MEM_CMD_WRITE 0x02
#define SPI_MEM_CMD_RDSR  0x05
#define SPI_MEM_CMD_WRHF  0x07

#define SPI_MEM_WRHF_CLR_MASK   (1 << 0)
#define SPI_MEM_WRHF_SET_MASK   (1 << 1)
#define SPI_MEM_WRHF_READY_MASK  (1 << 5)
#define SPI_MEM_WRHF_TRANS_MASK  (1 << 3)
#define SPI_MEM_WRHF_LSTB_MASK  (1 << 6)
#define SPI_MEM_WRHF_USTB_MASK  (1 << 7)
#define SPI_MEM_WRHF_ALL_MASK   0xFC
//#define Swap16(uint16_t) ((uint16_t)(((uint16_t)(uint16_t) >> 8) ||((uint16_t)(uint16_t) << 8)))
//#define Swap32(uint32_t) ((uint32_t)(((uint32_t)Swap16((uint32_t)(uint32_t) >> 16)) || ((uint32_t)Swap16((uint32_t)(uint32_t)) << 16)))
uint32_t Swap32(uint32_t value)
{
    uint32_t result = 0;
    result |= (value & 0x000000FF) << 24;
    result |= (value & 0x0000FF00) << 8;
    result |= (value & 0x00FF0000) >> 8;
    result |= (value & 0xFF000000) >> 24;
    return result;
}
/*
uint16_t spi_transfer16 ( uint16_t pData );
uint32_t spi_transfer32 ( uint32_t pData );
void prng_seed ( uint32_t pSeed );
uint32_t prng_next();
int spi_mem_write ( uint32_t* pData, uint32_t pLen );
int spi_mem_read ( uint32_t* pData, uint32_t pLen );
*/
uint8_t gOldSPIFlags = 0x00;
// The callback function which is called if the handshake flags change
spi_cb gSPIMemCallback = NULL;



uint16_t spi_transfer16 ( uint16_t pData )
{
  uint16_t lReturn;
  spi_write ( &NEO430_SPI0, pData );
  spi_read ( &NEO430_SPI0, &lReturn );
  return lReturn;
}

uint32_t spi_transfer32 ( uint32_t pData )
{
#ifndef BIG_ENDIAN_MCU
  pData = Swap32 ( pData );
#endif //BIG_ENDIAN_MCU
  uint32_t lReturn;
  spi_write ( &NEO430_SPI0, * ( ( uint16_t* ) ( &pData ) +1 ) );
  spi_read ( &NEO430_SPI0, ( ( uint16_t* ) ( &lReturn ) +1 ) );
  spi_write ( &NEO430_SPI0, * ( ( uint16_t* ) ( &pData ) ) );
  spi_read ( &NEO430_SPI0, ( ( uint16_t* ) ( &lReturn ) ) );
#ifndef BIG_ENDIAN_MCU
  lReturn = Swap32 ( lReturn );
#endif //BIG_ENDIAN_MCU
  return lReturn;
  
}

uint48_t spi_transfer48 ( uint48_t pData )
{
  uint48_t lReturn;
  spi_write ( &NEO430_SPI0, pData.bit[0] );
  spi_read ( &NEO430_SPI0, &lReturn.bit[0] );
  spi_write ( &NEO430_SPI0, pData.bit[1] );
  spi_read ( &NEO430_SPI0, &lReturn.bit[1] );
  spi_write ( &NEO430_SPI0, pData.bit[2] );
  spi_read ( &NEO430_SPI0, &lReturn.bit[2] );

  return lReturn;
}



int spi_mem_write ( uint32_t* pData, uint32_t pLen )
{
  uint16_t xReturn = 0;
  int i = 0;
  spi_selectChip ( &NEO430_SPI0, SPI0_MEM_SEL );
  uint16_t control = 0x0000;
  //    printf("SPI : SEND HEADER: 0x%02X\n", control );
  spi_write ( &NEO430_SPI0, control );
  spi_read ( &NEO430_SPI0, &control );
  //We need to send the counter
  uint32_t len = pLen;
#ifndef BIG_ENDIAN_MCU
  len = Swap32 ( len );
#endif //BIG_ENDIAN_MCU
  //	printf("SPI : SEND COUNTER: 0x%08lX\n", len );
  spi_write ( &NEO430_SPI0, * ( ( uint16_t* ) ( &len ) +1 ) );
  spi_read ( &NEO430_SPI0, &xReturn );
  spi_write ( &NEO430_SPI0, * ( ( uint16_t* ) ( &len ) ) );
  spi_read ( &NEO430_SPI0, &xReturn );

  // Now send the data
  for ( i = 0; i != pLen; ++i )
  {
#ifndef BIG_ENDIAN_MCU
    pData[i] = Swap32 ( pData[i] );
#endif //BIG_ENDIAN_MCU
    //	printf("SPI : WRITE: 0x%08lX\n", pData[i] );
    spi_write ( &NEO430_SPI0, * ( ( uint16_t* ) ( pData+i ) +1 ) );
    spi_read ( &NEO430_SPI0, &xReturn );
    spi_write ( &NEO430_SPI0, * ( ( uint16_t* ) ( pData+i ) ) );
    spi_read ( &NEO430_SPI0, &xReturn );
  }

  spi_unselectChip ( &NEO430_SPI0, SPI0_MEM_SEL );
  return 0;
}


int spi_mem_read ( uint32_t* pData, uint32_t pLen )
{
  int i = 0;
  spi_selectChip ( &NEO430_SPI0, SPI0_MEM_SEL );
  uint16_t control = 0x0001;
  uint16_t send = 0xFFFF;
  //  printf("SPI : SEND HEADER: 0x%02X\n", control );
  spi_write ( &NEO430_SPI0, control );
  spi_read ( &NEO430_SPI0, &control );
  //We need to receive the counter
  uint32_t len;
  spi_write ( &NEO430_SPI0, send );
  spi_read ( &NEO430_SPI0, ( ( uint16_t* ) ( &len ) +1 ) );
  spi_write ( &NEO430_SPI0, send );
  spi_read ( &NEO430_SPI0, ( ( uint16_t* ) ( &len ) ) );
#ifndef BIG_ENDIAN_MCU
  len = Swap32 ( len );
#endif //BIG_ENDIAN_MCU
  //	printf("SPI : RECEIVED COUNTER: 0x%08lX\n", len );

  if ( len < pLen )
  {
    printf ( "Received Counter is less than requested read size, returning\n" );
    spi_unselectChip ( &NEO430_SPI0, SPI0_MEM_SEL );
    return -1;
  }


  // Now send the data
  for ( i = 0; i != pLen; ++i )
  {
    spi_write ( &NEO430_SPI0, send );
    spi_read ( &NEO430_SPI0, ( ( uint16_t* ) ( pData+i ) +1 ) );

    if ( i == ( pLen-1 ) )
    {
      send = 0x0000;
    }

    spi_write ( &NEO430_SPI0, send );
    spi_read ( &NEO430_SPI0, ( ( uint16_t* ) ( pData+i ) ) );
    //		printf("SPI : REPLY: 0x%08lX\n", pData[i] );
#ifndef BIG_ENDIAN_MCU
    pData[i] = Swap32 ( pData[i] );
#endif //BIG_ENDIAN_MCU
  }

  // de-assert CS_B
  spi_unselectChip ( &NEO430_SPI0, SPI0_MEM_SEL );
  return 0;
}

uint32_t gPRNGState = 0xFFFFFFFF;

void prng_seed ( uint32_t pSeed )
{
  gPRNGState = pSeed;
}

uint32_t prng_next(){
uint32_t x;
x = rand() & 0xff;
x |= (rand() & 0xff) << 8;
x |= (rand() & 0xff) << 16;
x |= (rand() & 0xff) << 24;

return x;
	}


#endif /* NEO430_SPI_H_ */
