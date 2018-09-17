
#ifndef _SPI_H_
#define _SPI_H_

//#include <neo430/io.h>

#include "neo430_spi_def.h"


//! Time-out value (number of attempts).
#define SPI_TIMEOUT       10000


//! Status codes used by the SPI driver.
typedef enum
{
  SPI_ERROR = -1,
  SPI_OK = 0,
  SPI_ERROR_TIMEOUT = 1,
  SPI_ERROR_ARGUMENT,
  SPI_ERROR_OVERRUN,
  SPI_ERROR_MODE_FAULT,
  SPI_ERROR_OVERRUN_AND_MODE_FAULT
} spi_status_t;

//! Option structure for SPI channels.

/*

extern spi_status_t spi_selectChip(volatile neo430_spi_t *spi, unsigned char chip);
extern spi_status_t spi_unselectChip(volatile neo430_spi_t *spi, unsigned char chip);

extern spi_status_t spi_write(volatile neo430_spi_t *spi, unsigned short data);
extern spi_status_t spi_read(volatile neo430_spi_t *spi, unsigned short *data);
*/

spi_status_t spi_selectChip(volatile neo430_spi_t *spi, unsigned char chip)
{
/*
#ifdef FREERTOS_USED
  while (pdFALSE == xSemaphoreTake(xSPIMutex, 20));
#endif
*/
  // Assert all lines; no peripheral is selected.
  spi->mr |= NEO430_SPI_MR_PCS_MASK;

  if (spi->mr & NEO430_SPI_MR_PCSDEC_MASK) {
    // The signal is decoded; allow up to 15 chips.
    if (chip > 14) {
      return SPI_ERROR_ARGUMENT;
    }

    spi->mr &= ~NEO430_SPI_MR_PCS_MASK | (chip << NEO430_SPI_MR_PCS_OFFSET);
  } else {
    if (chip > 3) {
      return SPI_ERROR_ARGUMENT;
    }

    spi->mr &= ~(1 << (NEO430_SPI_MR_PCS_OFFSET + chip));
  }

  return SPI_OK;
}

spi_status_t spi_unselectChip(volatile neo430_spi_t *spi, unsigned char chip)
{
  unsigned int timeout = SPI_TIMEOUT;

  while (!(spi->sr & NEO430_SPI_SR_TXEMPTY_MASK)) {
    if (!timeout--) {
      return SPI_ERROR_TIMEOUT;
    }
  }

  // Assert all lines; no peripheral is selected.
  spi->mr |= NEO430_SPI_MR_PCS_MASK;

  // Last transfer, so deassert the current NPCS if CSAAT is set.
  spi->cr = NEO430_SPI_CR_LASTXFER_MASK;

#ifdef FREERTOS_USED
  xSemaphoreGive(xSPIMutex);
#endif

  return SPI_OK;
}


spi_status_t spi_write(volatile neo430_spi_t *spi, unsigned short data)
{
  unsigned int timeout = SPI_TIMEOUT;

  //printf("> 0x%02X\n", data);

  while (!(spi->sr & NEO430_SPI_SR_TDRE_MASK)) {
    if (!timeout--) {
      return SPI_ERROR_TIMEOUT;
    }
  }

  spi->tdr = data << NEO430_SPI_TDR_TD_OFFSET;

  return SPI_OK;
}


spi_status_t spi_read(volatile neo430_spi_t *spi, unsigned short *data)
{
  unsigned int timeout = SPI_TIMEOUT;

  while ((spi->sr & (NEO430_SPI_SR_RDRF_MASK | NEO430_SPI_SR_TXEMPTY_MASK)) !=
         (NEO430_SPI_SR_RDRF_MASK | NEO430_SPI_SR_TXEMPTY_MASK)) {
    if (!timeout--) {
      return SPI_ERROR_TIMEOUT;
    }
  }

  *data = spi->rdr >> NEO430_SPI_RDR_RD_OFFSET;

  //printf("< 0x%02X\n", *data);

  return SPI_OK;
}



#endif  // _SPI_H_


