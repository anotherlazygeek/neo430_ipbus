
#ifndef NEO430_SPI_H_INCLUDED
#define NEO430_SPI_H_INCLUDED

#include<stdint.h>
#include<stdio.h>
#include<stdbool.h>


/*
typedef char                   U8;
typedef unsigned short        U16;
typedef unsigned int          U32;
typedef unsigned long long    U64;
*/
//ifdef __neo430_ABI_COMPILER__




typedef struct neo430_spi_cr_t {
    unsigned int                 : 7;
    unsigned int lastxfer        : 1;
    unsigned int                 :15;
    unsigned int flushfifo       : 1;
    unsigned int swrst           : 1;
    unsigned int                 : 5;
    unsigned int spidis          : 1;
    unsigned int spien           : 1;
} neo430_spi_cr_t;



typedef struct neo430_spi_mr_t {
    unsigned int dlybcs          : 8;
    unsigned int                 : 4;
    unsigned int pcs             : 4;
    unsigned int                 : 8;
    unsigned int llb             : 1;
    unsigned int rxfifoen        : 1;
    unsigned int wdrbt           : 1;
    unsigned int modfdis         : 1;
    unsigned int                 : 1;
    unsigned int pcsdec          : 1;
    unsigned int ps              : 1;
    unsigned int mstr            : 1;
} neo430_spi_mr_t;



typedef struct neo430_spi_rdr_t {
    unsigned int                 :12;
    unsigned int pcs             : 4;
    unsigned int rd              :16;
} neo430_spi_rdr_t;



typedef struct neo430_spi_tdr_t {
    unsigned int                 : 7;
    unsigned int lastxfer        : 1;
    unsigned int                 : 4;
    unsigned int pcs             : 4;
    unsigned int td              :16;
} neo430_spi_tdr_t;



typedef struct neo430_spi_sr_t {
    unsigned int                 :15;
    unsigned int spiens          : 1;
    unsigned int                 : 5;
    unsigned int undes           : 1;
    unsigned int txempty         : 1;
    unsigned int nssr            : 1;
    unsigned int txbufe          : 1;
    unsigned int rxbuff          : 1;
    unsigned int endtx           : 1;
    unsigned int endrx           : 1;
    unsigned int ovres           : 1;
    unsigned int modf            : 1;
    unsigned int tdre            : 1;
    unsigned int rdrf            : 1;
} neo430_spi_sr_t;






typedef struct neo430_spi_t {
  union {
          unsigned long                  cr        ;//0x0000
          neo430_spi_cr_t                 CR        ;
  };
  union {
          unsigned long                  mr        ;//0x0004
          neo430_spi_mr_t                 MR        ;
  };
  union {
    const unsigned long                  rdr       ;//0x0008
    const neo430_spi_rdr_t                RDR       ;
  };
  union {
          unsigned long                  tdr       ;//0x000c
          neo430_spi_tdr_t                TDR       ;
  };
  union {
    const unsigned long                  sr        ;//0x0010
    const neo430_spi_sr_t                 SR        ;
  };
   
} neo430_spi_t;



/*#ifdef __Neo430_ABI_COMPILER__*/
//#endif

#define SPI0_GPIO_SCK      NEO430_SPI0_SCK_0_1_PIN
#define SPI0_GPIO_SCK_FN   NEO430_SPI0_SCK_0_1_FUNCTION
#define SPI0_GPIO_MISO     NEO430_SPI0_MISO_0_1_PIN
#define SPI0_GPIO_MISO_FN  NEO430_SPI0_MISO_0_1_FUNCTION
#define SPI0_GPIO_MOSI     NEO430_SPI0_MOSI_0_1_PIN
#define SPI0_GPIO_MOSI_FN  NEO430_SPI0_MOSI_0_1_FUNCTION
#define SPI0_GPIO_CS0      NEO430_SPI0_NPCS_0_1_PIN
#define SPI0_GPIO_CS0_FN   NEO430_SPI0_NPCS_0_1_FUNCTION

#define SPI0_MEM_SEL 0

/* SPI */

/* SPI0 */ 
#define NEO430_SPI0_ADDRESS                 0xFFFF2400
#define NEO430_SPI0                         (*((volatile neo430_spi_t*)NEO430_SPI0_ADDRESS))



//#define NEO430_SPI_H_VERSION 210

//#include "NEO430/abi.h"



