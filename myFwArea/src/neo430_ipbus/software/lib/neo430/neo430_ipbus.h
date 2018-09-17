/*
 * NEO430_ipbus.h
 *
 *  Created on: 3 Jun 2013
 *      Author: sf105
 */

#ifndef NEO430_IPBUS_H_
#define NEO430_IPBUS_H_

#include "neo430_spi.h"


bool ipbus_init ( void )
{
  printf ( "[IPBus] Init...\n" );
  return true;
}


int spi_ipbus_write ( uint32_t Address , const uint32_t* Data , uint32_t PayloadLength, bool NonIncrementing , bool UseConfigurationSpace )
{

  uint32_t lTransactionHeader , lReplyHeader , lExpectedHeader;

  if ( PayloadLength > 256 )
  {
    printf( "Maximum number of words is 256\n" );
    return -1;
  }

  if ( !UseConfigurationSpace && !NonIncrementing )
  {
    //Normal space, Incrementing
    lTransactionHeader = 0x2000001F | ( PayloadLength<<8 );
    lExpectedHeader = 0x20000010 | ( PayloadLength<<8 );
  }
  else if ( !UseConfigurationSpace && NonIncrementing )
  {
    //Normal space, Non-Incrementing
    lTransactionHeader = 0x2000003F | ( PayloadLength<<8 );
    lExpectedHeader = 0x20000030 | ( PayloadLength<<8 );
  }
  else if ( UseConfigurationSpace && !NonIncrementing )
  {
    //Configuration space, Incrementing
    lTransactionHeader = 0x2000007F | ( PayloadLength<<8 );
    lExpectedHeader = 0x20000070 | ( ( PayloadLength+1 ) <<8 ); //Hack to work around bug in firmware
  }
  else
  {
    //Configuration space, Non-Incrementing
    printf ( "Cannot use Non-Incrementing Transactions in Configuration Space\n" );
    return -1;
  }

  {
    // Start the write half of the transfer
    spi_selectChip( &NEO430_SPI0, SPI0_MEM_SEL );

    // Control Word - Write Mode. Ignore the reply.
    spi_transfer16 ( 0x0000 );

    // The total size of the IPbus packet to follow. Ignore the reply.
    spi_transfer32 ( PayloadLength + 2 );

    // The IPbus Transaction Header. Ignore the reply.
    spi_transfer32 ( lTransactionHeader );

    // The Transaction Base Address. Ignore the reply.
    spi_transfer32 ( Address );

    // The Payload. Ignore the reply.
    int i = 0;

    for ( ; i != PayloadLength; ++i )
    {
      spi_transfer32 ( Data[i] );
    }

    // End the write half of the transaction
    spi_unselectChip( &NEO430_SPI0, SPI0_MEM_SEL );
  }

  {
   // uint32_t length;
    //     do{
    // Start the read half of the transfer
    spi_selectChip( &NEO430_SPI0, SPI0_MEM_SEL );
    // Control Word - Read Mode. Ignore the reply.
    spi_transfer16 ( 0x0001 );
    // Get the total size of the IPbus packet to follow.
   // length = spi_transfer32 ( 0xFFFFFFFF );

    // Get the total size of the IPbus packet to follow.
    lReplyHeader = spi_transfer32 ( 0x0000FFFF );
    // End the read half of the transaction
    spi_unselectChip( &NEO430_SPI0, SPI0_MEM_SEL );
  }

  if ( lReplyHeader != lExpectedHeader )
  {
    printf ( "IPbus Reply Header Mismatch. Sent 0x%08lX , Got 0x%08lX , Expected 0x%08lX \n" , lTransactionHeader , lReplyHeader , lExpectedHeader );
    return -1;
  }

  return 0;
}



int spi_ipbus_read ( uint32_t Address , uint32_t* Reply , uint32_t PayloadLength, bool NonIncrementing , bool UseConfigurationSpace )
{

  uint32_t lTransactionHeader , lReplyHeader , lExpectedHeader;

  if ( PayloadLength > 256 )
  {
    printf ( "Maximum number of words is 256\n" );
    return -1;
  }

  if ( !UseConfigurationSpace && !NonIncrementing )
  {
    //Normal space, Incrementing
    lTransactionHeader = 0x2000000F | ( PayloadLength<<8 );
    lExpectedHeader = 0x20000000 | ( PayloadLength<<8 );
  }
  else if ( !UseConfigurationSpace && NonIncrementing )
  {
    //Normal space, Non-Incrementing
    lTransactionHeader = 0x2000002F | ( PayloadLength<<8 );
    lExpectedHeader = 0x20000020 | ( PayloadLength<<8 );
  }
  else if ( UseConfigurationSpace && !NonIncrementing )
  {
    //Configuration space, Incrementing
    lTransactionHeader = 0x2000006F | ( PayloadLength<<8 );
    lExpectedHeader = 0x20000060 | ( ( PayloadLength+1 ) <<8 ); //Hack to work around bug in firmware
  }
  else
  {
    //Configuration space, Non-Incrementing
    printf ( "Cannot use Non-Incrementing Transactions in Configuration Space\n" );
    return -1;
  }

  {
    // Start the write half of the transfer
    spi_selectChip( &NEO430_SPI0, SPI0_MEM_SEL );
    // Control Word - Write Mode. Ignore the reply.
    spi_transfer16 ( 0x0000 );
    // The total size of the IPbus packet to follow. Ignore the reply.
    spi_transfer32 ( 2 );
    // The IPbus Transaction Header. Ignore the reply.
    spi_transfer32 ( lTransactionHeader );
    // The Transaction Base Address. Ignore the reply.
    spi_transfer32 ( Address );
    // End the write half of the transaction
    spi_unselectChip( &NEO430_SPI0, SPI0_MEM_SEL );
  }

  {
    //uint32_t length;
    //     do{
    // Start the read half of the transfer
    spi_selectChip( &NEO430_SPI0, SPI0_MEM_SEL );
    // Control Word - Read Mode. Ignore the reply.
    spi_transfer16 ( 0x0001 );
    // Get the total size of the IPbus packet to follow.
    //length = spi_transfer32 ( 0xFFFFFFFF );

    // Get the total size of the IPbus packet to follow.
    lReplyHeader = spi_transfer32 ( 0xFFFFFFFF );
    // Get the reply except the final word
    int i = 0;

    for ( ; i != PayloadLength-1; ++i )
    {
      Reply[i] = spi_transfer32 ( 0xFFFFFFFF );
    }

    // Get the final word of the reply
    Reply[PayloadLength-1] = spi_transfer32 ( 0x0000FFFF );
    // End the read half of the transaction
    spi_unselectChip( &NEO430_SPI0, SPI0_MEM_SEL );
  }

  if ( lReplyHeader != lExpectedHeader )
  {
    printf ( "IPbus Reply Header Mismatch. Sent 0x%08lX , Got 0x%08lX , Expected 0x%08lX  \n" , lTransactionHeader , lReplyHeader , lExpectedHeader );
    return -1;
  }

  return 0;
}




#endif /* NEO430_IPBUS_H_ */