#define NEO430_SPI_CR                                       0x00000000
#define NEO430_SPI_CR_FLUSHFIFO                                      8
#define NEO430_SPI_CR_FLUSHFIFO_MASK                        0x00000100
#define NEO430_SPI_CR_FLUSHFIFO_OFFSET                               8
#define NEO430_SPI_CR_FLUSHFIFO_SIZE                                 1
#define NEO430_SPI_CR_LASTXFER                                      24
#define NEO430_SPI_CR_LASTXFER_MASK                         0x01000000
#define NEO430_SPI_CR_LASTXFER_OFFSET                               24
#define NEO430_SPI_CR_LASTXFER_SIZE                                  1
#define NEO430_SPI_CR_SPIDIS                                         1
#define NEO430_SPI_CR_SPIDIS_MASK                           0x00000002
#define NEO430_SPI_CR_SPIDIS_OFFSET                                  1
#define NEO430_SPI_CR_SPIDIS_SIZE                                    1
#define NEO430_SPI_CR_SPIEN                                          0
#define NEO430_SPI_CR_SPIEN_MASK                            0x00000001
#define NEO430_SPI_CR_SPIEN_OFFSET                                   0
#define NEO430_SPI_CR_SPIEN_SIZE                                     1
#define NEO430_SPI_CR_SWRST                                          7
#define NEO430_SPI_CR_SWRST_MASK                            0x00000080
#define NEO430_SPI_CR_SWRST_OFFSET                                   7
#define NEO430_SPI_CR_SWRST_SIZE                                     1



#define NEO430_SPI_MR                                       0x00000004
#define NEO430_SPI_MR_DLYBCS                                        24
#define NEO430_SPI_MR_DLYBCS_MASK                           0xff000000
#define NEO430_SPI_MR_DLYBCS_OFFSET                                 24
#define NEO430_SPI_MR_DLYBCS_SIZE                                    8
#define NEO430_SPI_MR_LLB                                            7
#define NEO430_SPI_MR_LLB_MASK                              0x00000080
#define NEO430_SPI_MR_LLB_OFFSET                                     7
#define NEO430_SPI_MR_LLB_SIZE                                       1
#define NEO430_SPI_MR_MODFDIS                                        4
#define NEO430_SPI_MR_MODFDIS_MASK                          0x00000010
#define NEO430_SPI_MR_MODFDIS_OFFSET                                 4
#define NEO430_SPI_MR_MODFDIS_SIZE                                   1
#define NEO430_SPI_MR_MSTR                                           0
#define NEO430_SPI_MR_MSTR_MASK                             0x00000001
#define NEO430_SPI_MR_MSTR_OFFSET                                    0
#define NEO430_SPI_MR_MSTR_SIZE                                      1
#define NEO430_SPI_MR_PCS                                           16
#define NEO430_SPI_MR_PCSDEC                                         2
#define NEO430_SPI_MR_PCSDEC_MASK                           0x00000004
#define NEO430_SPI_MR_PCSDEC_OFFSET                                  2
#define NEO430_SPI_MR_PCSDEC_SIZE                                    1
#define NEO430_SPI_MR_PCS_MASK                              0x000f0000
#define NEO430_SPI_MR_PCS_OFFSET                                    16
#define NEO430_SPI_MR_PCS_SIZE                                       4
#define NEO430_SPI_MR_PS                                             1
#define NEO430_SPI_MR_PS_MASK                               0x00000002
#define NEO430_SPI_MR_PS_OFFSET                                      1
#define NEO430_SPI_MR_PS_SIZE                                        1
#define NEO430_SPI_MR_RXFIFOEN                                       6
#define NEO430_SPI_MR_RXFIFOEN_MASK                         0x00000040
#define NEO430_SPI_MR_RXFIFOEN_OFFSET                                6
#define NEO430_SPI_MR_RXFIFOEN_SIZE                                  1
#define NEO430_SPI_MR_WDRBT                                          5
#define NEO430_SPI_MR_WDRBT_MASK                            0x00000020
#define NEO430_SPI_MR_WDRBT_OFFSET                                   5
#define NEO430_SPI_MR_WDRBT_SIZE                                     1


#define NEO430_SPI_RD                                                0
#define NEO430_SPI_RDR                                      0x00000008
#define NEO430_SPI_RDRF                                              0
#define NEO430_SPI_RDRF_MASK                                0x00000001
#define NEO430_SPI_RDRF_OFFSET                                       0
#define NEO430_SPI_RDRF_SIZE                                         1
#define NEO430_SPI_RDR_PCS                                          16
#define NEO430_SPI_RDR_PCS_MASK                             0x000f0000
#define NEO430_SPI_RDR_PCS_OFFSET                                   16
#define NEO430_SPI_RDR_PCS_SIZE                                      4
#define NEO430_SPI_RDR_RD                                            0
#define NEO430_SPI_RDR_RD_MASK                              0x0000ffff
#define NEO430_SPI_RDR_RD_OFFSET                                     0
#define NEO430_SPI_RDR_RD_SIZE                                      16



#define NEO430_SPI_SR                                       0x00000010
#define NEO430_SPI_SR_ENDRX                                          4
#define NEO430_SPI_SR_ENDRX_MASK                            0x00000010
#define NEO430_SPI_SR_ENDRX_OFFSET                                   4
#define NEO430_SPI_SR_ENDRX_SIZE                                     1
#define NEO430_SPI_SR_ENDTX                                          5
#define NEO430_SPI_SR_ENDTX_MASK                            0x00000020
#define NEO430_SPI_SR_ENDTX_OFFSET                                   5
#define NEO430_SPI_SR_ENDTX_SIZE                                     1
#define NEO430_SPI_SR_MODF                                           2
#define NEO430_SPI_SR_MODF_MASK                             0x00000004
#define NEO430_SPI_SR_MODF_OFFSET                                    2
#define NEO430_SPI_SR_MODF_SIZE                                      1
#define NEO430_SPI_SR_NSSR                                           8
#define NEO430_SPI_SR_NSSR_MASK                             0x00000100
#define NEO430_SPI_SR_NSSR_OFFSET                                    8
#define NEO430_SPI_SR_NSSR_SIZE                                      1
#define NEO430_SPI_SR_OVRES                                          3
#define NEO430_SPI_SR_OVRES_MASK                            0x00000008
#define NEO430_SPI_SR_OVRES_OFFSET                                   3
#define NEO430_SPI_SR_OVRES_SIZE                                     1
#define NEO430_SPI_SR_RDRF                                           0
#define NEO430_SPI_SR_RDRF_MASK                             0x00000001
#define NEO430_SPI_SR_RDRF_OFFSET                                    0
#define NEO430_SPI_SR_RDRF_SIZE                                      1
#define NEO430_SPI_SR_RXBUFF                                         6
#define NEO430_SPI_SR_RXBUFF_MASK                           0x00000040
#define NEO430_SPI_SR_RXBUFF_OFFSET                                  6
#define NEO430_SPI_SR_RXBUFF_SIZE                                    1
#define NEO430_SPI_SR_SPIENS                                        16
#define NEO430_SPI_SR_SPIENS_MASK                           0x00010000
#define NEO430_SPI_SR_SPIENS_OFFSET                                 16
#define NEO430_SPI_SR_SPIENS_SIZE                                    1
#define NEO430_SPI_SR_TDRE                                           1
#define NEO430_SPI_SR_TDRE_MASK                             0x00000002
#define NEO430_SPI_SR_TDRE_OFFSET                                    1
#define NEO430_SPI_SR_TDRE_SIZE                                      1
#define NEO430_SPI_SR_TXBUFE                                         7
#define NEO430_SPI_SR_TXBUFE_MASK                           0x00000080
#define NEO430_SPI_SR_TXBUFE_OFFSET                                  7
#define NEO430_SPI_SR_TXBUFE_SIZE                                    1
#define NEO430_SPI_SR_TXEMPTY                                        9
#define NEO430_SPI_SR_TXEMPTY_MASK                          0x00000200
#define NEO430_SPI_SR_TXEMPTY_OFFSET                                 9
#define NEO430_SPI_SR_TXEMPTY_SIZE                                   1
#define NEO430_SPI_SR_UNDES                                         10
#define NEO430_SPI_SR_UNDES_MASK                            0x00000400
#define NEO430_SPI_SR_UNDES_OFFSET                                  10
#define NEO430_SPI_SR_UNDES_SIZE                                     1


#define NEO430_SPI_TD                                                0
#define NEO430_SPI_TDR                                      0x0000000c
#define NEO430_SPI_TDRE                                              1
#define NEO430_SPI_TDRE_MASK                                0x00000002
#define NEO430_SPI_TDRE_OFFSET                                       1
#define NEO430_SPI_TDRE_SIZE                                         1
#define NEO430_SPI_TDR_LASTXFER                                     24
#define NEO430_SPI_TDR_LASTXFER_MASK                        0x01000000
#define NEO430_SPI_TDR_LASTXFER_OFFSET                              24
#define NEO430_SPI_TDR_LASTXFER_SIZE                                 1
#define NEO430_SPI_TDR_PCS                                          16
#define NEO430_SPI_TDR_PCS_MASK                             0x000f0000
#define NEO430_SPI_TDR_PCS_OFFSET                                   16
#define NEO430_SPI_TDR_PCS_SIZE                                      4
#define NEO430_SPI_TDR_TD                                            0
#define NEO430_SPI_TDR_TD_MASK                              0x0000ffff
#define NEO430_SPI_TDR_TD_OFFSET                                     0
#define NEO430_SPI_TDR_TD_SIZE                                      16



/*#ifdef Neo430_SPI_H_INCLUDED*/
#endif

