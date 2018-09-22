
main.elf:     file format elf32-msp430


Disassembly of section .text:

00000000 <L0>:

__crt0_begin:
; -----------------------------------------------------------
; Get required system info
; -----------------------------------------------------------
    mov  &0xFFF8, r8 ; = DMEM (RAM) base address
       0:	18 42 f8 ff 	mov	&0xfff8,r8	;0xfff8

00000004 <.Loc.34.1>:
    mov  &0xFFFA, r1 ; = DMEM (RAM) size in byte
       4:	11 42 fa ff 	mov	&0xfffa,r1	;0xfffa

00000008 <.Loc.40.1>:


; -----------------------------------------------------------
; Minimal required hardware setup
; -----------------------------------------------------------
    mov  #0, r2           ; clear status register & disable interrupts
       8:	02 43       	clr	r2		;

0000000a <.Loc.41.1>:
    add  r8, r1           ; r1 = stack pointer = end of RAM
       a:	01 58       	add	r8,	r1	;

0000000c <.Loc.42.1>:
    mov  #0x4700, &0xFFB8 ; deactivate watchdog
       c:	b2 40 00 47 	mov	#18176,	&0xffb8	;#0x4700
      10:	b8 ff 

00000012 <.Loc.51.1>:
; Initialize all IO device registers (set to zero)
; -----------------------------------------------------------
; This loop does not trigger any operations as the CTRL registers, which are located
; at offset 0 of the according device, are set to zero resulting in disabling the
; specific device.
    mov  #0xFF80, r9 ; beginning of IO section
      12:	39 40 80 ff 	mov	#65408,	r9	;#0xff80

00000016 <__crt0_clr_io>:
__crt0_clr_io:
      tst  r9 ; until the end -> wrap-around to 0
      16:	09 93       	cmp	#0,	r9	;r3 As==00

00000018 <.Loc.54.1>:
      jeq  __crt0_clr_io_end
      18:	04 24       	jz	$+10     	;abs 0x22

0000001a <.Loc.55.1>:
      mov  #0, 0(r9) ; clear entry
      1a:	89 43 00 00 	mov	#0,	0(r9)	;r3 As==00

0000001e <.Loc.56.1>:
      incd r9
      1e:	29 53       	incd	r9		;

00000020 <.Loc.57.1>:
      jmp  __crt0_clr_io
      20:	fa 3f       	jmp	$-10     	;abs 0x16

00000022 <__crt0_clr_dmem>:

; -----------------------------------------------------------
; Clear complete DMEM (including .bss section)
; -----------------------------------------------------------
__crt0_clr_dmem:
      cmp  r8, r1 ; base address equal to end of RAM?
      22:	01 98       	cmp	r8,	r1	;

00000024 <.Loc.66.1>:
      jeq  __crt0_clr_dmem_end
      24:	04 24       	jz	$+10     	;abs 0x2e

00000026 <.Loc.67.1>:
      mov  #0, 0(r8) ; clear entry
      26:	88 43 00 00 	mov	#0,	0(r8)	;r3 As==00

0000002a <.Loc.68.1>:
      incd r8
      2a:	28 53       	incd	r8		;

0000002c <.Loc.69.1>:
      jmp  __crt0_clr_dmem
      2c:	fa 3f       	jmp	$-10     	;abs 0x22

0000002e <__crt0_clr_dmem_end>:


; -----------------------------------------------------------
; Copy initialized .data section from ROM to RAM
; -----------------------------------------------------------
    mov  #__data_start_rom, r5
      2e:	35 40 bc 37 	mov	#14268,	r5	;#0x37bc

00000032 <.Loc.77.1>:
    mov  #__data_end_rom, r6
      32:	36 40 a8 38 	mov	#14504,	r6	;#0x38a8

00000036 <.Loc.78.1>:
    mov  #__data_start, r7
      36:	37 40 08 80 	mov	#32776,	r7	;#0x8008

0000003a <__crt0_cpy_data>:
__crt0_cpy_data:
      cmp  r5, r6
      3a:	06 95       	cmp	r5,	r6	;

0000003c <.Loc.81.1>:
      jeq  __crt0_cpy_data_end
      3c:	04 24       	jz	$+10     	;abs 0x46

0000003e <.Loc.82.1>:
      mov  @r5+, 0(r7)
      3e:	b7 45 00 00 	mov	@r5+,	0(r7)	;

00000042 <.Loc.83.1>:
      incd r7
      42:	27 53       	incd	r7		;

00000044 <.Loc.84.1>:
      jmp  __crt0_cpy_data
      44:	fa 3f       	jmp	$-10     	;abs 0x3a

00000046 <__crt0_cpy_data_end>:


; -----------------------------------------------------------
; Re-init SR and clear all pending IRQs from buffer
; -----------------------------------------------------------
    mov  #(1<<14), r2 ; this flag auto clears
      46:	32 40 00 40 	mov	#16384,	r2	;#0x4000

0000004a <.Loc.97.1>:


; -----------------------------------------------------------
; Initialize all remaining registers
; -----------------------------------------------------------
    mov  #0, r4
      4a:	04 43       	clr	r4		;

0000004c <.Loc.103.1>:
;   mov  #0, r5 ; -- is already initialized
;   mov  #0, r6 ; -- is already initialized
;   mov  #0, r7 ; -- is already initialized
;   mov  #0, r8 ; -- is already initialized
;   mov  #0, r9 ; -- is already initialized
    mov  #0, r10
      4c:	0a 43       	clr	r10		;

0000004e <.Loc.104.1>:
    mov  #0, r11
      4e:	0b 43       	clr	r11		;

00000050 <.Loc.105.1>:
    mov  #0, r12 ; set argc = 0
      50:	0c 43       	clr	r12		;

00000052 <.Loc.106.1>:
    mov  #0, r13
      52:	0d 43       	clr	r13		;

00000054 <.Loc.107.1>:
    mov  #0, r14
      54:	0e 43       	clr	r14		;

00000056 <.Loc.108.1>:
    mov  #0, r15
      56:	0f 43       	clr	r15		;

00000058 <__crt0_start_main>:

; -----------------------------------------------------------
; This is where the actual application is started
; -----------------------------------------------------------
__crt0_start_main:
    call  #main
      58:	b0 12 40 07 	call	#1856		;#0x0740

0000005c <__crt0_this_is_the_end>:

; -----------------------------------------------------------
; Go to endless sleep mode if main returns
; -----------------------------------------------------------
__crt0_this_is_the_end:
    mov  #0, r2 ; deactivate IRQs
      5c:	02 43       	clr	r2		;

0000005e <.Loc.123.1>:
    mov  #0x4700, &0xFFB8 ; deactivate watchdog
      5e:	b2 40 00 47 	mov	#18176,	&0xffb8	;#0x4700
      62:	b8 ff 

00000064 <.Loc.124.1>:
    mov  #(1<<4), r2 ; set CPU to sleep mode
      64:	32 40 10 00 	mov	#16,	r2	;#0x0010

00000068 <.Loc.125.1>:
    nop
      68:	03 43       	nop			

0000006a <uart_putc>:
      6a:	3c f0 ff 00 	and	#255,	r12	;#0x00ff
      6e:	3d 40 a0 ff 	mov	#65440,	r13	;#0xffa0

00000072 <.L2>:
      72:	bd b2 00 00 	bit	#8,	0(r13)	;r2 As==11
      76:	fd 23       	jnz	$-4      	;abs 0x72
      78:	82 4c a4 ff 	mov	r12,	&0xffa4	;
      7c:	30 41       	ret			

0000007e <uart_br_print>:
      7e:	0a 12       	push	r10		;
      80:	09 12       	push	r9		;
      82:	08 12       	push	r8		;
      84:	07 12       	push	r7		;
      86:	09 4c       	mov	r12,	r9	;
      88:	38 40 6a 00 	mov	#106,	r8	;#0x006a
      8c:	77 40 0d 00 	mov.b	#13,	r7	;#0x000d

00000090 <.L5>:
      90:	6a 49       	mov.b	@r9,	r10	;
      92:	0a 93       	cmp	#0,	r10	;r3 As==00
      94:	02 20       	jnz	$+6      	;abs 0x9a
      96:	30 40 ac 12 	br	#0x12ac		;

0000009a <.L7>:
      9a:	3a 90 0a 00 	cmp	#10,	r10	;#0x000a
      9e:	02 20       	jnz	$+6      	;abs 0xa4
      a0:	4c 47       	mov.b	r7,	r12	;
      a2:	88 12       	call	r8		;

000000a4 <.L6>:
      a4:	4c 4a       	mov.b	r10,	r12	;
      a6:	88 12       	call	r8		;
      a8:	19 53       	inc	r9		;
      aa:	30 40 90 00 	br	#0x0090		;

000000ae <uart_print_hex_char>:
      ae:	7c f0 0f 00 	and.b	#15,	r12	;#0x000f
      b2:	7d 40 09 00 	mov.b	#9,	r13	;
      b6:	4d 9c       	cmp.b	r12,	r13	;
      b8:	07 28       	jnc	$+16     	;abs 0xc8
      ba:	7c 50 30 00 	add.b	#48,	r12	;#0x0030

000000be <.L11>:
      be:	3c f0 ff 00 	and	#255,	r12	;#0x00ff
      c2:	b0 12 6a 00 	call	#106		;#0x006a
      c6:	30 41       	ret			

000000c8 <.L9>:
      c8:	7c 50 37 00 	add.b	#55,	r12	;#0x0037
      cc:	30 40 be 00 	br	#0x00be		;

000000d0 <wishbone_write8>:
      d0:	0a 12       	push	r10		;
      d2:	09 12       	push	r9		;
      d4:	08 12       	push	r8		;
      d6:	07 12       	push	r7		;
      d8:	08 4c       	mov	r12,	r8	;
      da:	09 4d       	mov	r13,	r9	;
      dc:	47 4e       	mov.b	r14,	r7	;
      de:	0a 4c       	mov	r12,	r10	;
      e0:	7a f0 03 00 	and.b	#3,	r10	;
      e4:	5c 43       	mov.b	#1,	r12	;r3 As==01
      e6:	0d 4a       	mov	r10,	r13	;
      e8:	b0 12 da 12 	call	#4826		;#0x12da
      ec:	3d 40 90 ff 	mov	#65424,	r13	;#0xff90
      f0:	8d 4c 00 00 	mov	r12,	0(r13)	;
      f4:	ca 47 9a ff 	mov.b	r7,	-102(r10); 0xff9a
      f8:	82 48 96 ff 	mov	r8,	&0xff96	;
      fc:	82 49 98 ff 	mov	r9,	&0xff98	;

00000100 <.L13>:
     100:	2c 4d       	mov	@r13,	r12	;
     102:	0c 93       	cmp	#0,	r12	;r3 As==00
     104:	fd 3b       	jl	$-4      	;abs 0x100
     106:	30 40 ac 12 	br	#0x12ac		;

0000010a <spi_read.constprop.7>:
     10a:	3d 40 11 27 	mov	#10001,	r13	;#0x2711

0000010e <.L16>:
     10e:	1e 42 b4 ff 	mov	&0xffb4,r14	;0xffb4
     112:	1f 42 b6 ff 	mov	&0xffb6,r15	;0xffb6
     116:	3e f0 01 02 	and	#513,	r14	;#0x0201
     11a:	3e 90 01 02 	cmp	#513,	r14	;#0x0201
     11e:	08 20       	jnz	$+18     	;abs 0x130
     120:	1e 42 ac ff 	mov	&0xffac,r14	;0xffac
     124:	1f 42 ae ff 	mov	&0xffae,r15	;0xffae
     128:	8c 4e 00 00 	mov	r14,	0(r12)	;
     12c:	4c 43       	clr.b	r12		;

0000012e <.L15>:
     12e:	30 41       	ret			

00000130 <.L18>:
     130:	3d 53       	add	#-1,	r13	;r3 As==11
     132:	0d 93       	cmp	#0,	r13	;r3 As==00
     134:	ec 23       	jnz	$-38     	;abs 0x10e
     136:	5c 43       	mov.b	#1,	r12	;r3 As==01
     138:	30 40 2e 01 	br	#0x012e		;

0000013c <spi_write.constprop.8>:
     13c:	3d 40 11 27 	mov	#10001,	r13	;#0x2711

00000140 <.L21>:
     140:	1e 42 b4 ff 	mov	&0xffb4,r14	;0xffb4
     144:	1f 42 b6 ff 	mov	&0xffb6,r15	;0xffb6
     148:	6e f3       	and.b	#2,	r14	;r3 As==10
     14a:	0e 93       	cmp	#0,	r14	;r3 As==00
     14c:	07 24       	jz	$+16     	;abs 0x15c
     14e:	4f 43       	clr.b	r15		;
     150:	82 4c b0 ff 	mov	r12,	&0xffb0	;
     154:	82 4f b2 ff 	mov	r15,	&0xffb2	;
     158:	0c 4f       	mov	r15,	r12	;

0000015a <.L20>:
     15a:	30 41       	ret			

0000015c <.L23>:
     15c:	3d 53       	add	#-1,	r13	;r3 As==11
     15e:	0d 93       	cmp	#0,	r13	;r3 As==00
     160:	ef 23       	jnz	$-32     	;abs 0x140
     162:	5c 43       	mov.b	#1,	r12	;r3 As==01
     164:	30 40 5a 01 	br	#0x015a		;

00000168 <spi_transfer48>:
     168:	0a 12       	push	r10		;
     16a:	09 12       	push	r9		;
     16c:	08 12       	push	r8		;
     16e:	07 12       	push	r7		;
     170:	06 12       	push	r6		;
     172:	31 80 06 00 	sub	#6,	r1	;
     176:	0a 4c       	mov	r12,	r10	;
     178:	16 4d 02 00 	mov	2(r13),	r6	;
     17c:	17 4d 04 00 	mov	4(r13),	r7	;
     180:	38 40 3c 01 	mov	#316,	r8	;#0x013c
     184:	2c 4d       	mov	@r13,	r12	;
     186:	88 12       	call	r8		;
     188:	39 40 0a 01 	mov	#266,	r9	;#0x010a
     18c:	0c 41       	mov	r1,	r12	;
     18e:	89 12       	call	r9		;
     190:	0c 46       	mov	r6,	r12	;
     192:	88 12       	call	r8		;
     194:	0c 41       	mov	r1,	r12	;
     196:	2c 53       	incd	r12		;
     198:	89 12       	call	r9		;
     19a:	0c 47       	mov	r7,	r12	;
     19c:	88 12       	call	r8		;
     19e:	0c 41       	mov	r1,	r12	;
     1a0:	2c 52       	add	#4,	r12	;r2 As==10
     1a2:	89 12       	call	r9		;
     1a4:	aa 41 00 00 	mov	@r1,	0(r10)	;
     1a8:	9a 41 02 00 	mov	2(r1),	2(r10)	;
     1ac:	02 00 
     1ae:	9a 41 04 00 	mov	4(r1),	4(r10)	;
     1b2:	04 00 
     1b4:	0c 4a       	mov	r10,	r12	;
     1b6:	31 50 06 00 	add	#6,	r1	;
     1ba:	30 40 aa 12 	br	#0x12aa		;

000001be <spi_transfer16>:
     1be:	21 83       	decd	r1		;
     1c0:	b0 12 3c 01 	call	#316		;#0x013c
     1c4:	0c 41       	mov	r1,	r12	;
     1c6:	b0 12 0a 01 	call	#266		;#0x010a
     1ca:	2c 41       	mov	@r1,	r12	;
     1cc:	21 53       	incd	r1		;
     1ce:	30 41       	ret			

000001d0 <hex_str_to_uint32.constprop.12>:
     1d0:	0a 12       	push	r10		;
     1d2:	09 12       	push	r9		;
     1d4:	08 12       	push	r8		;
     1d6:	07 12       	push	r7		;
     1d8:	06 12       	push	r6		;
     1da:	05 12       	push	r5		;
     1dc:	04 12       	push	r4		;
     1de:	3c 40 00 81 	mov	#33024,	r12	;#0x8100
     1e2:	b0 12 f0 14 	call	#5360		;#0x14f0
     1e6:	04 4c       	mov	r12,	r4	;
     1e8:	0a 4c       	mov	r12,	r10	;
     1ea:	3a 50 ff 3f 	add	#16383,	r10	;#0x3fff
     1ee:	0a 5a       	rla	r10		;
     1f0:	0a 5a       	rla	r10		;
     1f2:	45 43       	clr.b	r5		;
     1f4:	48 43       	clr.b	r8		;
     1f6:	49 43       	clr.b	r9		;
     1f8:	06 48       	mov	r8,	r6	;
     1fa:	07 49       	mov	r9,	r7	;

000001fc <.L29>:
     1fc:	04 95       	cmp	r5,	r4	;
     1fe:	04 20       	jnz	$+10     	;abs 0x208
     200:	0c 48       	mov	r8,	r12	;
     202:	0d 49       	mov	r9,	r13	;
     204:	30 40 a6 12 	br	#0x12a6		;

00000208 <.L33>:
     208:	5c 45 00 81 	mov.b	-32512(r5),r12	;0xffff8100
     20c:	4d 4c       	mov.b	r12,	r13	;
     20e:	7d 50 d0 ff 	add.b	#65488,	r13	;#0xffd0
     212:	7e 40 09 00 	mov.b	#9,	r14	;
     216:	4e 9d       	cmp.b	r13,	r14	;
     218:	10 28       	jnc	$+34     	;abs 0x23a
     21a:	3c 50 d0 ff 	add	#65488,	r12	;#0xffd0

0000021e <.L35>:
     21e:	3c b0 00 80 	bit	#32768,	r12	;#0x8000
     222:	0d 7d       	subc	r13,	r13	;
     224:	3d e3       	inv	r13		;

00000226 <.L31>:
     226:	0e 4a       	mov	r10,	r14	;
     228:	b0 12 24 13 	call	#4900		;#0x1324
     22c:	08 5c       	add	r12,	r8	;
     22e:	09 6d       	addc	r13,	r9	;
     230:	15 53       	inc	r5		;
     232:	3a 50 fc ff 	add	#65532,	r10	;#0xfffc
     236:	30 40 fc 01 	br	#0x01fc		;

0000023a <.L30>:
     23a:	4d 4c       	mov.b	r12,	r13	;
     23c:	7d 50 9f ff 	add.b	#65439,	r13	;#0xff9f
     240:	7e 40 05 00 	mov.b	#5,	r14	;
     244:	4e 9d       	cmp.b	r13,	r14	;
     246:	04 28       	jnc	$+10     	;abs 0x250
     248:	3c 50 a9 ff 	add	#65449,	r12	;#0xffa9
     24c:	30 40 1e 02 	br	#0x021e		;

00000250 <.L32>:
     250:	4d 4c       	mov.b	r12,	r13	;
     252:	7d 50 bf ff 	add.b	#65471,	r13	;#0xffbf
     256:	7e 40 05 00 	mov.b	#5,	r14	;
     25a:	4e 9d       	cmp.b	r13,	r14	;
     25c:	04 28       	jnc	$+10     	;abs 0x266
     25e:	3c 50 c9 ff 	add	#65481,	r12	;#0xffc9
     262:	30 40 1e 02 	br	#0x021e		;

00000266 <.L34>:
     266:	0c 46       	mov	r6,	r12	;
     268:	0d 47       	mov	r7,	r13	;
     26a:	30 40 26 02 	br	#0x0226		;

0000026e <uart_scan.constprop.18>:
     26e:	0a 12       	push	r10		;
     270:	09 12       	push	r9		;
     272:	08 12       	push	r8		;
     274:	07 12       	push	r7		;
     276:	06 12       	push	r6		;
     278:	4a 43       	clr.b	r10		;
     27a:	38 40 00 81 	mov	#33024,	r8	;#0x8100
     27e:	06 4c       	mov	r12,	r6	;
     280:	36 53       	add	#-1,	r6	;r3 As==11
     282:	37 40 6a 00 	mov	#106,	r7	;#0x006a

00000286 <.L37>:
     286:	3c 40 a4 ff 	mov	#65444,	r12	;#0xffa4

0000028a <.L38>:
     28a:	29 4c       	mov	@r12,	r9	;
     28c:	09 93       	cmp	#0,	r9	;r3 As==00
     28e:	fd 37       	jge	$-4      	;abs 0x28a
     290:	39 f0 ff 00 	and	#255,	r9	;#0x00ff
     294:	79 92       	cmp.b	#8,	r9	;r2 As==11
     296:	10 20       	jnz	$+34     	;abs 0x2b8
     298:	0a 93       	cmp	#0,	r10	;r3 As==00
     29a:	f5 27       	jz	$-20     	;abs 0x286
     29c:	39 40 88 31 	mov	#12680,	r9	;#0x3188

000002a0 <.L41>:
     2a0:	19 53       	inc	r9		;
     2a2:	5c 49 ff ff 	mov.b	-1(r9),	r12	;
     2a6:	0c 93       	cmp	#0,	r12	;r3 As==00
     2a8:	04 20       	jnz	$+10     	;abs 0x2b2
     2aa:	38 53       	add	#-1,	r8	;r3 As==11
     2ac:	3a 53       	add	#-1,	r10	;r3 As==11
     2ae:	30 40 86 02 	br	#0x0286		;

000002b2 <.L42>:
     2b2:	87 12       	call	r7		;
     2b4:	30 40 a0 02 	br	#0x02a0		;

000002b8 <.L39>:
     2b8:	79 90 0d 00 	cmp.b	#13,	r9	;#0x000d
     2bc:	11 24       	jz	$+36     	;abs 0x2e0
     2be:	4c 49       	mov.b	r9,	r12	;
     2c0:	7c 50 e0 ff 	add.b	#65504,	r12	;#0xffe0
     2c4:	7d 40 5e 00 	mov.b	#94,	r13	;#0x005e
     2c8:	4d 9c       	cmp.b	r12,	r13	;
     2ca:	dd 2b       	jnc	$-68     	;abs 0x286
     2cc:	0a 96       	cmp	r6,	r10	;
     2ce:	db 2f       	jc	$-72     	;abs 0x286
     2d0:	4c 49       	mov.b	r9,	r12	;
     2d2:	87 12       	call	r7		;
     2d4:	c8 49 00 00 	mov.b	r9,	0(r8)	;
     2d8:	1a 53       	inc	r10		;
     2da:	18 53       	inc	r8		;
     2dc:	30 40 86 02 	br	#0x0286		;

000002e0 <.L43>:
     2e0:	c8 43 00 00 	mov.b	#0,	0(r8)	;r3 As==00
     2e4:	0c 4a       	mov	r10,	r12	;
     2e6:	30 40 aa 12 	br	#0x12aa		;

000002ea <spi_unselectChip.isra.2.constprop.21>:
     2ea:	3e 40 11 27 	mov	#10001,	r14	;#0x2711

000002ee <.L49>:
     2ee:	1c 42 b4 ff 	mov	&0xffb4,r12	;0xffb4
     2f2:	1d 42 b6 ff 	mov	&0xffb6,r13	;0xffb6
     2f6:	3c f0 00 02 	and	#512,	r12	;#0x0200
     2fa:	0c 93       	cmp	#0,	r12	;r3 As==00
     2fc:	12 24       	jz	$+38     	;abs 0x322
     2fe:	1e 42 a8 ff 	mov	&0xffa8,r14	;0xffa8
     302:	1f 42 aa ff 	mov	&0xffaa,r15	;0xffaa
     306:	0d 4f       	mov	r15,	r13	;
     308:	3d d0 0f 00 	bis	#15,	r13	;#0x000f
     30c:	82 4e a8 ff 	mov	r14,	&0xffa8	;
     310:	82 4d aa ff 	mov	r13,	&0xffaa	;
     314:	82 43 a2 ff 	mov	#0,	&0xffa2	;r3 As==00
     318:	b2 40 00 01 	mov	#256,	&0xffa4	;#0x0100
     31c:	a4 ff 
     31e:	4c 43       	clr.b	r12		;

00000320 <.L48>:
     320:	30 41       	ret			

00000322 <.L51>:
     322:	3e 53       	add	#-1,	r14	;r3 As==11
     324:	0e 93       	cmp	#0,	r14	;r3 As==00
     326:	e3 23       	jnz	$-56     	;abs 0x2ee
     328:	5c 43       	mov.b	#1,	r12	;r3 As==01
     32a:	30 40 20 03 	br	#0x0320		;

0000032e <spi_selectChip.constprop.9>:
     32e:	1e 42 a8 ff 	mov	&0xffa8,r14	;0xffa8
     332:	1f 42 aa ff 	mov	&0xffaa,r15	;0xffaa
     336:	0d 4f       	mov	r15,	r13	;
     338:	3d d0 0f 00 	bis	#15,	r13	;#0x000f
     33c:	82 4e a8 ff 	mov	r14,	&0xffa8	;
     340:	82 4d aa ff 	mov	r13,	&0xffaa	;
     344:	1c 42 a8 ff 	mov	&0xffa8,r12	;0xffa8
     348:	1d 42 aa ff 	mov	&0xffaa,r13	;0xffaa
     34c:	6c f2       	and.b	#4,	r12	;r2 As==10
     34e:	0c 93       	cmp	#0,	r12	;r3 As==00
     350:	0e 24       	jz	$+30     	;abs 0x36e
     352:	1e 42 a8 ff 	mov	&0xffa8,r14	;0xffa8
     356:	1f 42 aa ff 	mov	&0xffaa,r15	;0xffaa
     35a:	0c 4e       	mov	r14,	r12	;
     35c:	0d 4f       	mov	r15,	r13	;
     35e:	3d f0 f0 ff 	and	#65520,	r13	;#0xfff0

00000362 <.L58>:
     362:	82 4c a8 ff 	mov	r12,	&0xffa8	;
     366:	82 4d aa ff 	mov	r13,	&0xffaa	;
     36a:	4c 43       	clr.b	r12		;
     36c:	30 41       	ret			

0000036e <.L55>:
     36e:	1c 42 a8 ff 	mov	&0xffa8,r12	;0xffa8
     372:	1d 42 aa ff 	mov	&0xffaa,r13	;0xffaa
     376:	30 40 62 03 	br	#0x0362		;

0000037a <checkack.constprop.17>:
     37a:	3d 40 90 ff 	mov	#65424,	r13	;#0xff90
     37e:	3e 40 9a ff 	mov	#65434,	r14	;#0xff9a

00000382 <.L60>:
     382:	4c 43       	clr.b	r12		;

00000384 <.L61>:
     384:	03 43       	nop			
     386:	1c 53       	inc	r12		;
     388:	3c 90 00 02 	cmp	#512,	r12	;#0x0200
     38c:	fb 23       	jnz	$-8      	;abs 0x384
     38e:	92 43 90 ff 	mov	#1,	&0xff90	;r3 As==01
     392:	b2 40 10 00 	mov	#16,	&0xff92	;#0x0010
     396:	92 ff 
     398:	82 43 94 ff 	mov	#0,	&0xff94	;r3 As==00

0000039c <.L62>:
     39c:	2c 4d       	mov	@r13,	r12	;
     39e:	0c 93       	cmp	#0,	r12	;r3 As==00
     3a0:	fd 3b       	jl	$-4      	;abs 0x39c
     3a2:	6c 4e       	mov.b	@r14,	r12	;
     3a4:	2c b3       	bit	#2,	r12	;r3 As==10
     3a6:	ed 23       	jnz	$-36     	;abs 0x382
     3a8:	7c e3       	xor.b	#-1,	r12	;r3 As==11
     3aa:	3c f0 ff 00 	and	#255,	r12	;#0x00ff
     3ae:	b0 12 4a 13 	call	#4938		;#0x134a
     3b2:	30 41       	ret			

000003b4 <read_i2c_address.constprop.15>:
     3b4:	0a 12       	push	r10		;
     3b6:	09 12       	push	r9		;
     3b8:	08 12       	push	r8		;
     3ba:	07 12       	push	r7		;
     3bc:	06 12       	push	r6		;
     3be:	05 12       	push	r5		;
     3c0:	04 12       	push	r4		;
     3c2:	21 83       	decd	r1		;
     3c4:	4e 4c       	mov.b	r12,	r14	;
     3c6:	47 4d       	mov.b	r13,	r7	;
     3c8:	4e 5e       	rla.b	r14		;
     3ca:	38 40 d0 00 	mov	#208,	r8	;#0x00d0
     3ce:	5e d3       	bis.b	#1,	r14	;r3 As==01
     3d0:	7c 40 0c 00 	mov.b	#12,	r12	;#0x000c
     3d4:	4d 43       	clr.b	r13		;
     3d6:	88 12       	call	r8		;
     3d8:	7e 40 90 ff 	mov.b	#65424,	r14	;#0xff90
     3dc:	7c 40 10 00 	mov.b	#16,	r12	;#0x0010
     3e0:	4d 43       	clr.b	r13		;
     3e2:	88 12       	call	r8		;
     3e4:	39 40 7a 03 	mov	#890,	r9	;#0x037a
     3e8:	89 12       	call	r9		;
     3ea:	4a 4c       	mov.b	r12,	r10	;
     3ec:	06 48       	mov	r8,	r6	;
     3ee:	0a 93       	cmp	#0,	r10	;r3 As==00
     3f0:	24 24       	jz	$+74     	;abs 0x43a
     3f2:	4a 43       	clr.b	r10		;
     3f4:	0c 47       	mov	r7,	r12	;
     3f6:	3c 53       	add	#-1,	r12	;r3 As==11
     3f8:	81 4c 00 00 	mov	r12,	0(r1)	;
     3fc:	74 40 10 00 	mov.b	#16,	r4	;#0x0010
     400:	45 43       	clr.b	r5		;
     402:	38 40 90 ff 	mov	#65424,	r8	;#0xff90

00000406 <.L68>:
     406:	0a 97       	cmp	r7,	r10	;
     408:	1e 24       	jz	$+62     	;abs 0x446
     40a:	2a 91       	cmp	@r1,	r10	;
     40c:	20 34       	jge	$+66     	;abs 0x44e
     40e:	7e 40 20 00 	mov.b	#32,	r14	;#0x0020

00000412 <.L75>:
     412:	0c 44       	mov	r4,	r12	;
     414:	0d 45       	mov	r5,	r13	;
     416:	86 12       	call	r6		;
     418:	89 12       	call	r9		;
     41a:	92 43 90 ff 	mov	#1,	&0xff90	;r3 As==01
     41e:	b2 40 0c 00 	mov	#12,	&0xff92	;#0x000c
     422:	92 ff 
     424:	82 43 94 ff 	mov	#0,	&0xff94	;r3 As==00

00000428 <.L72>:
     428:	2c 48       	mov	@r8,	r12	;
     42a:	0c 93       	cmp	#0,	r12	;r3 As==00
     42c:	fd 3b       	jl	$-4      	;abs 0x428
     42e:	da 42 9a ff 	mov.b	&0xff9a,-32496(r10);0xff9a, 0x8110
     432:	10 81 
     434:	1a 53       	inc	r10		;
     436:	30 40 06 04 	br	#0x0406		;

0000043a <.L67>:
     43a:	7e 40 40 00 	mov.b	#64,	r14	;#0x0040
     43e:	7c 40 10 00 	mov.b	#16,	r12	;#0x0010
     442:	4d 43       	clr.b	r13		;
     444:	88 12       	call	r8		;

00000446 <.L76>:
     446:	0c 4a       	mov	r10,	r12	;
     448:	21 53       	incd	r1		;
     44a:	30 40 a6 12 	br	#0x12a6		;

0000044e <.L70>:
     44e:	7e 40 68 00 	mov.b	#104,	r14	;#0x0068
     452:	30 40 12 04 	br	#0x0412		;

00000456 <write_i2c_address.constprop.14>:
     456:	0a 12       	push	r10		;
     458:	09 12       	push	r9		;
     45a:	08 12       	push	r8		;
     45c:	07 12       	push	r7		;
     45e:	06 12       	push	r6		;
     460:	05 12       	push	r5		;
     462:	04 12       	push	r4		;
     464:	3c f0 ff 00 	and	#255,	r12	;#0x00ff
     468:	47 4d       	mov.b	r13,	r7	;
     46a:	48 4e       	mov.b	r14,	r8	;
     46c:	4c 5c       	rla.b	r12		;
     46e:	3a 40 d0 00 	mov	#208,	r10	;#0x00d0
     472:	4e 4c       	mov.b	r12,	r14	;
     474:	7c 40 0c 00 	mov.b	#12,	r12	;#0x000c
     478:	4d 43       	clr.b	r13		;
     47a:	8a 12       	call	r10		;
     47c:	7e 40 90 ff 	mov.b	#65424,	r14	;#0xff90
     480:	7c 40 10 00 	mov.b	#16,	r12	;#0x0010
     484:	4d 43       	clr.b	r13		;
     486:	8a 12       	call	r10		;
     488:	39 40 7a 03 	mov	#890,	r9	;#0x037a
     48c:	89 12       	call	r9		;
     48e:	06 4a       	mov	r10,	r6	;
     490:	4c 93       	cmp.b	#0,	r12	;r3 As==00
     492:	0a 24       	jz	$+22     	;abs 0x4a8
     494:	4a 43       	clr.b	r10		;
     496:	74 40 10 00 	mov.b	#16,	r4	;#0x0010
     49a:	45 43       	clr.b	r5		;

0000049c <.L79>:
     49c:	0a 97       	cmp	r7,	r10	;
     49e:	0e 20       	jnz	$+30     	;abs 0x4bc
     4a0:	08 93       	cmp	#0,	r8	;r3 As==00
     4a2:	09 24       	jz	$+20     	;abs 0x4b6
     4a4:	30 40 d8 04 	br	#0x04d8		;

000004a8 <.L78>:
     4a8:	7e 40 40 00 	mov.b	#64,	r14	;#0x0040
     4ac:	7c 40 10 00 	mov.b	#16,	r12	;#0x0010
     4b0:	4d 43       	clr.b	r13		;
     4b2:	8a 12       	call	r10		;
     4b4:	3a 43       	mov	#-1,	r10	;r3 As==11

000004b6 <.L77>:
     4b6:	0c 4a       	mov	r10,	r12	;
     4b8:	30 40 a6 12 	br	#0x12a6		;

000004bc <.L82>:
     4bc:	5e 4a 10 81 	mov.b	-32496(r10),r14	;0xffff8110
     4c0:	7c 40 0c 00 	mov.b	#12,	r12	;#0x000c
     4c4:	4d 43       	clr.b	r13		;
     4c6:	86 12       	call	r6		;
     4c8:	7e 40 10 00 	mov.b	#16,	r14	;#0x0010
     4cc:	0c 44       	mov	r4,	r12	;
     4ce:	0d 45       	mov	r5,	r13	;
     4d0:	86 12       	call	r6		;
     4d2:	89 12       	call	r9		;
     4d4:	4c 93       	cmp.b	#0,	r12	;r3 As==00
     4d6:	08 20       	jnz	$+18     	;abs 0x4e8

000004d8 <.L86>:
     4d8:	7e 40 40 00 	mov.b	#64,	r14	;#0x0040
     4dc:	7c 40 10 00 	mov.b	#16,	r12	;#0x0010
     4e0:	4d 43       	clr.b	r13		;
     4e2:	86 12       	call	r6		;
     4e4:	30 40 b6 04 	br	#0x04b6		;

000004e8 <.L81>:
     4e8:	1a 53       	inc	r10		;
     4ea:	30 40 9c 04 	br	#0x049c		;

000004ee <read_i2c_prom.constprop.13>:
     4ee:	0a 12       	push	r10		;
     4f0:	4a 4d       	mov.b	r13,	r10	;
     4f2:	c2 4c 10 81 	mov.b	r12,	&0x8110	;
     4f6:	4e 43       	clr.b	r14		;
     4f8:	5d 43       	mov.b	#1,	r13	;r3 As==01
     4fa:	7c 40 53 00 	mov.b	#83,	r12	;#0x0053
     4fe:	b0 12 56 04 	call	#1110		;#0x0456
     502:	4c 43       	clr.b	r12		;

00000504 <.L88>:
     504:	0c 9a       	cmp	r10,	r12	;
     506:	08 28       	jnc	$+18     	;abs 0x518
     508:	4d 4a       	mov.b	r10,	r13	;
     50a:	7c 40 53 00 	mov.b	#83,	r12	;#0x0053
     50e:	b0 12 b4 03 	call	#948		;#0x03b4
     512:	0c 4a       	mov	r10,	r12	;
     514:	3a 41       	pop	r10		;
     516:	30 41       	ret			

00000518 <.L89>:
     518:	cc 43 10 81 	mov.b	#0,	-32496(r12);r3 As==00, 0x8110
     51c:	1c 53       	inc	r12		;
     51e:	30 40 04 05 	br	#0x0504		;

00000522 <read_mac>:
     522:	0a 12       	push	r10		;
     524:	0a 4c       	mov	r12,	r10	;
     526:	7d 40 06 00 	mov.b	#6,	r13	;
     52a:	4c 43       	clr.b	r12		;
     52c:	b0 12 ee 04 	call	#1262		;#0x04ee
     530:	3f 40 10 81 	mov	#33040,	r15	;#0x8110
     534:	5c 4f 01 00 	mov.b	1(r15),	r12	;
     538:	0c 5c       	rla	r12		;
     53a:	0c 5c       	rla	r12		;
     53c:	0c 5c       	rla	r12		;
     53e:	0c 5c       	rla	r12		;
     540:	0c 5c       	rla	r12		;
     542:	0c 5c       	rla	r12		;
     544:	0c 5c       	rla	r12		;
     546:	0c 5c       	rla	r12		;
     548:	6d 4f       	mov.b	@r15,	r13	;
     54a:	0c 5d       	add	r13,	r12	;
     54c:	5d 4f 03 00 	mov.b	3(r15),	r13	;
     550:	0d 5d       	rla	r13		;
     552:	0d 5d       	rla	r13		;
     554:	0d 5d       	rla	r13		;
     556:	0d 5d       	rla	r13		;
     558:	0d 5d       	rla	r13		;
     55a:	0d 5d       	rla	r13		;
     55c:	0d 5d       	rla	r13		;
     55e:	0d 5d       	rla	r13		;
     560:	5e 4f 02 00 	mov.b	2(r15),	r14	;
     564:	0d 5e       	add	r14,	r13	;
     566:	5e 4f 05 00 	mov.b	5(r15),	r14	;
     56a:	0e 5e       	rla	r14		;
     56c:	0e 5e       	rla	r14		;
     56e:	0e 5e       	rla	r14		;
     570:	0e 5e       	rla	r14		;
     572:	0e 5e       	rla	r14		;
     574:	0e 5e       	rla	r14		;
     576:	0e 5e       	rla	r14		;
     578:	0e 5e       	rla	r14		;
     57a:	5f 4f 04 00 	mov.b	4(r15),	r15	;
     57e:	0f 5e       	add	r14,	r15	;
     580:	8a 4f 00 00 	mov	r15,	0(r10)	;
     584:	8a 4d 02 00 	mov	r13,	2(r10)	;
     588:	8a 4c 04 00 	mov	r12,	4(r10)	;
     58c:	0c 4a       	mov	r10,	r12	;
     58e:	3a 41       	pop	r10		;
     590:	30 41       	ret			

00000592 <read_Prom>:
     592:	0a 12       	push	r10		;
     594:	09 12       	push	r9		;
     596:	08 12       	push	r8		;
     598:	07 12       	push	r7		;
     59a:	6d 42       	mov.b	#4,	r13	;r2 As==10
     59c:	4c 43       	clr.b	r12		;
     59e:	b0 12 ee 04 	call	#1262		;#0x04ee
     5a2:	3a 40 10 81 	mov	#33040,	r10	;#0x8110
     5a6:	4c 43       	clr.b	r12		;
     5a8:	0d 4c       	mov	r12,	r13	;
     5aa:	5c 4a 01 00 	mov.b	1(r10),	r12	;
     5ae:	0c 5c       	rla	r12		;
     5b0:	0d 6d       	rlc	r13		;
     5b2:	0c 5c       	rla	r12		;
     5b4:	0d 6d       	rlc	r13		;
     5b6:	0c 5c       	rla	r12		;
     5b8:	0d 6d       	rlc	r13		;
     5ba:	0c 5c       	rla	r12		;
     5bc:	0d 6d       	rlc	r13		;
     5be:	0c 5c       	rla	r12		;
     5c0:	0d 6d       	rlc	r13		;
     5c2:	0c 5c       	rla	r12		;
     5c4:	0d 6d       	rlc	r13		;
     5c6:	0c 5c       	rla	r12		;
     5c8:	0d 6d       	rlc	r13		;
     5ca:	09 4c       	mov	r12,	r9	;
     5cc:	09 5c       	add	r12,	r9	;
     5ce:	08 4d       	mov	r13,	r8	;
     5d0:	08 6d       	addc	r13,	r8	;
     5d2:	47 43       	clr.b	r7		;
     5d4:	5c 4a 02 00 	mov.b	2(r10),	r12	;
     5d8:	0d 47       	mov	r7,	r13	;
     5da:	7e 40 10 00 	mov.b	#16,	r14	;#0x0010
     5de:	b0 12 24 13 	call	#4900		;#0x1324
     5e2:	0c 59       	add	r9,	r12	;
     5e4:	08 6d       	addc	r13,	r8	;
     5e6:	0d 47       	mov	r7,	r13	;
     5e8:	69 4a       	mov.b	@r10,	r9	;
     5ea:	09 5c       	add	r12,	r9	;
     5ec:	08 67       	addc	r7,	r8	;
     5ee:	5c 4a 03 00 	mov.b	3(r10),	r12	;
     5f2:	7e 40 18 00 	mov.b	#24,	r14	;#0x0018
     5f6:	b0 12 24 13 	call	#4900		;#0x1324
     5fa:	0c 59       	add	r9,	r12	;
     5fc:	0d 68       	addc	r8,	r13	;
     5fe:	30 40 ac 12 	br	#0x12ac		;

00000602 <uart_print_hex_word>:
     602:	0a 12       	push	r10		;
     604:	09 12       	push	r9		;
     606:	08 12       	push	r8		;
     608:	09 4c       	mov	r12,	r9	;
     60a:	b0 12 46 13 	call	#4934		;#0x1346
     60e:	48 4c       	mov.b	r12,	r8	;
     610:	0c 48       	mov	r8,	r12	;
     612:	b0 12 56 13 	call	#4950		;#0x1356
     616:	3a 40 ae 00 	mov	#174,	r10	;#0x00ae
     61a:	8a 12       	call	r10		;
     61c:	4c 48       	mov.b	r8,	r12	;
     61e:	8a 12       	call	r10		;
     620:	39 f0 ff 00 	and	#255,	r9	;#0x00ff
     624:	0c 49       	mov	r9,	r12	;
     626:	b0 12 56 13 	call	#4950		;#0x1356
     62a:	8a 12       	call	r10		;
     62c:	4c 49       	mov.b	r9,	r12	;
     62e:	8a 12       	call	r10		;
     630:	30 40 ae 12 	br	#0x12ae		;

00000634 <uart_print_hex_dword>:
     634:	0a 12       	push	r10		;
     636:	09 12       	push	r9		;
     638:	09 4c       	mov	r12,	r9	;
     63a:	7e 40 10 00 	mov.b	#16,	r14	;#0x0010
     63e:	b0 12 d8 13 	call	#5080		;#0x13d8
     642:	3a 40 02 06 	mov	#1538,	r10	;#0x0602
     646:	8a 12       	call	r10		;
     648:	0c 49       	mov	r9,	r12	;
     64a:	8a 12       	call	r10		;
     64c:	30 40 b0 12 	br	#0x12b0		;

00000650 <spi_transfer32>:
     650:	0a 12       	push	r10		;
     652:	09 12       	push	r9		;
     654:	08 12       	push	r8		;
     656:	07 12       	push	r7		;
     658:	31 82       	sub	#8,	r1	;r2 As==11
     65a:	0a 4c       	mov	r12,	r10	;
     65c:	09 4d       	mov	r13,	r9	;
     65e:	7e 40 18 00 	mov.b	#24,	r14	;#0x0018
     662:	b0 12 24 13 	call	#4900		;#0x1324
     666:	08 4c       	mov	r12,	r8	;
     668:	07 4d       	mov	r13,	r7	;
     66a:	0c 4a       	mov	r10,	r12	;
     66c:	0d 49       	mov	r9,	r13	;
     66e:	7e 40 18 00 	mov.b	#24,	r14	;#0x0018
     672:	b0 12 d8 13 	call	#5080		;#0x13d8
     676:	08 dc       	bis	r12,	r8	;
     678:	07 dd       	bis	r13,	r7	;
     67a:	0e 4a       	mov	r10,	r14	;
     67c:	0e 5a       	add	r10,	r14	;
     67e:	0c 49       	mov	r9,	r12	;
     680:	0c 69       	addc	r9,	r12	;
     682:	0e 5e       	rla	r14		;
     684:	0c 6c       	rlc	r12		;
     686:	0e 5e       	rla	r14		;
     688:	0c 6c       	rlc	r12		;
     68a:	0e 5e       	rla	r14		;
     68c:	0c 6c       	rlc	r12		;
     68e:	0e 5e       	rla	r14		;
     690:	0c 6c       	rlc	r12		;
     692:	0e 5e       	rla	r14		;
     694:	0c 6c       	rlc	r12		;
     696:	0e 5e       	rla	r14		;
     698:	0c 6c       	rlc	r12		;
     69a:	0e 5e       	rla	r14		;
     69c:	0c 6c       	rlc	r12		;
     69e:	7c f0 ff 00 	and.b	#255,	r12	;#0x00ff
     6a2:	07 dc       	bis	r12,	r7	;
     6a4:	0c 4a       	mov	r10,	r12	;
     6a6:	0d 49       	mov	r9,	r13	;
     6a8:	b0 12 9e 13 	call	#5022		;#0x139e
     6ac:	3c f0 00 ff 	and	#65280,	r12	;#0xff00
     6b0:	08 dc       	bis	r12,	r8	;
     6b2:	81 48 00 00 	mov	r8,	0(r1)	;
     6b6:	81 47 02 00 	mov	r7,	2(r1)	;
     6ba:	39 40 3c 01 	mov	#316,	r9	;#0x013c
     6be:	0c 47       	mov	r7,	r12	;
     6c0:	89 12       	call	r9		;
     6c2:	3a 40 0a 01 	mov	#266,	r10	;#0x010a
     6c6:	0c 41       	mov	r1,	r12	;
     6c8:	3c 50 06 00 	add	#6,	r12	;
     6cc:	8a 12       	call	r10		;
     6ce:	2c 41       	mov	@r1,	r12	;
     6d0:	89 12       	call	r9		;
     6d2:	0c 41       	mov	r1,	r12	;
     6d4:	2c 52       	add	#4,	r12	;r2 As==10
     6d6:	8a 12       	call	r10		;
     6d8:	1a 41 04 00 	mov	4(r1),	r10	;
     6dc:	18 41 06 00 	mov	6(r1),	r8	;
     6e0:	0c 4a       	mov	r10,	r12	;
     6e2:	0d 48       	mov	r8,	r13	;
     6e4:	7e 40 18 00 	mov.b	#24,	r14	;#0x0018
     6e8:	b0 12 24 13 	call	#4900		;#0x1324
     6ec:	09 4c       	mov	r12,	r9	;
     6ee:	07 4d       	mov	r13,	r7	;
     6f0:	0c 4a       	mov	r10,	r12	;
     6f2:	0d 48       	mov	r8,	r13	;
     6f4:	7e 40 18 00 	mov.b	#24,	r14	;#0x0018
     6f8:	b0 12 d8 13 	call	#5080		;#0x13d8
     6fc:	09 dc       	bis	r12,	r9	;
     6fe:	07 dd       	bis	r13,	r7	;
     700:	0e 4a       	mov	r10,	r14	;
     702:	0e 5a       	add	r10,	r14	;
     704:	0c 48       	mov	r8,	r12	;
     706:	0c 68       	addc	r8,	r12	;
     708:	0e 5e       	rla	r14		;
     70a:	0c 6c       	rlc	r12		;
     70c:	0e 5e       	rla	r14		;
     70e:	0c 6c       	rlc	r12		;
     710:	0e 5e       	rla	r14		;
     712:	0c 6c       	rlc	r12		;
     714:	0e 5e       	rla	r14		;
     716:	0c 6c       	rlc	r12		;
     718:	0e 5e       	rla	r14		;
     71a:	0c 6c       	rlc	r12		;
     71c:	0e 5e       	rla	r14		;
     71e:	0c 6c       	rlc	r12		;
     720:	0e 5e       	rla	r14		;
     722:	0c 6c       	rlc	r12		;
     724:	7c f0 ff 00 	and.b	#255,	r12	;#0x00ff
     728:	07 dc       	bis	r12,	r7	;
     72a:	0c 4a       	mov	r10,	r12	;
     72c:	0d 48       	mov	r8,	r13	;
     72e:	b0 12 9e 13 	call	#5022		;#0x139e
     732:	3c f0 00 ff 	and	#65280,	r12	;#0xff00
     736:	0c d9       	bis	r9,	r12	;
     738:	0d 47       	mov	r7,	r13	;
     73a:	31 52       	add	#8,	r1	;r2 As==11
     73c:	30 40 ac 12 	br	#0x12ac		;

00000740 <main>:
     740:	0a 12       	push	r10		;
     742:	09 12       	push	r9		;
     744:	08 12       	push	r8		;
     746:	07 12       	push	r7		;
     748:	06 12       	push	r6		;
     74a:	05 12       	push	r5		;
     74c:	04 12       	push	r4		;
     74e:	31 80 3e 00 	sub	#62,	r1	;#0x003e
     752:	1e 42 fc ff 	mov	&0xfffc,r14	;0xfffc
     756:	1f 42 fe ff 	mov	&0xfffe,r15	;0xfffe
     75a:	4c 43       	clr.b	r12		;

0000075c <.L96>:
     75c:	0a 4f       	mov	r15,	r10	;
     75e:	0f 93       	cmp	#0,	r15	;r3 As==00
     760:	b9 20       	jnz	$+372    	;abs 0x8d4
     762:	3d 40 ff 95 	mov	#38399,	r13	;#0x95ff
     766:	0d 9e       	cmp	r14,	r13	;
     768:	b5 28       	jnc	$+364    	;abs 0x8d4

0000076a <.L99>:
     76a:	7e 40 ff 00 	mov.b	#255,	r14	;#0x00ff
     76e:	0e 9c       	cmp	r12,	r14	;
     770:	b7 28       	jnc	$+368    	;abs 0x8e0
     772:	0d 4a       	mov	r10,	r13	;
     774:	0d 5a       	add	r10,	r13	;
     776:	0d 5d       	rla	r13		;
     778:	0d 5d       	rla	r13		;
     77a:	0d 5d       	rla	r13		;
     77c:	0d 5d       	rla	r13		;
     77e:	0d 5d       	rla	r13		;
     780:	0d 5d       	rla	r13		;
     782:	0d 5d       	rla	r13		;
     784:	0d dc       	bis	r12,	r13	;
     786:	82 4d a6 ff 	mov	r13,	&0xffa6	;
     78a:	92 43 a0 ff 	mov	#1,	&0xffa0	;r3 As==01
     78e:	39 40 7e 00 	mov	#126,	r9	;#0x007e
     792:	3c 40 8c 31 	mov	#12684,	r12	;#0x318c
     796:	89 12       	call	r9		;
     798:	0a 49       	mov	r9,	r10	;
     79a:	a2 b3 f2 ff 	bit	#2,	&0xfff2	;r3 As==10
     79e:	02 20       	jnz	$+6      	;abs 0x7a4
     7a0:	30 40 e0 11 	br	#0x11e0		;
     7a4:	3c 40 2b 32 	mov	#12843,	r12	;#0x322b
     7a8:	89 12       	call	r9		;
     7aa:	39 40 d0 00 	mov	#208,	r9	;#0x00d0
     7ae:	4e 43       	clr.b	r14		;
     7b0:	7c 42       	mov.b	#8,	r12	;r2 As==11
     7b2:	4d 43       	clr.b	r13		;
     7b4:	89 12       	call	r9		;
     7b6:	4e 43       	clr.b	r14		;
     7b8:	4c 43       	clr.b	r12		;
     7ba:	4d 43       	clr.b	r13		;
     7bc:	89 12       	call	r9		;
     7be:	6e 42       	mov.b	#4,	r14	;r2 As==10
     7c0:	6c 42       	mov.b	#4,	r12	;r2 As==10
     7c2:	4d 43       	clr.b	r13		;
     7c4:	89 12       	call	r9		;
     7c6:	7e 40 80 ff 	mov.b	#65408,	r14	;#0xff80
     7ca:	7c 42       	mov.b	#8,	r12	;r2 As==11
     7cc:	4d 43       	clr.b	r13		;
     7ce:	89 12       	call	r9		;
     7d0:	4c 43       	clr.b	r12		;

000007d2 <.L105>:
     7d2:	03 43       	nop			
     7d4:	1c 53       	inc	r12		;
     7d6:	3c 90 e8 03 	cmp	#1000,	r12	;#0x03e8
     7da:	fb 23       	jnz	$-8      	;abs 0x7d2
     7dc:	3c 40 3f 32 	mov	#12863,	r12	;#0x323f
     7e0:	8a 12       	call	r10		;
     7e2:	39 40 f4 80 	mov	#33012,	r9	;#0x80f4

000007e6 <.L106>:
     7e6:	38 40 7e 00 	mov	#126,	r8	;#0x007e
     7ea:	3c 40 4d 32 	mov	#12877,	r12	;#0x324d
     7ee:	88 12       	call	r8		;
     7f0:	34 40 6e 02 	mov	#622,	r4	;#0x026e
     7f4:	7c 40 10 00 	mov.b	#16,	r12	;#0x0010
     7f8:	84 12       	call	r4		;
     7fa:	07 4c       	mov	r12,	r7	;
     7fc:	3c 40 61 32 	mov	#12897,	r12	;#0x3261
     800:	88 12       	call	r8		;
     802:	07 93       	cmp	#0,	r7	;r3 As==00
     804:	f0 27       	jz	$-30     	;abs 0x7e6
     806:	35 40 d4 14 	mov	#5332,	r5	;#0x14d4
     80a:	3d 40 63 32 	mov	#12899,	r13	;#0x3263
     80e:	3c 40 00 81 	mov	#33024,	r12	;#0x8100
     812:	85 12       	call	r5		;
     814:	06 4c       	mov	r12,	r6	;
     816:	3d 40 68 32 	mov	#12904,	r13	;#0x3268
     81a:	3c 40 00 81 	mov	#33024,	r12	;#0x8100
     81e:	85 12       	call	r5		;
     820:	0c 93       	cmp	#0,	r12	;r3 As==00
     822:	6d 24       	jz	$+220    	;abs 0x8fe
     824:	57 43       	mov.b	#1,	r7	;r3 As==01
     826:	06 93       	cmp	#0,	r6	;r3 As==00
     828:	01 24       	jz	$+4      	;abs 0x82c
     82a:	47 43       	clr.b	r7		;

0000082c <.L108>:
     82c:	3d 40 6f 32 	mov	#12911,	r13	;#0x326f
     830:	3c 40 00 81 	mov	#33024,	r12	;#0x8100
     834:	85 12       	call	r5		;
     836:	0c 93       	cmp	#0,	r12	;r3 As==00
     838:	02 20       	jnz	$+6      	;abs 0x83e
     83a:	77 40 03 00 	mov.b	#3,	r7	;

0000083e <.L110>:
     83e:	3d 40 72 32 	mov	#12914,	r13	;#0x3272
     842:	3c 40 00 81 	mov	#33024,	r12	;#0x8100
     846:	85 12       	call	r5		;
     848:	0c 93       	cmp	#0,	r12	;r3 As==00
     84a:	01 20       	jnz	$+4      	;abs 0x84e
     84c:	67 42       	mov.b	#4,	r7	;r2 As==10

0000084e <.L111>:
     84e:	3d 40 7b 32 	mov	#12923,	r13	;#0x327b
     852:	3c 40 00 81 	mov	#33024,	r12	;#0x8100
     856:	85 12       	call	r5		;
     858:	0c 93       	cmp	#0,	r12	;r3 As==00
     85a:	02 20       	jnz	$+6      	;abs 0x860
     85c:	77 40 05 00 	mov.b	#5,	r7	;

00000860 <.L112>:
     860:	3d 40 84 32 	mov	#12932,	r13	;#0x3284
     864:	3c 40 00 81 	mov	#33024,	r12	;#0x8100
     868:	85 12       	call	r5		;
     86a:	0c 93       	cmp	#0,	r12	;r3 As==00
     86c:	02 20       	jnz	$+6      	;abs 0x872
     86e:	77 40 06 00 	mov.b	#6,	r7	;

00000872 <.L113>:
     872:	3d 40 8e 32 	mov	#12942,	r13	;#0x328e
     876:	3c 40 00 81 	mov	#33024,	r12	;#0x8100
     87a:	85 12       	call	r5		;
     87c:	0c 93       	cmp	#0,	r12	;r3 As==00
     87e:	02 20       	jnz	$+6      	;abs 0x884
     880:	77 40 07 00 	mov.b	#7,	r7	;

00000884 <.L114>:
     884:	3d 40 98 32 	mov	#12952,	r13	;#0x3298
     888:	3c 40 00 81 	mov	#33024,	r12	;#0x8100
     88c:	85 12       	call	r5		;
     88e:	0c 93       	cmp	#0,	r12	;r3 As==00
     890:	01 20       	jnz	$+4      	;abs 0x894
     892:	77 42       	mov.b	#8,	r7	;r2 As==11

00000894 <.L115>:
     894:	3d 40 a0 32 	mov	#12960,	r13	;#0x32a0
     898:	3c 40 00 81 	mov	#33024,	r12	;#0x8100
     89c:	85 12       	call	r5		;
     89e:	0c 93       	cmp	#0,	r12	;r3 As==00
     8a0:	02 20       	jnz	$+6      	;abs 0x8a6
     8a2:	77 40 09 00 	mov.b	#9,	r7	;

000008a6 <.L116>:
     8a6:	3d 40 a8 32 	mov	#12968,	r13	;#0x32a8
     8aa:	3c 40 00 81 	mov	#33024,	r12	;#0x8100
     8ae:	85 12       	call	r5		;
     8b0:	0c 93       	cmp	#0,	r12	;r3 As==00
     8b2:	02 20       	jnz	$+6      	;abs 0x8b8
     8b4:	77 40 0b 00 	mov.b	#11,	r7	;#0x000b

000008b8 <.L117>:
     8b8:	3d 40 b1 32 	mov	#12977,	r13	;#0x32b1
     8bc:	3c 40 00 81 	mov	#33024,	r12	;#0x8100
     8c0:	85 12       	call	r5		;
     8c2:	0c 93       	cmp	#0,	r12	;r3 As==00
     8c4:	1f 20       	jnz	$+64     	;abs 0x904
     8c6:	3c 40 a0 ff 	mov	#65440,	r12	;#0xffa0

000008ca <.L118>:
     8ca:	bc b2 00 00 	bit	#8,	0(r12)	;r2 As==11
     8ce:	fd 23       	jnz	$-4      	;abs 0x8ca
     8d0:	30 40 e6 07 	br	#0x07e6		;

000008d4 <.L97>:
     8d4:	3e 50 00 6a 	add	#27136,	r14	;#0x6a00
     8d8:	3f 63       	addc	#-1,	r15	;r3 As==11
     8da:	1c 53       	inc	r12		;
     8dc:	30 40 5c 07 	br	#0x075c		;

000008e0 <.L103>:
     8e0:	6a 93       	cmp.b	#2,	r10	;r3 As==10
     8e2:	02 24       	jz	$+6      	;abs 0x8e8
     8e4:	6a 92       	cmp.b	#4,	r10	;r2 As==10
     8e6:	07 20       	jnz	$+16     	;abs 0x8f6

000008e8 <.L100>:
     8e8:	b0 12 5a 13 	call	#4954		;#0x135a

000008ec <.L102>:
     8ec:	5a 53       	inc.b	r10		;
     8ee:	3a f0 ff 00 	and	#255,	r10	;#0x00ff
     8f2:	30 40 6a 07 	br	#0x076a		;

000008f6 <.L101>:
     8f6:	b0 12 62 13 	call	#4962		;#0x1362
     8fa:	30 40 ec 08 	br	#0x08ec		;

000008fe <.L176>:
     8fe:	67 43       	mov.b	#2,	r7	;r3 As==10
     900:	30 40 2c 08 	br	#0x082c		;

00000904 <.L202>:
     904:	37 90 06 00 	cmp	#6,	r7	;
     908:	02 20       	jnz	$+6      	;abs 0x90e
     90a:	30 40 9c 0d 	br	#0x0d9c		;
     90e:	7f 40 06 00 	mov.b	#6,	r15	;
     912:	0f 97       	cmp	r7,	r15	;
     914:	81 28       	jnc	$+260    	;abs 0xa18
     916:	37 90 03 00 	cmp	#3,	r7	;
     91a:	ef 25       	jz	$+992    	;abs 0xcfa
     91c:	7c 40 03 00 	mov.b	#3,	r12	;
     920:	0c 97       	cmp	r7,	r12	;
     922:	08 28       	jnc	$+18     	;abs 0x934
     924:	17 93       	cmp	#1,	r7	;r3 As==01
     926:	bc 25       	jz	$+890    	;abs 0xca0
     928:	27 93       	cmp	#2,	r7	;r3 As==10
     92a:	bf 25       	jz	$+896    	;abs 0xcaa

0000092c <.L119>:
     92c:	3c 40 ff 36 	mov	#14079,	r12	;#0x36ff
     930:	30 40 a4 0c 	br	#0x0ca4		;

00000934 <.L123>:
     934:	27 92       	cmp	#4,	r7	;r2 As==10
     936:	02 20       	jnz	$+6      	;abs 0x93c
     938:	30 40 42 0d 	br	#0x0d42		;
     93c:	37 90 05 00 	cmp	#5,	r7	;
     940:	f5 23       	jnz	$-20     	;abs 0x92c
     942:	b0 12 92 05 	call	#1426		;#0x0592
     946:	07 4c       	mov	r12,	r7	;
     948:	08 4d       	mov	r13,	r8	;
     94a:	3c 40 f0 34 	mov	#13552,	r12	;#0x34f0
     94e:	8a 12       	call	r10		;
     950:	0c 47       	mov	r7,	r12	;
     952:	0d 48       	mov	r8,	r13	;
     954:	b0 12 34 06 	call	#1588		;#0x0634
     958:	3c 40 61 32 	mov	#12897,	r12	;#0x3261
     95c:	8a 12       	call	r10		;
     95e:	3c 40 03 35 	mov	#13571,	r12	;#0x3503
     962:	8a 12       	call	r10		;
     964:	0c 47       	mov	r7,	r12	;
     966:	0d 48       	mov	r8,	r13	;
     968:	b0 12 9e 13 	call	#5022		;#0x139e
     96c:	45 4c       	mov.b	r12,	r5	;
     96e:	36 40 96 12 	mov	#4758,	r6	;#0x1296
     972:	7d 40 64 00 	mov.b	#100,	r13	;#0x0064
     976:	0c 45       	mov	r5,	r12	;
     978:	86 12       	call	r6		;
     97a:	44 4c       	mov.b	r12,	r4	;
     97c:	38 40 00 81 	mov	#33024,	r8	;#0x8100
     980:	4e 44       	mov.b	r4,	r14	;
     982:	7e 50 30 00 	add.b	#48,	r14	;#0x0030
     986:	c8 4e 00 00 	mov.b	r14,	0(r8)	;
     98a:	7d 40 0a 00 	mov.b	#10,	r13	;#0x000a
     98e:	0c 45       	mov	r5,	r12	;
     990:	86 12       	call	r6		;
     992:	7c 50 30 00 	add.b	#48,	r12	;#0x0030
     996:	4d 44       	mov.b	r4,	r13	;
     998:	4d 54       	add.b	r4,	r13	;
     99a:	4d 5d       	rla.b	r13		;
     99c:	4d 54       	add.b	r4,	r13	;
     99e:	4d 5d       	rla.b	r13		;
     9a0:	4c 8d       	sub.b	r13,	r12	;
     9a2:	c8 4c 01 00 	mov.b	r12,	1(r8)	;
     9a6:	34 40 9e 12 	mov	#4766,	r4	;#0x129e
     9aa:	7d 40 0a 00 	mov.b	#10,	r13	;#0x000a
     9ae:	0c 45       	mov	r5,	r12	;
     9b0:	84 12       	call	r4		;
     9b2:	7c 50 30 00 	add.b	#48,	r12	;#0x0030
     9b6:	c8 4c 02 00 	mov.b	r12,	2(r8)	;
     9ba:	c2 43 03 81 	mov.b	#0,	&0x8103	;r3 As==00
     9be:	0c 48       	mov	r8,	r12	;
     9c0:	8a 12       	call	r10		;
     9c2:	3c 40 1a 35 	mov	#13594,	r12	;#0x351a
     9c6:	8a 12       	call	r10		;
     9c8:	37 f0 ff 00 	and	#255,	r7	;#0x00ff
     9cc:	7d 40 64 00 	mov.b	#100,	r13	;#0x0064
     9d0:	0c 47       	mov	r7,	r12	;
     9d2:	86 12       	call	r6		;
     9d4:	45 4c       	mov.b	r12,	r5	;
     9d6:	4c 45       	mov.b	r5,	r12	;
     9d8:	7c 50 30 00 	add.b	#48,	r12	;#0x0030
     9dc:	c8 4c 00 00 	mov.b	r12,	0(r8)	;
     9e0:	7d 40 0a 00 	mov.b	#10,	r13	;#0x000a
     9e4:	0c 47       	mov	r7,	r12	;
     9e6:	86 12       	call	r6		;
     9e8:	7c 50 30 00 	add.b	#48,	r12	;#0x0030
     9ec:	4d 45       	mov.b	r5,	r13	;
     9ee:	4d 55       	add.b	r5,	r13	;
     9f0:	4d 5d       	rla.b	r13		;
     9f2:	4d 55       	add.b	r5,	r13	;
     9f4:	4d 5d       	rla.b	r13		;
     9f6:	4c 8d       	sub.b	r13,	r12	;
     9f8:	c8 4c 01 00 	mov.b	r12,	1(r8)	;
     9fc:	7d 40 0a 00 	mov.b	#10,	r13	;#0x000a
     a00:	0c 47       	mov	r7,	r12	;
     a02:	84 12       	call	r4		;
     a04:	7c 50 30 00 	add.b	#48,	r12	;#0x0030
     a08:	c8 4c 02 00 	mov.b	r12,	2(r8)	;
     a0c:	c2 43 03 81 	mov.b	#0,	&0x8103	;r3 As==00
     a10:	0c 48       	mov	r8,	r12	;
     a12:	8a 12       	call	r10		;
     a14:	30 40 f0 0c 	br	#0x0cf0		;

00000a18 <.L121>:
     a18:	37 90 09 00 	cmp	#9,	r7	;
     a1c:	02 20       	jnz	$+6      	;abs 0xa22
     a1e:	30 40 9e 0f 	br	#0x0f9e		;
     a22:	7d 40 09 00 	mov.b	#9,	r13	;
     a26:	0d 97       	cmp	r7,	r13	;
     a28:	98 28       	jnc	$+306    	;abs 0xb5a
     a2a:	37 90 07 00 	cmp	#7,	r7	;
     a2e:	02 20       	jnz	$+6      	;abs 0xa34
     a30:	30 40 20 0f 	br	#0x0f20		;
     a34:	37 92       	cmp	#8,	r7	;r2 As==11
     a36:	7a 23       	jnz	$-266    	;abs 0x92c
     a38:	3c 40 1e 35 	mov	#13598,	r12	;#0x351e
     a3c:	88 12       	call	r8		;
     a3e:	3c 40 41 35 	mov	#13633,	r12	;#0x3541
     a42:	88 12       	call	r8		;
     a44:	7c 40 09 00 	mov.b	#9,	r12	;
     a48:	84 12       	call	r4		;
     a4a:	b0 12 d0 01 	call	#464		;#0x01d0
     a4e:	81 4c 18 00 	mov	r12,	24(r1)	; 0x0018
     a52:	81 4d 1a 00 	mov	r13,	26(r1)	; 0x001a
     a56:	3c 40 6d 35 	mov	#13677,	r12	;#0x356d
     a5a:	88 12       	call	r8		;
     a5c:	7c 40 10 00 	mov.b	#16,	r12	;#0x0010
     a60:	84 12       	call	r4		;
     a62:	3d 40 84 35 	mov	#13700,	r13	;#0x3584
     a66:	3c 40 00 81 	mov	#33024,	r12	;#0x8100
     a6a:	85 12       	call	r5		;
     a6c:	0c 93       	cmp	#0,	r12	;r3 As==00
     a6e:	02 24       	jz	$+6      	;abs 0xa74
     a70:	30 40 5a 0f 	br	#0x0f5a		;
     a74:	d2 43 fe 80 	mov.b	#1,	&0x80fe	;r3 As==01

00000a78 <.L150>:
     a78:	3c 40 86 35 	mov	#13702,	r12	;#0x3586
     a7c:	88 12       	call	r8		;
     a7e:	5c 43       	mov.b	#1,	r12	;r3 As==01
     a80:	84 12       	call	r4		;
     a82:	3d 40 84 35 	mov	#13700,	r13	;#0x3584
     a86:	3c 40 00 81 	mov	#33024,	r12	;#0x8100
     a8a:	85 12       	call	r5		;
     a8c:	0c 93       	cmp	#0,	r12	;r3 As==00
     a8e:	02 24       	jz	$+6      	;abs 0xa94
     a90:	30 40 62 0f 	br	#0x0f62		;
     a94:	d2 43 ff 80 	mov.b	#1,	&0x80ff	;r3 As==01

00000a98 <.L152>:
     a98:	b0 12 92 05 	call	#1426		;#0x0592
     a9c:	81 4c 1c 00 	mov	r12,	28(r1)	; 0x001c
     aa0:	81 4d 1e 00 	mov	r13,	30(r1)	; 0x001e
     aa4:	5c 42 fe 80 	mov.b	&0x80fe,r12	;0x80fe
     aa8:	c2 93 ff 80 	cmp.b	#0,	&0x80ff	;r3 As==00
     aac:	02 24       	jz	$+6      	;abs 0xab2
     aae:	30 40 6a 0f 	br	#0x0f6a		;
     ab2:	0c 93       	cmp	#0,	r12	;r3 As==00
     ab4:	02 20       	jnz	$+6      	;abs 0xaba
     ab6:	30 40 7a 0f 	br	#0x0f7a		;
     aba:	35 40 30 01 	mov	#304,	r5	;#0x0130
     abe:	34 40 00 20 	mov	#8192,	r4	;#0x2000
     ac2:	b1 40 3f 01 	mov	#319,	20(r1)	;#0x013f, 0x0014
     ac6:	14 00 

00000ac8 <.L208>:
     ac8:	b1 40 00 20 	mov	#8192,	22(r1)	;#0x2000, 0x0016
     acc:	16 00 
     ace:	3f 40 2e 03 	mov	#814,	r15	;#0x032e
     ad2:	81 4f 0e 00 	mov	r15,	14(r1)	; 0x000e
     ad6:	8f 12       	call	r15		;
     ad8:	36 40 be 01 	mov	#446,	r6	;#0x01be
     adc:	4c 43       	clr.b	r12		;
     ade:	86 12       	call	r6		;
     ae0:	38 40 50 06 	mov	#1616,	r8	;#0x0650
     ae4:	7c 40 03 00 	mov.b	#3,	r12	;
     ae8:	4d 43       	clr.b	r13		;
     aea:	88 12       	call	r8		;
     aec:	1c 41 14 00 	mov	20(r1),	r12	;0x00014
     af0:	1d 41 16 00 	mov	22(r1),	r13	;0x00016
     af4:	88 12       	call	r8		;
     af6:	1c 41 18 00 	mov	24(r1),	r12	;0x00018
     afa:	1d 41 1a 00 	mov	26(r1),	r13	;0x0001a
     afe:	88 12       	call	r8		;
     b00:	1c 41 1c 00 	mov	28(r1),	r12	;0x0001c
     b04:	1d 41 1e 00 	mov	30(r1),	r13	;0x0001e
     b08:	88 12       	call	r8		;
     b0a:	37 40 ea 02 	mov	#746,	r7	;#0x02ea
     b0e:	87 12       	call	r7		;
     b10:	1f 41 0e 00 	mov	14(r1),	r15	;0x0000e
     b14:	8f 12       	call	r15		;
     b16:	5c 43       	mov.b	#1,	r12	;r3 As==01
     b18:	86 12       	call	r6		;
     b1a:	3c 43       	mov	#-1,	r12	;r3 As==11
     b1c:	4d 43       	clr.b	r13		;
     b1e:	88 12       	call	r8		;
     b20:	08 4c       	mov	r12,	r8	;
     b22:	06 4d       	mov	r13,	r6	;
     b24:	87 12       	call	r7		;
     b26:	08 95       	cmp	r5,	r8	;
     b28:	03 20       	jnz	$+8      	;abs 0xb30
     b2a:	36 90 00 20 	cmp	#8192,	r6	;#0x2000
     b2e:	5b 26       	jz	$-840    	;abs 0x7e6

00000b30 <.L183>:
     b30:	81 45 0a 00 	mov	r5,	10(r1)	; 0x000a
     b34:	81 44 0c 00 	mov	r4,	12(r1)	; 0x000c
     b38:	81 48 06 00 	mov	r8,	6(r1)	;
     b3c:	81 46 08 00 	mov	r6,	8(r1)	;

00000b40 <.L207>:
     b40:	91 41 14 00 	mov	20(r1),	2(r1)	;0x00014
     b44:	02 00 
     b46:	91 41 16 00 	mov	22(r1),	4(r1)	;0x00016
     b4a:	04 00 
     b4c:	b1 40 e8 35 	mov	#13800,	0(r1)	;#0x35e8
     b50:	00 00 
     b52:	b0 12 de 13 	call	#5086		;#0x13de
     b56:	30 40 e6 07 	br	#0x07e6		;

00000b5a <.L129>:
     b5a:	37 90 0a 00 	cmp	#10,	r7	;#0x000a
     b5e:	02 20       	jnz	$+6      	;abs 0xb64
     b60:	30 40 94 10 	br	#0x1094		;
     b64:	37 90 0b 00 	cmp	#11,	r7	;#0x000b
     b68:	e1 22       	jnz	$-572    	;abs 0x92c
     b6a:	3c 40 e6 36 	mov	#14054,	r12	;#0x36e6
     b6e:	88 12       	call	r8		;
     b70:	3c 40 4d 36 	mov	#13901,	r12	;#0x364d
     b74:	88 12       	call	r8		;
     b76:	7c 40 09 00 	mov.b	#9,	r12	;
     b7a:	84 12       	call	r4		;
     b7c:	b0 12 d0 01 	call	#464		;#0x01d0
     b80:	81 4c 14 00 	mov	r12,	20(r1)	; 0x0014
     b84:	81 4d 16 00 	mov	r13,	22(r1)	; 0x0016
     b88:	3c 40 6d 35 	mov	#13677,	r12	;#0x356d
     b8c:	88 12       	call	r8		;
     b8e:	7c 40 10 00 	mov.b	#16,	r12	;#0x0010
     b92:	84 12       	call	r4		;
     b94:	3d 40 84 35 	mov	#13700,	r13	;#0x3584
     b98:	3c 40 00 81 	mov	#33024,	r12	;#0x8100
     b9c:	85 12       	call	r5		;
     b9e:	0c 93       	cmp	#0,	r12	;r3 As==00
     ba0:	02 24       	jz	$+6      	;abs 0xba6
     ba2:	30 40 d0 11 	br	#0x11d0		;
     ba6:	d2 43 fe 80 	mov.b	#1,	&0x80fe	;r3 As==01

00000baa <.L171>:
     baa:	3c 40 86 35 	mov	#13702,	r12	;#0x3586
     bae:	88 12       	call	r8		;
     bb0:	5c 43       	mov.b	#1,	r12	;r3 As==01
     bb2:	84 12       	call	r4		;
     bb4:	3d 40 84 35 	mov	#13700,	r13	;#0x3584
     bb8:	3c 40 00 81 	mov	#33024,	r12	;#0x8100
     bbc:	85 12       	call	r5		;
     bbe:	0c 93       	cmp	#0,	r12	;r3 As==00
     bc0:	02 24       	jz	$+6      	;abs 0xbc6
     bc2:	30 40 d8 11 	br	#0x11d8		;
     bc6:	d2 43 ff 80 	mov.b	#1,	&0x80ff	;r3 As==01

00000bca <.L173>:
     bca:	35 40 2e 03 	mov	#814,	r5	;#0x032e
     bce:	85 12       	call	r5		;
     bd0:	36 40 be 01 	mov	#446,	r6	;#0x01be
     bd4:	4c 43       	clr.b	r12		;
     bd6:	86 12       	call	r6		;
     bd8:	37 40 50 06 	mov	#1616,	r7	;#0x0650
     bdc:	6c 43       	mov.b	#2,	r12	;r3 As==10
     bde:	4d 43       	clr.b	r13		;
     be0:	87 12       	call	r7		;
     be2:	3c 40 6f 01 	mov	#367,	r12	;#0x016f
     be6:	3d 40 00 20 	mov	#8192,	r13	;#0x2000
     bea:	87 12       	call	r7		;
     bec:	1c 41 14 00 	mov	20(r1),	r12	;0x00014
     bf0:	1d 41 16 00 	mov	22(r1),	r13	;0x00016
     bf4:	87 12       	call	r7		;
     bf6:	34 40 ea 02 	mov	#746,	r4	;#0x02ea
     bfa:	84 12       	call	r4		;
     bfc:	85 12       	call	r5		;
     bfe:	5c 43       	mov.b	#1,	r12	;r3 As==01
     c00:	86 12       	call	r6		;
     c02:	81 43 38 00 	mov	#0,	56(r1)	;r3 As==00, 0x0038
     c06:	b1 40 ff 00 	mov	#255,	58(r1)	;#0x00ff, 0x003a
     c0a:	3a 00 
     c0c:	b1 43 3c 00 	mov	#-1,	60(r1)	;r3 As==11, 0x003c
     c10:	3c 43       	mov	#-1,	r12	;r3 As==11
     c12:	3d 43       	mov	#-1,	r13	;r3 As==11
     c14:	87 12       	call	r7		;
     c16:	06 4c       	mov	r12,	r6	;
     c18:	07 4d       	mov	r13,	r7	;
     c1a:	0d 41       	mov	r1,	r13	;
     c1c:	3d 50 38 00 	add	#56,	r13	;#0x0038
     c20:	0c 41       	mov	r1,	r12	;
     c22:	3c 50 20 00 	add	#32,	r12	;#0x0020
     c26:	b0 12 68 01 	call	#360		;#0x0168
     c2a:	99 41 20 00 	mov	32(r1),	0(r9)	;0x00020
     c2e:	00 00 
     c30:	99 41 22 00 	mov	34(r1),	2(r9)	;0x00022
     c34:	02 00 
     c36:	3e 40 f8 80 	mov	#33016,	r14	;#0x80f8
     c3a:	9e 41 24 00 	mov	36(r1),	0(r14)	;0x00024
     c3e:	00 00 
     c40:	84 12       	call	r4		;
     c42:	36 90 60 02 	cmp	#608,	r6	;#0x0260
     c46:	03 20       	jnz	$+8      	;abs 0xc4e
     c48:	37 90 00 20 	cmp	#8192,	r7	;#0x2000
     c4c:	15 24       	jz	$+44     	;abs 0xc78

00000c4e <.L186>:
     c4e:	b1 40 60 02 	mov	#608,	10(r1)	;#0x0260, 0x000a
     c52:	0a 00 
     c54:	b1 40 00 20 	mov	#8192,	12(r1)	;#0x2000, 0x000c
     c58:	0c 00 
     c5a:	81 46 06 00 	mov	r6,	6(r1)	;
     c5e:	81 47 08 00 	mov	r7,	8(r1)	;
     c62:	b1 40 6f 01 	mov	#367,	2(r1)	;#0x016f
     c66:	02 00 
     c68:	b1 40 00 20 	mov	#8192,	4(r1)	;#0x2000
     c6c:	04 00 
     c6e:	b1 40 74 36 	mov	#13940,	0(r1)	;#0x3674
     c72:	00 00 
     c74:	b0 12 de 13 	call	#5086		;#0x13de

00000c78 <.L174>:
     c78:	15 49 02 00 	mov	2(r9),	r5	;
     c7c:	16 49 04 00 	mov	4(r9),	r6	;
     c80:	37 40 02 06 	mov	#1538,	r7	;#0x0602
     c84:	2c 49       	mov	@r9,	r12	;
     c86:	87 12       	call	r7		;
     c88:	3c 40 1c 35 	mov	#13596,	r12	;#0x351c
     c8c:	88 12       	call	r8		;
     c8e:	0c 45       	mov	r5,	r12	;
     c90:	87 12       	call	r7		;
     c92:	3c 40 1c 35 	mov	#13596,	r12	;#0x351c
     c96:	88 12       	call	r8		;
     c98:	0c 46       	mov	r6,	r12	;
     c9a:	87 12       	call	r7		;
     c9c:	30 40 e6 07 	br	#0x07e6		;

00000ca0 <.L124>:
     ca0:	3c 40 b7 32 	mov	#12983,	r12	;#0x32b7

00000ca4 <.L204>:
     ca4:	88 12       	call	r8		;
     ca6:	30 40 e6 07 	br	#0x07e6		;

00000caa <.L125>:
     caa:	3c 40 85 34 	mov	#13445,	r12	;#0x3485
     cae:	8a 12       	call	r10		;
     cb0:	d2 43 10 81 	mov.b	#1,	&0x8110	;r3 As==01
     cb4:	f2 40 7f 00 	mov.b	#127,	&0x8111	;#0x007f
     cb8:	11 81 
     cba:	38 40 56 04 	mov	#1110,	r8	;#0x0456
     cbe:	5e 43       	mov.b	#1,	r14	;r3 As==01
     cc0:	4d 47       	mov.b	r7,	r13	;
     cc2:	7c 40 21 00 	mov.b	#33,	r12	;#0x0021
     cc6:	88 12       	call	r8		;
     cc8:	d2 43 10 81 	mov.b	#1,	&0x8110	;r3 As==01
     ccc:	4e 43       	clr.b	r14		;
     cce:	5d 43       	mov.b	#1,	r13	;r3 As==01
     cd0:	7c 40 21 00 	mov.b	#33,	r12	;#0x0021
     cd4:	88 12       	call	r8		;
     cd6:	5d 43       	mov.b	#1,	r13	;r3 As==01
     cd8:	7c 40 21 00 	mov.b	#33,	r12	;#0x0021
     cdc:	b0 12 b4 03 	call	#948		;#0x03b4
     ce0:	3c 40 9c 34 	mov	#13468,	r12	;#0x349c
     ce4:	8a 12       	call	r10		;
     ce6:	5c 42 10 81 	mov.b	&0x8110,r12	;0x8110
     cea:	4d 43       	clr.b	r13		;
     cec:	b0 12 34 06 	call	#1588		;#0x0634

00000cf0 <.L205>:
     cf0:	3c 40 61 32 	mov	#12897,	r12	;#0x3261
     cf4:	8a 12       	call	r10		;
     cf6:	30 40 e6 07 	br	#0x07e6		;

00000cfa <.L122>:
     cfa:	7d 40 06 00 	mov.b	#6,	r13	;
     cfe:	7c 40 fa ff 	mov.b	#65530,	r12	;#0xfffa
     d02:	b0 12 ee 04 	call	#1262		;#0x04ee
     d06:	3c 40 10 81 	mov	#33040,	r12	;#0x8110
     d0a:	56 4c 04 00 	mov.b	4(r12),	r6	;
     d0e:	06 56       	rla	r6		;
     d10:	06 56       	rla	r6		;
     d12:	06 56       	rla	r6		;
     d14:	06 56       	rla	r6		;
     d16:	06 56       	rla	r6		;
     d18:	06 56       	rla	r6		;
     d1a:	06 56       	rla	r6		;
     d1c:	06 56       	rla	r6		;
     d1e:	5c 4c 05 00 	mov.b	5(r12),	r12	;
     d22:	06 5c       	add	r12,	r6	;
     d24:	36 b0 00 80 	bit	#32768,	r6	;#0x8000
     d28:	07 77       	subc	r7,	r7	;
     d2a:	37 e3       	inv	r7		;
     d2c:	3c 40 aa 34 	mov	#13482,	r12	;#0x34aa
     d30:	88 12       	call	r8		;
     d32:	0c 46       	mov	r6,	r12	;
     d34:	0d 47       	mov	r7,	r13	;
     d36:	b0 12 34 06 	call	#1588		;#0x0634

00000d3a <.L206>:
     d3a:	3c 40 61 32 	mov	#12897,	r12	;#0x3261
     d3e:	30 40 a4 0c 	br	#0x0ca4		;

00000d42 <.L126>:
     d42:	3c 40 c4 34 	mov	#13508,	r12	;#0x34c4
     d46:	8a 12       	call	r10		;
     d48:	7c 40 09 00 	mov.b	#9,	r12	;
     d4c:	84 12       	call	r4		;
     d4e:	b0 12 d0 01 	call	#464		;#0x01d0
     d52:	07 4c       	mov	r12,	r7	;
     d54:	06 4d       	mov	r13,	r6	;
     d56:	38 40 10 81 	mov	#33040,	r8	;#0x8110
     d5a:	c2 43 10 81 	mov.b	#0,	&0x8110	;r3 As==00
     d5e:	c8 4c 01 00 	mov.b	r12,	1(r8)	;
     d62:	b0 12 9e 13 	call	#5022		;#0x139e
     d66:	c8 4c 02 00 	mov.b	r12,	2(r8)	;
     d6a:	0c 47       	mov	r7,	r12	;
     d6c:	0d 46       	mov	r6,	r13	;
     d6e:	7e 40 10 00 	mov.b	#16,	r14	;#0x0010
     d72:	b0 12 d8 13 	call	#5080		;#0x13d8
     d76:	c8 4c 03 00 	mov.b	r12,	3(r8)	;
     d7a:	0c 47       	mov	r7,	r12	;
     d7c:	0d 46       	mov	r6,	r13	;
     d7e:	7e 40 18 00 	mov.b	#24,	r14	;#0x0018
     d82:	b0 12 d8 13 	call	#5080		;#0x13d8
     d86:	c8 4c 04 00 	mov.b	r12,	4(r8)	;
     d8a:	5e 43       	mov.b	#1,	r14	;r3 As==01
     d8c:	7d 40 05 00 	mov.b	#5,	r13	;
     d90:	7c 40 53 00 	mov.b	#83,	r12	;#0x0053
     d94:	b0 12 56 04 	call	#1110		;#0x0456
     d98:	30 40 e6 07 	br	#0x07e6		;

00000d9c <.L120>:
     d9c:	3c 40 c4 34 	mov	#13508,	r12	;#0x34c4
     da0:	88 12       	call	r8		;
     da2:	7c 40 0d 00 	mov.b	#13,	r12	;#0x000d
     da6:	84 12       	call	r4		;
     da8:	38 40 f0 14 	mov	#5360,	r8	;#0x14f0
     dac:	3c 40 00 81 	mov	#33024,	r12	;#0x8100
     db0:	88 12       	call	r8		;
     db2:	05 4c       	mov	r12,	r5	;
     db4:	07 41       	mov	r1,	r7	;
     db6:	37 50 38 00 	add	#56,	r7	;#0x0038
     dba:	4c 43       	clr.b	r12		;
     dbc:	04 4c       	mov	r12,	r4	;
     dbe:	0e 45       	mov	r5,	r14	;
     dc0:	3e 53       	add	#-1,	r14	;r3 As==11
     dc2:	81 4e 14 00 	mov	r14,	20(r1)	; 0x0014

00000dc6 <.L144>:
     dc6:	06 4c       	mov	r12,	r6	;
     dc8:	26 52       	add	#4,	r6	;r2 As==10
     dca:	0d 4c       	mov	r12,	r13	;

00000dcc <.L135>:
     dcc:	0d 96       	cmp	r6,	r13	;
     dce:	3f 28       	jnc	$+128    	;abs 0xe4e
     dd0:	0c 41       	mov	r1,	r12	;
     dd2:	3c 50 32 00 	add	#50,	r12	;#0x0032
     dd6:	b0 12 f0 14 	call	#5360		;#0x14f0
     dda:	0b 4c       	mov	r12,	r11	;
     ddc:	08 4c       	mov	r12,	r8	;
     dde:	38 50 ff 3f 	add	#16383,	r8	;#0x3fff
     de2:	08 58       	rla	r8		;
     de4:	08 58       	rla	r8		;
     de6:	4e 43       	clr.b	r14		;
     de8:	0f 4e       	mov	r14,	r15	;

00000dea <.L138>:
     dea:	0e 9b       	cmp	r11,	r14	;
     dec:	3f 20       	jnz	$+128    	;abs 0xe6c
     dee:	87 4f 00 00 	mov	r15,	0(r7)	;
     df2:	81 94 14 00 	cmp	r4,	20(r1)	; 0x0014
     df6:	05 24       	jz	$+12     	;abs 0xe02
     df8:	27 53       	incd	r7		;
     dfa:	0c 46       	mov	r6,	r12	;
     dfc:	36 90 0c 00 	cmp	#12,	r6	;#0x000c
     e00:	e2 23       	jnz	$-58     	;abs 0xdc6

00000e02 <.L145>:
     e02:	91 41 38 00 	mov	56(r1),	50(r1)	;0x00038, 0x0032
     e06:	32 00 
     e08:	91 41 3a 00 	mov	58(r1),	52(r1)	;0x0003a, 0x0034
     e0c:	34 00 
     e0e:	91 41 3c 00 	mov	60(r1),	54(r1)	;0x0003c, 0x0036
     e12:	36 00 
     e14:	c2 43 10 81 	mov.b	#0,	&0x8110	;r3 As==00
     e18:	08 41       	mov	r1,	r8	;
     e1a:	38 50 36 00 	add	#54,	r8	;#0x0036
     e1e:	44 43       	clr.b	r4		;
     e20:	35 40 10 81 	mov	#33040,	r5	;#0x8110
     e24:	36 40 56 04 	mov	#1110,	r6	;#0x0456

00000e28 <.L148>:
     e28:	4e 44       	mov.b	r4,	r14	;
     e2a:	3e f0 ff 00 	and	#255,	r14	;#0x00ff
     e2e:	24 53       	incd	r4		;

00000e30 <.L146>:
     e30:	0e 94       	cmp	r4,	r14	;
     e32:	61 38       	jl	$+196    	;abs 0xef6
     e34:	5e 43       	mov.b	#1,	r14	;r3 As==01
     e36:	7d 40 07 00 	mov.b	#7,	r13	;
     e3a:	7c 40 53 00 	mov.b	#83,	r12	;#0x0053
     e3e:	86 12       	call	r6		;
     e40:	38 50 fe ff 	add	#65534,	r8	;#0xfffe
     e44:	34 90 06 00 	cmp	#6,	r4	;
     e48:	ef 23       	jnz	$-32     	;abs 0xe28
     e4a:	30 40 e6 07 	br	#0x07e6		;

00000e4e <.L137>:
     e4e:	0d 95       	cmp	r5,	r13	;
     e50:	0a 2c       	jc	$+22     	;abs 0xe66
     e52:	0e 4d       	mov	r13,	r14	;
     e54:	0e 8c       	sub	r12,	r14	;
     e56:	7f 40 32 00 	mov.b	#50,	r15	;#0x0032
     e5a:	0f 51       	add	r1,	r15	;
     e5c:	0e 5f       	add	r15,	r14	;
     e5e:	de 4d 00 81 	mov.b	-32512(r13),0(r14)	;0xffff8100
     e62:	00 00 
     e64:	04 4d       	mov	r13,	r4	;

00000e66 <.L136>:
     e66:	1d 53       	inc	r13		;
     e68:	30 40 cc 0d 	br	#0x0dcc		;

00000e6c <.L142>:
     e6c:	7c 40 32 00 	mov.b	#50,	r12	;#0x0032
     e70:	0c 51       	add	r1,	r12	;
     e72:	0c 5e       	add	r14,	r12	;
     e74:	6c 4c       	mov.b	@r12,	r12	;
     e76:	4d 4c       	mov.b	r12,	r13	;
     e78:	7d 50 d0 ff 	add.b	#65488,	r13	;#0xffd0
     e7c:	c1 4d 18 00 	mov.b	r13,	24(r1)	; 0x0018
     e80:	7d 40 09 00 	mov.b	#9,	r13	;
     e84:	5d 91 18 00 	cmp.b	24(r1),	r13	;0x00018
     e88:	17 28       	jnc	$+48     	;abs 0xeb8
     e8a:	3c 50 d0 ff 	add	#65488,	r12	;#0xffd0

00000e8e <.L140>:
     e8e:	0d 48       	mov	r8,	r13	;
     e90:	81 4b 12 00 	mov	r11,	18(r1)	; 0x0012
     e94:	81 4e 10 00 	mov	r14,	16(r1)	; 0x0010
     e98:	81 4f 0e 00 	mov	r15,	14(r1)	; 0x000e
     e9c:	b0 12 da 12 	call	#4826		;#0x12da
     ea0:	1f 41 0e 00 	mov	14(r1),	r15	;0x0000e
     ea4:	0f 5c       	add	r12,	r15	;
     ea6:	1e 41 10 00 	mov	16(r1),	r14	;0x00010
     eaa:	1e 53       	inc	r14		;
     eac:	38 50 fc ff 	add	#65532,	r8	;#0xfffc
     eb0:	1b 41 12 00 	mov	18(r1),	r11	;0x00012
     eb4:	30 40 ea 0d 	br	#0x0dea		;

00000eb8 <.L139>:
     eb8:	4d 4c       	mov.b	r12,	r13	;
     eba:	7d 50 9f ff 	add.b	#65439,	r13	;#0xff9f
     ebe:	c1 4d 18 00 	mov.b	r13,	24(r1)	; 0x0018
     ec2:	7d 40 05 00 	mov.b	#5,	r13	;
     ec6:	5d 91 18 00 	cmp.b	24(r1),	r13	;0x00018
     eca:	04 28       	jnc	$+10     	;abs 0xed4
     ecc:	3c 50 a9 ff 	add	#65449,	r12	;#0xffa9
     ed0:	30 40 8e 0e 	br	#0x0e8e		;

00000ed4 <.L141>:
     ed4:	4d 4c       	mov.b	r12,	r13	;
     ed6:	7d 50 bf ff 	add.b	#65471,	r13	;#0xffbf
     eda:	c1 4d 18 00 	mov.b	r13,	24(r1)	; 0x0018
     ede:	7d 40 05 00 	mov.b	#5,	r13	;
     ee2:	5d 91 18 00 	cmp.b	24(r1),	r13	;0x00018
     ee6:	04 28       	jnc	$+10     	;abs 0xef0
     ee8:	3c 50 c9 ff 	add	#65481,	r12	;#0xffc9
     eec:	30 40 8e 0e 	br	#0x0e8e		;

00000ef0 <.L178>:
     ef0:	4c 43       	clr.b	r12		;
     ef2:	30 40 8e 0e 	br	#0x0e8e		;

00000ef6 <.L147>:
     ef6:	07 45       	mov	r5,	r7	;
     ef8:	07 5e       	add	r14,	r7	;
     efa:	17 53       	inc	r7		;
     efc:	0d 4e       	mov	r14,	r13	;
     efe:	0d 5e       	add	r14,	r13	;
     f00:	0d 5d       	rla	r13		;
     f02:	0d 5d       	rla	r13		;
     f04:	2c 48       	mov	@r8,	r12	;
     f06:	81 4e 10 00 	mov	r14,	16(r1)	; 0x0010
     f0a:	b0 12 6e 13 	call	#4974		;#0x136e
     f0e:	c7 4c 00 00 	mov.b	r12,	0(r7)	;
     f12:	1e 41 10 00 	mov	16(r1),	r14	;0x00010
     f16:	5e 53       	inc.b	r14		;
     f18:	3e f0 ff 00 	and	#255,	r14	;#0x00ff
     f1c:	30 40 30 0e 	br	#0x0e30		;

00000f20 <.L130>:
     f20:	0c 41       	mov	r1,	r12	;
     f22:	3c 50 2c 00 	add	#44,	r12	;#0x002c
     f26:	b0 12 22 05 	call	#1314		;#0x0522
     f2a:	3c 40 f0 34 	mov	#13552,	r12	;#0x34f0
     f2e:	88 12       	call	r8		;
     f30:	15 41 2e 00 	mov	46(r1),	r5	;0x0002e
     f34:	16 41 30 00 	mov	48(r1),	r6	;0x00030
     f38:	37 40 02 06 	mov	#1538,	r7	;#0x0602
     f3c:	1c 41 2c 00 	mov	44(r1),	r12	;0x0002c
     f40:	87 12       	call	r7		;
     f42:	3c 40 1c 35 	mov	#13596,	r12	;#0x351c
     f46:	88 12       	call	r8		;
     f48:	0c 45       	mov	r5,	r12	;
     f4a:	87 12       	call	r7		;
     f4c:	3c 40 1c 35 	mov	#13596,	r12	;#0x351c
     f50:	88 12       	call	r8		;
     f52:	0c 46       	mov	r6,	r12	;
     f54:	87 12       	call	r7		;
     f56:	30 40 3a 0d 	br	#0x0d3a		;

00000f5a <.L149>:
     f5a:	c2 43 fe 80 	mov.b	#0,	&0x80fe	;r3 As==00
     f5e:	30 40 78 0a 	br	#0x0a78		;

00000f62 <.L151>:
     f62:	c2 43 ff 80 	mov.b	#0,	&0x80ff	;r3 As==00
     f66:	30 40 98 0a 	br	#0x0a98		;

00000f6a <.L153>:
     f6a:	0c 93       	cmp	#0,	r12	;r3 As==00
     f6c:	0f 24       	jz	$+32     	;abs 0xf8c

00000f6e <.L168>:
     f6e:	3c 40 a8 35 	mov	#13736,	r12	;#0x35a8
     f72:	b0 12 c8 14 	call	#5320		;#0x14c8
     f76:	30 40 e6 07 	br	#0x07e6		;

00000f7a <.L179>:
     f7a:	35 40 10 01 	mov	#272,	r5	;#0x0110
     f7e:	34 40 00 20 	mov	#8192,	r4	;#0x2000
     f82:	b1 40 1f 01 	mov	#287,	20(r1)	;#0x011f, 0x0014
     f86:	14 00 
     f88:	30 40 c8 0a 	br	#0x0ac8		;

00000f8c <.L180>:
     f8c:	35 40 70 02 	mov	#624,	r5	;#0x0270
     f90:	34 40 00 20 	mov	#8192,	r4	;#0x2000
     f94:	b1 40 7f 01 	mov	#383,	20(r1)	;#0x017f, 0x0014
     f98:	14 00 
     f9a:	30 40 c8 0a 	br	#0x0ac8		;

00000f9e <.L128>:
     f9e:	3c 40 35 36 	mov	#13877,	r12	;#0x3635
     fa2:	88 12       	call	r8		;
     fa4:	3c 40 4d 36 	mov	#13901,	r12	;#0x364d
     fa8:	88 12       	call	r8		;
     faa:	0c 47       	mov	r7,	r12	;
     fac:	84 12       	call	r4		;
     fae:	b0 12 d0 01 	call	#464		;#0x01d0
     fb2:	06 4c       	mov	r12,	r6	;
     fb4:	07 4d       	mov	r13,	r7	;
     fb6:	3c 40 6d 35 	mov	#13677,	r12	;#0x356d
     fba:	88 12       	call	r8		;
     fbc:	7c 40 10 00 	mov.b	#16,	r12	;#0x0010
     fc0:	84 12       	call	r4		;
     fc2:	3d 40 84 35 	mov	#13700,	r13	;#0x3584
     fc6:	3c 40 00 81 	mov	#33024,	r12	;#0x8100
     fca:	85 12       	call	r5		;
     fcc:	0c 93       	cmp	#0,	r12	;r3 As==00
     fce:	5a 20       	jnz	$+182    	;abs 0x1084
     fd0:	d2 43 fe 80 	mov.b	#1,	&0x80fe	;r3 As==01

00000fd4 <.L157>:
     fd4:	3c 40 86 35 	mov	#13702,	r12	;#0x3586
     fd8:	88 12       	call	r8		;
     fda:	5c 43       	mov.b	#1,	r12	;r3 As==01
     fdc:	84 12       	call	r4		;
     fde:	3d 40 84 35 	mov	#13700,	r13	;#0x3584
     fe2:	3c 40 00 81 	mov	#33024,	r12	;#0x8100
     fe6:	85 12       	call	r5		;
     fe8:	0c 93       	cmp	#0,	r12	;r3 As==00
     fea:	50 20       	jnz	$+162    	;abs 0x108c
     fec:	d2 43 ff 80 	mov.b	#1,	&0x80ff	;r3 As==01

00000ff0 <.L159>:
     ff0:	34 40 2e 03 	mov	#814,	r4	;#0x032e
     ff4:	84 12       	call	r4		;
     ff6:	35 40 be 01 	mov	#446,	r5	;#0x01be
     ffa:	4c 43       	clr.b	r12		;
     ffc:	85 12       	call	r5		;
     ffe:	38 40 50 06 	mov	#1616,	r8	;#0x0650
    1002:	6c 43       	mov.b	#2,	r12	;r3 As==10
    1004:	4d 43       	clr.b	r13		;
    1006:	88 12       	call	r8		;
    1008:	3c 40 6f 01 	mov	#367,	r12	;#0x016f
    100c:	3d 40 00 20 	mov	#8192,	r13	;#0x2000
    1010:	88 12       	call	r8		;
    1012:	0c 46       	mov	r6,	r12	;
    1014:	0d 47       	mov	r7,	r13	;
    1016:	88 12       	call	r8		;
    1018:	36 40 ea 02 	mov	#746,	r6	;#0x02ea
    101c:	86 12       	call	r6		;
    101e:	84 12       	call	r4		;
    1020:	5c 43       	mov.b	#1,	r12	;r3 As==01
    1022:	85 12       	call	r5		;
    1024:	3c 43       	mov	#-1,	r12	;r3 As==11
    1026:	3d 43       	mov	#-1,	r13	;r3 As==11
    1028:	88 12       	call	r8		;
    102a:	05 4c       	mov	r12,	r5	;
    102c:	07 4d       	mov	r13,	r7	;
    102e:	3c 43       	mov	#-1,	r12	;r3 As==11
    1030:	4d 43       	clr.b	r13		;
    1032:	88 12       	call	r8		;
    1034:	82 4c fa 80 	mov	r12,	&0x80fa	;
    1038:	82 4d fc 80 	mov	r13,	&0x80fc	;
    103c:	86 12       	call	r6		;
    103e:	35 90 60 02 	cmp	#608,	r5	;#0x0260
    1042:	03 20       	jnz	$+8      	;abs 0x104a
    1044:	37 90 00 20 	cmp	#8192,	r7	;#0x2000
    1048:	15 24       	jz	$+44     	;abs 0x1074

0000104a <.L184>:
    104a:	b1 40 60 02 	mov	#608,	10(r1)	;#0x0260, 0x000a
    104e:	0a 00 
    1050:	b1 40 00 20 	mov	#8192,	12(r1)	;#0x2000, 0x000c
    1054:	0c 00 
    1056:	81 45 06 00 	mov	r5,	6(r1)	;
    105a:	81 47 08 00 	mov	r7,	8(r1)	;
    105e:	b1 40 6f 01 	mov	#367,	2(r1)	;#0x016f
    1062:	02 00 
    1064:	b1 40 00 20 	mov	#8192,	4(r1)	;#0x2000
    1068:	04 00 
    106a:	b1 40 74 36 	mov	#13940,	0(r1)	;#0x3674
    106e:	00 00 
    1070:	b0 12 de 13 	call	#5086		;#0x13de

00001074 <.L160>:
    1074:	1c 42 fa 80 	mov	&0x80fa,r12	;0x80fa
    1078:	1d 42 fc 80 	mov	&0x80fc,r13	;0x80fc
    107c:	b0 12 34 06 	call	#1588		;#0x0634
    1080:	30 40 e6 07 	br	#0x07e6		;

00001084 <.L156>:
    1084:	c2 43 fe 80 	mov.b	#0,	&0x80fe	;r3 As==00
    1088:	30 40 d4 0f 	br	#0x0fd4		;

0000108c <.L158>:
    108c:	c2 43 ff 80 	mov.b	#0,	&0x80ff	;r3 As==00
    1090:	30 40 f0 0f 	br	#0x0ff0		;

00001094 <.L132>:
    1094:	3c 40 c2 36 	mov	#14018,	r12	;#0x36c2
    1098:	88 12       	call	r8		;
    109a:	3c 40 41 35 	mov	#13633,	r12	;#0x3541
    109e:	88 12       	call	r8		;
    10a0:	7c 40 09 00 	mov.b	#9,	r12	;
    10a4:	84 12       	call	r4		;
    10a6:	b0 12 d0 01 	call	#464		;#0x01d0
    10aa:	81 4c 18 00 	mov	r12,	24(r1)	; 0x0018
    10ae:	81 4d 1a 00 	mov	r13,	26(r1)	; 0x001a
    10b2:	3c 40 6d 35 	mov	#13677,	r12	;#0x356d
    10b6:	88 12       	call	r8		;
    10b8:	7c 40 10 00 	mov.b	#16,	r12	;#0x0010
    10bc:	84 12       	call	r4		;
    10be:	3d 40 84 35 	mov	#13700,	r13	;#0x3584
    10c2:	3c 40 00 81 	mov	#33024,	r12	;#0x8100
    10c6:	85 12       	call	r5		;
    10c8:	0c 93       	cmp	#0,	r12	;r3 As==00
    10ca:	66 20       	jnz	$+206    	;abs 0x1198
    10cc:	d2 43 fe 80 	mov.b	#1,	&0x80fe	;r3 As==01

000010d0 <.L163>:
    10d0:	3c 40 86 35 	mov	#13702,	r12	;#0x3586
    10d4:	88 12       	call	r8		;
    10d6:	5c 43       	mov.b	#1,	r12	;r3 As==01
    10d8:	84 12       	call	r4		;
    10da:	3d 40 84 35 	mov	#13700,	r13	;#0x3584
    10de:	3c 40 00 81 	mov	#33024,	r12	;#0x8100
    10e2:	85 12       	call	r5		;
    10e4:	0c 93       	cmp	#0,	r12	;r3 As==00
    10e6:	5c 20       	jnz	$+186    	;abs 0x11a0
    10e8:	d2 43 ff 80 	mov.b	#1,	&0x80ff	;r3 As==01

000010ec <.L165>:
    10ec:	0c 41       	mov	r1,	r12	;
    10ee:	3c 50 26 00 	add	#38,	r12	;#0x0026
    10f2:	b0 12 22 05 	call	#1314		;#0x0522
    10f6:	5c 42 fe 80 	mov.b	&0x80fe,r12	;0x80fe
    10fa:	c2 93 ff 80 	cmp.b	#0,	&0x80ff	;r3 As==00
    10fe:	54 20       	jnz	$+170    	;abs 0x11a8
    1100:	0c 93       	cmp	#0,	r12	;r3 As==00
    1102:	5d 24       	jz	$+188    	;abs 0x11be
    1104:	38 40 30 01 	mov	#304,	r8	;#0x0130
    1108:	34 40 00 20 	mov	#8192,	r4	;#0x2000
    110c:	b1 40 3f 01 	mov	#319,	20(r1)	;#0x013f, 0x0014
    1110:	14 00 

00001112 <.L209>:
    1112:	b1 40 00 20 	mov	#8192,	22(r1)	;#0x2000, 0x0016
    1116:	16 00 
    1118:	3f 40 2e 03 	mov	#814,	r15	;#0x032e
    111c:	81 4f 0e 00 	mov	r15,	14(r1)	; 0x000e
    1120:	8f 12       	call	r15		;
    1122:	36 40 be 01 	mov	#446,	r6	;#0x01be
    1126:	4c 43       	clr.b	r12		;
    1128:	86 12       	call	r6		;
    112a:	35 40 50 06 	mov	#1616,	r5	;#0x0650
    112e:	7c 40 03 00 	mov.b	#3,	r12	;
    1132:	4d 43       	clr.b	r13		;
    1134:	85 12       	call	r5		;
    1136:	1c 41 14 00 	mov	20(r1),	r12	;0x00014
    113a:	1d 41 16 00 	mov	22(r1),	r13	;0x00016
    113e:	85 12       	call	r5		;
    1140:	1c 41 18 00 	mov	24(r1),	r12	;0x00018
    1144:	1d 41 1a 00 	mov	26(r1),	r13	;0x0001a
    1148:	85 12       	call	r5		;
    114a:	0d 41       	mov	r1,	r13	;
    114c:	3d 50 26 00 	add	#38,	r13	;#0x0026
    1150:	0c 41       	mov	r1,	r12	;
    1152:	3c 50 20 00 	add	#32,	r12	;#0x0020
    1156:	b0 12 68 01 	call	#360		;#0x0168
    115a:	37 40 ea 02 	mov	#746,	r7	;#0x02ea
    115e:	87 12       	call	r7		;
    1160:	1f 41 0e 00 	mov	14(r1),	r15	;0x0000e
    1164:	8f 12       	call	r15		;
    1166:	5c 43       	mov.b	#1,	r12	;r3 As==01
    1168:	86 12       	call	r6		;
    116a:	3c 43       	mov	#-1,	r12	;r3 As==11
    116c:	4d 43       	clr.b	r13		;
    116e:	85 12       	call	r5		;
    1170:	06 4c       	mov	r12,	r6	;
    1172:	05 4d       	mov	r13,	r5	;
    1174:	87 12       	call	r7		;
    1176:	06 98       	cmp	r8,	r6	;
    1178:	05 20       	jnz	$+12     	;abs 0x1184
    117a:	35 90 00 20 	cmp	#8192,	r5	;#0x2000
    117e:	02 20       	jnz	$+6      	;abs 0x1184
    1180:	30 40 e6 07 	br	#0x07e6		;

00001184 <.L185>:
    1184:	81 48 0a 00 	mov	r8,	10(r1)	; 0x000a
    1188:	81 44 0c 00 	mov	r4,	12(r1)	; 0x000c
    118c:	81 46 06 00 	mov	r6,	6(r1)	;
    1190:	81 45 08 00 	mov	r5,	8(r1)	;
    1194:	30 40 40 0b 	br	#0x0b40		;

00001198 <.L162>:
    1198:	c2 43 fe 80 	mov.b	#0,	&0x80fe	;r3 As==00
    119c:	30 40 d0 10 	br	#0x10d0		;

000011a0 <.L164>:
    11a0:	c2 43 ff 80 	mov.b	#0,	&0x80ff	;r3 As==00
    11a4:	30 40 ec 10 	br	#0x10ec		;

000011a8 <.L166>:
    11a8:	0c 93       	cmp	#0,	r12	;r3 As==00
    11aa:	e1 22       	jnz	$-572    	;abs 0xf6e
    11ac:	38 40 70 02 	mov	#624,	r8	;#0x0270
    11b0:	34 40 00 20 	mov	#8192,	r4	;#0x2000
    11b4:	b1 40 7f 01 	mov	#383,	20(r1)	;#0x017f, 0x0014
    11b8:	14 00 
    11ba:	30 40 12 11 	br	#0x1112		;

000011be <.L181>:
    11be:	38 40 10 01 	mov	#272,	r8	;#0x0110
    11c2:	34 40 00 20 	mov	#8192,	r4	;#0x2000
    11c6:	b1 40 1f 01 	mov	#287,	20(r1)	;#0x011f, 0x0014
    11ca:	14 00 
    11cc:	30 40 12 11 	br	#0x1112		;

000011d0 <.L170>:
    11d0:	c2 43 fe 80 	mov.b	#0,	&0x80fe	;r3 As==00
    11d4:	30 40 aa 0b 	br	#0x0baa		;

000011d8 <.L172>:
    11d8:	c2 43 ff 80 	mov.b	#0,	&0x80ff	;r3 As==00
    11dc:	30 40 ca 0b 	br	#0x0bca		;

000011e0 <.L203>:
    11e0:	3c 40 03 32 	mov	#12803,	r12	;#0x3203
    11e4:	89 12       	call	r9		;
    11e6:	5c 43       	mov.b	#1,	r12	;r3 As==01
    11e8:	31 50 3e 00 	add	#62,	r1	;#0x003e
    11ec:	30 40 a6 12 	br	#0x12a6		;

000011f0 <udivmodhi4>:
    11f0:	0a 12       	push	r10		;

000011f2 <.LCFI0>:
    11f2:	09 12       	push	r9		;

000011f4 <.LCFI1>:
    11f4:	08 12       	push	r8		;

000011f6 <.LCFI2>:
    11f6:	07 12       	push	r7		;

000011f8 <.LCFI3>:
    11f8:	06 12       	push	r6		;

000011fa <.LCFI4>:
    11fa:	07 4c       	mov	r12,	r7	;
    11fc:	09 4d       	mov	r13,	r9	;
    11fe:	06 4e       	mov	r14,	r6	;

00001200 <.LVL1>:
    1200:	7a 40 11 00 	mov.b	#17,	r10	;#0x0011

00001204 <.Loc.35.1>:
    1204:	58 43       	mov.b	#1,	r8	;r3 As==01

00001206 <.L2>:
    1206:	09 97       	cmp	r7,	r9	;
    1208:	09 28       	jnc	$+20     	;abs 0x121c

0000120a <.L15>:
    120a:	4a 43       	clr.b	r10		;

0000120c <.L4>:
    120c:	08 93       	cmp	#0,	r8	;r3 As==00
    120e:	0f 20       	jnz	$+32     	;abs 0x122e

00001210 <.L5>:
    1210:	06 93       	cmp	#0,	r6	;r3 As==00
    1212:	01 24       	jz	$+4      	;abs 0x1216
    1214:	0a 47       	mov	r7,	r10	;

00001216 <.L1>:
    1216:	0c 4a       	mov	r10,	r12	;
    1218:	30 40 aa 12 	br	#0x12aa		;

0000121c <.L3>:
    121c:	3a 53       	add	#-1,	r10	;r3 As==11

0000121e <.Loc.38.1>:
    121e:	0a 93       	cmp	#0,	r10	;r3 As==00
    1220:	f7 27       	jz	$-16     	;abs 0x1210

00001222 <.Loc.38.1>:
    1222:	09 93       	cmp	#0,	r9	;r3 As==00
    1224:	f2 3b       	jl	$-26     	;abs 0x120a

00001226 <.Loc.40.1>:
    1226:	09 59       	rla	r9		;

00001228 <.Loc.41.1>:
    1228:	08 58       	rla	r8		;
    122a:	30 40 06 12 	br	#0x1206		;

0000122e <.L9>:
    122e:	07 99       	cmp	r9,	r7	;
    1230:	02 28       	jnc	$+6      	;abs 0x1236

00001232 <.Loc.47.1>:
    1232:	07 89       	sub	r9,	r7	;

00001234 <.Loc.48.1>:
    1234:	0a d8       	bis	r8,	r10	;

00001236 <.L8>:
    1236:	0c 48       	mov	r8,	r12	;
    1238:	b0 12 62 13 	call	#4962		;#0x1362
    123c:	08 4c       	mov	r12,	r8	;

0000123e <.Loc.51.1>:
    123e:	0c 49       	mov	r9,	r12	;
    1240:	b0 12 62 13 	call	#4962		;#0x1362
    1244:	09 4c       	mov	r12,	r9	;
    1246:	30 40 0c 12 	br	#0x120c		;

0000124a <__mspabi_divi>:
    124a:	0a 12       	push	r10		;

0000124c <.LCFI5>:
    124c:	0f 4c       	mov	r12,	r15	;
    124e:	0e 4d       	mov	r13,	r14	;

00001250 <.LVL16>:
    1250:	3b 40 f0 11 	mov	#4592,	r11	;#0x11f0

00001254 <.Loc.64.1>:
    1254:	0c 93       	cmp	#0,	r12	;r3 As==00
    1256:	1a 34       	jge	$+54     	;abs 0x128c

00001258 <.Loc.66.1>:
    1258:	4c 43       	clr.b	r12		;

0000125a <.LVL17>:
    125a:	0c 8f       	sub	r15,	r12	;
    125c:	0f 4c       	mov	r12,	r15	;

0000125e <.LVL18>:
    125e:	0d 93       	cmp	#0,	r13	;r3 As==00
    1260:	0d 34       	jge	$+28     	;abs 0x127c

00001262 <.Loc.67.1>:
    1262:	5a 43       	mov.b	#1,	r10	;r3 As==01

00001264 <.L21>:
    1264:	0d 43       	clr	r13		;
    1266:	0d 8e       	sub	r14,	r13	;

00001268 <.LVL20>:
    1268:	4e 43       	clr.b	r14		;

0000126a <.LVL21>:
    126a:	0c 4f       	mov	r15,	r12	;

0000126c <.LVL22>:
    126c:	8b 12       	call	r11		;

0000126e <.LVL23>:
    126e:	1a 93       	cmp	#1,	r10	;r3 As==01
    1270:	03 24       	jz	$+8      	;abs 0x1278

00001272 <.L20>:
    1272:	4d 43       	clr.b	r13		;
    1274:	0d 8c       	sub	r12,	r13	;
    1276:	0c 4d       	mov	r13,	r12	;

00001278 <.L16>:
    1278:	3a 41       	pop	r10		;
    127a:	30 41       	ret			

0000127c <.L18>:
    127c:	4e 43       	clr.b	r14		;
    127e:	8b 12       	call	r11		;

00001280 <.LVL27>:
    1280:	30 40 72 12 	br	#0x1272		;

00001284 <.L27>:
    1284:	4e 43       	clr.b	r14		;
    1286:	8b 12       	call	r11		;

00001288 <.LVL29>:
    1288:	30 40 78 12 	br	#0x1278		;

0000128c <.L17>:
    128c:	0d 93       	cmp	#0,	r13	;r3 As==00
    128e:	fa 37       	jge	$-10     	;abs 0x1284

00001290 <.Loc.61.1>:
    1290:	4a 43       	clr.b	r10		;
    1292:	30 40 64 12 	br	#0x1264		;

00001296 <__mspabi_divu>:
    1296:	4e 43       	clr.b	r14		;
    1298:	b0 12 f0 11 	call	#4592		;#0x11f0

0000129c <.LVL41>:
    129c:	30 41       	ret			

0000129e <__mspabi_remu>:
    129e:	5e 43       	mov.b	#1,	r14	;r3 As==01
    12a0:	b0 12 f0 11 	call	#4592		;#0x11f0

000012a4 <.LVL43>:
    12a4:	30 41       	ret			

000012a6 <__mspabi_func_epilog_7>:
    12a6:	34 41       	pop	r4		;

000012a8 <__mspabi_func_epilog_6>:
    12a8:	35 41       	pop	r5		;

000012aa <__mspabi_func_epilog_5>:
    12aa:	36 41       	pop	r6		;

000012ac <__mspabi_func_epilog_4>:
    12ac:	37 41       	pop	r7		;

000012ae <__mspabi_func_epilog_3>:
    12ae:	38 41       	pop	r8		;

000012b0 <__mspabi_func_epilog_2>:
    12b0:	39 41       	pop	r9		;

000012b2 <__mspabi_func_epilog_1>:
    12b2:	3a 41       	pop	r10		;
    12b4:	30 41       	ret			

000012b6 <__mspabi_slli_15>:
    12b6:	0c 5c       	rla	r12		;

000012b8 <__mspabi_slli_14>:
    12b8:	0c 5c       	rla	r12		;

000012ba <__mspabi_slli_13>:
    12ba:	0c 5c       	rla	r12		;

000012bc <__mspabi_slli_12>:
    12bc:	0c 5c       	rla	r12		;

000012be <__mspabi_slli_11>:
    12be:	0c 5c       	rla	r12		;

000012c0 <__mspabi_slli_10>:
    12c0:	0c 5c       	rla	r12		;

000012c2 <__mspabi_slli_9>:
    12c2:	0c 5c       	rla	r12		;

000012c4 <__mspabi_slli_8>:
    12c4:	0c 5c       	rla	r12		;

000012c6 <__mspabi_slli_7>:
    12c6:	0c 5c       	rla	r12		;

000012c8 <__mspabi_slli_6>:
    12c8:	0c 5c       	rla	r12		;

000012ca <__mspabi_slli_5>:
    12ca:	0c 5c       	rla	r12		;

000012cc <__mspabi_slli_4>:
    12cc:	0c 5c       	rla	r12		;

000012ce <__mspabi_slli_3>:
    12ce:	0c 5c       	rla	r12		;

000012d0 <__mspabi_slli_2>:
    12d0:	0c 5c       	rla	r12		;

000012d2 <__mspabi_slli_1>:
    12d2:	0c 5c       	rla	r12		;
    12d4:	30 41       	ret			

000012d6 <.L11>:
    12d6:	3d 53       	add	#-1,	r13	;r3 As==11
    12d8:	0c 5c       	rla	r12		;

000012da <__mspabi_slli>:
    12da:	0d 93       	cmp	#0,	r13	;r3 As==00
    12dc:	fc 23       	jnz	$-6      	;abs 0x12d6
    12de:	30 41       	ret			

000012e0 <__mspabi_slll_15>:
    12e0:	0c 5c       	rla	r12		;
    12e2:	0d 6d       	rlc	r13		;

000012e4 <__mspabi_slll_14>:
    12e4:	0c 5c       	rla	r12		;
    12e6:	0d 6d       	rlc	r13		;

000012e8 <__mspabi_slll_13>:
    12e8:	0c 5c       	rla	r12		;
    12ea:	0d 6d       	rlc	r13		;

000012ec <__mspabi_slll_12>:
    12ec:	0c 5c       	rla	r12		;
    12ee:	0d 6d       	rlc	r13		;

000012f0 <__mspabi_slll_11>:
    12f0:	0c 5c       	rla	r12		;
    12f2:	0d 6d       	rlc	r13		;

000012f4 <__mspabi_slll_10>:
    12f4:	0c 5c       	rla	r12		;
    12f6:	0d 6d       	rlc	r13		;

000012f8 <__mspabi_slll_9>:
    12f8:	0c 5c       	rla	r12		;
    12fa:	0d 6d       	rlc	r13		;

000012fc <__mspabi_slll_8>:
    12fc:	0c 5c       	rla	r12		;
    12fe:	0d 6d       	rlc	r13		;

00001300 <__mspabi_slll_7>:
    1300:	0c 5c       	rla	r12		;
    1302:	0d 6d       	rlc	r13		;

00001304 <__mspabi_slll_6>:
    1304:	0c 5c       	rla	r12		;
    1306:	0d 6d       	rlc	r13		;

00001308 <__mspabi_slll_5>:
    1308:	0c 5c       	rla	r12		;
    130a:	0d 6d       	rlc	r13		;

0000130c <__mspabi_slll_4>:
    130c:	0c 5c       	rla	r12		;
    130e:	0d 6d       	rlc	r13		;

00001310 <__mspabi_slll_3>:
    1310:	0c 5c       	rla	r12		;
    1312:	0d 6d       	rlc	r13		;

00001314 <__mspabi_slll_2>:
    1314:	0c 5c       	rla	r12		;
    1316:	0d 6d       	rlc	r13		;

00001318 <__mspabi_slll_1>:
    1318:	0c 5c       	rla	r12		;
    131a:	0d 6d       	rlc	r13		;
    131c:	30 41       	ret			

0000131e <.L12>:
    131e:	3e 53       	add	#-1,	r14	;r3 As==11
    1320:	0c 5c       	rla	r12		;
    1322:	0d 6d       	rlc	r13		;

00001324 <__mspabi_slll>:
    1324:	0e 93       	cmp	#0,	r14	;r3 As==00
    1326:	fb 23       	jnz	$-8      	;abs 0x131e
    1328:	30 41       	ret			

0000132a <__mspabi_srli_15>:
    132a:	12 c3       	clrc			
    132c:	0c 10       	rrc	r12		;

0000132e <__mspabi_srli_14>:
    132e:	12 c3       	clrc			
    1330:	0c 10       	rrc	r12		;

00001332 <__mspabi_srli_13>:
    1332:	12 c3       	clrc			
    1334:	0c 10       	rrc	r12		;

00001336 <__mspabi_srli_12>:
    1336:	12 c3       	clrc			
    1338:	0c 10       	rrc	r12		;

0000133a <__mspabi_srli_11>:
    133a:	12 c3       	clrc			
    133c:	0c 10       	rrc	r12		;

0000133e <__mspabi_srli_10>:
    133e:	12 c3       	clrc			
    1340:	0c 10       	rrc	r12		;

00001342 <__mspabi_srli_9>:
    1342:	12 c3       	clrc			
    1344:	0c 10       	rrc	r12		;

00001346 <__mspabi_srli_8>:
    1346:	12 c3       	clrc			
    1348:	0c 10       	rrc	r12		;

0000134a <__mspabi_srli_7>:
    134a:	12 c3       	clrc			
    134c:	0c 10       	rrc	r12		;

0000134e <__mspabi_srli_6>:
    134e:	12 c3       	clrc			
    1350:	0c 10       	rrc	r12		;

00001352 <__mspabi_srli_5>:
    1352:	12 c3       	clrc			
    1354:	0c 10       	rrc	r12		;

00001356 <__mspabi_srli_4>:
    1356:	12 c3       	clrc			
    1358:	0c 10       	rrc	r12		;

0000135a <__mspabi_srli_3>:
    135a:	12 c3       	clrc			
    135c:	0c 10       	rrc	r12		;

0000135e <__mspabi_srli_2>:
    135e:	12 c3       	clrc			
    1360:	0c 10       	rrc	r12		;

00001362 <__mspabi_srli_1>:
    1362:	12 c3       	clrc			
    1364:	0c 10       	rrc	r12		;
    1366:	30 41       	ret			

00001368 <.L11>:
    1368:	3d 53       	add	#-1,	r13	;r3 As==11
    136a:	12 c3       	clrc			
    136c:	0c 10       	rrc	r12		;

0000136e <__mspabi_srli>:
    136e:	0d 93       	cmp	#0,	r13	;r3 As==00
    1370:	fb 23       	jnz	$-8      	;abs 0x1368
    1372:	30 41       	ret			

00001374 <__mspabi_srll_15>:
    1374:	12 c3       	clrc			
    1376:	0d 10       	rrc	r13		;
    1378:	0c 10       	rrc	r12		;

0000137a <__mspabi_srll_14>:
    137a:	12 c3       	clrc			
    137c:	0d 10       	rrc	r13		;
    137e:	0c 10       	rrc	r12		;

00001380 <__mspabi_srll_13>:
    1380:	12 c3       	clrc			
    1382:	0d 10       	rrc	r13		;
    1384:	0c 10       	rrc	r12		;

00001386 <__mspabi_srll_12>:
    1386:	12 c3       	clrc			
    1388:	0d 10       	rrc	r13		;
    138a:	0c 10       	rrc	r12		;

0000138c <__mspabi_srll_11>:
    138c:	12 c3       	clrc			
    138e:	0d 10       	rrc	r13		;
    1390:	0c 10       	rrc	r12		;

00001392 <__mspabi_srll_10>:
    1392:	12 c3       	clrc			
    1394:	0d 10       	rrc	r13		;
    1396:	0c 10       	rrc	r12		;

00001398 <__mspabi_srll_9>:
    1398:	12 c3       	clrc			
    139a:	0d 10       	rrc	r13		;
    139c:	0c 10       	rrc	r12		;

0000139e <__mspabi_srll_8>:
    139e:	12 c3       	clrc			
    13a0:	0d 10       	rrc	r13		;
    13a2:	0c 10       	rrc	r12		;

000013a4 <__mspabi_srll_7>:
    13a4:	12 c3       	clrc			
    13a6:	0d 10       	rrc	r13		;
    13a8:	0c 10       	rrc	r12		;

000013aa <__mspabi_srll_6>:
    13aa:	12 c3       	clrc			
    13ac:	0d 10       	rrc	r13		;
    13ae:	0c 10       	rrc	r12		;

000013b0 <__mspabi_srll_5>:
    13b0:	12 c3       	clrc			
    13b2:	0d 10       	rrc	r13		;
    13b4:	0c 10       	rrc	r12		;

000013b6 <__mspabi_srll_4>:
    13b6:	12 c3       	clrc			
    13b8:	0d 10       	rrc	r13		;
    13ba:	0c 10       	rrc	r12		;

000013bc <__mspabi_srll_3>:
    13bc:	12 c3       	clrc			
    13be:	0d 10       	rrc	r13		;
    13c0:	0c 10       	rrc	r12		;

000013c2 <__mspabi_srll_2>:
    13c2:	12 c3       	clrc			
    13c4:	0d 10       	rrc	r13		;
    13c6:	0c 10       	rrc	r12		;

000013c8 <__mspabi_srll_1>:
    13c8:	12 c3       	clrc			
    13ca:	0d 10       	rrc	r13		;
    13cc:	0c 10       	rrc	r12		;
    13ce:	30 41       	ret			

000013d0 <.L12>:
    13d0:	3e 53       	add	#-1,	r14	;r3 As==11
    13d2:	12 c3       	clrc			
    13d4:	0d 10       	rrc	r13		;
    13d6:	0c 10       	rrc	r12		;

000013d8 <__mspabi_srll>:
    13d8:	0e 93       	cmp	#0,	r14	;r3 As==00
    13da:	fa 23       	jnz	$-10     	;abs 0x13d0
    13dc:	30 41       	ret			

000013de <iprintf>:
    13de:	0a 12       	push	r10		;

000013e0 <.LCFI1>:
    13e0:	1a 42 08 80 	mov	&0x8008,r10	;0x8008

000013e4 <.LVL5>:
    13e4:	0a 93       	cmp	#0,	r10	;r3 As==00
    13e6:	06 24       	jz	$+14     	;abs 0x13f4

000013e8 <.Loc.56.1>:
    13e8:	8a 93 0c 00 	cmp	#0,	12(r10)	;r3 As==00, 0x000c
    13ec:	03 20       	jnz	$+8      	;abs 0x13f4

000013ee <.Loc.56.1>:
    13ee:	0c 4a       	mov	r10,	r12	;
    13f0:	b0 12 b0 15 	call	#5552		;#0x15b0

000013f4 <.L7>:
    13f4:	0f 41       	mov	r1,	r15	;
    13f6:	3f 50 06 00 	add	#6,	r15	;
    13fa:	1e 41 04 00 	mov	4(r1),	r14	;
    13fe:	1d 4a 04 00 	mov	4(r10),	r13	;
    1402:	0c 4a       	mov	r10,	r12	;
    1404:	b0 12 e4 1d 	call	#7652		;#0x1de4

00001408 <.LVL7>:
    1408:	3a 41       	pop	r10		;

0000140a <.LVL8>:
    140a:	30 41       	ret			

0000140c <_puts_r>:
    140c:	0a 12       	push	r10		;

0000140e <.LCFI0>:
    140e:	09 12       	push	r9		;

00001410 <.LCFI1>:
    1410:	31 80 0e 00 	sub	#14,	r1	;#0x000e

00001414 <.LCFI2>:
    1414:	09 4c       	mov	r12,	r9	;
    1416:	0a 4d       	mov	r13,	r10	;

00001418 <.Loc.83.1>:
    1418:	0c 4d       	mov	r13,	r12	;

0000141a <.LVL1>:
    141a:	b0 12 f0 14 	call	#5360		;#0x14f0

0000141e <.LVL2>:
    141e:	81 4a 06 00 	mov	r10,	6(r1)	;

00001422 <.Loc.89.1>:
    1422:	81 4c 08 00 	mov	r12,	8(r1)	;

00001426 <.Loc.90.1>:
    1426:	b1 40 32 37 	mov	#14130,	10(r1)	;#0x3732, 0x000a
    142a:	0a 00 

0000142c <.Loc.91.1>:
    142c:	91 43 0c 00 	mov	#1,	12(r1)	;r3 As==01, 0x000c

00001430 <.Loc.92.1>:
    1430:	1c 53       	inc	r12		;

00001432 <.LVL3>:
    1432:	81 4c 04 00 	mov	r12,	4(r1)	;

00001436 <.Loc.93.1>:
    1436:	7c 40 06 00 	mov.b	#6,	r12	;
    143a:	0c 51       	add	r1,	r12	;
    143c:	81 4c 00 00 	mov	r12,	0(r1)	;

00001440 <.Loc.94.1>:
    1440:	a1 43 02 00 	mov	#2,	2(r1)	;r3 As==10

00001444 <.Loc.96.1>:
    1444:	09 93       	cmp	#0,	r9	;r3 As==00
    1446:	06 24       	jz	$+14     	;abs 0x1454

00001448 <.Loc.96.1>:
    1448:	89 93 0c 00 	cmp	#0,	12(r9)	;r3 As==00, 0x000c
    144c:	03 20       	jnz	$+8      	;abs 0x1454

0000144e <.Loc.96.1>:
    144e:	0c 49       	mov	r9,	r12	;
    1450:	b0 12 b0 15 	call	#5552		;#0x15b0

00001454 <.L2>:
    1454:	1a 49 04 00 	mov	4(r9),	r10	;

00001458 <.LBB2>:
    1458:	89 93 0c 00 	cmp	#0,	12(r9)	;r3 As==00, 0x000c
    145c:	03 20       	jnz	$+8      	;abs 0x1464

0000145e <.Loc.98.1>:
    145e:	0c 49       	mov	r9,	r12	;
    1460:	b0 12 b0 15 	call	#5552		;#0x15b0

00001464 <.L3>:
    1464:	3a 90 58 37 	cmp	#14168,	r10	;#0x3758
    1468:	1e 20       	jnz	$+62     	;abs 0x14a6

0000146a <.Loc.98.1>:
    146a:	1a 49 02 00 	mov	2(r9),	r10	;

0000146e <.L5>:
    146e:	1c 4a 06 00 	mov	6(r10),	r12	;
    1472:	3c b0 00 20 	bit	#8192,	r12	;#0x2000
    1476:	0a 20       	jnz	$+22     	;abs 0x148c

00001478 <.Loc.100.1>:
    1478:	3c d0 00 20 	bis	#8192,	r12	;#0x2000
    147c:	8a 4c 06 00 	mov	r12,	6(r10)	;
    1480:	1c 4a 3a 00 	mov	58(r10),r12	;0x0003a
    1484:	3c f0 ff df 	and	#57343,	r12	;#0xdfff
    1488:	8a 4c 3a 00 	mov	r12,	58(r10)	; 0x003a

0000148c <.L7>:
    148c:	0e 41       	mov	r1,	r14	;
    148e:	0d 4a       	mov	r10,	r13	;
    1490:	0c 49       	mov	r9,	r12	;
    1492:	b0 12 de 16 	call	#5854		;#0x16de

00001496 <.LVL8>:
    1496:	0c 93       	cmp	#0,	r12	;r3 As==00
    1498:	14 20       	jnz	$+42     	;abs 0x14c2
    149a:	7c 40 0a 00 	mov.b	#10,	r12	;#0x000a

0000149e <.L1>:
    149e:	31 50 0e 00 	add	#14,	r1	;#0x000e
    14a2:	30 40 b0 12 	br	#0x12b0		;

000014a6 <.L4>:
    14a6:	3a 90 46 37 	cmp	#14150,	r10	;#0x3746
    14aa:	04 20       	jnz	$+10     	;abs 0x14b4

000014ac <.Loc.98.1>:
    14ac:	1a 49 04 00 	mov	4(r9),	r10	;
    14b0:	30 40 6e 14 	br	#0x146e		;

000014b4 <.L6>:
    14b4:	3a 90 34 37 	cmp	#14132,	r10	;#0x3734
    14b8:	da 23       	jnz	$-74     	;abs 0x146e

000014ba <.Loc.98.1>:
    14ba:	1a 49 06 00 	mov	6(r9),	r10	;
    14be:	30 40 6e 14 	br	#0x146e		;

000014c2 <.L9>:
    14c2:	3c 43       	mov	#-1,	r12	;r3 As==11

000014c4 <.Loc.103.1>:
    14c4:	30 40 9e 14 	br	#0x149e		;

000014c8 <puts>:
    14c8:	0d 4c       	mov	r12,	r13	;
    14ca:	1c 42 08 80 	mov	&0x8008,r12	;0x8008

000014ce <.LVL13>:
    14ce:	b0 12 0c 14 	call	#5132		;#0x140c

000014d2 <.LVL14>:
    14d2:	30 41       	ret			

000014d4 <strcmp>:
    14d4:	6e 4c       	mov.b	@r12,	r14	;
    14d6:	0e 93       	cmp	#0,	r14	;r3 As==00
    14d8:	03 24       	jz	$+8      	;abs 0x14e0

000014da <.Loc.66.1>:
    14da:	cd 9e 00 00 	cmp.b	r14,	0(r13)	;
    14de:	04 24       	jz	$+10     	;abs 0x14e8

000014e0 <.L3>:
    14e0:	0c 4e       	mov	r14,	r12	;

000014e2 <.LVL1>:
    14e2:	6d 4d       	mov.b	@r13,	r13	;

000014e4 <.LVL2>:
    14e4:	0c 8d       	sub	r13,	r12	;
    14e6:	30 41       	ret			

000014e8 <.L4>:
    14e8:	1c 53       	inc	r12		;

000014ea <.Loc.69.1>:
    14ea:	1d 53       	inc	r13		;
    14ec:	30 40 d4 14 	br	#0x14d4		;

000014f0 <strlen>:
    14f0:	0d 4c       	mov	r12,	r13	;

000014f2 <.L2>:
    14f2:	cd 93 00 00 	cmp.b	#0,	0(r13)	;r3 As==00
    14f6:	03 20       	jnz	$+8      	;abs 0x14fe

000014f8 <.Loc.88.1>:
    14f8:	0d 8c       	sub	r12,	r13	;

000014fa <.LVL3>:
    14fa:	0c 4d       	mov	r13,	r12	;

000014fc <.LVL4>:
    14fc:	30 41       	ret			

000014fe <.L3>:
    14fe:	1d 53       	inc	r13		;
    1500:	30 40 f2 14 	br	#0x14f2		;

00001504 <_cleanup_r>:
    1504:	3d 40 96 23 	mov	#9110,	r13	;#0x2396
    1508:	b0 12 12 1a 	call	#6674		;#0x1a12

0000150c <.LVL4>:
    150c:	30 41       	ret			

0000150e <std.isra.0>:
    150e:	0a 12       	push	r10		;

00001510 <.LCFI0>:
    1510:	0a 4c       	mov	r12,	r10	;

00001512 <.Loc.49.1>:
    1512:	8c 43 00 00 	mov	#0,	0(r12)	;r3 As==00

00001516 <.Loc.50.1>:
    1516:	8c 43 02 00 	mov	#0,	2(r12)	;r3 As==00

0000151a <.Loc.51.1>:
    151a:	8c 43 04 00 	mov	#0,	4(r12)	;r3 As==00

0000151e <.Loc.52.1>:
    151e:	8c 4d 06 00 	mov	r13,	6(r12)	;

00001522 <.Loc.53.1>:
    1522:	8c 43 3a 00 	mov	#0,	58(r12)	;r3 As==00, 0x003a

00001526 <.Loc.54.1>:
    1526:	8c 4e 08 00 	mov	r14,	8(r12)	;

0000152a <.Loc.55.1>:
    152a:	8c 43 0a 00 	mov	#0,	10(r12)	;r3 As==00, 0x000a

0000152e <.Loc.56.1>:
    152e:	8c 43 0c 00 	mov	#0,	12(r12)	;r3 As==00, 0x000c

00001532 <.Loc.57.1>:
    1532:	8c 43 0e 00 	mov	#0,	14(r12)	;r3 As==00, 0x000e

00001536 <.Loc.58.1>:
    1536:	7e 40 06 00 	mov.b	#6,	r14	;

0000153a <.LVL7>:
    153a:	4d 43       	clr.b	r13		;

0000153c <.LVL8>:
    153c:	3c 50 34 00 	add	#52,	r12	;#0x0034

00001540 <.LVL9>:
    1540:	b0 12 d8 1a 	call	#6872		;#0x1ad8

00001544 <.LVL10>:
    1544:	8a 4a 12 00 	mov	r10,	18(r10)	; 0x0012

00001548 <.Loc.60.1>:
    1548:	ba 40 ae 20 	mov	#8366,	20(r10)	;#0x20ae, 0x0014
    154c:	14 00 

0000154e <.Loc.62.1>:
    154e:	ba 40 ee 20 	mov	#8430,	22(r10)	;#0x20ee, 0x0016
    1552:	16 00 

00001554 <.Loc.68.1>:
    1554:	ba 40 30 21 	mov	#8496,	24(r10)	;#0x2130, 0x0018
    1558:	18 00 

0000155a <.Loc.70.1>:
    155a:	ba 40 6a 21 	mov	#8554,	26(r10)	;#0x216a, 0x001a
    155e:	1a 00 

00001560 <.Loc.86.1>:
    1560:	3a 41       	pop	r10		;

00001562 <.LVL11>:
    1562:	30 41       	ret			

00001564 <__sfmoreglue>:
    1564:	0a 12       	push	r10		;

00001566 <.LCFI1>:
    1566:	09 12       	push	r9		;

00001568 <.LCFI2>:
    1568:	08 12       	push	r8		;

0000156a <.LCFI3>:
    156a:	0a 4c       	mov	r12,	r10	;
    156c:	08 4d       	mov	r13,	r8	;

0000156e <.Loc.101.1>:
    156e:	7d 40 3c 00 	mov.b	#60,	r13	;#0x003c

00001572 <.LVL13>:
    1572:	0c 48       	mov	r8,	r12	;

00001574 <.LVL14>:
    1574:	3c 53       	add	#-1,	r12	;r3 As==11
    1576:	b0 12 20 30 	call	#12320		;#0x3020
    157a:	09 4c       	mov	r12,	r9	;

0000157c <.Loc.100.1>:
    157c:	0d 4c       	mov	r12,	r13	;
    157e:	3d 50 42 00 	add	#66,	r13	;#0x0042
    1582:	0c 4a       	mov	r10,	r12	;
    1584:	b0 12 e2 1b 	call	#7138		;#0x1be2

00001588 <.LVL16>:
    1588:	0a 4c       	mov	r12,	r10	;

0000158a <.LVL17>:
    158a:	0c 93       	cmp	#0,	r12	;r3 As==00
    158c:	0e 24       	jz	$+30     	;abs 0x15aa

0000158e <.Loc.104.1>:
    158e:	8c 43 00 00 	mov	#0,	0(r12)	;r3 As==00

00001592 <.Loc.105.1>:
    1592:	8c 48 02 00 	mov	r8,	2(r12)	;

00001596 <.Loc.106.1>:
    1596:	3c 50 06 00 	add	#6,	r12	;
    159a:	8a 4c 04 00 	mov	r12,	4(r10)	;

0000159e <.Loc.107.1>:
    159e:	0e 49       	mov	r9,	r14	;
    15a0:	3e 50 3c 00 	add	#60,	r14	;#0x003c
    15a4:	4d 43       	clr.b	r13		;
    15a6:	b0 12 d8 1a 	call	#6872		;#0x1ad8

000015aa <.L6>:
    15aa:	0c 4a       	mov	r10,	r12	;
    15ac:	30 40 ae 12 	br	#0x12ae		;

000015b0 <__sinit>:
    15b0:	0a 12       	push	r10		;

000015b2 <.LCFI4>:
    15b2:	09 12       	push	r9		;

000015b4 <.LCFI5>:
    15b4:	0a 4c       	mov	r12,	r10	;

000015b6 <.Loc.213.1>:
    15b6:	8c 93 0c 00 	cmp	#0,	12(r12)	;r3 As==00, 0x000c
    15ba:	31 20       	jnz	$+100    	;abs 0x161e

000015bc <.LBB20>:
    15bc:	bc 40 04 15 	mov	#5380,	20(r12)	;#0x1504, 0x0014
    15c0:	14 00 

000015c2 <.Loc.222.1>:
    15c2:	8c 43 6c 00 	mov	#0,	108(r12);r3 As==00, 0x006c

000015c6 <.Loc.227.1>:
    15c6:	8c 43 6e 00 	mov	#0,	110(r12);r3 As==00, 0x006e

000015ca <.Loc.228.1>:
    15ca:	8c 43 70 00 	mov	#0,	112(r12);r3 As==00, 0x0070

000015ce <.Loc.232.1>:
    15ce:	1c 92 6a 37 	cmp	&0x376a,r12	;0x376a
    15d2:	02 20       	jnz	$+6      	;abs 0x15d8

000015d4 <.Loc.233.1>:
    15d4:	9c 43 0c 00 	mov	#1,	12(r12)	;r3 As==01, 0x000c

000015d8 <.L13>:
    15d8:	39 40 22 16 	mov	#5666,	r9	;#0x1622
    15dc:	0c 4a       	mov	r10,	r12	;

000015de <.LVL22>:
    15de:	89 12       	call	r9		;

000015e0 <.LVL23>:
    15e0:	8a 4c 02 00 	mov	r12,	2(r10)	;

000015e4 <.Loc.235.1>:
    15e4:	0c 4a       	mov	r10,	r12	;
    15e6:	89 12       	call	r9		;

000015e8 <.LVL24>:
    15e8:	8a 4c 04 00 	mov	r12,	4(r10)	;

000015ec <.Loc.236.1>:
    15ec:	0c 4a       	mov	r10,	r12	;
    15ee:	89 12       	call	r9		;

000015f0 <.LVL25>:
    15f0:	8a 4c 06 00 	mov	r12,	6(r10)	;

000015f4 <.Loc.239.1>:
    15f4:	39 40 0e 15 	mov	#5390,	r9	;#0x150e
    15f8:	4e 43       	clr.b	r14		;
    15fa:	6d 42       	mov.b	#4,	r13	;r2 As==10
    15fc:	1c 4a 02 00 	mov	2(r10),	r12	;
    1600:	89 12       	call	r9		;

00001602 <.LVL26>:
    1602:	5e 43       	mov.b	#1,	r14	;r3 As==01
    1604:	7d 40 09 00 	mov.b	#9,	r13	;
    1608:	1c 4a 04 00 	mov	4(r10),	r12	;
    160c:	89 12       	call	r9		;

0000160e <.LVL27>:
    160e:	6e 43       	mov.b	#2,	r14	;r3 As==10
    1610:	7d 40 12 00 	mov.b	#18,	r13	;#0x0012
    1614:	1c 4a 06 00 	mov	6(r10),	r12	;
    1618:	89 12       	call	r9		;

0000161a <.LVL28>:
    161a:	9a 43 0c 00 	mov	#1,	12(r10)	;r3 As==01, 0x000c

0000161e <.L11>:
    161e:	30 40 b0 12 	br	#0x12b0		;

00001622 <__sfp>:
    1622:	0a 12       	push	r10		;

00001624 <.LCFI6>:
    1624:	09 12       	push	r9		;

00001626 <.LCFI7>:
    1626:	08 12       	push	r8		;

00001628 <.LCFI8>:
    1628:	07 12       	push	r7		;

0000162a <.LCFI9>:
    162a:	06 12       	push	r6		;

0000162c <.LCFI10>:
    162c:	08 4c       	mov	r12,	r8	;

0000162e <.Loc.125.1>:
    162e:	19 42 6a 37 	mov	&0x376a,r9	;0x376a
    1632:	89 93 0c 00 	cmp	#0,	12(r9)	;r3 As==00, 0x000c
    1636:	03 20       	jnz	$+8      	;abs 0x163e

00001638 <.Loc.126.1>:
    1638:	0c 49       	mov	r9,	r12	;

0000163a <.LVL31>:
    163a:	b0 12 b0 15 	call	#5552		;#0x15b0

0000163e <.L15>:
    163e:	39 50 6c 00 	add	#108,	r9	;#0x006c

00001642 <.Loc.133.1>:
    1642:	37 40 64 15 	mov	#5476,	r7	;#0x1564
    1646:	66 42       	mov.b	#4,	r6	;r2 As==10

00001648 <.L20>:
    1648:	1d 49 02 00 	mov	2(r9),	r13	;

0000164c <.LVL35>:
    164c:	1c 49 04 00 	mov	4(r9),	r12	;
    1650:	3c 50 06 00 	add	#6,	r12	;

00001654 <.L16>:
    1654:	0a 4c       	mov	r12,	r10	;
    1656:	3a 50 fa ff 	add	#65530,	r10	;#0xfffa

0000165a <.LVL37>:
    165a:	3d 53       	add	#-1,	r13	;r3 As==11
    165c:	0d 93       	cmp	#0,	r13	;r3 As==00
    165e:	06 34       	jge	$+14     	;abs 0x166c

00001660 <.Loc.132.1>:
    1660:	89 93 00 00 	cmp	#0,	0(r9)	;r3 As==00
    1664:	2c 24       	jz	$+90     	;abs 0x16be

00001666 <.L21>:
    1666:	29 49       	mov	@r9,	r9	;

00001668 <.Loc.129.1>:
    1668:	30 40 48 16 	br	#0x1648		;

0000166c <.L18>:
    166c:	3c 50 3c 00 	add	#60,	r12	;#0x003c

00001670 <.Loc.130.1>:
    1670:	8c 93 c4 ff 	cmp	#0,	-60(r12);r3 As==00, 0xffc4
    1674:	ef 23       	jnz	$-32     	;abs 0x1654

00001676 <.L17>:
    1676:	ba 43 08 00 	mov	#-1,	8(r10)	;r3 As==11

0000167a <.Loc.142.1>:
    167a:	9a 43 06 00 	mov	#1,	6(r10)	;r3 As==01

0000167e <.Loc.143.1>:
    167e:	8a 43 3a 00 	mov	#0,	58(r10)	;r3 As==00, 0x003a

00001682 <.Loc.149.1>:
    1682:	8a 43 00 00 	mov	#0,	0(r10)	;r3 As==00

00001686 <.Loc.150.1>:
    1686:	8a 43 04 00 	mov	#0,	4(r10)	;r3 As==00

0000168a <.Loc.151.1>:
    168a:	8a 43 02 00 	mov	#0,	2(r10)	;r3 As==00

0000168e <.Loc.152.1>:
    168e:	8a 43 0a 00 	mov	#0,	10(r10)	;r3 As==00, 0x000a

00001692 <.Loc.153.1>:
    1692:	8a 43 0c 00 	mov	#0,	12(r10)	;r3 As==00, 0x000c

00001696 <.Loc.154.1>:
    1696:	8a 43 0e 00 	mov	#0,	14(r10)	;r3 As==00, 0x000e

0000169a <.Loc.155.1>:
    169a:	7e 40 06 00 	mov.b	#6,	r14	;
    169e:	4d 43       	clr.b	r13		;

000016a0 <.LVL42>:
    16a0:	0c 4a       	mov	r10,	r12	;
    16a2:	3c 50 34 00 	add	#52,	r12	;#0x0034
    16a6:	b0 12 d8 1a 	call	#6872		;#0x1ad8

000016aa <.LVL43>:
    16aa:	8a 43 1c 00 	mov	#0,	28(r10)	;r3 As==00, 0x001c

000016ae <.Loc.158.1>:
    16ae:	8a 43 1e 00 	mov	#0,	30(r10)	;r3 As==00, 0x001e

000016b2 <.Loc.159.1>:
    16b2:	8a 43 28 00 	mov	#0,	40(r10)	;r3 As==00, 0x0028

000016b6 <.Loc.160.1>:
    16b6:	8a 43 2a 00 	mov	#0,	42(r10)	;r3 As==00, 0x002a

000016ba <.Loc.162.1>:
    16ba:	30 40 d4 16 	br	#0x16d4		;

000016be <.L19>:
    16be:	0d 46       	mov	r6,	r13	;

000016c0 <.LVL45>:
    16c0:	0c 48       	mov	r8,	r12	;
    16c2:	87 12       	call	r7		;

000016c4 <.LVL46>:
    16c4:	89 4c 00 00 	mov	r12,	0(r9)	;

000016c8 <.Loc.132.1>:
    16c8:	0c 93       	cmp	#0,	r12	;r3 As==00
    16ca:	cd 23       	jnz	$-100    	;abs 0x1666

000016cc <.Loc.137.1>:
    16cc:	b8 40 0c 00 	mov	#12,	0(r8)	;#0x000c
    16d0:	00 00 

000016d2 <.Loc.138.1>:
    16d2:	0a 4c       	mov	r12,	r10	;

000016d4 <.L14>:
    16d4:	0c 4a       	mov	r10,	r12	;
    16d6:	30 40 aa 12 	br	#0x12aa		;

000016da <__sfp_lock_acquire>:
    16da:	30 41       	ret			

000016dc <__sfp_lock_release>:
    16dc:	30 41       	ret			

000016de <__sfvwrite_r>:
    16de:	0a 12       	push	r10		;

000016e0 <.LCFI0>:
    16e0:	09 12       	push	r9		;

000016e2 <.LCFI1>:
    16e2:	08 12       	push	r8		;

000016e4 <.LCFI2>:
    16e4:	07 12       	push	r7		;

000016e6 <.LCFI3>:
    16e6:	06 12       	push	r6		;

000016e8 <.LCFI4>:
    16e8:	05 12       	push	r5		;

000016ea <.LCFI5>:
    16ea:	04 12       	push	r4		;

000016ec <.LCFI6>:
    16ec:	31 80 0a 00 	sub	#10,	r1	;#0x000a

000016f0 <.LCFI7>:
    16f0:	07 4c       	mov	r12,	r7	;
    16f2:	06 4d       	mov	r13,	r6	;
    16f4:	81 4e 04 00 	mov	r14,	4(r1)	;

000016f8 <.LVL1>:
    16f8:	8e 93 04 00 	cmp	#0,	4(r14)	;r3 As==00
    16fc:	05 20       	jnz	$+12     	;abs 0x1708

000016fe <.L12>:
    16fe:	4c 43       	clr.b	r12		;

00001700 <.L1>:
    1700:	31 50 0a 00 	add	#10,	r1	;#0x000a
    1704:	30 40 a6 12 	br	#0x12a6		;

00001708 <.L2>:
    1708:	fd b2 06 00 	bit.b	#8,	6(r13)	;r2 As==11
    170c:	31 24       	jz	$+100    	;abs 0x1770

0000170e <.Loc.64.1>:
    170e:	8d 93 0a 00 	cmp	#0,	10(r13)	;r3 As==00, 0x000a
    1712:	2e 24       	jz	$+94     	;abs 0x1770

00001714 <.L7>:
    1714:	14 41 04 00 	mov	4(r1),	r4	;
    1718:	28 44       	mov	@r4,	r8	;

0000171a <.LVL5>:
    171a:	15 46 06 00 	mov	6(r6),	r5	;
    171e:	09 45       	mov	r5,	r9	;
    1720:	69 f3       	and.b	#2,	r9	;r3 As==10
    1722:	81 49 06 00 	mov	r9,	6(r1)	;
    1726:	09 93       	cmp	#0,	r9	;r3 As==00
    1728:	32 24       	jz	$+102    	;abs 0x178e
    172a:	49 43       	clr.b	r9		;
    172c:	0a 49       	mov	r9,	r10	;

0000172e <.Loc.100.1>:
    172e:	35 40 00 7c 	mov	#31744,	r5	;#0x7c00

00001732 <.L6>:
    1732:	0a 93       	cmp	#0,	r10	;r3 As==00
    1734:	26 24       	jz	$+78     	;abs 0x1782

00001736 <.Loc.100.1>:
    1736:	0f 4a       	mov	r10,	r15	;
    1738:	3c 40 00 7c 	mov	#31744,	r12	;#0x7c00
    173c:	0c 9a       	cmp	r10,	r12	;
    173e:	01 2c       	jc	$+4      	;abs 0x1742
    1740:	0f 45       	mov	r5,	r15	;

00001742 <.L9>:
    1742:	0e 49       	mov	r9,	r14	;
    1744:	1d 46 12 00 	mov	18(r6),	r13	;0x00012
    1748:	0c 47       	mov	r7,	r12	;
    174a:	14 46 16 00 	mov	22(r6),	r4	;0x00016
    174e:	84 12       	call	r4		;

00001750 <.LVL7>:
    1750:	4d 43       	clr.b	r13		;
    1752:	0d 9c       	cmp	r12,	r13	;
    1754:	9e 34       	jge	$+318    	;abs 0x1892

00001756 <.LVL8>:
    1756:	09 5c       	add	r12,	r9	;

00001758 <.LVL9>:
    1758:	0a 8c       	sub	r12,	r10	;

0000175a <.Loc.106.1>:
    175a:	14 41 04 00 	mov	4(r1),	r4	;
    175e:	1d 44 04 00 	mov	4(r4),	r13	;
    1762:	0d 8c       	sub	r12,	r13	;
    1764:	84 4d 04 00 	mov	r13,	4(r4)	;
    1768:	0d 93       	cmp	#0,	r13	;r3 As==00
    176a:	e3 23       	jnz	$-56     	;abs 0x1732
    176c:	30 40 fe 16 	br	#0x16fe		;

00001770 <.L4>:
    1770:	0d 46       	mov	r6,	r13	;
    1772:	0c 47       	mov	r7,	r12	;
    1774:	b0 12 72 22 	call	#8818		;#0x2272

00001778 <.LVL12>:
    1778:	0c 93       	cmp	#0,	r12	;r3 As==00
    177a:	cc 27       	jz	$-102    	;abs 0x1714

0000177c <.L40>:
    177c:	3c 43       	mov	#-1,	r12	;r3 As==11
    177e:	30 40 00 17 	br	#0x1700		;

00001782 <.L8>:
    1782:	29 48       	mov	@r8,	r9	;
    1784:	1a 48 02 00 	mov	2(r8),	r10	;

00001788 <.LVL15>:
    1788:	28 52       	add	#4,	r8	;r2 As==10

0000178a <.LVL16>:
    178a:	30 40 32 17 	br	#0x1732		;

0000178e <.L5>:
    178e:	55 f3       	and.b	#1,	r5	;r3 As==01
    1790:	81 45 08 00 	mov	r5,	8(r1)	;
    1794:	05 93       	cmp	#0,	r5	;r3 As==00
    1796:	45 24       	jz	$+140    	;abs 0x1822
    1798:	1a 41 06 00 	mov	6(r1),	r10	;
    179c:	0c 4a       	mov	r10,	r12	;
    179e:	05 4a       	mov	r10,	r5	;
    17a0:	09 4a       	mov	r10,	r9	;

000017a2 <.L14>:
    17a2:	09 93       	cmp	#0,	r9	;r3 As==00
    17a4:	07 25       	jz	$+528    	;abs 0x19b4

000017a6 <.Loc.220.1>:
    17a6:	0c 93       	cmp	#0,	r12	;r3 As==00
    17a8:	0b 20       	jnz	$+24     	;abs 0x17c0

000017aa <.Loc.222.1>:
    17aa:	0e 49       	mov	r9,	r14	;
    17ac:	7d 40 0a 00 	mov.b	#10,	r13	;#0x000a
    17b0:	0c 45       	mov	r5,	r12	;

000017b2 <.LVL19>:
    17b2:	b0 12 6c 1a 	call	#6764		;#0x1a6c

000017b6 <.LVL20>:
    17b6:	0c 93       	cmp	#0,	r12	;r3 As==00
    17b8:	05 25       	jz	$+524    	;abs 0x19c4

000017ba <.Loc.223.1>:
    17ba:	1c 53       	inc	r12		;

000017bc <.LVL21>:
    17bc:	0a 4c       	mov	r12,	r10	;
    17be:	0a 85       	sub	r5,	r10	;

000017c0 <.L32>:
    17c0:	0f 4a       	mov	r10,	r15	;
    17c2:	09 9a       	cmp	r10,	r9	;
    17c4:	01 2c       	jc	$+4      	;abs 0x17c8
    17c6:	0f 49       	mov	r9,	r15	;

000017c8 <.L34>:
    17c8:	1d 46 0c 00 	mov	12(r6),	r13	;0x0000c

000017cc <.LVL24>:
    17cc:	2c 46       	mov	@r6,	r12	;
    17ce:	86 9c 0a 00 	cmp	r12,	10(r6)	; 0x000a
    17d2:	fc 2c       	jc	$+506    	;abs 0x19cc

000017d4 <.Loc.227.1>:
    17d4:	04 4d       	mov	r13,	r4	;
    17d6:	14 56 04 00 	add	4(r6),	r4	;

000017da <.Loc.228.1>:
    17da:	04 9f       	cmp	r15,	r4	;
    17dc:	f7 34       	jge	$+496    	;abs 0x19cc

000017de <.Loc.230.1>:
    17de:	0e 44       	mov	r4,	r14	;
    17e0:	0d 45       	mov	r5,	r13	;

000017e2 <.LVL25>:
    17e2:	b0 12 9c 1a 	call	#6812		;#0x1a9c

000017e6 <.LVL26>:
    17e6:	86 54 00 00 	add	r4,	0(r6)	;

000017ea <.Loc.233.1>:
    17ea:	0d 46       	mov	r6,	r13	;
    17ec:	0c 47       	mov	r7,	r12	;
    17ee:	b0 12 f0 25 	call	#9712		;#0x25f0

000017f2 <.LVL27>:
    17f2:	0c 93       	cmp	#0,	r12	;r3 As==00
    17f4:	4e 20       	jnz	$+158    	;abs 0x1892

000017f6 <.L36>:
    17f6:	0a 84       	sub	r4,	r10	;
    17f8:	0a 93       	cmp	#0,	r10	;r3 As==00
    17fa:	07 21       	jnz	$+528    	;abs 0x1a0a

000017fc <.Loc.252.1>:
    17fc:	0d 46       	mov	r6,	r13	;
    17fe:	0c 47       	mov	r7,	r12	;
    1800:	b0 12 f0 25 	call	#9712		;#0x25f0

00001804 <.LVL30>:
    1804:	0c 93       	cmp	#0,	r12	;r3 As==00
    1806:	45 20       	jnz	$+140    	;abs 0x1892

00001808 <.L38>:
    1808:	05 54       	add	r4,	r5	;

0000180a <.LVL32>:
    180a:	09 84       	sub	r4,	r9	;

0000180c <.Loc.259.1>:
    180c:	1e 41 04 00 	mov	4(r1),	r14	;
    1810:	1d 4e 04 00 	mov	4(r14),	r13	;
    1814:	0d 84       	sub	r4,	r13	;
    1816:	8e 4d 04 00 	mov	r13,	4(r14)	;
    181a:	0d 93       	cmp	#0,	r13	;r3 As==00
    181c:	c2 23       	jnz	$-122    	;abs 0x17a2
    181e:	30 40 fe 16 	br	#0x16fe		;

00001822 <.L13>:
    1822:	15 41 08 00 	mov	8(r1),	r5	;
    1826:	0a 45       	mov	r5,	r10	;

00001828 <.L15>:
    1828:	0a 93       	cmp	#0,	r10	;r3 As==00
    182a:	38 24       	jz	$+114    	;abs 0x189c

0000182c <.Loc.126.1>:
    182c:	1f 46 04 00 	mov	4(r6),	r15	;

00001830 <.LVL36>:
    1830:	1e 46 06 00 	mov	6(r6),	r14	;
    1834:	3e b0 00 02 	bit	#512,	r14	;#0x0200
    1838:	82 24       	jz	$+262    	;abs 0x193e

0000183a <.Loc.129.1>:
    183a:	0a 9f       	cmp	r15,	r10	;
    183c:	53 28       	jnc	$+168    	;abs 0x18e4

0000183e <.Loc.129.1>:
    183e:	3e b0 80 04 	bit	#1152,	r14	;#0x0480
    1842:	4e 24       	jz	$+158    	;abs 0x18e0

00001844 <.LBB2>:
    1844:	1d 46 0a 00 	mov	10(r6),	r13	;0x0000a
    1848:	24 46       	mov	@r6,	r4	;
    184a:	04 8d       	sub	r13,	r4	;

0000184c <.LVL37>:
    184c:	1c 46 0c 00 	mov	12(r6),	r12	;0x0000c
    1850:	09 4c       	mov	r12,	r9	;
    1852:	09 5c       	add	r12,	r9	;
    1854:	09 5c       	add	r12,	r9	;
    1856:	0c 49       	mov	r9,	r12	;
    1858:	81 4d 00 00 	mov	r13,	0(r1)	;
    185c:	81 4e 02 00 	mov	r14,	2(r1)	;
    1860:	b0 12 2a 13 	call	#4906		;#0x132a

00001864 <.LVL38>:
    1864:	09 5c       	add	r12,	r9	;
    1866:	09 11       	rra	r9		;

00001868 <.LVL39>:
    1868:	0c 44       	mov	r4,	r12	;
    186a:	1c 53       	inc	r12		;
    186c:	0c 5a       	add	r10,	r12	;
    186e:	2d 41       	mov	@r1,	r13	;
    1870:	1e 41 02 00 	mov	2(r1),	r14	;
    1874:	09 9c       	cmp	r12,	r9	;
    1876:	01 2c       	jc	$+4      	;abs 0x187a

00001878 <.Loc.142.1>:
    1878:	09 4c       	mov	r12,	r9	;

0000187a <.L19>:
    187a:	3e b0 00 04 	bit	#1024,	r14	;#0x0400
    187e:	4e 24       	jz	$+158    	;abs 0x191c

00001880 <.Loc.146.1>:
    1880:	0d 49       	mov	r9,	r13	;
    1882:	0c 47       	mov	r7,	r12	;
    1884:	b0 12 e2 1b 	call	#7138		;#0x1be2

00001888 <.LVL41>:
    1888:	0c 93       	cmp	#0,	r12	;r3 As==00
    188a:	0e 20       	jnz	$+30     	;abs 0x18a8

0000188c <.L49>:
    188c:	b7 40 0c 00 	mov	#12,	0(r7)	;#0x000c
    1890:	00 00 

00001892 <.L22>:
    1892:	b6 d0 40 00 	bis	#64,	6(r6)	;#0x0040
    1896:	06 00 
    1898:	30 40 7c 17 	br	#0x177c		;

0000189c <.L16>:
    189c:	25 48       	mov	@r8,	r5	;
    189e:	1a 48 02 00 	mov	2(r8),	r10	;

000018a2 <.LVL45>:
    18a2:	28 52       	add	#4,	r8	;r2 As==10

000018a4 <.LVL46>:
    18a4:	30 40 28 18 	br	#0x1828		;

000018a8 <.L21>:
    18a8:	0e 44       	mov	r4,	r14	;
    18aa:	1d 46 0a 00 	mov	10(r6),	r13	;0x0000a
    18ae:	81 4c 02 00 	mov	r12,	2(r1)	;
    18b2:	b0 12 86 1a 	call	#6790		;#0x1a86

000018b6 <.LVL48>:
    18b6:	1c 46 06 00 	mov	6(r6),	r12	;
    18ba:	3c f0 7f fb 	and	#64383,	r12	;#0xfb7f
    18be:	3c d0 80 00 	bis	#128,	r12	;#0x0080
    18c2:	86 4c 06 00 	mov	r12,	6(r6)	;
    18c6:	1f 41 02 00 	mov	2(r1),	r15	;

000018ca <.L23>:
    18ca:	86 4f 0a 00 	mov	r15,	10(r6)	; 0x000a

000018ce <.Loc.171.1>:
    18ce:	0f 54       	add	r4,	r15	;

000018d0 <.LVL50>:
    18d0:	86 4f 00 00 	mov	r15,	0(r6)	;

000018d4 <.Loc.172.1>:
    18d4:	86 49 0c 00 	mov	r9,	12(r6)	; 0x000c

000018d8 <.LVL51>:
    18d8:	0f 4a       	mov	r10,	r15	;

000018da <.Loc.174.1>:
    18da:	09 84       	sub	r4,	r9	;

000018dc <.LVL52>:
    18dc:	86 49 04 00 	mov	r9,	4(r6)	;

000018e0 <.L18>:
    18e0:	0a 9f       	cmp	r15,	r10	;
    18e2:	01 2c       	jc	$+4      	;abs 0x18e6

000018e4 <.L42>:
    18e4:	0f 4a       	mov	r10,	r15	;

000018e6 <.L24>:
    18e6:	0e 4f       	mov	r15,	r14	;
    18e8:	0d 45       	mov	r5,	r13	;
    18ea:	2c 46       	mov	@r6,	r12	;
    18ec:	81 4f 02 00 	mov	r15,	2(r1)	;
    18f0:	b0 12 9c 1a 	call	#6812		;#0x1a9c

000018f4 <.LVL56>:
    18f4:	1f 41 02 00 	mov	2(r1),	r15	;
    18f8:	86 8f 04 00 	sub	r15,	4(r6)	;

000018fc <.Loc.180.1>:
    18fc:	86 5f 00 00 	add	r15,	0(r6)	;

00001900 <.Loc.181.1>:
    1900:	09 4a       	mov	r10,	r9	;

00001902 <.L25>:
    1902:	05 59       	add	r9,	r5	;

00001904 <.LVL58>:
    1904:	0a 89       	sub	r9,	r10	;

00001906 <.Loc.204.1>:
    1906:	14 41 04 00 	mov	4(r1),	r4	;
    190a:	1c 44 04 00 	mov	4(r4),	r12	;
    190e:	0c 89       	sub	r9,	r12	;
    1910:	84 4c 04 00 	mov	r12,	4(r4)	;
    1914:	0c 93       	cmp	#0,	r12	;r3 As==00
    1916:	88 23       	jnz	$-238    	;abs 0x1828
    1918:	30 40 fe 16 	br	#0x16fe		;

0000191c <.L20>:
    191c:	0e 49       	mov	r9,	r14	;
    191e:	0c 47       	mov	r7,	r12	;
    1920:	b0 12 e0 1c 	call	#7392		;#0x1ce0

00001924 <.LVL61>:
    1924:	0f 4c       	mov	r12,	r15	;

00001926 <.LVL62>:
    1926:	0c 93       	cmp	#0,	r12	;r3 As==00
    1928:	d0 23       	jnz	$-94     	;abs 0x18ca

0000192a <.Loc.163.1>:
    192a:	1d 46 0a 00 	mov	10(r6),	r13	;0x0000a
    192e:	0c 47       	mov	r7,	r12	;

00001930 <.LVL63>:
    1930:	b0 12 ec 1a 	call	#6892		;#0x1aec

00001934 <.LVL64>:
    1934:	b6 f0 7f ff 	and	#65407,	6(r6)	;#0xff7f
    1938:	06 00 
    193a:	30 40 8c 18 	br	#0x188c		;

0000193e <.L17>:
    193e:	2c 46       	mov	@r6,	r12	;
    1940:	86 9c 0a 00 	cmp	r12,	10(r6)	; 0x000a
    1944:	04 28       	jnc	$+10     	;abs 0x194e

00001946 <.Loc.183.1>:
    1946:	19 46 0c 00 	mov	12(r6),	r9	;0x0000c
    194a:	0a 99       	cmp	r9,	r10	;
    194c:	19 2c       	jc	$+52     	;abs 0x1980

0000194e <.L26>:
    194e:	09 4f       	mov	r15,	r9	;
    1950:	0a 9f       	cmp	r15,	r10	;
    1952:	01 2c       	jc	$+4      	;abs 0x1956

00001954 <.LVL66>:
    1954:	09 4a       	mov	r10,	r9	;

00001956 <.L28>:
    1956:	0e 49       	mov	r9,	r14	;
    1958:	0d 45       	mov	r5,	r13	;
    195a:	b0 12 9c 1a 	call	#6812		;#0x1a9c

0000195e <.LVL68>:
    195e:	1c 46 04 00 	mov	4(r6),	r12	;
    1962:	0c 89       	sub	r9,	r12	;
    1964:	86 4c 04 00 	mov	r12,	4(r6)	;

00001968 <.Loc.189.1>:
    1968:	86 59 00 00 	add	r9,	0(r6)	;

0000196c <.Loc.190.1>:
    196c:	0c 93       	cmp	#0,	r12	;r3 As==00
    196e:	c9 23       	jnz	$-108    	;abs 0x1902

00001970 <.Loc.190.1>:
    1970:	0d 46       	mov	r6,	r13	;
    1972:	0c 47       	mov	r7,	r12	;
    1974:	b0 12 f0 25 	call	#9712		;#0x25f0

00001978 <.LVL69>:
    1978:	0c 93       	cmp	#0,	r12	;r3 As==00
    197a:	c3 27       	jz	$-120    	;abs 0x1902
    197c:	30 40 92 18 	br	#0x1892		;

00001980 <.L27>:
    1980:	0c 4a       	mov	r10,	r12	;
    1982:	3d 40 ff 7f 	mov	#32767,	r13	;#0x7fff
    1986:	0d 9a       	cmp	r10,	r13	;
    1988:	01 2c       	jc	$+4      	;abs 0x198c
    198a:	0c 4d       	mov	r13,	r12	;

0000198c <.L29>:
    198c:	0d 49       	mov	r9,	r13	;
    198e:	b0 12 4a 12 	call	#4682		;#0x124a

00001992 <.LVL71>:
    1992:	0d 49       	mov	r9,	r13	;
    1994:	b0 12 20 30 	call	#12320		;#0x3020

00001998 <.LVL72>:
    1998:	0f 4c       	mov	r12,	r15	;
    199a:	0e 45       	mov	r5,	r14	;
    199c:	1d 46 12 00 	mov	18(r6),	r13	;0x00012
    19a0:	0c 47       	mov	r7,	r12	;

000019a2 <.LVL73>:
    19a2:	14 46 16 00 	mov	22(r6),	r4	;0x00016
    19a6:	84 12       	call	r4		;

000019a8 <.LVL74>:
    19a8:	09 4c       	mov	r12,	r9	;

000019aa <.LVL75>:
    19aa:	4c 43       	clr.b	r12		;
    19ac:	0c 99       	cmp	r9,	r12	;
    19ae:	a9 3b       	jl	$-172    	;abs 0x1902
    19b0:	30 40 92 18 	br	#0x1892		;

000019b4 <.L31>:
    19b4:	25 48       	mov	@r8,	r5	;
    19b6:	19 48 02 00 	mov	2(r8),	r9	;

000019ba <.LVL77>:
    19ba:	28 52       	add	#4,	r8	;r2 As==10

000019bc <.LVL78>:
    19bc:	1c 41 06 00 	mov	6(r1),	r12	;
    19c0:	30 40 a2 17 	br	#0x17a2		;

000019c4 <.L33>:
    19c4:	0a 49       	mov	r9,	r10	;

000019c6 <.LVL80>:
    19c6:	1a 53       	inc	r10		;
    19c8:	30 40 c0 17 	br	#0x17c0		;

000019cc <.L35>:
    19cc:	0f 9d       	cmp	r13,	r15	;
    19ce:	0e 38       	jl	$+30     	;abs 0x19ec

000019d0 <.Loc.238.1>:
    19d0:	0f 4d       	mov	r13,	r15	;

000019d2 <.LVL82>:
    19d2:	0e 45       	mov	r5,	r14	;
    19d4:	1d 46 12 00 	mov	18(r6),	r13	;0x00012

000019d8 <.LVL83>:
    19d8:	0c 47       	mov	r7,	r12	;
    19da:	14 46 16 00 	mov	22(r6),	r4	;0x00016
    19de:	84 12       	call	r4		;

000019e0 <.LVL84>:
    19e0:	04 4c       	mov	r12,	r4	;

000019e2 <.LVL85>:
    19e2:	4c 43       	clr.b	r12		;
    19e4:	0c 94       	cmp	r4,	r12	;
    19e6:	07 3b       	jl	$-496    	;abs 0x17f6
    19e8:	30 40 92 18 	br	#0x1892		;

000019ec <.L37>:
    19ec:	0e 4f       	mov	r15,	r14	;
    19ee:	0d 45       	mov	r5,	r13	;
    19f0:	81 4f 02 00 	mov	r15,	2(r1)	;
    19f4:	b0 12 9c 1a 	call	#6812		;#0x1a9c

000019f8 <.LVL87>:
    19f8:	1f 41 02 00 	mov	2(r1),	r15	;
    19fc:	86 8f 04 00 	sub	r15,	4(r6)	;

00001a00 <.Loc.247.1>:
    1a00:	86 5f 00 00 	add	r15,	0(r6)	;
    1a04:	04 4f       	mov	r15,	r4	;
    1a06:	30 40 f6 17 	br	#0x17f6		;

00001a0a <.L41>:
    1a0a:	1c 41 08 00 	mov	8(r1),	r12	;
    1a0e:	30 40 08 18 	br	#0x1808		;

00001a12 <_fwalk_reent>:
    1a12:	0a 12       	push	r10		;

00001a14 <.LCFI5>:
    1a14:	09 12       	push	r9		;

00001a16 <.LCFI6>:
    1a16:	08 12       	push	r8		;

00001a18 <.LCFI7>:
    1a18:	07 12       	push	r7		;

00001a1a <.LCFI8>:
    1a1a:	06 12       	push	r6		;

00001a1c <.LCFI9>:
    1a1c:	05 12       	push	r5		;

00001a1e <.LCFI10>:
    1a1e:	06 4c       	mov	r12,	r6	;
    1a20:	05 4d       	mov	r13,	r5	;

00001a22 <.LVL14>:
    1a22:	0a 4c       	mov	r12,	r10	;
    1a24:	3a 50 6c 00 	add	#108,	r10	;#0x006c

00001a28 <.Loc.63.1>:
    1a28:	48 43       	clr.b	r8		;

00001a2a <.L8>:
    1a2a:	0a 93       	cmp	#0,	r10	;r3 As==00
    1a2c:	03 20       	jnz	$+8      	;abs 0x1a34

00001a2e <.Loc.80.1>:
    1a2e:	0c 48       	mov	r8,	r12	;
    1a30:	30 40 a8 12 	br	#0x12a8		;

00001a34 <.L12>:
    1a34:	17 4a 02 00 	mov	2(r10),	r7	;
    1a38:	19 4a 04 00 	mov	4(r10),	r9	;
    1a3c:	39 50 06 00 	add	#6,	r9	;

00001a40 <.L9>:
    1a40:	0d 49       	mov	r9,	r13	;
    1a42:	3d 50 fa ff 	add	#65530,	r13	;#0xfffa

00001a46 <.LVL20>:
    1a46:	37 53       	add	#-1,	r7	;r3 As==11
    1a48:	07 93       	cmp	#0,	r7	;r3 As==00
    1a4a:	03 34       	jge	$+8      	;abs 0x1a52

00001a4c <.Loc.74.1>:
    1a4c:	2a 4a       	mov	@r10,	r10	;
    1a4e:	30 40 2a 1a 	br	#0x1a2a		;

00001a52 <.L11>:
    1a52:	5c 43       	mov.b	#1,	r12	;r3 As==01
    1a54:	2c 99       	cmp	@r9,	r12	;
    1a56:	06 2c       	jc	$+14     	;abs 0x1a64

00001a58 <.Loc.76.1>:
    1a58:	b9 93 02 00 	cmp	#-1,	2(r9)	;r3 As==11
    1a5c:	03 24       	jz	$+8      	;abs 0x1a64

00001a5e <.Loc.77.1>:
    1a5e:	0c 46       	mov	r6,	r12	;
    1a60:	85 12       	call	r5		;

00001a62 <.LVL23>:
    1a62:	08 dc       	bis	r12,	r8	;

00001a64 <.L10>:
    1a64:	39 50 3c 00 	add	#60,	r9	;#0x003c

00001a68 <.LVL25>:
    1a68:	30 40 40 1a 	br	#0x1a40		;

00001a6c <memchr>:
    1a6c:	3d f0 ff 00 	and	#255,	r13	;#0x00ff

00001a70 <.LVL2>:
    1a70:	0e 5c       	add	r12,	r14	;

00001a72 <.L2>:
    1a72:	0c 9e       	cmp	r14,	r12	;
    1a74:	02 20       	jnz	$+6      	;abs 0x1a7a

00001a76 <.Loc.133.1>:
    1a76:	4c 43       	clr.b	r12		;

00001a78 <.L1>:
    1a78:	30 41       	ret			

00001a7a <.L4>:
    1a7a:	cc 9d 00 00 	cmp.b	r13,	0(r12)	;
    1a7e:	fc 27       	jz	$-6      	;abs 0x1a78

00001a80 <.Loc.130.1>:
    1a80:	1c 53       	inc	r12		;

00001a82 <.LVL6>:
    1a82:	30 40 72 1a 	br	#0x1a72		;

00001a86 <memcpy>:
    1a86:	0f 4c       	mov	r12,	r15	;
    1a88:	0e 5c       	add	r12,	r14	;

00001a8a <.L2>:
    1a8a:	0f 9e       	cmp	r14,	r15	;
    1a8c:	01 20       	jnz	$+4      	;abs 0x1a90

00001a8e <.Loc.111.1>:
    1a8e:	30 41       	ret			

00001a90 <.L3>:
    1a90:	ef 4d 00 00 	mov.b	@r13,	0(r15)	;
    1a94:	1f 53       	inc	r15		;

00001a96 <.LVL4>:
    1a96:	1d 53       	inc	r13		;
    1a98:	30 40 8a 1a 	br	#0x1a8a		;

00001a9c <memmove>:
    1a9c:	0b 4c       	mov	r12,	r11	;
    1a9e:	0b 5e       	add	r14,	r11	;

00001aa0 <.Loc.69.1>:
    1aa0:	0d 9c       	cmp	r12,	r13	;
    1aa2:	09 28       	jnc	$+20     	;abs 0x1ab6

00001aa4 <.L4>:
    1aa4:	0e 4c       	mov	r12,	r14	;

00001aa6 <.L3>:
    1aa6:	0b 9e       	cmp	r14,	r11	;
    1aa8:	10 24       	jz	$+34     	;abs 0x1aca

00001aaa <.LVL3>:
    1aaa:	ee 4d 00 00 	mov.b	@r13,	0(r14)	;
    1aae:	1e 53       	inc	r14		;

00001ab0 <.LVL4>:
    1ab0:	1d 53       	inc	r13		;
    1ab2:	30 40 a6 1a 	br	#0x1aa6		;

00001ab6 <.L2>:
    1ab6:	0f 4d       	mov	r13,	r15	;
    1ab8:	0f 5e       	add	r14,	r15	;
    1aba:	0c 9f       	cmp	r15,	r12	;
    1abc:	f3 2f       	jc	$-24     	;abs 0x1aa4

00001abe <.LVL6>:
    1abe:	0d 4f       	mov	r15,	r13	;

00001ac0 <.LVL7>:
    1ac0:	0e 8f       	sub	r15,	r14	;

00001ac2 <.L5>:
    1ac2:	0f 4d       	mov	r13,	r15	;
    1ac4:	0f 5e       	add	r14,	r15	;
    1ac6:	0f 93       	cmp	#0,	r15	;r3 As==00
    1ac8:	01 20       	jnz	$+4      	;abs 0x1acc

00001aca <.L9>:
    1aca:	30 41       	ret			

00001acc <.L6>:
    1acc:	3b 53       	add	#-1,	r11	;r3 As==11
    1ace:	3d 53       	add	#-1,	r13	;r3 As==11

00001ad0 <.LVL12>:
    1ad0:	eb 4d 00 00 	mov.b	@r13,	0(r11)	;
    1ad4:	30 40 c2 1a 	br	#0x1ac2		;

00001ad8 <memset>:
    1ad8:	0f 4c       	mov	r12,	r15	;
    1ada:	0e 5c       	add	r12,	r14	;

00001adc <.L2>:
    1adc:	0f 9e       	cmp	r14,	r15	;
    1ade:	01 20       	jnz	$+4      	;abs 0x1ae2

00001ae0 <.Loc.104.1>:
    1ae0:	30 41       	ret			

00001ae2 <.L3>:
    1ae2:	cf 4d 00 00 	mov.b	r13,	0(r15)	;
    1ae6:	1f 53       	inc	r15		;

00001ae8 <.LVL4>:
    1ae8:	30 40 dc 1a 	br	#0x1adc		;

00001aec <_free_r>:
    1aec:	0a 12       	push	r10		;

00001aee <.LCFI0>:
    1aee:	09 12       	push	r9		;

00001af0 <.LCFI1>:
    1af0:	08 12       	push	r8		;

00001af2 <.LCFI2>:
    1af2:	07 12       	push	r7		;

00001af4 <.LCFI3>:
    1af4:	0d 93       	cmp	#0,	r13	;r3 As==00
    1af6:	28 24       	jz	$+82     	;abs 0x1b48

00001af8 <.LBB4>:
    1af8:	0e 4d       	mov	r13,	r14	;
    1afa:	3e 50 fc ff 	add	#65532,	r14	;#0xfffc

00001afe <.LVL2>:
    1afe:	1f 4d fc ff 	mov	-4(r13),r15	;
    1b02:	8d 93 fe ff 	cmp	#0,	-2(r13)	;r3 As==00, 0xfffe
    1b06:	01 34       	jge	$+4      	;abs 0x1b0a
    1b08:	0e 5f       	add	r15,	r14	;

00001b0a <.L4>:
    1b0a:	1d 42 22 81 	mov	&0x8122,r13	;0x8122

00001b0e <.LVL4>:
    1b0e:	0d 93       	cmp	#0,	r13	;r3 As==00
    1b10:	04 20       	jnz	$+10     	;abs 0x1b1a

00001b12 <.L8>:
    1b12:	8e 4d 04 00 	mov	r13,	4(r14)	;
    1b16:	30 40 44 1b 	br	#0x1b44		;

00001b1a <.L6>:
    1b1a:	0e 9d       	cmp	r13,	r14	;
    1b1c:	18 2c       	jc	$+50     	;abs 0x1b4e

00001b1e <.Loc.359.1>:
    1b1e:	2a 4e       	mov	@r14,	r10	;
    1b20:	1b 4e 02 00 	mov	2(r14),	r11	;
    1b24:	0c 4e       	mov	r14,	r12	;

00001b26 <.LVL7>:
    1b26:	0c 5a       	add	r10,	r12	;
    1b28:	0d 9c       	cmp	r12,	r13	;
    1b2a:	f3 23       	jnz	$-24     	;abs 0x1b12

00001b2c <.Loc.363.1>:
    1b2c:	08 4a       	mov	r10,	r8	;
    1b2e:	09 4b       	mov	r11,	r9	;
    1b30:	28 5d       	add	@r13,	r8	;
    1b32:	19 6d 02 00 	addc	2(r13),	r9	;
    1b36:	8e 48 00 00 	mov	r8,	0(r14)	;
    1b3a:	8e 49 02 00 	mov	r9,	2(r14)	;

00001b3e <.Loc.364.1>:
    1b3e:	9e 4d 04 00 	mov	4(r13),	4(r14)	;
    1b42:	04 00 

00001b44 <.L9>:
    1b44:	82 4e 22 81 	mov	r14,	&0x8122	;

00001b48 <.L1>:
    1b48:	30 40 ac 12 	br	#0x12ac		;

00001b4c <.L16>:
    1b4c:	0d 4f       	mov	r15,	r13	;

00001b4e <.L11>:
    1b4e:	1f 4d 04 00 	mov	4(r13),	r15	;

00001b52 <.LVL10>:
    1b52:	0f 93       	cmp	#0,	r15	;r3 As==00
    1b54:	02 24       	jz	$+6      	;abs 0x1b5a

00001b56 <.Loc.382.1>:
    1b56:	0e 9f       	cmp	r15,	r14	;
    1b58:	f9 2f       	jc	$-12     	;abs 0x1b4c

00001b5a <.L10>:
    1b5a:	29 4d       	mov	@r13,	r9	;
    1b5c:	17 4d 02 00 	mov	2(r13),	r7	;
    1b60:	08 4d       	mov	r13,	r8	;
    1b62:	08 59       	add	r9,	r8	;
    1b64:	08 9e       	cmp	r14,	r8	;
    1b66:	1b 20       	jnz	$+56     	;abs 0x1b9e

00001b68 <.Loc.391.1>:
    1b68:	2a 4e       	mov	@r14,	r10	;
    1b6a:	0a 59       	add	r9,	r10	;
    1b6c:	1b 4e 02 00 	mov	2(r14),	r11	;
    1b70:	0b 67       	addc	r7,	r11	;
    1b72:	8d 4a 00 00 	mov	r10,	0(r13)	;
    1b76:	8d 4b 02 00 	mov	r11,	2(r13)	;

00001b7a <.Loc.394.1>:
    1b7a:	0c 4d       	mov	r13,	r12	;

00001b7c <.LVL11>:
    1b7c:	0c 5a       	add	r10,	r12	;
    1b7e:	0f 9c       	cmp	r12,	r15	;
    1b80:	e3 23       	jnz	$-56     	;abs 0x1b48

00001b82 <.Loc.396.1>:
    1b82:	08 4a       	mov	r10,	r8	;
    1b84:	09 4b       	mov	r11,	r9	;
    1b86:	28 5f       	add	@r15,	r8	;
    1b88:	19 6f 02 00 	addc	2(r15),	r9	;
    1b8c:	8d 48 00 00 	mov	r8,	0(r13)	;
    1b90:	8d 49 02 00 	mov	r9,	2(r13)	;

00001b94 <.Loc.397.1>:
    1b94:	9d 4f 04 00 	mov	4(r15),	4(r13)	;
    1b98:	04 00 
    1b9a:	30 40 48 1b 	br	#0x1b48		;

00001b9e <.L12>:
    1b9e:	0e 98       	cmp	r8,	r14	;
    1ba0:	05 2c       	jc	$+12     	;abs 0x1bac

00001ba2 <.Loc.404.1>:
    1ba2:	bc 40 0c 00 	mov	#12,	0(r12)	;#0x000c
    1ba6:	00 00 

00001ba8 <.Loc.406.1>:
    1ba8:	30 40 48 1b 	br	#0x1b48		;

00001bac <.L14>:
    1bac:	2a 4e       	mov	@r14,	r10	;
    1bae:	1b 4e 02 00 	mov	2(r14),	r11	;
    1bb2:	0c 4e       	mov	r14,	r12	;

00001bb4 <.LVL13>:
    1bb4:	0c 5a       	add	r10,	r12	;
    1bb6:	0f 9c       	cmp	r12,	r15	;
    1bb8:	10 20       	jnz	$+34     	;abs 0x1bda

00001bba <.Loc.413.1>:
    1bba:	08 4a       	mov	r10,	r8	;
    1bbc:	09 4b       	mov	r11,	r9	;
    1bbe:	28 5f       	add	@r15,	r8	;
    1bc0:	19 6f 02 00 	addc	2(r15),	r9	;
    1bc4:	8e 48 00 00 	mov	r8,	0(r14)	;
    1bc8:	8e 49 02 00 	mov	r9,	2(r14)	;

00001bcc <.Loc.414.1>:
    1bcc:	9e 4f 04 00 	mov	4(r15),	4(r14)	;
    1bd0:	04 00 

00001bd2 <.L20>:
    1bd2:	8d 4e 04 00 	mov	r14,	4(r13)	;
    1bd6:	30 40 48 1b 	br	#0x1b48		;

00001bda <.L15>:
    1bda:	8e 4f 04 00 	mov	r15,	4(r14)	;
    1bde:	30 40 d2 1b 	br	#0x1bd2		;

00001be2 <_malloc_r>:
    1be2:	0a 12       	push	r10		;

00001be4 <.LCFI0>:
    1be4:	09 12       	push	r9		;

00001be6 <.LCFI1>:
    1be6:	08 12       	push	r8		;

00001be8 <.LCFI2>:
    1be8:	07 12       	push	r7		;

00001bea <.LCFI3>:
    1bea:	08 4c       	mov	r12,	r8	;

00001bec <.Loc.247.1>:
    1bec:	09 4d       	mov	r13,	r9	;
    1bee:	19 53       	inc	r9		;
    1bf0:	19 c3       	bic	#1,	r9	;r3 As==01

00001bf2 <.LVL1>:
    1bf2:	39 50 0a 00 	add	#10,	r9	;#0x000a

00001bf6 <.LVL2>:
    1bf6:	39 90 0c 00 	cmp	#12,	r9	;#0x000c
    1bfa:	02 2c       	jc	$+6      	;abs 0x1c00
    1bfc:	79 40 0c 00 	mov.b	#12,	r9	;#0x000c

00001c00 <.L2>:
    1c00:	09 9d       	cmp	r13,	r9	;
    1c02:	06 2c       	jc	$+14     	;abs 0x1c10

00001c04 <.L13>:
    1c04:	b8 40 0c 00 	mov	#12,	0(r8)	;#0x000c
    1c08:	00 00 

00001c0a <.Loc.255.1>:
    1c0a:	4c 43       	clr.b	r12		;

00001c0c <.L1>:
    1c0c:	30 40 ac 12 	br	#0x12ac		;

00001c10 <.L3>:
    1c10:	1e 42 22 81 	mov	&0x8122,r14	;0x8122

00001c14 <.LVL6>:
    1c14:	0d 4e       	mov	r14,	r13	;

00001c16 <.L5>:
    1c16:	0d 93       	cmp	#0,	r13	;r3 As==00
    1c18:	21 20       	jnz	$+68     	;abs 0x1c5c

00001c1a <.LVL8>:
    1c1a:	37 40 8c 20 	mov	#8332,	r7	;#0x208c

00001c1e <.LBB5>:
    1c1e:	82 93 20 81 	cmp	#0,	&0x8120	;r3 As==00
    1c22:	04 20       	jnz	$+10     	;abs 0x1c2c
    1c24:	0c 48       	mov	r8,	r12	;
    1c26:	87 12       	call	r7		;

00001c28 <.LVL9>:
    1c28:	82 4c 20 81 	mov	r12,	&0x8120	;

00001c2c <.L17>:
    1c2c:	0d 49       	mov	r9,	r13	;
    1c2e:	0c 48       	mov	r8,	r12	;
    1c30:	87 12       	call	r7		;

00001c32 <.LVL10>:
    1c32:	3c 93       	cmp	#-1,	r12	;r3 As==11
    1c34:	e7 27       	jz	$-48     	;abs 0x1c04

00001c36 <.Loc.222.1>:
    1c36:	0e 4c       	mov	r12,	r14	;
    1c38:	1e 53       	inc	r14		;
    1c3a:	0a 4e       	mov	r14,	r10	;
    1c3c:	1a c3       	bic	#1,	r10	;r3 As==01

00001c3e <.LVL11>:
    1c3e:	0c 9a       	cmp	r10,	r12	;
    1c40:	06 24       	jz	$+14     	;abs 0x1c4e

00001c42 <.Loc.227.1>:
    1c42:	0d 4a       	mov	r10,	r13	;
    1c44:	0d 8c       	sub	r12,	r13	;
    1c46:	0c 48       	mov	r8,	r12	;

00001c48 <.LVL12>:
    1c48:	87 12       	call	r7		;

00001c4a <.LVL13>:
    1c4a:	3c 93       	cmp	#-1,	r12	;r3 As==11
    1c4c:	db 27       	jz	$-72     	;abs 0x1c04

00001c4e <.L14>:
    1c4e:	8a 49 00 00 	mov	r9,	0(r10)	;
    1c52:	8a 43 02 00 	mov	#0,	2(r10)	;r3 As==00
    1c56:	0e 4a       	mov	r10,	r14	;
    1c58:	30 40 8a 1c 	br	#0x1c8a		;

00001c5c <.L10>:
    1c5c:	2c 4d       	mov	@r13,	r12	;
    1c5e:	0c 89       	sub	r9,	r12	;

00001c60 <.LVL16>:
    1c60:	0c 93       	cmp	#0,	r12	;r3 As==00
    1c62:	39 38       	jl	$+116    	;abs 0x1cd6

00001c64 <.Loc.268.1>:
    1c64:	7a 40 0b 00 	mov.b	#11,	r10	;#0x000b
    1c68:	0a 9c       	cmp	r12,	r10	;
    1c6a:	28 2c       	jc	$+82     	;abs 0x1cbc

00001c6c <.Loc.272.1>:
    1c6c:	0e 4c       	mov	r12,	r14	;
    1c6e:	3e b0 00 80 	bit	#32768,	r14	;#0x8000
    1c72:	0f 7f       	subc	r15,	r15	;
    1c74:	3f e3       	inv	r15		;

00001c76 <.LVL17>:
    1c76:	8d 4e 00 00 	mov	r14,	0(r13)	;
    1c7a:	8d 4f 02 00 	mov	r15,	2(r13)	;

00001c7e <.Loc.273.1>:
    1c7e:	0e 4d       	mov	r13,	r14	;
    1c80:	0e 5c       	add	r12,	r14	;

00001c82 <.LVL18>:
    1c82:	8e 49 00 00 	mov	r9,	0(r14)	;
    1c86:	8e 43 02 00 	mov	#0,	2(r14)	;r3 As==00

00001c8a <.L8>:
    1c8a:	0f 4e       	mov	r14,	r15	;
    1c8c:	2f 52       	add	#4,	r15	;r2 As==10

00001c8e <.LVL20>:
    1c8e:	0c 4f       	mov	r15,	r12	;
    1c90:	3c 50 07 00 	add	#7,	r12	;
    1c94:	3c f0 f8 ff 	and	#65528,	r12	;#0xfff8

00001c98 <.LVL21>:
    1c98:	0d 4c       	mov	r12,	r13	;
    1c9a:	0d 8f       	sub	r15,	r13	;

00001c9c <.LVL22>:
    1c9c:	0d 93       	cmp	#0,	r13	;r3 As==00
    1c9e:	b6 27       	jz	$-146    	;abs 0x1c0c

00001ca0 <.Loc.318.1>:
    1ca0:	0e 5d       	add	r13,	r14	;

00001ca2 <.LVL23>:
    1ca2:	0f 43       	clr	r15		;
    1ca4:	0f 8d       	sub	r13,	r15	;

00001ca6 <.LVL24>:
    1ca6:	0a 4f       	mov	r15,	r10	;
    1ca8:	3a b0 00 80 	bit	#32768,	r10	;#0x8000
    1cac:	0b 7b       	subc	r11,	r11	;
    1cae:	3b e3       	inv	r11		;
    1cb0:	8e 4a 00 00 	mov	r10,	0(r14)	;
    1cb4:	8e 4b 02 00 	mov	r11,	2(r14)	;
    1cb8:	30 40 0c 1c 	br	#0x1c0c		;

00001cbc <.L7>:
    1cbc:	0e 9d       	cmp	r13,	r14	;
    1cbe:	05 20       	jnz	$+12     	;abs 0x1cca

00001cc0 <.Loc.282.1>:
    1cc0:	92 4e 04 00 	mov	4(r14),	&0x8122	;
    1cc4:	22 81 
    1cc6:	30 40 8a 1c 	br	#0x1c8a		;

00001cca <.L9>:
    1cca:	9e 4d 04 00 	mov	4(r13),	4(r14)	;
    1cce:	04 00 
    1cd0:	0e 4d       	mov	r13,	r14	;

00001cd2 <.LVL26>:
    1cd2:	30 40 8a 1c 	br	#0x1c8a		;

00001cd6 <.L6>:
    1cd6:	0e 4d       	mov	r13,	r14	;
    1cd8:	1d 4d 04 00 	mov	4(r13),	r13	;

00001cdc <.LVL28>:
    1cdc:	30 40 16 1c 	br	#0x1c16		;

00001ce0 <_realloc_r>:
    1ce0:	0a 12       	push	r10		;

00001ce2 <.LCFI0>:
    1ce2:	09 12       	push	r9		;

00001ce4 <.LCFI1>:
    1ce4:	08 12       	push	r8		;

00001ce6 <.LCFI2>:
    1ce6:	07 12       	push	r7		;

00001ce8 <.LCFI3>:
    1ce8:	07 4c       	mov	r12,	r7	;
    1cea:	08 4d       	mov	r13,	r8	;
    1cec:	0a 4e       	mov	r14,	r10	;

00001cee <.Loc.454.1>:
    1cee:	0d 93       	cmp	#0,	r13	;r3 As==00
    1cf0:	07 20       	jnz	$+16     	;abs 0x1d00

00001cf2 <.Loc.454.1>:
    1cf2:	0d 4e       	mov	r14,	r13	;

00001cf4 <.LVL1>:
    1cf4:	b0 12 e2 1b 	call	#7138		;#0x1be2

00001cf8 <.LVL2>:
    1cf8:	09 4c       	mov	r12,	r9	;

00001cfa <.L1>:
    1cfa:	0c 49       	mov	r9,	r12	;
    1cfc:	30 40 ac 12 	br	#0x12ac		;

00001d00 <.L2>:
    1d00:	0e 93       	cmp	#0,	r14	;r3 As==00
    1d02:	05 20       	jnz	$+12     	;abs 0x1d0e

00001d04 <.Loc.458.1>:
    1d04:	b0 12 ec 1a 	call	#6892		;#0x1aec

00001d08 <.LVL3>:
    1d08:	09 4a       	mov	r10,	r9	;
    1d0a:	30 40 fa 1c 	br	#0x1cfa		;

00001d0e <.L4>:
    1d0e:	b0 12 70 28 	call	#10352		;#0x2870

00001d12 <.LVL4>:
    1d12:	0c 9a       	cmp	r10,	r12	;
    1d14:	11 2c       	jc	$+36     	;abs 0x1d38

00001d16 <.Loc.467.1>:
    1d16:	0d 4a       	mov	r10,	r13	;
    1d18:	0c 47       	mov	r7,	r12	;
    1d1a:	b0 12 e2 1b 	call	#7138		;#0x1be2

00001d1e <.LVL5>:
    1d1e:	09 4c       	mov	r12,	r9	;

00001d20 <.LVL6>:
    1d20:	0c 93       	cmp	#0,	r12	;r3 As==00
    1d22:	eb 27       	jz	$-40     	;abs 0x1cfa

00001d24 <.Loc.470.1>:
    1d24:	0e 4a       	mov	r10,	r14	;
    1d26:	0d 48       	mov	r8,	r13	;
    1d28:	b0 12 86 1a 	call	#6790		;#0x1a86

00001d2c <.LVL7>:
    1d2c:	0d 48       	mov	r8,	r13	;
    1d2e:	0c 47       	mov	r7,	r12	;
    1d30:	b0 12 ec 1a 	call	#6892		;#0x1aec

00001d34 <.LVL8>:
    1d34:	30 40 fa 1c 	br	#0x1cfa		;

00001d38 <.L5>:
    1d38:	09 48       	mov	r8,	r9	;
    1d3a:	30 40 fa 1c 	br	#0x1cfa		;

00001d3e <__sfputc_r>:
    1d3e:	1f 4e 04 00 	mov	4(r14),	r15	;
    1d42:	3f 53       	add	#-1,	r15	;r3 As==11
    1d44:	8e 4f 04 00 	mov	r15,	4(r14)	;
    1d48:	0f 93       	cmp	#0,	r15	;r3 As==00
    1d4a:	06 34       	jge	$+14     	;abs 0x1d58

00001d4c <.Loc.400.1>:
    1d4c:	1f 9e 0e 00 	cmp	14(r14),r15	;0x0000e
    1d50:	0e 38       	jl	$+30     	;abs 0x1d6e

00001d52 <.Loc.400.1>:
    1d52:	7d 90 0a 00 	cmp.b	#10,	r13	;#0x000a
    1d56:	0b 24       	jz	$+24     	;abs 0x1d6e

00001d58 <.L2>:
    1d58:	2c 4e       	mov	@r14,	r12	;

00001d5a <.LVL1>:
    1d5a:	0f 4c       	mov	r12,	r15	;
    1d5c:	1f 53       	inc	r15		;
    1d5e:	8e 4f 00 00 	mov	r15,	0(r14)	;
    1d62:	cc 4d 00 00 	mov.b	r13,	0(r12)	;
    1d66:	0c 4d       	mov	r13,	r12	;
    1d68:	7c f0 ff 00 	and.b	#255,	r12	;#0x00ff

00001d6c <.L1>:
    1d6c:	30 41       	ret			

00001d6e <.L3>:
    1d6e:	b0 12 74 21 	call	#8564		;#0x2174

00001d72 <.LVL4>:
    1d72:	30 40 6c 1d 	br	#0x1d6c		;

00001d76 <__sfputs_r>:
    1d76:	0a 12       	push	r10		;

00001d78 <.LCFI0>:
    1d78:	09 12       	push	r9		;

00001d7a <.LCFI1>:
    1d7a:	08 12       	push	r8		;

00001d7c <.LCFI2>:
    1d7c:	07 12       	push	r7		;

00001d7e <.LCFI3>:
    1d7e:	06 12       	push	r6		;

00001d80 <.LCFI4>:
    1d80:	05 12       	push	r5		;

00001d82 <.LCFI5>:
    1d82:	07 4c       	mov	r12,	r7	;
    1d84:	08 4d       	mov	r13,	r8	;
    1d86:	0c 4f       	mov	r15,	r12	;

00001d88 <.LVL6>:
    1d88:	0a 4e       	mov	r14,	r10	;

00001d8a <.Loc.416.1>:
    1d8a:	fd b0 20 00 	bit.b	#32,	59(r13)	;#0x0020, 0x003b
    1d8e:	3b 00 
    1d90:	0f 20       	jnz	$+32     	;abs 0x1db0
    1d92:	09 4e       	mov	r14,	r9	;
    1d94:	09 5f       	add	r15,	r9	;

00001d96 <.Loc.433.1>:
    1d96:	36 40 3e 1d 	mov	#7486,	r6	;#0x1d3e

00001d9a <.L10>:
    1d9a:	0a 99       	cmp	r9,	r10	;
    1d9c:	11 24       	jz	$+36     	;abs 0x1dc0

00001d9e <.Loc.433.1>:
    1d9e:	0e 48       	mov	r8,	r14	;
    1da0:	6d 4a       	mov.b	@r10,	r13	;
    1da2:	0c 47       	mov	r7,	r12	;
    1da4:	86 12       	call	r6		;

00001da6 <.LVL8>:
    1da6:	1a 53       	inc	r10		;

00001da8 <.LVL9>:
    1da8:	3c 93       	cmp	#-1,	r12	;r3 As==11
    1daa:	f7 23       	jnz	$-16     	;abs 0x1d9a
    1dac:	30 40 d8 1d 	br	#0x1dd8		;

00001db0 <.L9>:
    1db0:	b0 12 5e 13 	call	#4958		;#0x135e

00001db4 <.LVL11>:
    1db4:	06 4c       	mov	r12,	r6	;
    1db6:	49 43       	clr.b	r9		;

00001db8 <.Loc.423.1>:
    1db8:	35 40 08 27 	mov	#9992,	r5	;#0x2708

00001dbc <.L11>:
    1dbc:	09 96       	cmp	r6,	r9	;
    1dbe:	03 20       	jnz	$+8      	;abs 0x1dc6

00001dc0 <.L17>:
    1dc0:	4c 43       	clr.b	r12		;
    1dc2:	30 40 da 1d 	br	#0x1dda		;

00001dc6 <.L14>:
    1dc6:	0f 48       	mov	r8,	r15	;
    1dc8:	2d 4a       	mov	@r10,	r13	;
    1dca:	1e 4a 02 00 	mov	2(r10),	r14	;
    1dce:	0c 47       	mov	r7,	r12	;
    1dd0:	85 12       	call	r5		;

00001dd2 <.LVL15>:
    1dd2:	2a 52       	add	#4,	r10	;r2 As==10
    1dd4:	3c 93       	cmp	#-1,	r12	;r3 As==11
    1dd6:	03 20       	jnz	$+8      	;abs 0x1dde

00001dd8 <.L15>:
    1dd8:	3c 43       	mov	#-1,	r12	;r3 As==11

00001dda <.L8>:
    1dda:	30 40 a8 12 	br	#0x12a8		;

00001dde <.L12>:
    1dde:	19 53       	inc	r9		;
    1de0:	30 40 bc 1d 	br	#0x1dbc		;

00001de4 <_vfiprintf_r>:
    1de4:	0a 12       	push	r10		;

00001de6 <.LCFI14>:
    1de6:	09 12       	push	r9		;

00001de8 <.LCFI15>:
    1de8:	08 12       	push	r8		;

00001dea <.LCFI16>:
    1dea:	07 12       	push	r7		;

00001dec <.LCFI17>:
    1dec:	06 12       	push	r6		;

00001dee <.LCFI18>:
    1dee:	05 12       	push	r5		;

00001df0 <.LCFI19>:
    1df0:	04 12       	push	r4		;

00001df2 <.LCFI20>:
    1df2:	31 80 52 00 	sub	#82,	r1	;#0x0052

00001df6 <.LCFI21>:
    1df6:	08 4c       	mov	r12,	r8	;
    1df8:	09 4d       	mov	r13,	r9	;
    1dfa:	07 4e       	mov	r14,	r7	;
    1dfc:	81 4f 04 00 	mov	r15,	4(r1)	;

00001e00 <.LBB16>:
    1e00:	0c 93       	cmp	#0,	r12	;r3 As==00
    1e02:	05 24       	jz	$+12     	;abs 0x1e0e

00001e04 <.Loc.493.1>:
    1e04:	8c 93 0c 00 	cmp	#0,	12(r12)	;r3 As==00, 0x000c
    1e08:	02 20       	jnz	$+6      	;abs 0x1e0e

00001e0a <.Loc.493.1>:
    1e0a:	b0 12 b0 15 	call	#5552		;#0x15b0

00001e0e <.L32>:
    1e0e:	39 90 58 37 	cmp	#14168,	r9	;#0x3758
    1e12:	66 20       	jnz	$+206    	;abs 0x1ee0

00001e14 <.Loc.493.1>:
    1e14:	19 48 02 00 	mov	2(r8),	r9	;

00001e18 <.L34>:
    1e18:	f9 b2 06 00 	bit.b	#8,	6(r9)	;r2 As==11
    1e1c:	6f 24       	jz	$+224    	;abs 0x1efc

00001e1e <.Loc.497.1>:
    1e1e:	89 93 0a 00 	cmp	#0,	10(r9)	;r3 As==00, 0x000a
    1e22:	6c 24       	jz	$+218    	;abs 0x1efc

00001e24 <.L38>:
    1e24:	81 43 10 00 	mov	#0,	16(r1)	;r3 As==00, 0x0010

00001e28 <.Loc.519.1>:
    1e28:	f1 40 20 00 	mov.b	#32,	19(r1)	;#0x0020, 0x0013
    1e2c:	13 00 

00001e2e <.Loc.520.1>:
    1e2e:	f1 40 30 00 	mov.b	#48,	20(r1)	;#0x0030, 0x0014
    1e32:	14 00 

00001e34 <.Loc.531.1>:
    1e34:	35 40 76 1d 	mov	#7542,	r5	;#0x1d76

00001e38 <.Loc.554.1>:
    1e38:	34 40 6c 1a 	mov	#6764,	r4	;#0x1a6c

00001e3c <.L37>:
    1e3c:	0a 47       	mov	r7,	r10	;

00001e3e <.L40>:
    1e3e:	6c 4a       	mov.b	@r10,	r12	;
    1e40:	0c 93       	cmp	#0,	r12	;r3 As==00
    1e42:	67 20       	jnz	$+208    	;abs 0x1f12

00001e44 <.L45>:
    1e44:	0b 4a       	mov	r10,	r11	;
    1e46:	0b 87       	sub	r7,	r11	;

00001e48 <.LVL43>:
    1e48:	0b 93       	cmp	#0,	r11	;r3 As==00
    1e4a:	0d 24       	jz	$+28     	;abs 0x1e66

00001e4c <.Loc.531.1>:
    1e4c:	0f 4b       	mov	r11,	r15	;
    1e4e:	0e 47       	mov	r7,	r14	;
    1e50:	0d 49       	mov	r9,	r13	;
    1e52:	0c 48       	mov	r8,	r12	;
    1e54:	81 4b 02 00 	mov	r11,	2(r1)	;
    1e58:	85 12       	call	r5		;

00001e5a <.LVL44>:
    1e5a:	1b 41 02 00 	mov	2(r1),	r11	;
    1e5e:	3c 93       	cmp	#-1,	r12	;r3 As==11
    1e60:	ff 24       	jz	$+512    	;abs 0x2060

00001e62 <.Loc.532.1>:
    1e62:	81 5b 10 00 	add	r11,	16(r1)	; 0x0010

00001e66 <.L43>:
    1e66:	ca 93 00 00 	cmp.b	#0,	0(r10)	;r3 As==00
    1e6a:	fa 24       	jz	$+502    	;abs 0x2060

00001e6c <.Loc.537.1>:
    1e6c:	1a 53       	inc	r10		;

00001e6e <.LVL45>:
    1e6e:	81 43 06 00 	mov	#0,	6(r1)	;r3 As==00

00001e72 <.Loc.540.1>:
    1e72:	81 43 0c 00 	mov	#0,	12(r1)	;r3 As==00, 0x000c

00001e76 <.Loc.541.1>:
    1e76:	b1 43 08 00 	mov	#-1,	8(r1)	;r3 As==11

00001e7a <.Loc.542.1>:
    1e7a:	81 43 0a 00 	mov	#0,	10(r1)	;r3 As==00, 0x000a

00001e7e <.Loc.543.1>:
    1e7e:	c1 43 3d 00 	mov.b	#0,	61(r1)	;r3 As==00, 0x003d

00001e82 <.Loc.545.1>:
    1e82:	81 43 50 00 	mov	#0,	80(r1)	;r3 As==00, 0x0050

00001e86 <.L47>:
    1e86:	7e 40 05 00 	mov.b	#5,	r14	;
    1e8a:	6d 4a       	mov.b	@r10,	r13	;
    1e8c:	3c 40 6e 37 	mov	#14190,	r12	;#0x376e
    1e90:	84 12       	call	r4		;

00001e92 <.LVL47>:
    1e92:	0d 4c       	mov	r12,	r13	;

00001e94 <.LVL48>:
    1e94:	07 4a       	mov	r10,	r7	;
    1e96:	17 53       	inc	r7		;
    1e98:	0c 93       	cmp	#0,	r12	;r3 As==00
    1e9a:	41 20       	jnz	$+132    	;abs 0x1f1e

00001e9c <.Loc.557.1>:
    1e9c:	1d 41 06 00 	mov	6(r1),	r13	;
    1ea0:	3d b0 10 00 	bit	#16,	r13	;#0x0010
    1ea4:	03 24       	jz	$+8      	;abs 0x1eac

00001ea6 <.Loc.558.1>:
    1ea6:	f1 40 20 00 	mov.b	#32,	61(r1)	;#0x0020, 0x003d
    1eaa:	3d 00 

00001eac <.L49>:
    1eac:	3d b2       	bit	#8,	r13	;r2 As==11
    1eae:	03 24       	jz	$+8      	;abs 0x1eb6

00001eb0 <.Loc.566.1>:
    1eb0:	f1 40 2b 00 	mov.b	#43,	61(r1)	;#0x002b, 0x003d
    1eb4:	3d 00 

00001eb6 <.L50>:
    1eb6:	fa 90 2a 00 	cmp.b	#42,	0(r10)	;#0x002a
    1eba:	00 00 
    1ebc:	3a 24       	jz	$+118    	;abs 0x1f32
    1ebe:	1f 41 0c 00 	mov	12(r1),	r15	;0x0000c
    1ec2:	4c 43       	clr.b	r12		;

00001ec4 <.LVL49>:
    1ec4:	5e 43       	mov.b	#1,	r14	;r3 As==01

00001ec6 <.L52>:
    1ec6:	6d 4a       	mov.b	@r10,	r13	;
    1ec8:	3d 50 d0 ff 	add	#65488,	r13	;#0xffd0
    1ecc:	77 40 09 00 	mov.b	#9,	r7	;
    1ed0:	07 9d       	cmp	r13,	r7	;
    1ed2:	8b 2c       	jc	$+280    	;abs 0x1fea
    1ed4:	0c 93       	cmp	#0,	r12	;r3 As==00
    1ed6:	3b 24       	jz	$+120    	;abs 0x1f4e
    1ed8:	81 4f 0c 00 	mov	r15,	12(r1)	; 0x000c
    1edc:	30 40 4e 1f 	br	#0x1f4e		;

00001ee0 <.L33>:
    1ee0:	39 90 46 37 	cmp	#14150,	r9	;#0x3746
    1ee4:	04 20       	jnz	$+10     	;abs 0x1eee

00001ee6 <.Loc.493.1>:
    1ee6:	19 48 04 00 	mov	4(r8),	r9	;
    1eea:	30 40 18 1e 	br	#0x1e18		;

00001eee <.L35>:
    1eee:	39 90 34 37 	cmp	#14132,	r9	;#0x3734
    1ef2:	92 23       	jnz	$-218    	;abs 0x1e18

00001ef4 <.Loc.493.1>:
    1ef4:	19 48 06 00 	mov	6(r8),	r9	;
    1ef8:	30 40 18 1e 	br	#0x1e18		;

00001efc <.L36>:
    1efc:	0d 49       	mov	r9,	r13	;
    1efe:	0c 48       	mov	r8,	r12	;
    1f00:	b0 12 72 22 	call	#8818		;#0x2272

00001f04 <.LVL53>:
    1f04:	0c 93       	cmp	#0,	r12	;r3 As==00
    1f06:	8e 27       	jz	$-226    	;abs 0x1e24

00001f08 <.L70>:
    1f08:	3c 43       	mov	#-1,	r12	;r3 As==11

00001f0a <.L31>:
    1f0a:	31 50 52 00 	add	#82,	r1	;#0x0052
    1f0e:	30 40 a6 12 	br	#0x12a6		;

00001f12 <.L41>:
    1f12:	3c 90 25 00 	cmp	#37,	r12	;#0x0025
    1f16:	96 27       	jz	$-210    	;abs 0x1e44

00001f18 <.Loc.527.1>:
    1f18:	1a 53       	inc	r10		;
    1f1a:	30 40 3e 1e 	br	#0x1e3e		;

00001f1e <.L48>:
    1f1e:	5c 43       	mov.b	#1,	r12	;r3 As==01

00001f20 <.LVL58>:
    1f20:	3d 80 6e 37 	sub	#14190,	r13	;#0x376e

00001f24 <.LVL59>:
    1f24:	b0 12 da 12 	call	#4826		;#0x12da

00001f28 <.LVL60>:
    1f28:	81 dc 06 00 	bis	r12,	6(r1)	;

00001f2c <.Loc.554.1>:
    1f2c:	0a 47       	mov	r7,	r10	;

00001f2e <.LVL61>:
    1f2e:	30 40 86 1e 	br	#0x1e86		;

00001f32 <.L51>:
    1f32:	1c 41 04 00 	mov	4(r1),	r12	;

00001f36 <.LVL63>:
    1f36:	1c 53       	inc	r12		;
    1f38:	1c c3       	bic	#1,	r12	;r3 As==01
    1f3a:	0e 4c       	mov	r12,	r14	;
    1f3c:	2e 53       	incd	r14		;
    1f3e:	81 4e 04 00 	mov	r14,	4(r1)	;
    1f42:	2c 4c       	mov	@r12,	r12	;

00001f44 <.Loc.578.1>:
    1f44:	0c 93       	cmp	#0,	r12	;r3 As==00
    1f46:	48 38       	jl	$+146    	;abs 0x1fd8

00001f48 <.Loc.577.1>:
    1f48:	81 4c 0c 00 	mov	r12,	12(r1)	; 0x000c

00001f4c <.L54>:
    1f4c:	0a 47       	mov	r7,	r10	;

00001f4e <.L55>:
    1f4e:	fa 90 2e 00 	cmp.b	#46,	0(r10)	;#0x002e
    1f52:	00 00 
    1f54:	14 20       	jnz	$+42     	;abs 0x1f7e

00001f56 <.Loc.594.1>:
    1f56:	0c 4a       	mov	r10,	r12	;
    1f58:	1c 53       	inc	r12		;

00001f5a <.LVL65>:
    1f5a:	fa 90 2a 00 	cmp.b	#42,	1(r10)	;#0x002a
    1f5e:	01 00 
    1f60:	53 20       	jnz	$+168    	;abs 0x2008

00001f62 <.Loc.597.1>:
    1f62:	2a 53       	incd	r10		;

00001f64 <.LVL66>:
    1f64:	1c 41 04 00 	mov	4(r1),	r12	;
    1f68:	1c 53       	inc	r12		;
    1f6a:	1c c3       	bic	#1,	r12	;r3 As==01
    1f6c:	0d 4c       	mov	r12,	r13	;
    1f6e:	2d 53       	incd	r13		;
    1f70:	81 4d 04 00 	mov	r13,	4(r1)	;
    1f74:	2c 4c       	mov	@r12,	r12	;

00001f76 <.Loc.599.1>:
    1f76:	0c 93       	cmp	#0,	r12	;r3 As==00
    1f78:	43 38       	jl	$+136    	;abs 0x2000

00001f7a <.Loc.598.1>:
    1f7a:	81 4c 08 00 	mov	r12,	8(r1)	;

00001f7e <.L58>:
    1f7e:	7e 40 03 00 	mov.b	#3,	r14	;
    1f82:	6d 4a       	mov.b	@r10,	r13	;
    1f84:	3c 40 74 37 	mov	#14196,	r12	;#0x3774
    1f88:	84 12       	call	r4		;

00001f8a <.LVL68>:
    1f8a:	0d 4c       	mov	r12,	r13	;

00001f8c <.LVL69>:
    1f8c:	0c 93       	cmp	#0,	r12	;r3 As==00
    1f8e:	09 24       	jz	$+20     	;abs 0x1fa2

00001f90 <.Loc.614.1>:
    1f90:	7c 40 40 00 	mov.b	#64,	r12	;#0x0040

00001f94 <.LVL70>:
    1f94:	3d 80 74 37 	sub	#14196,	r13	;#0x3774

00001f98 <.LVL71>:
    1f98:	b0 12 da 12 	call	#4826		;#0x12da

00001f9c <.LVL72>:
    1f9c:	81 dc 06 00 	bis	r12,	6(r1)	;

00001fa0 <.Loc.615.1>:
    1fa0:	1a 53       	inc	r10		;

00001fa2 <.L64>:
    1fa2:	07 4a       	mov	r10,	r7	;
    1fa4:	17 53       	inc	r7		;

00001fa6 <.LVL74>:
    1fa6:	6d 4a       	mov.b	@r10,	r13	;
    1fa8:	c1 4d 12 00 	mov.b	r13,	18(r1)	; 0x0012

00001fac <.Loc.620.1>:
    1fac:	7e 40 06 00 	mov.b	#6,	r14	;
    1fb0:	3c 40 78 37 	mov	#14200,	r12	;#0x3778
    1fb4:	84 12       	call	r4		;

00001fb6 <.LVL75>:
    1fb6:	0c 93       	cmp	#0,	r12	;r3 As==00
    1fb8:	5b 24       	jz	$+184    	;abs 0x2070

00001fba <.Loc.627.1>:
    1fba:	3a 40 00 00 	mov	#0,	r10	;
    1fbe:	0a 93       	cmp	#0,	r10	;r3 As==00
    1fc0:	41 20       	jnz	$+132    	;abs 0x2044
    1fc2:	1c 41 04 00 	mov	4(r1),	r12	;

00001fc6 <.LVL76>:
    1fc6:	1c 53       	inc	r12		;
    1fc8:	1c c3       	bic	#1,	r12	;r3 As==01
    1fca:	3c 52       	add	#8,	r12	;r2 As==11

00001fcc <.Loc.632.1>:
    1fcc:	81 4c 04 00 	mov	r12,	4(r1)	;

00001fd0 <.L68>:
    1fd0:	81 56 10 00 	add	r6,	16(r1)	; 0x0010

00001fd4 <.Loc.525.1>:
    1fd4:	30 40 3c 1e 	br	#0x1e3c		;

00001fd8 <.L53>:
    1fd8:	4e 43       	clr.b	r14		;
    1fda:	0e 8c       	sub	r12,	r14	;
    1fdc:	81 4e 0c 00 	mov	r14,	12(r1)	; 0x000c

00001fe0 <.Loc.581.1>:
    1fe0:	2d d3       	bis	#2,	r13	;r3 As==10
    1fe2:	81 4d 06 00 	mov	r13,	6(r1)	;
    1fe6:	30 40 4c 1f 	br	#0x1f4c		;

00001fea <.L56>:
    1fea:	0c 4f       	mov	r15,	r12	;
    1fec:	0c 5f       	add	r15,	r12	;
    1fee:	0c 5c       	rla	r12		;
    1ff0:	0c 5f       	add	r15,	r12	;
    1ff2:	0c 5c       	rla	r12		;
    1ff4:	0f 4c       	mov	r12,	r15	;
    1ff6:	0f 5d       	add	r13,	r15	;

00001ff8 <.Loc.587.1>:
    1ff8:	1a 53       	inc	r10		;
    1ffa:	0c 4e       	mov	r14,	r12	;
    1ffc:	30 40 c6 1e 	br	#0x1ec6		;

00002000 <.L60>:
    2000:	b1 43 08 00 	mov	#-1,	8(r1)	;r3 As==11
    2004:	30 40 7e 1f 	br	#0x1f7e		;

00002008 <.L59>:
    2008:	81 43 08 00 	mov	#0,	8(r1)	;r3 As==00

0000200c <.Loc.594.1>:
    200c:	0a 4c       	mov	r12,	r10	;

0000200e <.Loc.605.1>:
    200e:	4c 43       	clr.b	r12		;

00002010 <.LVL80>:
    2010:	0f 4c       	mov	r12,	r15	;
    2012:	5e 43       	mov.b	#1,	r14	;r3 As==01

00002014 <.L61>:
    2014:	6d 4a       	mov.b	@r10,	r13	;
    2016:	3d 50 d0 ff 	add	#65488,	r13	;#0xffd0
    201a:	77 40 09 00 	mov.b	#9,	r7	;
    201e:	07 9d       	cmp	r13,	r7	;
    2020:	06 2c       	jc	$+14     	;abs 0x202e
    2022:	0c 93       	cmp	#0,	r12	;r3 As==00
    2024:	ac 27       	jz	$-166    	;abs 0x1f7e
    2026:	81 4f 08 00 	mov	r15,	8(r1)	;
    202a:	30 40 7e 1f 	br	#0x1f7e		;

0000202e <.L62>:
    202e:	0c 4f       	mov	r15,	r12	;
    2030:	0c 5f       	add	r15,	r12	;
    2032:	0c 5c       	rla	r12		;
    2034:	0c 5f       	add	r15,	r12	;
    2036:	0c 5c       	rla	r12		;
    2038:	0f 4c       	mov	r12,	r15	;
    203a:	0f 5d       	add	r13,	r15	;

0000203c <.Loc.605.1>:
    203c:	1a 53       	inc	r10		;
    203e:	0c 4e       	mov	r14,	r12	;
    2040:	30 40 14 20 	br	#0x2014		;

00002044 <.L66>:
    2044:	6c 42       	mov.b	#4,	r12	;r2 As==10

00002046 <.LVL83>:
    2046:	0c 51       	add	r1,	r12	;
    2048:	81 4c 00 00 	mov	r12,	0(r1)	;
    204c:	0f 45       	mov	r5,	r15	;
    204e:	0e 49       	mov	r9,	r14	;
    2050:	0d 41       	mov	r1,	r13	;
    2052:	3d 50 06 00 	add	#6,	r13	;
    2056:	0c 48       	mov	r8,	r12	;
    2058:	8a 12       	call	r10		;

0000205a <.L101>:
    205a:	06 4c       	mov	r12,	r6	;

0000205c <.Loc.643.1>:
    205c:	3c 93       	cmp	#-1,	r12	;r3 As==11
    205e:	b8 23       	jnz	$-142    	;abs 0x1fd0

00002060 <.L46>:
    2060:	f9 b0 40 00 	bit.b	#64,	6(r9)	;#0x0040
    2064:	06 00 
    2066:	50 23       	jnz	$-350    	;abs 0x1f08

00002068 <.Loc.654.1>:
    2068:	1c 41 10 00 	mov	16(r1),	r12	;0x00010
    206c:	30 40 0a 1f 	br	#0x1f0a		;

00002070 <.L65>:
    2070:	6d 42       	mov.b	#4,	r13	;r2 As==10
    2072:	0d 51       	add	r1,	r13	;
    2074:	81 4d 00 00 	mov	r13,	0(r1)	;
    2078:	0f 45       	mov	r5,	r15	;
    207a:	0e 49       	mov	r9,	r14	;
    207c:	0d 41       	mov	r1,	r13	;
    207e:	3d 50 06 00 	add	#6,	r13	;
    2082:	0c 48       	mov	r8,	r12	;

00002084 <.LVL88>:
    2084:	b0 12 96 29 	call	#10646		;#0x2996

00002088 <.LVL89>:
    2088:	30 40 5a 20 	br	#0x205a		;

0000208c <_sbrk_r>:
    208c:	0a 12       	push	r10		;

0000208e <.LCFI0>:
    208e:	0a 4c       	mov	r12,	r10	;

00002090 <.Loc.57.1>:
    2090:	82 43 24 81 	mov	#0,	&0x8124	;r3 As==00

00002094 <.Loc.58.1>:
    2094:	0c 4d       	mov	r13,	r12	;

00002096 <.LVL1>:
    2096:	b0 12 ec 2f 	call	#12268		;#0x2fec

0000209a <.LVL2>:
    209a:	3c 93       	cmp	#-1,	r12	;r3 As==11
    209c:	06 20       	jnz	$+14     	;abs 0x20aa

0000209e <.Loc.58.1>:
    209e:	1d 42 24 81 	mov	&0x8124,r13	;0x8124
    20a2:	0d 93       	cmp	#0,	r13	;r3 As==00
    20a4:	02 24       	jz	$+6      	;abs 0x20aa

000020a6 <.Loc.59.1>:
    20a6:	8a 4d 00 00 	mov	r13,	0(r10)	;

000020aa <.L2>:
    20aa:	3a 41       	pop	r10		;

000020ac <.LVL3>:
    20ac:	30 41       	ret			

000020ae <__sread>:
    20ae:	0a 12       	push	r10		;

000020b0 <.LCFI0>:
    20b0:	09 12       	push	r9		;

000020b2 <.LCFI1>:
    20b2:	08 12       	push	r8		;

000020b4 <.LCFI2>:
    20b4:	0a 4d       	mov	r13,	r10	;

000020b6 <.LVL1>:
    20b6:	1d 4d 08 00 	mov	8(r13),	r13	;

000020ba <.LVL2>:
    20ba:	b0 12 52 2d 	call	#11602		;#0x2d52

000020be <.LVL3>:
    20be:	0c 93       	cmp	#0,	r12	;r3 As==00
    20c0:	11 38       	jl	$+36     	;abs 0x20e4

000020c2 <.Loc.58.1>:
    20c2:	0e 4c       	mov	r12,	r14	;
    20c4:	3e b0 00 80 	bit	#32768,	r14	;#0x8000
    20c8:	0f 7f       	subc	r15,	r15	;
    20ca:	3f e3       	inv	r15		;
    20cc:	08 4e       	mov	r14,	r8	;
    20ce:	09 4f       	mov	r15,	r9	;
    20d0:	18 5a 2e 00 	add	46(r10),r8	;0x0002e
    20d4:	19 6a 30 00 	addc	48(r10),r9	;0x00030
    20d8:	8a 48 2e 00 	mov	r8,	46(r10)	; 0x002e
    20dc:	8a 49 30 00 	mov	r9,	48(r10)	; 0x0030

000020e0 <.L1>:
    20e0:	30 40 ae 12 	br	#0x12ae		;

000020e4 <.L2>:
    20e4:	ba f0 ff ef 	and	#61439,	6(r10)	;#0xefff
    20e8:	06 00 

000020ea <.Loc.61.1>:
    20ea:	30 40 e0 20 	br	#0x20e0		;

000020ee <__swrite>:
    20ee:	0a 12       	push	r10		;

000020f0 <.LCFI3>:
    20f0:	09 12       	push	r9		;

000020f2 <.LCFI4>:
    20f2:	08 12       	push	r8		;

000020f4 <.LCFI5>:
    20f4:	07 12       	push	r7		;

000020f6 <.LCFI6>:
    20f6:	21 83       	decd	r1		;

000020f8 <.LCFI7>:
    20f8:	09 4c       	mov	r12,	r9	;
    20fa:	0a 4d       	mov	r13,	r10	;
    20fc:	08 4e       	mov	r14,	r8	;
    20fe:	07 4f       	mov	r15,	r7	;

00002100 <.LVL7>:
    2100:	dd b3 07 00 	bit.b	#1,	7(r13)	;r3 As==01
    2104:	08 24       	jz	$+18     	;abs 0x2116

00002106 <.Loc.89.1>:
    2106:	1d 4d 08 00 	mov	8(r13),	r13	;

0000210a <.LVL8>:
    210a:	a1 43 00 00 	mov	#2,	0(r1)	;r3 As==10
    210e:	4e 43       	clr.b	r14		;

00002110 <.LVL9>:
    2110:	4f 43       	clr.b	r15		;

00002112 <.LVL10>:
    2112:	b0 12 44 27 	call	#10052		;#0x2744

00002116 <.L6>:
    2116:	ba f0 ff ef 	and	#61439,	6(r10)	;#0xefff
    211a:	06 00 

0000211c <.Loc.97.1>:
    211c:	0f 47       	mov	r7,	r15	;
    211e:	0e 48       	mov	r8,	r14	;
    2120:	1d 4a 08 00 	mov	8(r10),	r13	;
    2124:	0c 49       	mov	r9,	r12	;
    2126:	b0 12 4c 22 	call	#8780		;#0x224c

0000212a <.LVL12>:
    212a:	21 53       	incd	r1		;
    212c:	30 40 ac 12 	br	#0x12ac		;

00002130 <__sseek>:
    2130:	0a 12       	push	r10		;

00002132 <.LCFI8>:
    2132:	21 83       	decd	r1		;

00002134 <.LCFI9>:
    2134:	0a 4d       	mov	r13,	r10	;

00002136 <.LVL14>:
    2136:	1d 4d 08 00 	mov	8(r13),	r13	;

0000213a <.LVL15>:
    213a:	91 41 06 00 	mov	6(r1),	0(r1)	;
    213e:	00 00 
    2140:	b0 12 44 27 	call	#10052		;#0x2744

00002144 <.LVL16>:
    2144:	3c 93       	cmp	#-1,	r12	;r3 As==11
    2146:	08 20       	jnz	$+18     	;abs 0x2158
    2148:	3d 93       	cmp	#-1,	r13	;r3 As==11
    214a:	06 20       	jnz	$+14     	;abs 0x2158

0000214c <.Loc.119.1>:
    214c:	ba f0 ff ef 	and	#61439,	6(r10)	;#0xefff
    2150:	06 00 

00002152 <.L10>:
    2152:	21 53       	incd	r1		;
    2154:	3a 41       	pop	r10		;

00002156 <.LVL17>:
    2156:	30 41       	ret			

00002158 <.L11>:
    2158:	ba d0 00 10 	bis	#4096,	6(r10)	;#0x1000
    215c:	06 00 

0000215e <.Loc.123.1>:
    215e:	8a 4c 2e 00 	mov	r12,	46(r10)	; 0x002e
    2162:	8a 4d 30 00 	mov	r13,	48(r10)	; 0x0030

00002166 <.Loc.125.1>:
    2166:	30 40 52 21 	br	#0x2152		;

0000216a <__sclose>:
    216a:	1d 4d 08 00 	mov	8(r13),	r13	;

0000216e <.LVL21>:
    216e:	b0 12 74 23 	call	#9076		;#0x2374

00002172 <.LVL22>:
    2172:	30 41       	ret			

00002174 <__swbuf_r>:
    2174:	0a 12       	push	r10		;

00002176 <.LCFI0>:
    2176:	09 12       	push	r9		;

00002178 <.LCFI1>:
    2178:	08 12       	push	r8		;

0000217a <.LCFI2>:
    217a:	07 12       	push	r7		;

0000217c <.LCFI3>:
    217c:	09 4c       	mov	r12,	r9	;
    217e:	08 4d       	mov	r13,	r8	;
    2180:	0a 4e       	mov	r14,	r10	;

00002182 <.LBB2>:
    2182:	0c 93       	cmp	#0,	r12	;r3 As==00
    2184:	05 24       	jz	$+12     	;abs 0x2190

00002186 <.Loc.45.1>:
    2186:	8c 93 0c 00 	cmp	#0,	12(r12)	;r3 As==00, 0x000c
    218a:	02 20       	jnz	$+6      	;abs 0x2190

0000218c <.Loc.45.1>:
    218c:	b0 12 b0 15 	call	#5552		;#0x15b0

00002190 <.L2>:
    2190:	3a 90 58 37 	cmp	#14168,	r10	;#0x3758
    2194:	3a 20       	jnz	$+118    	;abs 0x220a

00002196 <.Loc.45.1>:
    2196:	1a 49 02 00 	mov	2(r9),	r10	;

0000219a <.L4>:
    219a:	9a 4a 0e 00 	mov	14(r10),4(r10)	;0x0000e
    219e:	04 00 

000021a0 <.Loc.56.1>:
    21a0:	fa b2 06 00 	bit.b	#8,	6(r10)	;r2 As==11
    21a4:	40 24       	jz	$+130    	;abs 0x2226

000021a6 <.Loc.56.1>:
    21a6:	8a 93 0a 00 	cmp	#0,	10(r10)	;r3 As==00, 0x000a
    21aa:	3d 24       	jz	$+124    	;abs 0x2226

000021ac <.L9>:
    21ac:	47 48       	mov.b	r8,	r7	;
    21ae:	78 f0 ff 00 	and.b	#255,	r8	;#0x00ff

000021b2 <.Loc.60.1>:
    21b2:	1c 4a 06 00 	mov	6(r10),	r12	;
    21b6:	3c b0 00 20 	bit	#8192,	r12	;#0x2000
    21ba:	3f 24       	jz	$+128    	;abs 0x223a

000021bc <.L8>:
    21bc:	2c 4a       	mov	@r10,	r12	;
    21be:	1c 8a 0a 00 	sub	10(r10),r12	;0x0000a

000021c2 <.LVL5>:
    21c2:	1c 9a 0c 00 	cmp	12(r10),r12	;0x0000c
    21c6:	06 38       	jl	$+14     	;abs 0x21d4

000021c8 <.Loc.75.1>:
    21c8:	0d 4a       	mov	r10,	r13	;
    21ca:	0c 49       	mov	r9,	r12	;

000021cc <.LVL6>:
    21cc:	b0 12 f0 25 	call	#9712		;#0x25f0

000021d0 <.LVL7>:
    21d0:	0c 93       	cmp	#0,	r12	;r3 As==00
    21d2:	2f 20       	jnz	$+96     	;abs 0x2232

000021d4 <.L11>:
    21d4:	ba 53 04 00 	add	#-1,	4(r10)	;r3 As==11

000021d8 <.Loc.80.1>:
    21d8:	2d 4a       	mov	@r10,	r13	;
    21da:	0e 4d       	mov	r13,	r14	;
    21dc:	1e 53       	inc	r14		;
    21de:	8a 4e 00 00 	mov	r14,	0(r10)	;
    21e2:	cd 47 00 00 	mov.b	r7,	0(r13)	;

000021e6 <.LVL9>:
    21e6:	1c 53       	inc	r12		;

000021e8 <.LVL10>:
    21e8:	1c 9a 0c 00 	cmp	12(r10),r12	;0x0000c
    21ec:	06 24       	jz	$+14     	;abs 0x21fa

000021ee <.Loc.81.1>:
    21ee:	da b3 06 00 	bit.b	#1,	6(r10)	;r3 As==01
    21f2:	20 24       	jz	$+66     	;abs 0x2234

000021f4 <.Loc.81.1>:
    21f4:	38 90 0a 00 	cmp	#10,	r8	;#0x000a
    21f8:	1d 20       	jnz	$+60     	;abs 0x2234

000021fa <.L13>:
    21fa:	0d 4a       	mov	r10,	r13	;
    21fc:	0c 49       	mov	r9,	r12	;

000021fe <.LVL11>:
    21fe:	b0 12 f0 25 	call	#9712		;#0x25f0

00002202 <.LVL12>:
    2202:	0c 93       	cmp	#0,	r12	;r3 As==00
    2204:	17 24       	jz	$+48     	;abs 0x2234
    2206:	30 40 32 22 	br	#0x2232		;

0000220a <.L3>:
    220a:	3a 90 46 37 	cmp	#14150,	r10	;#0x3746
    220e:	04 20       	jnz	$+10     	;abs 0x2218

00002210 <.Loc.45.1>:
    2210:	1a 49 04 00 	mov	4(r9),	r10	;
    2214:	30 40 9a 21 	br	#0x219a		;

00002218 <.L5>:
    2218:	3a 90 34 37 	cmp	#14132,	r10	;#0x3734
    221c:	be 23       	jnz	$-130    	;abs 0x219a

0000221e <.Loc.45.1>:
    221e:	1a 49 06 00 	mov	6(r9),	r10	;
    2222:	30 40 9a 21 	br	#0x219a		;

00002226 <.L6>:
    2226:	0d 4a       	mov	r10,	r13	;
    2228:	0c 49       	mov	r9,	r12	;
    222a:	b0 12 72 22 	call	#8818		;#0x2272

0000222e <.LVL15>:
    222e:	0c 93       	cmp	#0,	r12	;r3 As==00
    2230:	bd 27       	jz	$-132    	;abs 0x21ac

00002232 <.L12>:
    2232:	38 43       	mov	#-1,	r8	;r3 As==11

00002234 <.L1>:
    2234:	0c 48       	mov	r8,	r12	;
    2236:	30 40 ac 12 	br	#0x12ac		;

0000223a <.L7>:
    223a:	3c d0 00 20 	bis	#8192,	r12	;#0x2000
    223e:	8a 4c 06 00 	mov	r12,	6(r10)	;
    2242:	ba f0 ff df 	and	#57343,	58(r10)	;#0xdfff, 0x003a
    2246:	3a 00 
    2248:	30 40 bc 21 	br	#0x21bc		;

0000224c <_write_r>:
    224c:	0a 12       	push	r10		;

0000224e <.LCFI0>:
    224e:	0a 4c       	mov	r12,	r10	;
    2250:	0c 4d       	mov	r13,	r12	;

00002252 <.LVL1>:
    2252:	0d 4e       	mov	r14,	r13	;

00002254 <.LVL2>:
    2254:	82 43 24 81 	mov	#0,	&0x8124	;r3 As==00

00002258 <.Loc.58.1>:
    2258:	0e 4f       	mov	r15,	r14	;

0000225a <.LVL3>:
    225a:	b0 12 54 2f 	call	#12116		;#0x2f54

0000225e <.LVL4>:
    225e:	3c 93       	cmp	#-1,	r12	;r3 As==11
    2260:	06 20       	jnz	$+14     	;abs 0x226e

00002262 <.Loc.58.1>:
    2262:	1d 42 24 81 	mov	&0x8124,r13	;0x8124
    2266:	0d 93       	cmp	#0,	r13	;r3 As==00
    2268:	02 24       	jz	$+6      	;abs 0x226e

0000226a <.Loc.59.1>:
    226a:	8a 4d 00 00 	mov	r13,	0(r10)	;

0000226e <.L1>:
    226e:	3a 41       	pop	r10		;

00002270 <.LVL5>:
    2270:	30 41       	ret			

00002272 <__swsetup_r>:
    2272:	0a 12       	push	r10		;

00002274 <.LCFI0>:
    2274:	09 12       	push	r9		;

00002276 <.LCFI1>:
    2276:	08 12       	push	r8		;

00002278 <.LCFI2>:
    2278:	08 4c       	mov	r12,	r8	;
    227a:	0a 4d       	mov	r13,	r10	;

0000227c <.LBB2>:
    227c:	19 42 08 80 	mov	&0x8008,r9	;0x8008
    2280:	09 93       	cmp	#0,	r9	;r3 As==00
    2282:	06 24       	jz	$+14     	;abs 0x2290

00002284 <.Loc.39.1>:
    2284:	89 93 0c 00 	cmp	#0,	12(r9)	;r3 As==00, 0x000c
    2288:	03 20       	jnz	$+8      	;abs 0x2290

0000228a <.Loc.39.1>:
    228a:	0c 49       	mov	r9,	r12	;

0000228c <.LVL2>:
    228c:	b0 12 b0 15 	call	#5552		;#0x15b0

00002290 <.L2>:
    2290:	3a 90 58 37 	cmp	#14168,	r10	;#0x3758
    2294:	13 20       	jnz	$+40     	;abs 0x22bc

00002296 <.Loc.39.1>:
    2296:	1a 49 02 00 	mov	2(r9),	r10	;

0000229a <.L4>:
    229a:	1c 4a 06 00 	mov	6(r10),	r12	;
    229e:	3c b2       	bit	#8,	r12	;r2 As==11
    22a0:	35 20       	jnz	$+108    	;abs 0x230c

000022a2 <.Loc.47.1>:
    22a2:	3c b0 10 00 	bit	#16,	r12	;#0x0010
    22a6:	18 20       	jnz	$+50     	;abs 0x22d8

000022a8 <.Loc.49.1>:
    22a8:	b8 40 09 00 	mov	#9,	0(r8)	;
    22ac:	00 00 

000022ae <.Loc.50.1>:
    22ae:	3c d0 40 00 	bis	#64,	r12	;#0x0040
    22b2:	8a 4c 06 00 	mov	r12,	6(r10)	;

000022b6 <.L32>:
    22b6:	3c 43       	mov	#-1,	r12	;r3 As==11

000022b8 <.L1>:
    22b8:	30 40 ae 12 	br	#0x12ae		;

000022bc <.L3>:
    22bc:	3a 90 46 37 	cmp	#14150,	r10	;#0x3746
    22c0:	04 20       	jnz	$+10     	;abs 0x22ca

000022c2 <.Loc.39.1>:
    22c2:	1a 49 04 00 	mov	4(r9),	r10	;
    22c6:	30 40 9a 22 	br	#0x229a		;

000022ca <.L5>:
    22ca:	3a 90 34 37 	cmp	#14132,	r10	;#0x3734
    22ce:	e5 23       	jnz	$-52     	;abs 0x229a

000022d0 <.Loc.39.1>:
    22d0:	1a 49 06 00 	mov	6(r9),	r10	;
    22d4:	30 40 9a 22 	br	#0x229a		;

000022d8 <.L7>:
    22d8:	2c b2       	bit	#4,	r12	;r2 As==10
    22da:	16 24       	jz	$+46     	;abs 0x2308

000022dc <.Loc.56.1>:
    22dc:	1d 4a 1c 00 	mov	28(r10),r13	;0x0001c
    22e0:	0d 93       	cmp	#0,	r13	;r3 As==00
    22e2:	0a 24       	jz	$+22     	;abs 0x22f8

000022e4 <.Loc.57.1>:
    22e4:	0c 4a       	mov	r10,	r12	;
    22e6:	3c 50 24 00 	add	#36,	r12	;#0x0024
    22ea:	0d 9c       	cmp	r12,	r13	;
    22ec:	03 24       	jz	$+8      	;abs 0x22f4

000022ee <.Loc.57.1>:
    22ee:	0c 48       	mov	r8,	r12	;
    22f0:	b0 12 ec 1a 	call	#6892		;#0x1aec

000022f4 <.L11>:
    22f4:	8a 43 1c 00 	mov	#0,	28(r10)	;r3 As==00, 0x001c

000022f8 <.L10>:
    22f8:	ba f0 db ff 	and	#65499,	6(r10)	;#0xffdb
    22fc:	06 00 

000022fe <.Loc.59.1>:
    22fe:	8a 43 02 00 	mov	#0,	2(r10)	;r3 As==00

00002302 <.Loc.60.1>:
    2302:	9a 4a 0a 00 	mov	10(r10),0(r10)	;0x0000a
    2306:	00 00 

00002308 <.L9>:
    2308:	ba d2 06 00 	bis	#8,	6(r10)	;r2 As==11

0000230c <.L6>:
    230c:	8a 93 0a 00 	cmp	#0,	10(r10)	;r3 As==00, 0x000a
    2310:	0b 20       	jnz	$+24     	;abs 0x2328

00002312 <.Loc.71.1>:
    2312:	1c 4a 06 00 	mov	6(r10),	r12	;
    2316:	3c f0 80 02 	and	#640,	r12	;#0x0280
    231a:	3c 90 00 02 	cmp	#512,	r12	;#0x0200
    231e:	04 24       	jz	$+10     	;abs 0x2328

00002320 <.Loc.72.1>:
    2320:	0d 4a       	mov	r10,	r13	;
    2322:	0c 48       	mov	r8,	r12	;
    2324:	b0 12 e2 27 	call	#10210		;#0x27e2

00002328 <.L12>:
    2328:	1d 4a 06 00 	mov	6(r10),	r13	;
    232c:	0c 4d       	mov	r13,	r12	;
    232e:	5c f3       	and.b	#1,	r12	;r3 As==01
    2330:	0c 93       	cmp	#0,	r12	;r3 As==00
    2332:	15 24       	jz	$+44     	;abs 0x235e

00002334 <.Loc.81.1>:
    2334:	8a 43 04 00 	mov	#0,	4(r10)	;r3 As==00

00002338 <.Loc.82.1>:
    2338:	4c 43       	clr.b	r12		;
    233a:	1c 8a 0c 00 	sub	12(r10),r12	;0x0000c
    233e:	8a 4c 0e 00 	mov	r12,	14(r10)	; 0x000e

00002342 <.L14>:
    2342:	8a 93 0a 00 	cmp	#0,	10(r10)	;r3 As==00, 0x000a
    2346:	13 20       	jnz	$+40     	;abs 0x236e

00002348 <.Loc.87.1>:
    2348:	0c 4d       	mov	r13,	r12	;
    234a:	7c f0 80 00 	and.b	#128,	r12	;#0x0080
    234e:	0c 93       	cmp	#0,	r12	;r3 As==00
    2350:	b3 27       	jz	$-152    	;abs 0x22b8

00002352 <.Loc.90.1>:
    2352:	3d d0 40 00 	bis	#64,	r13	;#0x0040
    2356:	8a 4d 06 00 	mov	r13,	6(r10)	;
    235a:	30 40 b6 22 	br	#0x22b6		;

0000235e <.L13>:
    235e:	2d b3       	bit	#2,	r13	;r3 As==10
    2360:	02 20       	jnz	$+6      	;abs 0x2366

00002362 <.Loc.85.1>:
    2362:	1c 4a 0c 00 	mov	12(r10),r12	;0x0000c

00002366 <.L15>:
    2366:	8a 4c 04 00 	mov	r12,	4(r10)	;
    236a:	30 40 42 23 	br	#0x2342		;

0000236e <.L16>:
    236e:	4c 43       	clr.b	r12		;
    2370:	30 40 b8 22 	br	#0x22b8		;

00002374 <_close_r>:
    2374:	0a 12       	push	r10		;

00002376 <.LCFI0>:
    2376:	0a 4c       	mov	r12,	r10	;

00002378 <.Loc.52.1>:
    2378:	82 43 24 81 	mov	#0,	&0x8124	;r3 As==00

0000237c <.Loc.53.1>:
    237c:	0c 4d       	mov	r13,	r12	;

0000237e <.LVL1>:
    237e:	b0 12 0e 2f 	call	#12046		;#0x2f0e

00002382 <.LVL2>:
    2382:	3c 93       	cmp	#-1,	r12	;r3 As==11
    2384:	06 20       	jnz	$+14     	;abs 0x2392

00002386 <.Loc.53.1>:
    2386:	1d 42 24 81 	mov	&0x8124,r13	;0x8124
    238a:	0d 93       	cmp	#0,	r13	;r3 As==00
    238c:	02 24       	jz	$+6      	;abs 0x2392

0000238e <.Loc.54.1>:
    238e:	8a 4d 00 00 	mov	r13,	0(r10)	;

00002392 <.L1>:
    2392:	3a 41       	pop	r10		;

00002394 <.LVL3>:
    2394:	30 41       	ret			

00002396 <_fclose_r>:
    2396:	0a 12       	push	r10		;

00002398 <.LCFI0>:
    2398:	09 12       	push	r9		;

0000239a <.LCFI1>:
    239a:	08 12       	push	r8		;

0000239c <.LCFI2>:
    239c:	09 4c       	mov	r12,	r9	;
    239e:	0a 4d       	mov	r13,	r10	;

000023a0 <.Loc.74.1>:
    23a0:	0d 93       	cmp	#0,	r13	;r3 As==00
    23a2:	04 20       	jnz	$+10     	;abs 0x23ac

000023a4 <.L8>:
    23a4:	48 43       	clr.b	r8		;

000023a6 <.L1>:
    23a6:	0c 48       	mov	r8,	r12	;
    23a8:	30 40 ae 12 	br	#0x12ae		;

000023ac <.L2>:
    23ac:	0c 93       	cmp	#0,	r12	;r3 As==00
    23ae:	05 24       	jz	$+12     	;abs 0x23ba

000023b0 <.Loc.77.1>:
    23b0:	8c 93 0c 00 	cmp	#0,	12(r12)	;r3 As==00, 0x000c
    23b4:	02 20       	jnz	$+6      	;abs 0x23ba

000023b6 <.Loc.77.1>:
    23b6:	b0 12 b0 15 	call	#5552		;#0x15b0

000023ba <.L4>:
    23ba:	3a 90 58 37 	cmp	#14168,	r10	;#0x3758
    23be:	3f 20       	jnz	$+128    	;abs 0x243e

000023c0 <.Loc.77.1>:
    23c0:	1a 49 02 00 	mov	2(r9),	r10	;

000023c4 <.L6>:
    23c4:	8a 93 06 00 	cmp	#0,	6(r10)	;r3 As==00
    23c8:	ed 27       	jz	$-36     	;abs 0x23a4

000023ca <.Loc.104.1>:
    23ca:	0d 4a       	mov	r10,	r13	;
    23cc:	0c 49       	mov	r9,	r12	;
    23ce:	b0 12 5a 24 	call	#9306		;#0x245a

000023d2 <.LVL5>:
    23d2:	08 4c       	mov	r12,	r8	;

000023d4 <.LVL6>:
    23d4:	1e 4a 1a 00 	mov	26(r10),r14	;0x0001a
    23d8:	0e 93       	cmp	#0,	r14	;r3 As==00
    23da:	07 24       	jz	$+16     	;abs 0x23ea

000023dc <.Loc.106.1>:
    23dc:	1d 4a 12 00 	mov	18(r10),r13	;0x00012
    23e0:	0c 49       	mov	r9,	r12	;
    23e2:	8e 12       	call	r14		;

000023e4 <.LVL7>:
    23e4:	0c 93       	cmp	#0,	r12	;r3 As==00
    23e6:	01 34       	jge	$+4      	;abs 0x23ea

000023e8 <.Loc.107.1>:
    23e8:	38 43       	mov	#-1,	r8	;r3 As==11

000023ea <.L9>:
    23ea:	1c 4a 06 00 	mov	6(r10),	r12	;
    23ee:	7c f0 80 00 	and.b	#128,	r12	;#0x0080
    23f2:	0c 93       	cmp	#0,	r12	;r3 As==00
    23f4:	05 24       	jz	$+12     	;abs 0x2400

000023f6 <.Loc.109.1>:
    23f6:	1d 4a 0a 00 	mov	10(r10),r13	;0x0000a
    23fa:	0c 49       	mov	r9,	r12	;
    23fc:	b0 12 ec 1a 	call	#6892		;#0x1aec

00002400 <.L10>:
    2400:	1d 4a 1c 00 	mov	28(r10),r13	;0x0001c
    2404:	0d 93       	cmp	#0,	r13	;r3 As==00
    2406:	0a 24       	jz	$+22     	;abs 0x241c

00002408 <.Loc.111.1>:
    2408:	0c 4a       	mov	r10,	r12	;
    240a:	3c 50 24 00 	add	#36,	r12	;#0x0024
    240e:	0d 9c       	cmp	r12,	r13	;
    2410:	03 24       	jz	$+8      	;abs 0x2418

00002412 <.Loc.111.1>:
    2412:	0c 49       	mov	r9,	r12	;
    2414:	b0 12 ec 1a 	call	#6892		;#0x1aec

00002418 <.L12>:
    2418:	8a 43 1c 00 	mov	#0,	28(r10)	;r3 As==00, 0x001c

0000241c <.L11>:
    241c:	1d 4a 28 00 	mov	40(r10),r13	;0x00028
    2420:	0d 93       	cmp	#0,	r13	;r3 As==00
    2422:	05 24       	jz	$+12     	;abs 0x242e

00002424 <.Loc.113.1>:
    2424:	0c 49       	mov	r9,	r12	;
    2426:	b0 12 ec 1a 	call	#6892		;#0x1aec

0000242a <.LVL11>:
    242a:	8a 43 28 00 	mov	#0,	40(r10)	;r3 As==00, 0x0028

0000242e <.L13>:
    242e:	b0 12 da 16 	call	#5850		;#0x16da

00002432 <.LVL12>:
    2432:	8a 43 06 00 	mov	#0,	6(r10)	;r3 As==00

00002436 <.Loc.122.1>:
    2436:	b0 12 dc 16 	call	#5852		;#0x16dc

0000243a <.LVL13>:
    243a:	30 40 a6 23 	br	#0x23a6		;

0000243e <.L5>:
    243e:	3a 90 46 37 	cmp	#14150,	r10	;#0x3746
    2442:	04 20       	jnz	$+10     	;abs 0x244c

00002444 <.Loc.77.1>:
    2444:	1a 49 04 00 	mov	4(r9),	r10	;
    2448:	30 40 c4 23 	br	#0x23c4		;

0000244c <.L7>:
    244c:	3a 90 34 37 	cmp	#14132,	r10	;#0x3734
    2450:	b9 23       	jnz	$-140    	;abs 0x23c4

00002452 <.Loc.77.1>:
    2452:	1a 49 06 00 	mov	6(r9),	r10	;
    2456:	30 40 c4 23 	br	#0x23c4		;

0000245a <__sflush_r>:
    245a:	0a 12       	push	r10		;

0000245c <.LCFI0>:
    245c:	09 12       	push	r9		;

0000245e <.LCFI1>:
    245e:	08 12       	push	r8		;

00002460 <.LCFI2>:
    2460:	07 12       	push	r7		;

00002462 <.LCFI3>:
    2462:	06 12       	push	r6		;

00002464 <.LCFI4>:
    2464:	21 83       	decd	r1		;

00002466 <.LCFI5>:
    2466:	09 4c       	mov	r12,	r9	;
    2468:	0a 4d       	mov	r13,	r10	;

0000246a <.Loc.112.1>:
    246a:	1c 4d 06 00 	mov	6(r13),	r12	;

0000246e <.LVL1>:
    246e:	08 4c       	mov	r12,	r8	;
    2470:	78 f2       	and.b	#8,	r8	;r2 As==11
    2472:	08 93       	cmp	#0,	r8	;r3 As==00
    2474:	93 20       	jnz	$+296    	;abs 0x259c

00002476 <.Loc.119.1>:
    2476:	06 4c       	mov	r12,	r6	;
    2478:	36 d0 00 08 	bis	#2048,	r6	;#0x0800
    247c:	8d 46 06 00 	mov	r6,	6(r13)	;

00002480 <.Loc.129.1>:
    2480:	4d 43       	clr.b	r13		;

00002482 <.LVL2>:
    2482:	1d 9a 02 00 	cmp	2(r10),	r13	;
    2486:	08 38       	jl	$+18     	;abs 0x2498

00002488 <.Loc.129.1>:
    2488:	1d 9a 22 00 	cmp	34(r10),r13	;0x00022
    248c:	05 38       	jl	$+12     	;abs 0x2498

0000248e <.L5>:
    248e:	48 43       	clr.b	r8		;

00002490 <.L1>:
    2490:	0c 48       	mov	r8,	r12	;
    2492:	21 53       	incd	r1		;
    2494:	30 40 aa 12 	br	#0x12aa		;

00002498 <.L3>:
    2498:	1b 4a 18 00 	mov	24(r10),r11	;0x00018
    249c:	0b 93       	cmp	#0,	r11	;r3 As==00
    249e:	f7 27       	jz	$-16     	;abs 0x248e

000024a0 <.LBB2>:
    24a0:	27 49       	mov	@r9,	r7	;

000024a2 <.LVL5>:
    24a2:	89 43 00 00 	mov	#0,	0(r9)	;r3 As==00

000024a6 <.Loc.144.1>:
    24a6:	3c b0 00 10 	bit	#4096,	r12	;#0x1000
    24aa:	5f 24       	jz	$+192    	;abs 0x256a

000024ac <.Loc.145.1>:
    24ac:	1c 4a 2e 00 	mov	46(r10),r12	;0x0002e

000024b0 <.LVL6>:
    24b0:	1d 4a 30 00 	mov	48(r10),r13	;0x00030

000024b4 <.L7>:
    24b4:	ea b2 06 00 	bit.b	#4,	6(r10)	;r2 As==10
    24b8:	15 24       	jz	$+44     	;abs 0x24e4

000024ba <.Loc.173.1>:
    24ba:	16 4a 02 00 	mov	2(r10),	r6	;
    24be:	0e 46       	mov	r6,	r14	;
    24c0:	3e b0 00 80 	bit	#32768,	r14	;#0x8000
    24c4:	0f 7f       	subc	r15,	r15	;
    24c6:	3f e3       	inv	r15		;
    24c8:	0c 8e       	sub	r14,	r12	;
    24ca:	0d 7f       	subc	r15,	r13	;

000024cc <.Loc.174.1>:
    24cc:	8a 93 1c 00 	cmp	#0,	28(r10)	;r3 As==00, 0x001c
    24d0:	09 24       	jz	$+20     	;abs 0x24e4

000024d2 <.Loc.175.1>:
    24d2:	16 4a 22 00 	mov	34(r10),r6	;0x00022
    24d6:	0e 46       	mov	r6,	r14	;
    24d8:	3e b0 00 80 	bit	#32768,	r14	;#0x8000
    24dc:	0f 7f       	subc	r15,	r15	;
    24de:	3f e3       	inv	r15		;
    24e0:	0c 8e       	sub	r14,	r12	;
    24e2:	0d 7f       	subc	r15,	r13	;

000024e4 <.L10>:
    24e4:	81 43 00 00 	mov	#0,	0(r1)	;r3 As==00
    24e8:	0e 4c       	mov	r12,	r14	;
    24ea:	0f 4d       	mov	r13,	r15	;
    24ec:	1d 4a 12 00 	mov	18(r10),r13	;0x00012
    24f0:	0c 49       	mov	r9,	r12	;

000024f2 <.LVL10>:
    24f2:	16 4a 18 00 	mov	24(r10),r6	;0x00018
    24f6:	86 12       	call	r6		;

000024f8 <.LVL11>:
    24f8:	3c 93       	cmp	#-1,	r12	;r3 As==11
    24fa:	0b 20       	jnz	$+24     	;abs 0x2512
    24fc:	3d 93       	cmp	#-1,	r13	;r3 As==11
    24fe:	09 20       	jnz	$+20     	;abs 0x2512

00002500 <.Loc.184.1>:
    2500:	2e 49       	mov	@r9,	r14	;
    2502:	0e 93       	cmp	#0,	r14	;r3 As==00
    2504:	06 24       	jz	$+14     	;abs 0x2512

00002506 <.Loc.185.1>:
    2506:	3e 90 1d 00 	cmp	#29,	r14	;#0x001d
    250a:	03 24       	jz	$+8      	;abs 0x2512

0000250c <.Loc.185.1>:
    250c:	3e 90 16 00 	cmp	#22,	r14	;#0x0016
    2510:	62 20       	jnz	$+198    	;abs 0x25d6

00002512 <.L11>:
    2512:	1e 4a 06 00 	mov	6(r10),	r14	;
    2516:	0f 4e       	mov	r14,	r15	;
    2518:	3f f0 ff f7 	and	#63487,	r15	;#0xf7ff
    251c:	8a 4f 06 00 	mov	r15,	6(r10)	;

00002520 <.Loc.192.1>:
    2520:	8a 43 02 00 	mov	#0,	2(r10)	;r3 As==00

00002524 <.Loc.193.1>:
    2524:	9a 4a 0a 00 	mov	10(r10),0(r10)	;0x0000a
    2528:	00 00 

0000252a <.Loc.194.1>:
    252a:	3e b0 00 10 	bit	#4096,	r14	;#0x1000
    252e:	0b 24       	jz	$+24     	;abs 0x2546

00002530 <.Loc.194.1>:
    2530:	3c 93       	cmp	#-1,	r12	;r3 As==11
    2532:	05 20       	jnz	$+12     	;abs 0x253e
    2534:	3d 93       	cmp	#-1,	r13	;r3 As==11
    2536:	03 20       	jnz	$+8      	;abs 0x253e

00002538 <.Loc.194.1>:
    2538:	89 93 00 00 	cmp	#0,	0(r9)	;r3 As==00
    253c:	04 20       	jnz	$+10     	;abs 0x2546

0000253e <.L14>:
    253e:	8a 4c 2e 00 	mov	r12,	46(r10)	; 0x002e
    2542:	8a 4d 30 00 	mov	r13,	48(r10)	; 0x0030

00002546 <.L13>:
    2546:	89 47 00 00 	mov	r7,	0(r9)	;

0000254a <.Loc.197.1>:
    254a:	1d 4a 1c 00 	mov	28(r10),r13	;0x0001c

0000254e <.LVL12>:
    254e:	0d 93       	cmp	#0,	r13	;r3 As==00
    2550:	9e 27       	jz	$-194    	;abs 0x248e

00002552 <.Loc.198.1>:
    2552:	0c 4a       	mov	r10,	r12	;
    2554:	3c 50 24 00 	add	#36,	r12	;#0x0024
    2558:	0d 9c       	cmp	r12,	r13	;
    255a:	03 24       	jz	$+8      	;abs 0x2562

0000255c <.Loc.198.1>:
    255c:	0c 49       	mov	r9,	r12	;
    255e:	b0 12 ec 1a 	call	#6892		;#0x1aec

00002562 <.L15>:
    2562:	8a 43 1c 00 	mov	#0,	28(r10)	;r3 As==00, 0x001c
    2566:	30 40 90 24 	br	#0x2490		;

0000256a <.L6>:
    256a:	1d 4a 12 00 	mov	18(r10),r13	;0x00012
    256e:	91 43 00 00 	mov	#1,	0(r1)	;r3 As==01
    2572:	4e 43       	clr.b	r14		;
    2574:	4f 43       	clr.b	r15		;
    2576:	0c 49       	mov	r9,	r12	;

00002578 <.LVL15>:
    2578:	8b 12       	call	r11		;

0000257a <.LVL16>:
    257a:	3c 93       	cmp	#-1,	r12	;r3 As==11
    257c:	9b 23       	jnz	$-200    	;abs 0x24b4
    257e:	3d 93       	cmp	#-1,	r13	;r3 As==11
    2580:	99 23       	jnz	$-204    	;abs 0x24b4

00002582 <.Loc.156.1>:
    2582:	2e 49       	mov	@r9,	r14	;
    2584:	0e 93       	cmp	#0,	r14	;r3 As==00
    2586:	96 27       	jz	$-210    	;abs 0x24b4

00002588 <.LBB3>:
    2588:	3e 90 1d 00 	cmp	#29,	r14	;#0x001d
    258c:	03 24       	jz	$+8      	;abs 0x2594

0000258e <.Loc.159.1>:
    258e:	3e 90 16 00 	cmp	#22,	r14	;#0x0016
    2592:	21 20       	jnz	$+68     	;abs 0x25d6

00002594 <.L8>:
    2594:	89 47 00 00 	mov	r7,	0(r9)	;
    2598:	30 40 90 24 	br	#0x2490		;

0000259c <.L2>:
    259c:	18 4d 0a 00 	mov	10(r13),r8	;0x0000a

000025a0 <.LVL20>:
    25a0:	08 93       	cmp	#0,	r8	;r3 As==00
    25a2:	75 27       	jz	$-276    	;abs 0x248e

000025a4 <.Loc.213.1>:
    25a4:	27 4d       	mov	@r13,	r7	;
    25a6:	07 88       	sub	r8,	r7	;

000025a8 <.LVL21>:
    25a8:	8d 48 00 00 	mov	r8,	0(r13)	;

000025ac <.Loc.221.1>:
    25ac:	3c b0 03 00 	bit	#3,	r12	;
    25b0:	18 20       	jnz	$+50     	;abs 0x25e2

000025b2 <.Loc.221.1>:
    25b2:	1c 4d 0c 00 	mov	12(r13),r12	;0x0000c

000025b6 <.L16>:
    25b6:	8a 4c 04 00 	mov	r12,	4(r10)	;

000025ba <.L17>:
    25ba:	4f 43       	clr.b	r15		;
    25bc:	0f 97       	cmp	r7,	r15	;
    25be:	67 37       	jge	$-304    	;abs 0x248e

000025c0 <.Loc.225.1>:
    25c0:	0f 47       	mov	r7,	r15	;
    25c2:	0e 48       	mov	r8,	r14	;
    25c4:	1d 4a 12 00 	mov	18(r10),r13	;0x00012
    25c8:	0c 49       	mov	r9,	r12	;
    25ca:	16 4a 16 00 	mov	22(r10),r6	;0x00016
    25ce:	86 12       	call	r6		;

000025d0 <.LVL24>:
    25d0:	4d 43       	clr.b	r13		;
    25d2:	0d 9c       	cmp	r12,	r13	;
    25d4:	09 38       	jl	$+20     	;abs 0x25e8

000025d6 <.L48>:
    25d6:	ba d0 40 00 	bis	#64,	6(r10)	;#0x0040
    25da:	06 00 

000025dc <.Loc.229.1>:
    25dc:	38 43       	mov	#-1,	r8	;r3 As==11
    25de:	30 40 90 24 	br	#0x2490		;

000025e2 <.L20>:
    25e2:	4c 43       	clr.b	r12		;

000025e4 <.LVL27>:
    25e4:	30 40 b6 25 	br	#0x25b6		;

000025e8 <.L18>:
    25e8:	08 5c       	add	r12,	r8	;

000025ea <.Loc.232.1>:
    25ea:	07 8c       	sub	r12,	r7	;
    25ec:	30 40 ba 25 	br	#0x25ba		;

000025f0 <_fflush_r>:
    25f0:	0a 12       	push	r10		;

000025f2 <.LCFI6>:
    25f2:	21 83       	decd	r1		;

000025f4 <.LCFI7>:
    25f4:	0a 4c       	mov	r12,	r10	;

000025f6 <.Loc.271.1>:
    25f6:	8d 93 0a 00 	cmp	#0,	10(r13)	;r3 As==00, 0x000a
    25fa:	04 20       	jnz	$+10     	;abs 0x2604

000025fc <.L56>:
    25fc:	4c 43       	clr.b	r12		;

000025fe <.L49>:
    25fe:	21 53       	incd	r1		;
    2600:	3a 41       	pop	r10		;

00002602 <.LVL34>:
    2602:	30 41       	ret			

00002604 <.L50>:
    2604:	0c 93       	cmp	#0,	r12	;r3 As==00
    2606:	08 24       	jz	$+18     	;abs 0x2618

00002608 <.Loc.275.1>:
    2608:	8c 93 0c 00 	cmp	#0,	12(r12)	;r3 As==00, 0x000c
    260c:	05 20       	jnz	$+12     	;abs 0x2618

0000260e <.Loc.275.1>:
    260e:	81 4d 00 00 	mov	r13,	0(r1)	;
    2612:	b0 12 b0 15 	call	#5552		;#0x15b0

00002616 <.LVL36>:
    2616:	2d 41       	mov	@r1,	r13	;

00002618 <.L52>:
    2618:	3d 90 58 37 	cmp	#14168,	r13	;#0x3758
    261c:	0a 20       	jnz	$+22     	;abs 0x2632

0000261e <.Loc.275.1>:
    261e:	1d 4a 02 00 	mov	2(r10),	r13	;

00002622 <.L54>:
    2622:	8d 93 06 00 	cmp	#0,	6(r13)	;r3 As==00
    2626:	ea 27       	jz	$-42     	;abs 0x25fc

00002628 <.Loc.281.1>:
    2628:	0c 4a       	mov	r10,	r12	;
    262a:	b0 12 5a 24 	call	#9306		;#0x245a

0000262e <.LVL38>:
    262e:	30 40 fe 25 	br	#0x25fe		;

00002632 <.L53>:
    2632:	3d 90 46 37 	cmp	#14150,	r13	;#0x3746
    2636:	04 20       	jnz	$+10     	;abs 0x2640

00002638 <.Loc.275.1>:
    2638:	1d 4a 04 00 	mov	4(r10),	r13	;

0000263c <.LVL40>:
    263c:	30 40 22 26 	br	#0x2622		;

00002640 <.L55>:
    2640:	3d 90 34 37 	cmp	#14132,	r13	;#0x3734
    2644:	ee 23       	jnz	$-34     	;abs 0x2622

00002646 <.Loc.275.1>:
    2646:	1d 4a 06 00 	mov	6(r10),	r13	;

0000264a <.LVL42>:
    264a:	30 40 22 26 	br	#0x2622		;

0000264e <__fputwc>:
    264e:	0a 12       	push	r10		;

00002650 <.LCFI0>:
    2650:	09 12       	push	r9		;

00002652 <.LCFI1>:
    2652:	08 12       	push	r8		;

00002654 <.LCFI2>:
    2654:	07 12       	push	r7		;

00002656 <.LCFI3>:
    2656:	06 12       	push	r6		;

00002658 <.LCFI4>:
    2658:	05 12       	push	r5		;

0000265a <.LCFI5>:
    265a:	21 82       	sub	#4,	r1	;r2 As==10

0000265c <.LCFI6>:
    265c:	06 4c       	mov	r12,	r6	;
    265e:	08 4d       	mov	r13,	r8	;
    2660:	07 4e       	mov	r14,	r7	;
    2662:	0a 4f       	mov	r15,	r10	;

00002664 <.Loc.194.1>:
    2664:	b0 12 3e 27 	call	#10046		;#0x273e

00002668 <.LVL1>:
    2668:	1c 93       	cmp	#1,	r12	;r3 As==01
    266a:	15 20       	jnz	$+44     	;abs 0x2696

0000266c <.Loc.194.1>:
    266c:	0e 48       	mov	r8,	r14	;
    266e:	3e 53       	add	#-1,	r14	;r3 As==11
    2670:	0d 47       	mov	r7,	r13	;
    2672:	3d 63       	addc	#-1,	r13	;r3 As==11
    2674:	0d 93       	cmp	#0,	r13	;r3 As==00
    2676:	0f 20       	jnz	$+32     	;abs 0x2696
    2678:	7d 40 fe 00 	mov.b	#254,	r13	;#0x00fe
    267c:	0d 9e       	cmp	r14,	r13	;
    267e:	0b 28       	jnc	$+24     	;abs 0x2696

00002680 <.Loc.201.1>:
    2680:	c1 48 03 00 	mov.b	r8,	3(r1)	;

00002684 <.LVL2>:
    2684:	09 4c       	mov	r12,	r9	;

00002686 <.L4>:
    2686:	47 43       	clr.b	r7		;

00002688 <.LBB4>:
    2688:	35 40 74 21 	mov	#8564,	r5	;#0x2174

0000268c <.L6>:
    268c:	07 99       	cmp	r9,	r7	;
    268e:	19 20       	jnz	$+52     	;abs 0x26c2

00002690 <.Loc.217.1>:
    2690:	0c 48       	mov	r8,	r12	;
    2692:	30 40 bc 26 	br	#0x26bc		;

00002696 <.L2>:
    2696:	0e 4a       	mov	r10,	r14	;
    2698:	3e 50 34 00 	add	#52,	r14	;#0x0034
    269c:	81 4e 00 00 	mov	r14,	0(r1)	;
    26a0:	0e 48       	mov	r8,	r14	;
    26a2:	0f 47       	mov	r7,	r15	;
    26a4:	0d 41       	mov	r1,	r13	;
    26a6:	3d 50 03 00 	add	#3,	r13	;
    26aa:	0c 46       	mov	r6,	r12	;
    26ac:	b0 12 78 2d 	call	#11640		;#0x2d78

000026b0 <.LVL6>:
    26b0:	09 4c       	mov	r12,	r9	;

000026b2 <.LVL7>:
    26b2:	3c 93       	cmp	#-1,	r12	;r3 As==11
    26b4:	e8 23       	jnz	$-46     	;abs 0x2686

000026b6 <.Loc.208.1>:
    26b6:	ba d0 40 00 	bis	#64,	6(r10)	;#0x0040
    26ba:	06 00 

000026bc <.L1>:
    26bc:	21 52       	add	#4,	r1	;r2 As==10
    26be:	30 40 a8 12 	br	#0x12a8		;

000026c2 <.L10>:
    26c2:	7c 40 03 00 	mov.b	#3,	r12	;
    26c6:	0c 51       	add	r1,	r12	;
    26c8:	0c 57       	add	r7,	r12	;
    26ca:	6d 4c       	mov.b	@r12,	r13	;

000026cc <.LBB8>:
    26cc:	1c 4a 04 00 	mov	4(r10),	r12	;
    26d0:	3c 53       	add	#-1,	r12	;r3 As==11
    26d2:	8a 4c 04 00 	mov	r12,	4(r10)	;
    26d6:	0c 93       	cmp	#0,	r12	;r3 As==00
    26d8:	06 34       	jge	$+14     	;abs 0x26e6
    26da:	1c 9a 0e 00 	cmp	14(r10),r12	;0x0000e
    26de:	0d 38       	jl	$+28     	;abs 0x26fa
    26e0:	3d 90 0a 00 	cmp	#10,	r13	;#0x000a
    26e4:	0a 24       	jz	$+22     	;abs 0x26fa

000026e6 <.L7>:
    26e6:	2c 4a       	mov	@r10,	r12	;
    26e8:	0e 4c       	mov	r12,	r14	;
    26ea:	1e 53       	inc	r14		;
    26ec:	8a 4e 00 00 	mov	r14,	0(r10)	;
    26f0:	cc 4d 00 00 	mov.b	r13,	0(r12)	;

000026f4 <.L9>:
    26f4:	17 53       	inc	r7		;
    26f6:	30 40 8c 26 	br	#0x268c		;

000026fa <.L8>:
    26fa:	0e 4a       	mov	r10,	r14	;
    26fc:	0c 46       	mov	r6,	r12	;
    26fe:	85 12       	call	r5		;

00002700 <.LBE9>:
    2700:	3c 93       	cmp	#-1,	r12	;r3 As==11
    2702:	f8 23       	jnz	$-14     	;abs 0x26f4
    2704:	30 40 bc 26 	br	#0x26bc		;

00002708 <_fputwc_r>:
    2708:	0a 12       	push	r10		;

0000270a <.LCFI7>:
    270a:	0a 4d       	mov	r13,	r10	;
    270c:	0b 4e       	mov	r14,	r11	;

0000270e <.Loc.229.1>:
    270e:	1e 4f 06 00 	mov	6(r15),	r14	;
    2712:	3e b0 00 20 	bit	#8192,	r14	;#0x2000
    2716:	0a 20       	jnz	$+22     	;abs 0x272c

00002718 <.Loc.229.1>:
    2718:	3e d0 00 20 	bis	#8192,	r14	;#0x2000
    271c:	8f 4e 06 00 	mov	r14,	6(r15)	;
    2720:	1d 4f 3a 00 	mov	58(r15),r13	;0x0003a

00002724 <.LVL15>:
    2724:	3d d0 00 20 	bis	#8192,	r13	;#0x2000
    2728:	8f 4d 3a 00 	mov	r13,	58(r15)	; 0x003a

0000272c <.L17>:
    272c:	0d 4a       	mov	r10,	r13	;
    272e:	0e 4b       	mov	r11,	r14	;
    2730:	b0 12 4e 26 	call	#9806		;#0x264e

00002734 <.LVL16>:
    2734:	3a 41       	pop	r10		;
    2736:	30 41       	ret			

00002738 <__locale_charset>:
    2738:	3c 40 82 80 	mov	#32898,	r12	;#0x8082
    273c:	30 41       	ret			

0000273e <__locale_mb_cur_max>:
    273e:	1c 42 a2 80 	mov	&0x80a2,r12	;0x80a2
    2742:	30 41       	ret			

00002744 <_lseek_r>:
    2744:	0a 12       	push	r10		;

00002746 <.LCFI0>:
    2746:	0a 4c       	mov	r12,	r10	;
    2748:	0c 4d       	mov	r13,	r12	;

0000274a <.LVL1>:
    274a:	0d 4e       	mov	r14,	r13	;

0000274c <.LVL2>:
    274c:	0e 4f       	mov	r15,	r14	;

0000274e <.LVL3>:
    274e:	82 43 24 81 	mov	#0,	&0x8124	;r3 As==00

00002752 <.Loc.58.1>:
    2752:	1f 41 04 00 	mov	4(r1),	r15	;
    2756:	b0 12 38 2f 	call	#12088		;#0x2f38

0000275a <.LVL4>:
    275a:	3c 93       	cmp	#-1,	r12	;r3 As==11
    275c:	08 20       	jnz	$+18     	;abs 0x276e
    275e:	3d 93       	cmp	#-1,	r13	;r3 As==11
    2760:	06 20       	jnz	$+14     	;abs 0x276e

00002762 <.Loc.58.1>:
    2762:	1e 42 24 81 	mov	&0x8124,r14	;0x8124
    2766:	0e 93       	cmp	#0,	r14	;r3 As==00
    2768:	02 24       	jz	$+6      	;abs 0x276e

0000276a <.Loc.59.1>:
    276a:	8a 4e 00 00 	mov	r14,	0(r10)	;

0000276e <.L1>:
    276e:	3a 41       	pop	r10		;

00002770 <.LVL5>:
    2770:	30 41       	ret			

00002772 <__swhatbuf_r>:
    2772:	0a 12       	push	r10		;

00002774 <.LCFI0>:
    2774:	09 12       	push	r9		;

00002776 <.LCFI1>:
    2776:	08 12       	push	r8		;

00002778 <.LCFI2>:
    2778:	31 80 3c 00 	sub	#60,	r1	;#0x003c

0000277c <.LCFI3>:
    277c:	08 4d       	mov	r13,	r8	;
    277e:	0a 4e       	mov	r14,	r10	;
    2780:	09 4f       	mov	r15,	r9	;

00002782 <.Loc.98.1>:
    2782:	1d 4d 08 00 	mov	8(r13),	r13	;

00002786 <.LVL2>:
    2786:	0d 93       	cmp	#0,	r13	;r3 As==00
    2788:	0d 34       	jge	$+28     	;abs 0x27a4

0000278a <.L5>:
    278a:	89 43 00 00 	mov	#0,	0(r9)	;r3 As==00

0000278e <.Loc.103.1>:
    278e:	1c 48 06 00 	mov	6(r8),	r12	;
    2792:	7c f0 80 00 	and.b	#128,	r12	;#0x0080
    2796:	0c 93       	cmp	#0,	r12	;r3 As==00
    2798:	1c 20       	jnz	$+58     	;abs 0x27d2

0000279a <.Loc.106.1>:
    279a:	ba 40 00 04 	mov	#1024,	0(r10)	;#0x0400
    279e:	00 00 
    27a0:	30 40 da 27 	br	#0x27da		;

000027a4 <.L2>:
    27a4:	0e 41       	mov	r1,	r14	;
    27a6:	b0 12 0e 2e 	call	#11790		;#0x2e0e

000027aa <.LVL5>:
    27aa:	0c 93       	cmp	#0,	r12	;r3 As==00
    27ac:	ee 3b       	jl	$-34     	;abs 0x278a

000027ae <.Loc.111.1>:
    27ae:	1d 41 04 00 	mov	4(r1),	r13	;
    27b2:	3d f0 00 f0 	and	#61440,	r13	;#0xf000
    27b6:	5c 43       	mov.b	#1,	r12	;r3 As==01
    27b8:	3d 90 00 20 	cmp	#8192,	r13	;#0x2000
    27bc:	01 24       	jz	$+4      	;abs 0x27c0
    27be:	4c 43       	clr.b	r12		;

000027c0 <.L8>:
    27c0:	89 4c 00 00 	mov	r12,	0(r9)	;

000027c4 <.Loc.125.1>:
    27c4:	ba 40 00 04 	mov	#1024,	0(r10)	;#0x0400
    27c8:	00 00 

000027ca <.Loc.126.1>:
    27ca:	3c 40 00 08 	mov	#2048,	r12	;#0x0800
    27ce:	30 40 da 27 	br	#0x27da		;

000027d2 <.L3>:
    27d2:	ba 40 40 00 	mov	#64,	0(r10)	;#0x0040
    27d6:	00 00 
    27d8:	4c 43       	clr.b	r12		;

000027da <.L1>:
    27da:	31 50 3c 00 	add	#60,	r1	;#0x003c
    27de:	30 40 ae 12 	br	#0x12ae		;

000027e2 <__smakebuf_r>:
    27e2:	0a 12       	push	r10		;

000027e4 <.LCFI4>:
    27e4:	09 12       	push	r9		;

000027e6 <.LCFI5>:
    27e6:	08 12       	push	r8		;

000027e8 <.LCFI6>:
    27e8:	21 82       	sub	#4,	r1	;r2 As==10

000027ea <.LCFI7>:
    27ea:	09 4c       	mov	r12,	r9	;
    27ec:	0a 4d       	mov	r13,	r10	;

000027ee <.Loc.47.1>:
    27ee:	ed b3 06 00 	bit.b	#2,	6(r13)	;r3 As==10
    27f2:	0c 24       	jz	$+26     	;abs 0x280c

000027f4 <.L23>:
    27f4:	0c 4a       	mov	r10,	r12	;
    27f6:	3c 50 27 00 	add	#39,	r12	;#0x0027
    27fa:	8a 4c 00 00 	mov	r12,	0(r10)	;
    27fe:	8a 4c 0a 00 	mov	r12,	10(r10)	; 0x000a

00002802 <.Loc.60.1>:
    2802:	9a 43 0c 00 	mov	#1,	12(r10)	;r3 As==01, 0x000c

00002806 <.L12>:
    2806:	21 52       	add	#4,	r1	;r2 As==10
    2808:	30 40 ae 12 	br	#0x12ae		;

0000280c <.L13>:
    280c:	0f 41       	mov	r1,	r15	;
    280e:	2f 53       	incd	r15		;
    2810:	0e 41       	mov	r1,	r14	;
    2812:	b0 12 72 27 	call	#10098		;#0x2772

00002816 <.LVL10>:
    2816:	08 4c       	mov	r12,	r8	;

00002818 <.Loc.54.1>:
    2818:	2d 41       	mov	@r1,	r13	;
    281a:	0c 49       	mov	r9,	r12	;
    281c:	b0 12 e2 1b 	call	#7138		;#0x1be2

00002820 <.LVL12>:
    2820:	0c 93       	cmp	#0,	r12	;r3 As==00
    2822:	0a 20       	jnz	$+22     	;abs 0x2838

00002824 <.Loc.56.1>:
    2824:	1c 4a 06 00 	mov	6(r10),	r12	;

00002828 <.LVL13>:
    2828:	3c b0 00 02 	bit	#512,	r12	;#0x0200
    282c:	ec 23       	jnz	$-38     	;abs 0x2806

0000282e <.Loc.58.1>:
    282e:	2c d3       	bis	#2,	r12	;r3 As==10
    2830:	8a 4c 06 00 	mov	r12,	6(r10)	;
    2834:	30 40 f4 27 	br	#0x27f4		;

00002838 <.L15>:
    2838:	b9 40 04 15 	mov	#5380,	20(r9)	;#0x1504, 0x0014
    283c:	14 00 

0000283e <.Loc.66.1>:
    283e:	ba d0 80 00 	bis	#128,	6(r10)	;#0x0080
    2842:	06 00 

00002844 <.Loc.67.1>:
    2844:	8a 4c 00 00 	mov	r12,	0(r10)	;
    2848:	8a 4c 0a 00 	mov	r12,	10(r10)	; 0x000a

0000284c <.Loc.68.1>:
    284c:	aa 41 0c 00 	mov	@r1,	12(r10)	; 0x000c

00002850 <.Loc.69.1>:
    2850:	81 93 02 00 	cmp	#0,	2(r1)	;r3 As==00
    2854:	09 24       	jz	$+20     	;abs 0x2868

00002856 <.Loc.69.1>:
    2856:	1d 4a 08 00 	mov	8(r10),	r13	;
    285a:	0c 49       	mov	r9,	r12	;

0000285c <.LVL15>:
    285c:	b0 12 32 2e 	call	#11826		;#0x2e32

00002860 <.LVL16>:
    2860:	0c 93       	cmp	#0,	r12	;r3 As==00
    2862:	02 24       	jz	$+6      	;abs 0x2868

00002864 <.Loc.70.1>:
    2864:	9a d3 06 00 	bis	#1,	6(r10)	;r3 As==01

00002868 <.L18>:
    2868:	8a d8 06 00 	bis	r8,	6(r10)	;
    286c:	30 40 06 28 	br	#0x2806		;

00002870 <_malloc_usable_size_r>:
    2870:	1e 4d fc ff 	mov	-4(r13),r14	;
    2874:	0c 4e       	mov	r14,	r12	;

00002876 <.LVL3>:
    2876:	3c 50 fc ff 	add	#65532,	r12	;#0xfffc

0000287a <.Loc.530.1>:
    287a:	0e 93       	cmp	#0,	r14	;r3 As==00
    287c:	02 34       	jge	$+6      	;abs 0x2882

0000287e <.LVL4>:
    287e:	0d 5c       	add	r12,	r13	;

00002880 <.LVL5>:
    2880:	2c 5d       	add	@r13,	r12	;

00002882 <.L1>:
    2882:	30 41       	ret			

00002884 <_printf_common>:
    2884:	0a 12       	push	r10		;

00002886 <.LCFI0>:
    2886:	09 12       	push	r9		;

00002888 <.LCFI1>:
    2888:	08 12       	push	r8		;

0000288a <.LCFI2>:
    288a:	07 12       	push	r7		;

0000288c <.LCFI3>:
    288c:	06 12       	push	r6		;

0000288e <.LCFI4>:
    288e:	05 12       	push	r5		;

00002890 <.LCFI5>:
    2890:	04 12       	push	r4		;

00002892 <.LCFI6>:
    2892:	21 83       	decd	r1		;

00002894 <.LCFI7>:
    2894:	07 4c       	mov	r12,	r7	;
    2896:	0a 4d       	mov	r13,	r10	;
    2898:	08 4e       	mov	r14,	r8	;
    289a:	06 4f       	mov	r15,	r6	;
    289c:	15 41 12 00 	mov	18(r1),	r5	;0x00012

000028a0 <.Loc.72.1>:
    28a0:	1d 4d 04 00 	mov	4(r13),	r13	;

000028a4 <.LVL1>:
    28a4:	1c 4a 08 00 	mov	8(r10),	r12	;

000028a8 <.LVL2>:
    28a8:	0c 9d       	cmp	r13,	r12	;
    28aa:	01 34       	jge	$+4      	;abs 0x28ae
    28ac:	0c 4d       	mov	r13,	r12	;

000028ae <.L2>:
    28ae:	88 4c 00 00 	mov	r12,	0(r8)	;

000028b2 <.Loc.73.1>:
    28b2:	ca 93 37 00 	cmp.b	#0,	55(r10)	;r3 As==00, 0x0037
    28b6:	03 24       	jz	$+8      	;abs 0x28be

000028b8 <.Loc.74.1>:
    28b8:	1c 53       	inc	r12		;
    28ba:	88 4c 00 00 	mov	r12,	0(r8)	;

000028be <.L3>:
    28be:	fa b0 20 00 	bit.b	#32,	0(r10)	;#0x0020
    28c2:	00 00 
    28c4:	02 24       	jz	$+6      	;abs 0x28ca

000028c6 <.Loc.77.1>:
    28c6:	a8 53 00 00 	incd	0(r8)		;

000028ca <.L4>:
    28ca:	29 4a       	mov	@r10,	r9	;
    28cc:	79 f0 06 00 	and.b	#6,	r9	;
    28d0:	09 93       	cmp	#0,	r9	;r3 As==00
    28d2:	0b 20       	jnz	$+24     	;abs 0x28ea

000028d4 <.LBB2>:
    28d4:	0c 4a       	mov	r10,	r12	;
    28d6:	3c 50 0d 00 	add	#13,	r12	;#0x000d
    28da:	81 4c 00 00 	mov	r12,	0(r1)	;
    28de:	54 43       	mov.b	#1,	r4	;r3 As==01

000028e0 <.L6>:
    28e0:	1c 4a 06 00 	mov	6(r10),	r12	;
    28e4:	2c 88       	sub	@r8,	r12	;
    28e6:	09 9c       	cmp	r12,	r9	;
    28e8:	30 38       	jl	$+98     	;abs 0x294a

000028ea <.L5>:
    28ea:	5d 4a 37 00 	mov.b	55(r10),r13	;0x00037
    28ee:	0c 43       	clr	r12		;
    28f0:	0c 8d       	sub	r13,	r12	;
    28f2:	b0 12 2a 13 	call	#4906		;#0x132a

000028f6 <.LVL6>:
    28f6:	fa b0 20 00 	bit.b	#32,	0(r10)	;#0x0020
    28fa:	00 00 
    28fc:	34 20       	jnz	$+106    	;abs 0x2966

000028fe <.L8>:
    28fe:	0f 4c       	mov	r12,	r15	;
    2900:	0e 4a       	mov	r10,	r14	;
    2902:	3e 50 37 00 	add	#55,	r14	;#0x0037
    2906:	0d 46       	mov	r6,	r13	;
    2908:	0c 47       	mov	r7,	r12	;

0000290a <.LVL8>:
    290a:	85 12       	call	r5		;

0000290c <.LVL9>:
    290c:	3c 93       	cmp	#-1,	r12	;r3 As==11
    290e:	24 24       	jz	$+74     	;abs 0x2958

00002910 <.Loc.95.1>:
    2910:	19 4a 06 00 	mov	6(r10),	r9	;
    2914:	2c 48       	mov	@r8,	r12	;

00002916 <.LVL10>:
    2916:	2d 4a       	mov	@r10,	r13	;
    2918:	7d f0 06 00 	and.b	#6,	r13	;
    291c:	2d 92       	cmp	#4,	r13	;r2 As==10
    291e:	03 20       	jnz	$+8      	;abs 0x2926

00002920 <.Loc.95.1>:
    2920:	09 8c       	sub	r12,	r9	;

00002922 <.LVL11>:
    2922:	09 93       	cmp	#0,	r9	;r3 As==00
    2924:	01 34       	jge	$+4      	;abs 0x2928

00002926 <.L18>:
    2926:	49 43       	clr.b	r9		;

00002928 <.L13>:
    2928:	1c 4a 04 00 	mov	4(r10),	r12	;
    292c:	1d 4a 08 00 	mov	8(r10),	r13	;
    2930:	0d 9c       	cmp	r12,	r13	;
    2932:	02 34       	jge	$+6      	;abs 0x2938

00002934 <.Loc.100.1>:
    2934:	0c 8d       	sub	r13,	r12	;
    2936:	09 5c       	add	r12,	r9	;

00002938 <.L15>:
    2938:	48 43       	clr.b	r8		;

0000293a <.LVL15>:
    293a:	3a 50 0e 00 	add	#14,	r10	;#0x000e

0000293e <.LVL16>:
    293e:	54 43       	mov.b	#1,	r4	;r3 As==01

00002940 <.L16>:
    2940:	09 98       	cmp	r8,	r9	;
    2942:	1f 20       	jnz	$+64     	;abs 0x2982

00002944 <.LBE3>:
    2944:	4c 43       	clr.b	r12		;
    2946:	30 40 5a 29 	br	#0x295a		;

0000294a <.L11>:
    294a:	0f 44       	mov	r4,	r15	;
    294c:	2e 41       	mov	@r1,	r14	;
    294e:	0d 46       	mov	r6,	r13	;
    2950:	0c 47       	mov	r7,	r12	;
    2952:	85 12       	call	r5		;

00002954 <.LVL19>:
    2954:	3c 93       	cmp	#-1,	r12	;r3 As==11
    2956:	04 20       	jnz	$+10     	;abs 0x2960

00002958 <.L12>:
    2958:	3c 43       	mov	#-1,	r12	;r3 As==11

0000295a <.L1>:
    295a:	21 53       	incd	r1		;
    295c:	30 40 a6 12 	br	#0x12a6		;

00002960 <.L9>:
    2960:	19 53       	inc	r9		;
    2962:	30 40 e0 28 	br	#0x28e0		;

00002966 <.L7>:
    2966:	0d 4a       	mov	r10,	r13	;
    2968:	0d 5c       	add	r12,	r13	;
    296a:	fd 40 30 00 	mov.b	#48,	55(r13)	;#0x0030, 0x0037
    296e:	37 00 

00002970 <.LVL24>:
    2970:	0d 4c       	mov	r12,	r13	;
    2972:	1d 53       	inc	r13		;
    2974:	0d 5a       	add	r10,	r13	;
    2976:	2c 53       	incd	r12		;

00002978 <.LVL25>:
    2978:	dd 4a 39 00 	mov.b	57(r10),55(r13)	;0x00039, 0x0037
    297c:	37 00 
    297e:	30 40 fe 28 	br	#0x28fe		;

00002982 <.L17>:
    2982:	0f 44       	mov	r4,	r15	;
    2984:	0e 4a       	mov	r10,	r14	;
    2986:	0d 46       	mov	r6,	r13	;
    2988:	0c 47       	mov	r7,	r12	;
    298a:	85 12       	call	r5		;

0000298c <.LVL27>:
    298c:	3c 93       	cmp	#-1,	r12	;r3 As==11
    298e:	e4 27       	jz	$-54     	;abs 0x2958

00002990 <.Loc.102.1>:
    2990:	18 53       	inc	r8		;
    2992:	30 40 40 29 	br	#0x2940		;

00002996 <_printf_i>:
    2996:	0a 12       	push	r10		;

00002998 <.LCFI8>:
    2998:	09 12       	push	r9		;

0000299a <.LCFI9>:
    299a:	08 12       	push	r8		;

0000299c <.LCFI10>:
    299c:	07 12       	push	r7		;

0000299e <.LCFI11>:
    299e:	06 12       	push	r6		;

000029a0 <.LCFI12>:
    29a0:	05 12       	push	r5		;

000029a2 <.LCFI13>:
    29a2:	04 12       	push	r4		;

000029a4 <.LCFI14>:
    29a4:	31 80 0e 00 	sub	#14,	r1	;#0x000e

000029a8 <.LCFI15>:
    29a8:	81 4c 04 00 	mov	r12,	4(r1)	;
    29ac:	0a 4d       	mov	r13,	r10	;
    29ae:	81 4e 06 00 	mov	r14,	6(r1)	;
    29b2:	04 4f       	mov	r15,	r4	;
    29b4:	1c 41 1e 00 	mov	30(r1),	r12	;0x0001e

000029b8 <.LVL30>:
    29b8:	0b 4d       	mov	r13,	r11	;
    29ba:	3b 50 37 00 	add	#55,	r11	;#0x0037

000029be <.LVL31>:
    29be:	5e 4d 0c 00 	mov.b	12(r13),r14	;0x0000c

000029c2 <.LVL32>:
    29c2:	7e 90 6e 00 	cmp.b	#110,	r14	;#0x006e
    29c6:	48 25       	jz	$+658    	;abs 0x2c58
    29c8:	79 40 6e 00 	mov.b	#110,	r9	;#0x006e
    29cc:	49 9e       	cmp.b	r14,	r9	;
    29ce:	3a 28       	jnc	$+118    	;abs 0x2a44
    29d0:	7e 90 63 00 	cmp.b	#99,	r14	;#0x0063
    29d4:	56 24       	jz	$+174    	;abs 0x2a82
    29d6:	7f 40 63 00 	mov.b	#99,	r15	;#0x0063

000029da <.LVL33>:
    29da:	4f 9e       	cmp.b	r14,	r15	;
    29dc:	0c 28       	jnc	$+26     	;abs 0x29f6
    29de:	4e 93       	cmp.b	#0,	r14	;r3 As==00
    29e0:	50 25       	jz	$+674    	;abs 0x2c82
    29e2:	7e 90 58 00 	cmp.b	#88,	r14	;#0x0058
    29e6:	cc 24       	jz	$+410    	;abs 0x2b80

000029e8 <.L29>:
    29e8:	07 4a       	mov	r10,	r7	;
    29ea:	37 50 36 00 	add	#54,	r7	;#0x0036

000029ee <.LVL34>:
    29ee:	ca 4e 36 00 	mov.b	r14,	54(r10)	; 0x0036
    29f2:	30 40 9a 2a 	br	#0x2a9a		;

000029f6 <.L33>:
    29f6:	7e 90 64 00 	cmp.b	#100,	r14	;#0x0064
    29fa:	03 24       	jz	$+8      	;abs 0x2a02
    29fc:	7e 90 69 00 	cmp.b	#105,	r14	;#0x0069
    2a00:	f3 23       	jnz	$-24     	;abs 0x29e8

00002a02 <.L36>:
    2a02:	2e 4a       	mov	@r10,	r14	;
    2a04:	2d 4c       	mov	@r12,	r13	;
    2a06:	1d 53       	inc	r13		;
    2a08:	1d c3       	bic	#1,	r13	;r3 As==01
    2a0a:	3e b0 80 00 	bit	#128,	r14	;#0x0080
    2a0e:	49 24       	jz	$+148    	;abs 0x2aa2
    2a10:	0f 4d       	mov	r13,	r15	;
    2a12:	2f 52       	add	#4,	r15	;r2 As==10
    2a14:	8c 4f 00 00 	mov	r15,	0(r12)	;
    2a18:	28 4d       	mov	@r13,	r8	;
    2a1a:	19 4d 02 00 	mov	2(r13),	r9	;

00002a1e <.L44>:
    2a1e:	09 93       	cmp	#0,	r9	;r3 As==00
    2a20:	0b 34       	jge	$+24     	;abs 0x2a38

00002a22 <.Loc.132.1>:
    2a22:	4c 43       	clr.b	r12		;
    2a24:	4d 43       	clr.b	r13		;
    2a26:	0e 4c       	mov	r12,	r14	;
    2a28:	0f 4d       	mov	r13,	r15	;
    2a2a:	0e 88       	sub	r8,	r14	;
    2a2c:	0f 79       	subc	r9,	r15	;
    2a2e:	08 4e       	mov	r14,	r8	;

00002a30 <.LVL37>:
    2a30:	09 4f       	mov	r15,	r9	;

00002a32 <.LVL38>:
    2a32:	fa 40 2d 00 	mov.b	#45,	55(r10)	;#0x002d, 0x0037
    2a36:	37 00 

00002a38 <.L75>:
    2a38:	35 40 7f 37 	mov	#14207,	r5	;#0x377f

00002a3c <.LBB9>:
    2a3c:	76 40 0a 00 	mov.b	#10,	r6	;#0x000a
    2a40:	30 40 fa 2a 	br	#0x2afa		;

00002a44 <.L31>:
    2a44:	7e 90 73 00 	cmp.b	#115,	r14	;#0x0073
    2a48:	34 25       	jz	$+618    	;abs 0x2cb2
    2a4a:	79 40 73 00 	mov.b	#115,	r9	;#0x0073
    2a4e:	49 9e       	cmp.b	r14,	r9	;
    2a50:	0b 28       	jnc	$+24     	;abs 0x2a68
    2a52:	7e 90 6f 00 	cmp.b	#111,	r14	;#0x006f
    2a56:	39 24       	jz	$+116    	;abs 0x2aca
    2a58:	7e 90 70 00 	cmp.b	#112,	r14	;#0x0070
    2a5c:	c5 23       	jnz	$-116    	;abs 0x29e8

00002a5e <.LBB10>:
    2a5e:	ba d0 20 00 	bis	#32,	0(r10)	;#0x0020
    2a62:	00 00 
    2a64:	30 40 74 2a 	br	#0x2a74		;

00002a68 <.L38>:
    2a68:	7e 90 75 00 	cmp.b	#117,	r14	;#0x0075
    2a6c:	2e 24       	jz	$+94     	;abs 0x2aca
    2a6e:	7e 90 78 00 	cmp.b	#120,	r14	;#0x0078
    2a72:	ba 23       	jnz	$-138    	;abs 0x29e8

00002a74 <.L41>:
    2a74:	fa 40 78 00 	mov.b	#120,	57(r10)	;#0x0078, 0x0039
    2a78:	39 00 

00002a7a <.Loc.159.1>:
    2a7a:	35 40 90 37 	mov	#14224,	r5	;#0x3790
    2a7e:	30 40 88 2b 	br	#0x2b88		;

00002a82 <.L32>:
    2a82:	07 4a       	mov	r10,	r7	;
    2a84:	37 50 36 00 	add	#54,	r7	;#0x0036

00002a88 <.LVL42>:
    2a88:	2d 4c       	mov	@r12,	r13	;
    2a8a:	1d 53       	inc	r13		;
    2a8c:	1d c3       	bic	#1,	r13	;r3 As==01
    2a8e:	0e 4d       	mov	r13,	r14	;
    2a90:	2e 53       	incd	r14		;
    2a92:	8c 4e 00 00 	mov	r14,	0(r12)	;
    2a96:	ea 4d 36 00 	mov.b	@r13,	54(r10)	; 0x0036

00002a9a <.L117>:
    2a9a:	9a 43 08 00 	mov	#1,	8(r10)	;r3 As==01
    2a9e:	30 40 da 2c 	br	#0x2cda		;

00002aa2 <.L43>:
    2aa2:	3e b0 40 00 	bit	#64,	r14	;#0x0040
    2aa6:	0b 24       	jz	$+24     	;abs 0x2abe

00002aa8 <.Loc.129.1>:
    2aa8:	09 4d       	mov	r13,	r9	;
    2aaa:	29 53       	incd	r9		;
    2aac:	8c 49 00 00 	mov	r9,	0(r12)	;

00002ab0 <.L115>:
    2ab0:	28 4d       	mov	@r13,	r8	;
    2ab2:	38 b0 00 80 	bit	#32768,	r8	;#0x8000
    2ab6:	09 79       	subc	r9,	r9	;
    2ab8:	39 e3       	inv	r9		;
    2aba:	30 40 1e 2a 	br	#0x2a1e		;

00002abe <.L45>:
    2abe:	0e 4d       	mov	r13,	r14	;
    2ac0:	2e 53       	incd	r14		;
    2ac2:	8c 4e 00 00 	mov	r14,	0(r12)	;
    2ac6:	30 40 b0 2a 	br	#0x2ab0		;

00002aca <.L39>:
    2aca:	2f 4a       	mov	@r10,	r15	;
    2acc:	07 4f       	mov	r15,	r7	;
    2ace:	77 f0 80 00 	and.b	#128,	r7	;#0x0080
    2ad2:	2d 4c       	mov	@r12,	r13	;
    2ad4:	07 93       	cmp	#0,	r7	;r3 As==00
    2ad6:	43 24       	jz	$+136    	;abs 0x2b5e
    2ad8:	1d 53       	inc	r13		;
    2ada:	1d c3       	bic	#1,	r13	;r3 As==01
    2adc:	0f 4d       	mov	r13,	r15	;
    2ade:	2f 52       	add	#4,	r15	;r2 As==10
    2ae0:	8c 4f 00 00 	mov	r15,	0(r12)	;
    2ae4:	28 4d       	mov	@r13,	r8	;
    2ae6:	19 4d 02 00 	mov	2(r13),	r9	;

00002aea <.L50>:
    2aea:	35 40 7f 37 	mov	#14207,	r5	;#0x377f

00002aee <.LBB12>:
    2aee:	3e 90 6f 00 	cmp	#111,	r14	;#0x006f
    2af2:	85 20       	jnz	$+268    	;abs 0x2bfe

00002af4 <.Loc.140.1>:
    2af4:	76 42       	mov.b	#8,	r6	;r2 As==11

00002af6 <.L52>:
    2af6:	ca 43 37 00 	mov.b	#0,	55(r10)	;r3 As==00, 0x0037

00002afa <.L47>:
    2afa:	1c 4a 02 00 	mov	2(r10),	r12	;
    2afe:	8a 4c 04 00 	mov	r12,	4(r10)	;
    2b02:	0c 93       	cmp	#0,	r12	;r3 As==00
    2b04:	1b 39       	jl	$+568    	;abs 0x2d3c

00002b06 <.Loc.180.1>:
    2b06:	aa c2 00 00 	bic	#4,	0(r10)	;r2 As==10

00002b0a <.Loc.187.1>:
    2b0a:	0d 48       	mov	r8,	r13	;
    2b0c:	0d d9       	bis	r9,	r13	;
    2b0e:	0d 93       	cmp	#0,	r13	;r3 As==00
    2b10:	7a 20       	jnz	$+246    	;abs 0x2c06

00002b12 <.Loc.187.1>:
    2b12:	0c 93       	cmp	#0,	r12	;r3 As==00
    2b14:	17 21       	jnz	$+560    	;abs 0x2d44

00002b16 <.LBE12>:
    2b16:	07 4b       	mov	r11,	r7	;

00002b18 <.L61>:
    2b18:	36 92       	cmp	#8,	r6	;r2 As==11
    2b1a:	0b 20       	jnz	$+24     	;abs 0x2b32

00002b1c <.Loc.198.1>:
    2b1c:	da b3 00 00 	bit.b	#1,	0(r10)	;r3 As==01
    2b20:	08 24       	jz	$+18     	;abs 0x2b32

00002b22 <.Loc.198.1>:
    2b22:	9a 9a 02 00 	cmp	2(r10),	8(r10)	;
    2b26:	08 00 
    2b28:	04 38       	jl	$+10     	;abs 0x2b32

00002b2a <.LVL48>:
    2b2a:	f7 40 30 00 	mov.b	#48,	-1(r7)	;#0x0030, 0xffff
    2b2e:	ff ff 
    2b30:	37 53       	add	#-1,	r7	;r3 As==11

00002b32 <.L63>:
    2b32:	0b 87       	sub	r7,	r11	;
    2b34:	8a 4b 08 00 	mov	r11,	8(r10)	;

00002b38 <.L64>:
    2b38:	81 44 00 00 	mov	r4,	0(r1)	;
    2b3c:	1f 41 06 00 	mov	6(r1),	r15	;
    2b40:	0e 41       	mov	r1,	r14	;
    2b42:	3e 50 0c 00 	add	#12,	r14	;#0x000c
    2b46:	0d 4a       	mov	r10,	r13	;
    2b48:	1c 41 04 00 	mov	4(r1),	r12	;
    2b4c:	b0 12 84 28 	call	#10372		;#0x2884

00002b50 <.LVL51>:
    2b50:	3c 93       	cmp	#-1,	r12	;r3 As==11
    2b52:	c7 20       	jnz	$+400    	;abs 0x2ce2

00002b54 <.L70>:
    2b54:	3c 43       	mov	#-1,	r12	;r3 As==11

00002b56 <.L28>:
    2b56:	31 50 0e 00 	add	#14,	r1	;#0x000e
    2b5a:	30 40 a6 12 	br	#0x12a6		;

00002b5e <.L49>:
    2b5e:	7f f0 40 00 	and.b	#64,	r15	;#0x0040
    2b62:	1d 53       	inc	r13		;
    2b64:	1d c3       	bic	#1,	r13	;r3 As==01
    2b66:	09 4d       	mov	r13,	r9	;
    2b68:	29 53       	incd	r9		;
    2b6a:	8c 49 00 00 	mov	r9,	0(r12)	;
    2b6e:	28 4d       	mov	@r13,	r8	;
    2b70:	0f 93       	cmp	#0,	r15	;r3 As==00
    2b72:	03 24       	jz	$+8      	;abs 0x2b7a

00002b74 <.Loc.139.1>:
    2b74:	09 47       	mov	r7,	r9	;
    2b76:	30 40 ea 2a 	br	#0x2aea		;

00002b7a <.L51>:
    2b7a:	09 4f       	mov	r15,	r9	;
    2b7c:	30 40 ea 2a 	br	#0x2aea		;

00002b80 <.L35>:
    2b80:	ca 4e 39 00 	mov.b	r14,	57(r10)	; 0x0039

00002b84 <.LBE14>:
    2b84:	35 40 7f 37 	mov	#14207,	r5	;#0x377f

00002b88 <.L53>:
    2b88:	2d 4a       	mov	@r10,	r13	;
    2b8a:	0f 4d       	mov	r13,	r15	;
    2b8c:	7f f0 80 00 	and.b	#128,	r15	;#0x0080
    2b90:	29 4c       	mov	@r12,	r9	;
    2b92:	0f 93       	cmp	#0,	r15	;r3 As==00
    2b94:	1a 24       	jz	$+54     	;abs 0x2bca
    2b96:	19 53       	inc	r9		;
    2b98:	19 c3       	bic	#1,	r9	;r3 As==01
    2b9a:	0e 49       	mov	r9,	r14	;
    2b9c:	2e 52       	add	#4,	r14	;r2 As==10
    2b9e:	8c 4e 00 00 	mov	r14,	0(r12)	;
    2ba2:	28 49       	mov	@r9,	r8	;
    2ba4:	19 49 02 00 	mov	2(r9),	r9	;

00002ba8 <.L55>:
    2ba8:	1d b3       	bit	#1,	r13	;r3 As==01
    2baa:	04 24       	jz	$+10     	;abs 0x2bb4

00002bac <.Loc.164.1>:
    2bac:	3d d0 20 00 	bis	#32,	r13	;#0x0020
    2bb0:	8a 4d 00 00 	mov	r13,	0(r10)	;

00002bb4 <.L57>:
    2bb4:	0c 48       	mov	r8,	r12	;

00002bb6 <.LVL56>:
    2bb6:	0c d9       	bis	r9,	r12	;
    2bb8:	0c 93       	cmp	#0,	r12	;r3 As==00
    2bba:	03 20       	jnz	$+8      	;abs 0x2bc2

00002bbc <.Loc.168.1>:
    2bbc:	ba f0 df ff 	and	#65503,	0(r10)	;#0xffdf
    2bc0:	00 00 

00002bc2 <.L77>:
    2bc2:	76 40 10 00 	mov.b	#16,	r6	;#0x0010
    2bc6:	30 40 f6 2a 	br	#0x2af6		;

00002bca <.L54>:
    2bca:	0e 4d       	mov	r13,	r14	;
    2bcc:	7e f0 40 00 	and.b	#64,	r14	;#0x0040
    2bd0:	19 53       	inc	r9		;
    2bd2:	0e 93       	cmp	#0,	r14	;r3 As==00
    2bd4:	0a 24       	jz	$+22     	;abs 0x2bea

00002bd6 <.Loc.161.1>:
    2bd6:	0e 49       	mov	r9,	r14	;
    2bd8:	1e c3       	bic	#1,	r14	;r3 As==01
    2bda:	09 4e       	mov	r14,	r9	;
    2bdc:	29 53       	incd	r9		;
    2bde:	8c 49 00 00 	mov	r9,	0(r12)	;
    2be2:	28 4e       	mov	@r14,	r8	;
    2be4:	09 4f       	mov	r15,	r9	;
    2be6:	30 40 a8 2b 	br	#0x2ba8		;

00002bea <.L56>:
    2bea:	0f 49       	mov	r9,	r15	;
    2bec:	1f c3       	bic	#1,	r15	;r3 As==01
    2bee:	09 4f       	mov	r15,	r9	;
    2bf0:	29 53       	incd	r9		;
    2bf2:	8c 49 00 00 	mov	r9,	0(r12)	;
    2bf6:	28 4f       	mov	@r15,	r8	;
    2bf8:	09 4e       	mov	r14,	r9	;
    2bfa:	30 40 a8 2b 	br	#0x2ba8		;

00002bfe <.L76>:
    2bfe:	76 40 0a 00 	mov.b	#10,	r6	;#0x000a
    2c02:	30 40 f6 2a 	br	#0x2af6		;

00002c06 <.L59>:
    2c06:	07 4b       	mov	r11,	r7	;

00002c08 <.Loc.191.1>:
    2c08:	0c 46       	mov	r6,	r12	;
    2c0a:	3c b0 00 80 	bit	#32768,	r12	;#0x8000
    2c0e:	0d 7d       	subc	r13,	r13	;
    2c10:	3d e3       	inv	r13		;
    2c12:	81 4c 08 00 	mov	r12,	8(r1)	;
    2c16:	81 4d 0a 00 	mov	r13,	10(r1)	; 0x000a

00002c1a <.L62>:
    2c1a:	37 53       	add	#-1,	r7	;r3 As==11
    2c1c:	1e 41 08 00 	mov	8(r1),	r14	;
    2c20:	1f 41 0a 00 	mov	10(r1),	r15	;0x0000a
    2c24:	0c 48       	mov	r8,	r12	;
    2c26:	0d 49       	mov	r9,	r13	;
    2c28:	81 4b 02 00 	mov	r11,	2(r1)	;
    2c2c:	b0 12 f2 2e 	call	#12018		;#0x2ef2
    2c30:	0c 55       	add	r5,	r12	;
    2c32:	e7 4c 00 00 	mov.b	@r12,	0(r7)	;

00002c36 <.Loc.192.1>:
    2c36:	1e 41 08 00 	mov	8(r1),	r14	;
    2c3a:	1f 41 0a 00 	mov	10(r1),	r15	;0x0000a
    2c3e:	0c 48       	mov	r8,	r12	;
    2c40:	0d 49       	mov	r9,	r13	;
    2c42:	b0 12 e4 2e 	call	#12004		;#0x2ee4
    2c46:	08 4c       	mov	r12,	r8	;

00002c48 <.LVL64>:
    2c48:	09 4d       	mov	r13,	r9	;

00002c4a <.LVL65>:
    2c4a:	0c dd       	bis	r13,	r12	;
    2c4c:	1b 41 02 00 	mov	2(r1),	r11	;
    2c50:	0c 93       	cmp	#0,	r12	;r3 As==00
    2c52:	e3 23       	jnz	$-56     	;abs 0x2c1a
    2c54:	30 40 18 2b 	br	#0x2b18		;

00002c58 <.L30>:
    2c58:	2e 4a       	mov	@r10,	r14	;
    2c5a:	2d 4c       	mov	@r12,	r13	;
    2c5c:	3e b0 80 00 	bit	#128,	r14	;#0x0080
    2c60:	15 24       	jz	$+44     	;abs 0x2c8c

00002c62 <.Loc.205.1>:
    2c62:	0e 4d       	mov	r13,	r14	;
    2c64:	2e 53       	incd	r14		;
    2c66:	8c 4e 00 00 	mov	r14,	0(r12)	;
    2c6a:	2c 4d       	mov	@r13,	r12	;

00002c6c <.LVL67>:
    2c6c:	1e 4a 0a 00 	mov	10(r10),r14	;0x0000a
    2c70:	0d 4e       	mov	r14,	r13	;
    2c72:	3d b0 00 80 	bit	#32768,	r13	;#0x8000
    2c76:	0e 7e       	subc	r14,	r14	;
    2c78:	3e e3       	inv	r14		;
    2c7a:	8c 4d 00 00 	mov	r13,	0(r12)	;
    2c7e:	8c 4e 02 00 	mov	r14,	2(r12)	;

00002c82 <.L34>:
    2c82:	8a 43 08 00 	mov	#0,	8(r10)	;r3 As==00

00002c86 <.LBE15>:
    2c86:	07 4b       	mov	r11,	r7	;

00002c88 <.LBB16>:
    2c88:	30 40 38 2b 	br	#0x2b38		;

00002c8c <.L65>:
    2c8c:	3e b0 40 00 	bit	#64,	r14	;#0x0040
    2c90:	0a 24       	jz	$+22     	;abs 0x2ca6

00002c92 <.Loc.207.1>:
    2c92:	0f 4d       	mov	r13,	r15	;
    2c94:	2f 53       	incd	r15		;
    2c96:	8c 4f 00 00 	mov	r15,	0(r12)	;

00002c9a <.L116>:
    2c9a:	2c 4d       	mov	@r13,	r12	;

00002c9c <.LVL70>:
    2c9c:	9c 4a 0a 00 	mov	10(r10),0(r12)	;0x0000a
    2ca0:	00 00 

00002ca2 <.LVL71>:
    2ca2:	30 40 82 2c 	br	#0x2c82		;

00002ca6 <.L66>:
    2ca6:	09 4d       	mov	r13,	r9	;
    2ca8:	29 53       	incd	r9		;
    2caa:	8c 49 00 00 	mov	r9,	0(r12)	;
    2cae:	30 40 9a 2c 	br	#0x2c9a		;

00002cb2 <.L37>:
    2cb2:	2d 4c       	mov	@r12,	r13	;
    2cb4:	0e 4d       	mov	r13,	r14	;
    2cb6:	2e 53       	incd	r14		;
    2cb8:	8c 4e 00 00 	mov	r14,	0(r12)	;
    2cbc:	27 4d       	mov	@r13,	r7	;

00002cbe <.LVL73>:
    2cbe:	1e 4a 02 00 	mov	2(r10),	r14	;
    2cc2:	4d 43       	clr.b	r13		;
    2cc4:	0c 47       	mov	r7,	r12	;

00002cc6 <.LVL74>:
    2cc6:	b0 12 6c 1a 	call	#6764		;#0x1a6c

00002cca <.LVL75>:
    2cca:	0c 93       	cmp	#0,	r12	;r3 As==00
    2ccc:	03 24       	jz	$+8      	;abs 0x2cd4

00002cce <.Loc.222.1>:
    2cce:	0c 87       	sub	r7,	r12	;

00002cd0 <.LVL76>:
    2cd0:	8a 4c 02 00 	mov	r12,	2(r10)	;

00002cd4 <.L67>:
    2cd4:	9a 4a 02 00 	mov	2(r10),	8(r10)	;
    2cd8:	08 00 

00002cda <.L42>:
    2cda:	ca 43 37 00 	mov.b	#0,	55(r10)	;r3 As==00, 0x0037

00002cde <.Loc.233.1>:
    2cde:	30 40 38 2b 	br	#0x2b38		;

00002ce2 <.L68>:
    2ce2:	1f 4a 08 00 	mov	8(r10),	r15	;
    2ce6:	0e 47       	mov	r7,	r14	;
    2ce8:	1d 41 06 00 	mov	6(r1),	r13	;
    2cec:	1c 41 04 00 	mov	4(r1),	r12	;

00002cf0 <.LVL79>:
    2cf0:	84 12       	call	r4		;

00002cf2 <.LVL80>:
    2cf2:	3c 93       	cmp	#-1,	r12	;r3 As==11
    2cf4:	2f 27       	jz	$-416    	;abs 0x2b54

00002cf6 <.Loc.243.1>:
    2cf6:	ea b3 00 00 	bit.b	#2,	0(r10)	;r3 As==10
    2cfa:	0b 24       	jz	$+24     	;abs 0x2d12
    2cfc:	49 43       	clr.b	r9		;

00002cfe <.LBB17>:
    2cfe:	08 4a       	mov	r10,	r8	;
    2d00:	38 50 0d 00 	add	#13,	r8	;#0x000d
    2d04:	57 43       	mov.b	#1,	r7	;r3 As==01

00002d06 <.L72>:
    2d06:	1c 4a 06 00 	mov	6(r10),	r12	;
    2d0a:	1c 81 0c 00 	sub	12(r1),	r12	;0x0000c
    2d0e:	09 9c       	cmp	r12,	r9	;
    2d10:	09 38       	jl	$+20     	;abs 0x2d24

00002d12 <.L71>:
    2d12:	1d 41 0c 00 	mov	12(r1),	r13	;0x0000c
    2d16:	1c 4a 06 00 	mov	6(r10),	r12	;
    2d1a:	0c 9d       	cmp	r13,	r12	;
    2d1c:	1c 37       	jge	$-454    	;abs 0x2b56
    2d1e:	0c 4d       	mov	r13,	r12	;
    2d20:	30 40 56 2b 	br	#0x2b56		;

00002d24 <.L74>:
    2d24:	0f 47       	mov	r7,	r15	;
    2d26:	0e 48       	mov	r8,	r14	;
    2d28:	1d 41 06 00 	mov	6(r1),	r13	;
    2d2c:	1c 41 04 00 	mov	4(r1),	r12	;
    2d30:	84 12       	call	r4		;

00002d32 <.LVL84>:
    2d32:	3c 93       	cmp	#-1,	r12	;r3 As==11
    2d34:	0f 27       	jz	$-480    	;abs 0x2b54

00002d36 <.Loc.244.1>:
    2d36:	19 53       	inc	r9		;
    2d38:	30 40 06 2d 	br	#0x2d06		;

00002d3c <.L58>:
    2d3c:	0c 48       	mov	r8,	r12	;
    2d3e:	0c d9       	bis	r9,	r12	;
    2d40:	0c 93       	cmp	#0,	r12	;r3 As==00
    2d42:	61 23       	jnz	$-316    	;abs 0x2c06

00002d44 <.L60>:
    2d44:	07 4a       	mov	r10,	r7	;
    2d46:	37 50 36 00 	add	#54,	r7	;#0x0036

00002d4a <.LVL88>:
    2d4a:	ea 45 36 00 	mov.b	@r5,	54(r10)	; 0x0036
    2d4e:	30 40 18 2b 	br	#0x2b18		;

00002d52 <_read_r>:
    2d52:	0a 12       	push	r10		;

00002d54 <.LCFI0>:
    2d54:	0a 4c       	mov	r12,	r10	;
    2d56:	0c 4d       	mov	r13,	r12	;

00002d58 <.LVL1>:
    2d58:	0d 4e       	mov	r14,	r13	;

00002d5a <.LVL2>:
    2d5a:	82 43 24 81 	mov	#0,	&0x8124	;r3 As==00

00002d5e <.Loc.58.1>:
    2d5e:	0e 4f       	mov	r15,	r14	;

00002d60 <.LVL3>:
    2d60:	b0 12 1c 2f 	call	#12060		;#0x2f1c

00002d64 <.LVL4>:
    2d64:	3c 93       	cmp	#-1,	r12	;r3 As==11
    2d66:	06 20       	jnz	$+14     	;abs 0x2d74

00002d68 <.Loc.58.1>:
    2d68:	1d 42 24 81 	mov	&0x8124,r13	;0x8124
    2d6c:	0d 93       	cmp	#0,	r13	;r3 As==00
    2d6e:	02 24       	jz	$+6      	;abs 0x2d74

00002d70 <.Loc.59.1>:
    2d70:	8a 4d 00 00 	mov	r13,	0(r10)	;

00002d74 <.L1>:
    2d74:	3a 41       	pop	r10		;

00002d76 <.LVL5>:
    2d76:	30 41       	ret			

00002d78 <_wcrtomb_r>:
    2d78:	0a 12       	push	r10		;

00002d7a <.LCFI0>:
    2d7a:	09 12       	push	r9		;

00002d7c <.LCFI1>:
    2d7c:	08 12       	push	r8		;

00002d7e <.LCFI2>:
    2d7e:	31 80 14 00 	sub	#20,	r1	;#0x0014

00002d82 <.LCFI3>:
    2d82:	0a 4c       	mov	r12,	r10	;
    2d84:	19 41 1c 00 	mov	28(r1),	r9	;0x0001c

00002d88 <.LVL1>:
    2d88:	18 42 a4 80 	mov	&0x80a4,r8	;0x80a4
    2d8c:	3c 40 38 27 	mov	#10040,	r12	;#0x2738

00002d90 <.LVL2>:
    2d90:	0d 93       	cmp	#0,	r13	;r3 As==00
    2d92:	17 20       	jnz	$+48     	;abs 0x2dc2

00002d94 <.Loc.28.1>:
    2d94:	8c 12       	call	r12		;

00002d96 <.LVL3>:
    2d96:	81 49 02 00 	mov	r9,	2(r1)	;
    2d9a:	81 4c 00 00 	mov	r12,	0(r1)	;
    2d9e:	4e 43       	clr.b	r14		;
    2da0:	4f 43       	clr.b	r15		;
    2da2:	0d 41       	mov	r1,	r13	;
    2da4:	3d 50 0a 00 	add	#10,	r13	;#0x000a

00002da8 <.L6>:
    2da8:	0c 4a       	mov	r10,	r12	;
    2daa:	88 12       	call	r8		;

00002dac <.LVL4>:
    2dac:	3c 93       	cmp	#-1,	r12	;r3 As==11
    2dae:	05 20       	jnz	$+12     	;abs 0x2dba

00002db0 <.Loc.34.1>:
    2db0:	89 43 00 00 	mov	#0,	0(r9)	;r3 As==00

00002db4 <.Loc.35.1>:
    2db4:	ba 40 8a 00 	mov	#138,	0(r10)	;#0x008a
    2db8:	00 00 

00002dba <.L1>:
    2dba:	31 50 14 00 	add	#20,	r1	;#0x0014
    2dbe:	30 40 ae 12 	br	#0x12ae		;

00002dc2 <.L2>:
    2dc2:	81 4d 08 00 	mov	r13,	8(r1)	;
    2dc6:	81 4e 06 00 	mov	r14,	6(r1)	;
    2dca:	81 4f 04 00 	mov	r15,	4(r1)	;
    2dce:	8c 12       	call	r12		;

00002dd0 <.LVL6>:
    2dd0:	81 49 02 00 	mov	r9,	2(r1)	;
    2dd4:	81 4c 00 00 	mov	r12,	0(r1)	;
    2dd8:	1e 41 06 00 	mov	6(r1),	r14	;
    2ddc:	1f 41 04 00 	mov	4(r1),	r15	;
    2de0:	1d 41 08 00 	mov	8(r1),	r13	;
    2de4:	30 40 a8 2d 	br	#0x2da8		;

00002de8 <__ascii_wctomb>:
    2de8:	0d 93       	cmp	#0,	r13	;r3 As==00
    2dea:	0e 24       	jz	$+30     	;abs 0x2e08

00002dec <.Loc.47.1>:
    2dec:	7f 40 ff 00 	mov.b	#255,	r15	;#0x00ff
    2df0:	0f 9e       	cmp	r14,	r15	;
    2df2:	05 2c       	jc	$+12     	;abs 0x2dfe

00002df4 <.Loc.50.1>:
    2df4:	bc 40 8a 00 	mov	#138,	0(r12)	;#0x008a
    2df8:	00 00 

00002dfa <.Loc.51.1>:
    2dfa:	3c 43       	mov	#-1,	r12	;r3 As==11

00002dfc <.L1>:
    2dfc:	30 41       	ret			

00002dfe <.L3>:
    2dfe:	cd 4e 00 00 	mov.b	r14,	0(r13)	;

00002e02 <.Loc.55.1>:
    2e02:	5c 43       	mov.b	#1,	r12	;r3 As==01

00002e04 <.LVL4>:
    2e04:	30 40 fc 2d 	br	#0x2dfc		;

00002e08 <.L4>:
    2e08:	0c 4d       	mov	r13,	r12	;

00002e0a <.LVL6>:
    2e0a:	30 40 fc 2d 	br	#0x2dfc		;

00002e0e <_fstat_r>:
    2e0e:	0a 12       	push	r10		;

00002e10 <.LCFI0>:
    2e10:	0a 4c       	mov	r12,	r10	;
    2e12:	0c 4d       	mov	r13,	r12	;

00002e14 <.LVL1>:
    2e14:	82 43 24 81 	mov	#0,	&0x8124	;r3 As==00

00002e18 <.Loc.62.1>:
    2e18:	0d 4e       	mov	r14,	r13	;

00002e1a <.LVL2>:
    2e1a:	b0 12 2a 2f 	call	#12074		;#0x2f2a

00002e1e <.LVL3>:
    2e1e:	3c 93       	cmp	#-1,	r12	;r3 As==11
    2e20:	06 20       	jnz	$+14     	;abs 0x2e2e

00002e22 <.Loc.62.1>:
    2e22:	1d 42 24 81 	mov	&0x8124,r13	;0x8124
    2e26:	0d 93       	cmp	#0,	r13	;r3 As==00
    2e28:	02 24       	jz	$+6      	;abs 0x2e2e

00002e2a <.Loc.63.1>:
    2e2a:	8a 4d 00 00 	mov	r13,	0(r10)	;

00002e2e <.L1>:
    2e2e:	3a 41       	pop	r10		;

00002e30 <.LVL4>:
    2e30:	30 41       	ret			

00002e32 <_isatty_r>:
    2e32:	0a 12       	push	r10		;

00002e34 <.LCFI0>:
    2e34:	0a 4c       	mov	r12,	r10	;

00002e36 <.Loc.57.1>:
    2e36:	82 43 24 81 	mov	#0,	&0x8124	;r3 As==00

00002e3a <.Loc.58.1>:
    2e3a:	0c 4d       	mov	r13,	r12	;

00002e3c <.LVL1>:
    2e3c:	b0 12 04 2f 	call	#12036		;#0x2f04

00002e40 <.LVL2>:
    2e40:	3c 93       	cmp	#-1,	r12	;r3 As==11
    2e42:	06 20       	jnz	$+14     	;abs 0x2e50

00002e44 <.Loc.58.1>:
    2e44:	1d 42 24 81 	mov	&0x8124,r13	;0x8124
    2e48:	0d 93       	cmp	#0,	r13	;r3 As==00
    2e4a:	02 24       	jz	$+6      	;abs 0x2e50

00002e4c <.Loc.59.1>:
    2e4c:	8a 4d 00 00 	mov	r13,	0(r10)	;

00002e50 <.L1>:
    2e50:	3a 41       	pop	r10		;

00002e52 <.LVL3>:
    2e52:	30 41       	ret			

00002e54 <udivmodsi4>:
    2e54:	0a 12       	push	r10		;

00002e56 <.LCFI0>:
    2e56:	09 12       	push	r9		;

00002e58 <.LCFI1>:
    2e58:	08 12       	push	r8		;

00002e5a <.LCFI2>:
    2e5a:	07 12       	push	r7		;

00002e5c <.LCFI3>:
    2e5c:	06 12       	push	r6		;

00002e5e <.LCFI4>:
    2e5e:	05 12       	push	r5		;

00002e60 <.LCFI5>:
    2e60:	0a 4c       	mov	r12,	r10	;
    2e62:	0b 4d       	mov	r13,	r11	;

00002e64 <.LVL1>:
    2e64:	7d 40 21 00 	mov.b	#33,	r13	;#0x0021

00002e68 <.Loc.35.1>:
    2e68:	58 43       	mov.b	#1,	r8	;r3 As==01
    2e6a:	49 43       	clr.b	r9		;

00002e6c <.Loc.38.1>:
    2e6c:	07 4b       	mov	r11,	r7	;

00002e6e <.L2>:
    2e6e:	0f 9b       	cmp	r11,	r15	;
    2e70:	11 28       	jnc	$+36     	;abs 0x2e94
    2e72:	07 9f       	cmp	r15,	r7	;
    2e74:	02 20       	jnz	$+6      	;abs 0x2e7a
    2e76:	0e 9a       	cmp	r10,	r14	;
    2e78:	0d 28       	jnc	$+28     	;abs 0x2e94

00002e7a <.L20>:
    2e7a:	4c 43       	clr.b	r12		;

00002e7c <.LVL3>:
    2e7c:	0d 4c       	mov	r12,	r13	;

00002e7e <.L5>:
    2e7e:	07 48       	mov	r8,	r7	;
    2e80:	07 d9       	bis	r9,	r7	;
    2e82:	07 93       	cmp	#0,	r7	;r3 As==00
    2e84:	1a 20       	jnz	$+54     	;abs 0x2eba

00002e86 <.L6>:
    2e86:	81 93 0e 00 	cmp	#0,	14(r1)	;r3 As==00, 0x000e
    2e8a:	02 24       	jz	$+6      	;abs 0x2e90
    2e8c:	0c 4a       	mov	r10,	r12	;
    2e8e:	0d 4b       	mov	r11,	r13	;

00002e90 <.L1>:
    2e90:	30 40 a8 12 	br	#0x12a8		;

00002e94 <.L3>:
    2e94:	3d 53       	add	#-1,	r13	;r3 As==11

00002e96 <.Loc.38.1>:
    2e96:	0d 93       	cmp	#0,	r13	;r3 As==00
    2e98:	22 24       	jz	$+70     	;abs 0x2ede

00002e9a <.Loc.38.1>:
    2e9a:	0f 93       	cmp	#0,	r15	;r3 As==00
    2e9c:	ee 3b       	jl	$-34     	;abs 0x2e7a

00002e9e <.Loc.40.1>:
    2e9e:	05 4e       	mov	r14,	r5	;
    2ea0:	06 4f       	mov	r15,	r6	;
    2ea2:	05 5e       	add	r14,	r5	;
    2ea4:	06 6f       	addc	r15,	r6	;
    2ea6:	0e 45       	mov	r5,	r14	;

00002ea8 <.LVL7>:
    2ea8:	0f 46       	mov	r6,	r15	;

00002eaa <.LVL8>:
    2eaa:	05 48       	mov	r8,	r5	;
    2eac:	06 49       	mov	r9,	r6	;
    2eae:	05 58       	add	r8,	r5	;
    2eb0:	06 69       	addc	r9,	r6	;
    2eb2:	08 45       	mov	r5,	r8	;

00002eb4 <.LVL9>:
    2eb4:	09 46       	mov	r6,	r9	;

00002eb6 <.LVL10>:
    2eb6:	30 40 6e 2e 	br	#0x2e6e		;

00002eba <.L12>:
    2eba:	0b 9f       	cmp	r15,	r11	;
    2ebc:	08 28       	jnc	$+18     	;abs 0x2ece
    2ebe:	0f 9b       	cmp	r11,	r15	;
    2ec0:	02 20       	jnz	$+6      	;abs 0x2ec6
    2ec2:	0a 9e       	cmp	r14,	r10	;
    2ec4:	04 28       	jnc	$+10     	;abs 0x2ece

00002ec6 <.L16>:
    2ec6:	0a 8e       	sub	r14,	r10	;
    2ec8:	0b 7f       	subc	r15,	r11	;

00002eca <.Loc.48.1>:
    2eca:	0c d8       	bis	r8,	r12	;

00002ecc <.LVL13>:
    2ecc:	0d d9       	bis	r9,	r13	;

00002ece <.L10>:
    2ece:	12 c3       	clrc			
    2ed0:	09 10       	rrc	r9		;
    2ed2:	08 10       	rrc	r8		;

00002ed4 <.Loc.51.1>:
    2ed4:	12 c3       	clrc			
    2ed6:	0f 10       	rrc	r15		;
    2ed8:	0e 10       	rrc	r14		;
    2eda:	30 40 7e 2e 	br	#0x2e7e		;

00002ede <.L14>:
    2ede:	0c 4d       	mov	r13,	r12	;

00002ee0 <.LVL18>:
    2ee0:	30 40 86 2e 	br	#0x2e86		;

00002ee4 <__mspabi_divlu>:
    2ee4:	21 83       	decd	r1		;

00002ee6 <.LCFI19>:
    2ee6:	81 43 00 00 	mov	#0,	0(r1)	;r3 As==00
    2eea:	b0 12 54 2e 	call	#11860		;#0x2e54

00002eee <.LVL46>:
    2eee:	21 53       	incd	r1		;
    2ef0:	30 41       	ret			

00002ef2 <__mspabi_remul>:
    2ef2:	21 83       	decd	r1		;

00002ef4 <.LCFI20>:
    2ef4:	91 43 00 00 	mov	#1,	0(r1)	;r3 As==01
    2ef8:	b0 12 54 2e 	call	#11860		;#0x2e54

00002efc <.LVL48>:
    2efc:	21 53       	incd	r1		;
    2efe:	30 41       	ret			

00002f00 <_exit>:
    2f00:	30 40 00 2f 	br	#0x2f00		;

00002f04 <_isatty>:
    2f04:	1c 43       	mov	#1,	r12	;r3 As==01

00002f06 <.Loc.59.1>:
    2f06:	30 41       	ret			

00002f08 <getpid>:
    2f08:	3c 40 2a 00 	mov	#42,	r12	;#0x002a

00002f0c <.Loc.65.1>:
    2f0c:	30 41       	ret			

00002f0e <close>:
    2f0e:	b0 12 74 30 	call	#12404		;#0x3074
    2f12:	bc 40 58 00 	mov	#88,	0(r12)	;#0x0058
    2f16:	00 00 
    2f18:	3c 43       	mov	#-1,	r12	;r3 As==11
    2f1a:	30 41       	ret			

00002f1c <read>:
    2f1c:	b0 12 74 30 	call	#12404		;#0x3074
    2f20:	bc 40 58 00 	mov	#88,	0(r12)	;#0x0058
    2f24:	00 00 
    2f26:	3c 43       	mov	#-1,	r12	;r3 As==11
    2f28:	30 41       	ret			

00002f2a <fstat>:
    2f2a:	b0 12 74 30 	call	#12404		;#0x3074
    2f2e:	bc 40 58 00 	mov	#88,	0(r12)	;#0x0058
    2f32:	00 00 
    2f34:	3c 43       	mov	#-1,	r12	;r3 As==11
    2f36:	30 41       	ret			

00002f38 <lseek>:
    2f38:	b0 12 74 30 	call	#12404		;#0x3074
    2f3c:	bc 40 58 00 	mov	#88,	0(r12)	;#0x0058
    2f40:	00 00 
    2f42:	3c 43       	mov	#-1,	r12	;r3 As==11
    2f44:	30 41       	ret			

00002f46 <kill>:
    2f46:	b0 12 74 30 	call	#12404		;#0x3074
    2f4a:	bc 40 58 00 	mov	#88,	0(r12)	;#0x0058
    2f4e:	00 00 
    2f50:	3c 43       	mov	#-1,	r12	;r3 As==11
    2f52:	30 41       	ret			

00002f54 <write>:
    2f54:	0a 12       	push	r10		;

00002f56 <.LCFI0>:
    2f56:	09 12       	push	r9		;

00002f58 <.LCFI1>:
    2f58:	08 12       	push	r8		;

00002f5a <.LCFI2>:
    2f5a:	07 12       	push	r7		;

00002f5c <.LCFI3>:
    2f5c:	06 12       	push	r6		;

00002f5e <.LCFI4>:
    2f5e:	05 12       	push	r5		;

00002f60 <.LCFI5>:
    2f60:	04 12       	push	r4		;

00002f62 <.LCFI6>:
    2f62:	21 83       	decd	r1		;

00002f64 <.LCFI7>:
    2f64:	81 4c 00 00 	mov	r12,	0(r1)	;
    2f68:	0a 4d       	mov	r13,	r10	;
    2f6a:	04 4e       	mov	r14,	r4	;

00002f6c <.LBB5>:
    2f6c:	b0 12 22 31 	call	#12578		;#0x3122

00002f70 <.LVL2>:
    2f70:	49 4c       	mov.b	r12,	r9	;

00002f72 <.LBE5>:
    2f72:	4c 43       	clr.b	r12		;

00002f74 <.LBB14>:
    2f74:	77 40 40 00 	mov.b	#64,	r7	;#0x0040

00002f78 <.LBB11>:
    2f78:	35 40 a8 80 	mov	#32936,	r5	;#0x80a8

00002f7c <.Loc.28.1>:
    2f7c:	06 45       	mov	r5,	r6	;
    2f7e:	36 50 0b 00 	add	#11,	r6	;#0x000b

00002f82 <.L2>:
    2f82:	4d 43       	clr.b	r13		;
    2f84:	0d 94       	cmp	r4,	r13	;
    2f86:	03 38       	jl	$+8      	;abs 0x2f8e

00002f88 <.Loc.59.1>:
    2f88:	21 53       	incd	r1		;

00002f8a <.LVL4>:
    2f8a:	30 40 a6 12 	br	#0x12a6		;

00002f8e <.L4>:
    2f8e:	08 44       	mov	r4,	r8	;
    2f90:	7c 40 40 00 	mov.b	#64,	r12	;#0x0040

00002f94 <.LVL6>:
    2f94:	0c 94       	cmp	r4,	r12	;
    2f96:	01 34       	jge	$+4      	;abs 0x2f9a
    2f98:	08 47       	mov	r7,	r8	;

00002f9a <.L3>:
    2f9a:	4c 48       	mov.b	r8,	r12	;
    2f9c:	c5 4c 00 00 	mov.b	r12,	0(r5)	;

00002fa0 <.Loc.22.1>:
    2fa0:	c2 43 a9 80 	mov.b	#0,	&0x80a9	;r3 As==00

00002fa4 <.Loc.23.1>:
    2fa4:	f2 40 f3 ff 	mov.b	#65523,	&0x80aa	;#0xfff3
    2fa8:	aa 80 

00002faa <.Loc.24.1>:
    2faa:	2d 41       	mov	@r1,	r13	;
    2fac:	c5 4d 03 00 	mov.b	r13,	3(r5)	;

00002fb0 <.Loc.25.1>:
    2fb0:	c5 49 04 00 	mov.b	r9,	4(r5)	;

00002fb4 <.Loc.26.1>:
    2fb4:	c5 4c 05 00 	mov.b	r12,	5(r5)	;

00002fb8 <.Loc.27.1>:
    2fb8:	c2 43 ae 80 	mov.b	#0,	&0x80ae	;r3 As==00

00002fbc <.Loc.28.1>:
    2fbc:	0e 48       	mov	r8,	r14	;
    2fbe:	0d 4a       	mov	r10,	r13	;
    2fc0:	0c 46       	mov	r6,	r12	;
    2fc2:	b0 12 86 1a 	call	#6790		;#0x1a86

00002fc6 <.LVL8>:
    2fc6:	b0 12 1c 30 	call	#12316		;#0x301c

00002fca <.LBE12>:
    2fca:	04 88       	sub	r8,	r4	;

00002fcc <.Loc.56.1>:
    2fcc:	0a 58       	add	r8,	r10	;

00002fce <.LBB13>:
    2fce:	5c 45 03 00 	mov.b	3(r5),	r12	;
    2fd2:	0c 5c       	rla	r12		;
    2fd4:	0c 5c       	rla	r12		;
    2fd6:	0c 5c       	rla	r12		;
    2fd8:	0c 5c       	rla	r12		;
    2fda:	0c 5c       	rla	r12		;
    2fdc:	0c 5c       	rla	r12		;
    2fde:	0c 5c       	rla	r12		;
    2fe0:	0c 5c       	rla	r12		;
    2fe2:	5d 45 02 00 	mov.b	2(r5),	r13	;
    2fe6:	0c 5d       	add	r13,	r12	;
    2fe8:	30 40 82 2f 	br	#0x2f82		;

00002fec <_sbrk>:
    2fec:	21 83       	decd	r1		;

00002fee <.LCFI0>:
    2fee:	1d 42 a6 80 	mov	&0x80a6,r13	;0x80a6

00002ff2 <.LVL1>:
    2ff2:	4e 43       	clr.b	r14		;
    2ff4:	0e 51       	add	r1,	r14	;
    2ff6:	81 4e 00 00 	mov	r14,	0(r1)	;

00002ffa <.Loc.22.1>:
    2ffa:	0c 5d       	add	r13,	r12	;

00002ffc <.LVL2>:
    2ffc:	01 9c       	cmp	r12,	r1	;
    2ffe:	09 2c       	jc	$+20     	;abs 0x3012

00003000 <.LBB7>:
    3000:	7e 40 1a 00 	mov.b	#26,	r14	;#0x001a
    3004:	3d 40 a1 37 	mov	#14241,	r13	;#0x37a1

00003008 <.LVL4>:
    3008:	5c 43       	mov.b	#1,	r12	;r3 As==01
    300a:	b0 12 54 2f 	call	#12116		;#0x2f54

0000300e <.LVL5>:
    300e:	b0 12 66 30 	call	#12390		;#0x3066

00003012 <.L2>:
    3012:	82 4c a6 80 	mov	r12,	&0x80a6	;

00003016 <.Loc.31.1>:
    3016:	0c 4d       	mov	r13,	r12	;
    3018:	21 53       	incd	r1		;
    301a:	30 41       	ret			

0000301c <C$$IO$$>:
    301c:	03 43       	nop			

0000301e <.Loc.33.1>:
    301e:	30 41       	ret			

00003020 <__mspabi_mpyi>:
    3020:	0d 93       	cmp	#0,	r13	;r3 As==00
    3022:	0d 34       	jge	$+28     	;abs 0x303e

00003024 <.Loc.13.2>:
    3024:	4e 43       	clr.b	r14		;
    3026:	0e 8d       	sub	r13,	r14	;
    3028:	0d 4e       	mov	r14,	r13	;

0000302a <.LVL11>:
    302a:	5b 43       	mov.b	#1,	r11	;r3 As==01

0000302c <.L12>:
    302c:	7f 40 11 00 	mov.b	#17,	r15	;#0x0011

00003030 <.Loc.9.2>:
    3030:	4e 43       	clr.b	r14		;

00003032 <.L13>:
    3032:	0d 93       	cmp	#0,	r13	;r3 As==00
    3034:	07 20       	jnz	$+16     	;abs 0x3044

00003036 <.L19>:
    3036:	0b 93       	cmp	#0,	r11	;r3 As==00
    3038:	11 20       	jnz	$+36     	;abs 0x305c

0000303a <.L11>:
    303a:	0c 4e       	mov	r14,	r12	;
    303c:	30 41       	ret			

0000303e <.L20>:
    303e:	4b 43       	clr.b	r11		;
    3040:	30 40 2c 30 	br	#0x302c		;

00003044 <.L15>:
    3044:	7f 53       	add.b	#-1,	r15	;r3 As==11

00003046 <.LVL18>:
    3046:	3f f0 ff 00 	and	#255,	r15	;#0x00ff

0000304a <.Loc.17.2>:
    304a:	0f 93       	cmp	#0,	r15	;r3 As==00
    304c:	f4 27       	jz	$-22     	;abs 0x3036

0000304e <.Loc.19.2>:
    304e:	1d b3       	bit	#1,	r13	;r3 As==01
    3050:	01 24       	jz	$+4      	;abs 0x3054

00003052 <.Loc.20.2>:
    3052:	0e 5c       	add	r12,	r14	;

00003054 <.L14>:
    3054:	0c 5c       	rla	r12		;

00003056 <.Loc.22.2>:
    3056:	0d 11       	rra	r13		;
    3058:	30 40 32 30 	br	#0x3032		;

0000305c <.L16>:
    305c:	4c 43       	clr.b	r12		;

0000305e <.LVL22>:
    305e:	0c 8e       	sub	r14,	r12	;
    3060:	0e 4c       	mov	r12,	r14	;

00003062 <.LVL23>:
    3062:	30 40 3a 30 	br	#0x303a		;

00003066 <abort>:
    3066:	7c 40 06 00 	mov.b	#6,	r12	;
    306a:	b0 12 de 30 	call	#12510		;#0x30de

0000306e <.LVL0>:
    306e:	5c 43       	mov.b	#1,	r12	;r3 As==01
    3070:	b0 12 00 2f 	call	#12032		;#0x2f00

00003074 <__errno>:
    3074:	1c 42 08 80 	mov	&0x8008,r12	;0x8008
    3078:	30 41       	ret			

0000307a <_raise_r>:
    307a:	0a 12       	push	r10		;

0000307c <.LCFI4>:
    307c:	09 12       	push	r9		;

0000307e <.LCFI5>:
    307e:	09 4c       	mov	r12,	r9	;
    3080:	0a 4d       	mov	r13,	r10	;

00003082 <.Loc.151.1>:
    3082:	7c 40 1f 00 	mov.b	#31,	r12	;#0x001f

00003086 <.LVL15>:
    3086:	0c 9d       	cmp	r13,	r12	;
    3088:	06 2c       	jc	$+14     	;abs 0x3096

0000308a <.Loc.153.1>:
    308a:	b9 40 16 00 	mov	#22,	0(r9)	;#0x0016
    308e:	00 00 

00003090 <.Loc.154.1>:
    3090:	3c 43       	mov	#-1,	r12	;r3 As==11

00003092 <.L17>:
    3092:	30 40 b0 12 	br	#0x12b0		;

00003096 <.L18>:
    3096:	1c 49 22 00 	mov	34(r9),	r12	;0x00022
    309a:	0c 93       	cmp	#0,	r12	;r3 As==00
    309c:	05 24       	jz	$+12     	;abs 0x30a8

0000309e <.Loc.160.1>:
    309e:	0d 5d       	rla	r13		;
    30a0:	0c 5d       	add	r13,	r12	;
    30a2:	2d 4c       	mov	@r12,	r13	;

000030a4 <.LVL17>:
    30a4:	0d 93       	cmp	#0,	r13	;r3 As==00
    30a6:	0a 20       	jnz	$+22     	;abs 0x30bc

000030a8 <.L20>:
    30a8:	0c 49       	mov	r9,	r12	;
    30aa:	b0 12 0e 31 	call	#12558		;#0x310e

000030ae <.LVL19>:
    30ae:	0e 4a       	mov	r10,	r14	;
    30b0:	0d 4c       	mov	r12,	r13	;
    30b2:	0c 49       	mov	r9,	r12	;
    30b4:	b0 12 ea 30 	call	#12522		;#0x30ea

000030b8 <.LVL20>:
    30b8:	30 40 92 30 	br	#0x3092		;

000030bc <.L21>:
    30bc:	1d 93       	cmp	#1,	r13	;r3 As==01
    30be:	0c 24       	jz	$+26     	;abs 0x30d8

000030c0 <.Loc.166.1>:
    30c0:	3d 93       	cmp	#-1,	r13	;r3 As==11
    30c2:	06 20       	jnz	$+14     	;abs 0x30d0

000030c4 <.Loc.168.1>:
    30c4:	b9 40 16 00 	mov	#22,	0(r9)	;#0x0016
    30c8:	00 00 

000030ca <.Loc.169.1>:
    30ca:	5c 43       	mov.b	#1,	r12	;r3 As==01
    30cc:	30 40 92 30 	br	#0x3092		;

000030d0 <.L22>:
    30d0:	8c 43 00 00 	mov	#0,	0(r12)	;r3 As==00

000030d4 <.Loc.174.1>:
    30d4:	0c 4a       	mov	r10,	r12	;
    30d6:	8d 12       	call	r13		;

000030d8 <.L23>:
    30d8:	4c 43       	clr.b	r12		;
    30da:	30 40 92 30 	br	#0x3092		;

000030de <raise>:
    30de:	0d 4c       	mov	r12,	r13	;
    30e0:	1c 42 08 80 	mov	&0x8008,r12	;0x8008

000030e4 <.LVL33>:
    30e4:	b0 12 7a 30 	call	#12410		;#0x307a

000030e8 <.LVL34>:
    30e8:	30 41       	ret			

000030ea <_kill_r>:
    30ea:	0a 12       	push	r10		;

000030ec <.LCFI0>:
    30ec:	0a 4c       	mov	r12,	r10	;
    30ee:	0c 4d       	mov	r13,	r12	;

000030f0 <.LVL1>:
    30f0:	82 43 24 81 	mov	#0,	&0x8124	;r3 As==00

000030f4 <.Loc.61.1>:
    30f4:	0d 4e       	mov	r14,	r13	;

000030f6 <.LVL2>:
    30f6:	b0 12 46 2f 	call	#12102		;#0x2f46

000030fa <.LVL3>:
    30fa:	3c 93       	cmp	#-1,	r12	;r3 As==11
    30fc:	06 20       	jnz	$+14     	;abs 0x310a

000030fe <.Loc.61.1>:
    30fe:	1d 42 24 81 	mov	&0x8124,r13	;0x8124
    3102:	0d 93       	cmp	#0,	r13	;r3 As==00
    3104:	02 24       	jz	$+6      	;abs 0x310a

00003106 <.Loc.62.1>:
    3106:	8a 4d 00 00 	mov	r13,	0(r10)	;

0000310a <.L1>:
    310a:	3a 41       	pop	r10		;

0000310c <.LVL4>:
    310c:	30 41       	ret			

0000310e <_getpid_r>:
    310e:	b0 12 08 2f 	call	#12040		;#0x2f08

00003112 <.LVL6>:
    3112:	30 41       	ret			

00003114 <__mspabi_srai_15>:
    3114:	0c 11       	rra	r12		;

00003116 <__mspabi_srai_14>:
    3116:	0c 11       	rra	r12		;

00003118 <__mspabi_srai_13>:
    3118:	0c 11       	rra	r12		;

0000311a <__mspabi_srai_12>:
    311a:	0c 11       	rra	r12		;

0000311c <__mspabi_srai_11>:
    311c:	0c 11       	rra	r12		;

0000311e <__mspabi_srai_10>:
    311e:	0c 11       	rra	r12		;

00003120 <__mspabi_srai_9>:
    3120:	0c 11       	rra	r12		;

00003122 <__mspabi_srai_8>:
    3122:	0c 11       	rra	r12		;

00003124 <__mspabi_srai_7>:
    3124:	0c 11       	rra	r12		;

00003126 <__mspabi_srai_6>:
    3126:	0c 11       	rra	r12		;

00003128 <__mspabi_srai_5>:
    3128:	0c 11       	rra	r12		;

0000312a <__mspabi_srai_4>:
    312a:	0c 11       	rra	r12		;

0000312c <__mspabi_srai_3>:
    312c:	0c 11       	rra	r12		;

0000312e <__mspabi_srai_2>:
    312e:	0c 11       	rra	r12		;

00003130 <__mspabi_srai_1>:
    3130:	0c 11       	rra	r12		;
    3132:	30 41       	ret			

00003134 <.L11>:
    3134:	3d 53       	add	#-1,	r13	;r3 As==11
    3136:	0c 11       	rra	r12		;

00003138 <__mspabi_srai>:
    3138:	0d 93       	cmp	#0,	r13	;r3 As==00
    313a:	fc 23       	jnz	$-6      	;abs 0x3134
    313c:	30 41       	ret			

0000313e <__mspabi_sral_15>:
    313e:	0d 11       	rra	r13		;
    3140:	0c 10       	rrc	r12		;

00003142 <__mspabi_sral_14>:
    3142:	0d 11       	rra	r13		;
    3144:	0c 10       	rrc	r12		;

00003146 <__mspabi_sral_13>:
    3146:	0d 11       	rra	r13		;
    3148:	0c 10       	rrc	r12		;

0000314a <__mspabi_sral_12>:
    314a:	0d 11       	rra	r13		;
    314c:	0c 10       	rrc	r12		;

0000314e <__mspabi_sral_11>:
    314e:	0d 11       	rra	r13		;
    3150:	0c 10       	rrc	r12		;

00003152 <__mspabi_sral_10>:
    3152:	0d 11       	rra	r13		;
    3154:	0c 10       	rrc	r12		;

00003156 <__mspabi_sral_9>:
    3156:	0d 11       	rra	r13		;
    3158:	0c 10       	rrc	r12		;

0000315a <__mspabi_sral_8>:
    315a:	0d 11       	rra	r13		;
    315c:	0c 10       	rrc	r12		;

0000315e <__mspabi_sral_7>:
    315e:	0d 11       	rra	r13		;
    3160:	0c 10       	rrc	r12		;

00003162 <__mspabi_sral_6>:
    3162:	0d 11       	rra	r13		;
    3164:	0c 10       	rrc	r12		;

00003166 <__mspabi_sral_5>:
    3166:	0d 11       	rra	r13		;
    3168:	0c 10       	rrc	r12		;

0000316a <__mspabi_sral_4>:
    316a:	0d 11       	rra	r13		;
    316c:	0c 10       	rrc	r12		;

0000316e <__mspabi_sral_3>:
    316e:	0d 11       	rra	r13		;
    3170:	0c 10       	rrc	r12		;

00003172 <__mspabi_sral_2>:
    3172:	0d 11       	rra	r13		;
    3174:	0c 10       	rrc	r12		;

00003176 <__mspabi_sral_1>:
    3176:	0d 11       	rra	r13		;
    3178:	0c 10       	rrc	r12		;
    317a:	30 41       	ret			

0000317c <.L12>:
    317c:	3e 53       	add	#-1,	r14	;r3 As==11
    317e:	0d 11       	rra	r13		;
    3180:	0c 10       	rrc	r12		;

00003182 <__mspabi_sral>:
    3182:	0e 93       	cmp	#0,	r14	;r3 As==00
    3184:	fb 23       	jnz	$-8      	;abs 0x317c
    3186:	30 41       	ret			

Disassembly of section .rodata:

00003188 <__sf_fake_stderr-0x5ac>:
    3188:	08 20       	jnz	$+18     	;abs 0x319a
    318a:	08 00       	mova	@r0,	r8	;
    318c:	0a 2d       	jc	$+534    	;abs 0x33a2
    318e:	2d 2d       	jc	$+604    	;abs 0x33ea
    3190:	2d 2d       	jc	$+604    	;abs 0x33ec
    3192:	2d 2d       	jc	$+604    	;abs 0x33ee
    3194:	2d 2d       	jc	$+604    	;abs 0x33f0
    3196:	2d 2d       	jc	$+604    	;abs 0x33f2
    3198:	2d 2d       	jc	$+604    	;abs 0x33f4
    319a:	2d 2d       	jc	$+604    	;abs 0x33f6
    319c:	2d 2d       	jc	$+604    	;abs 0x33f8
    319e:	2d 2d       	jc	$+604    	;abs 0x33fa
    31a0:	2d 2d       	jc	$+604    	;abs 0x33fc
    31a2:	2d 2d       	jc	$+604    	;abs 0x33fe
    31a4:	2d 2d       	jc	$+604    	;abs 0x3400
    31a6:	2d 2d       	jc	$+604    	;abs 0x3402
    31a8:	2d 2d       	jc	$+604    	;abs 0x3404
    31aa:	2d 2d       	jc	$+604    	;abs 0x3406
    31ac:	2d 2d       	jc	$+604    	;abs 0x3408
    31ae:	2d 2d       	jc	$+604    	;abs 0x340a
    31b0:	2d 2d       	jc	$+604    	;abs 0x340c
    31b2:	2d 0a 2d 2d 	mova	&666925,r13	;0xa2d2d
    31b6:	2d 20       	jnz	$+92     	;abs 0x3212
    31b8:	49 32       	jn	$-876    	;abs 0x2e4c
    31ba:	43 20       	jnz	$+136    	;abs 0x3242
    31bc:	57 69 73 68 	addc.b	26739(r9),r7	;0x06873
    31c0:	62 6f       	addc.b	@r15,	r2	;
    31c2:	6e 65       	addc.b	@r5,	r14	;
    31c4:	20 45       	br	@r5		;
    31c6:	78 70 6c 6f 	subc.b	#28524,	r8	;#0x6f6c
    31ca:	72 65       	addc.b	@r5+,	r2	;
    31cc:	72 20       	jnz	$+230    	;abs 0x32b2
    31ce:	54 65 72 6d 	addc.b	28018(r5),r4	;0x06d72
    31d2:	69 6e       	addc.b	@r14,	r9	;
    31d4:	61 6c       	addc.b	@r12,	r1	;
    31d6:	20 2d       	jc	$+578    	;abs 0x3418
    31d8:	2d 0a 2d 2d 	mova	&666925,r13	;0xa2d2d
    31dc:	2d 2d       	jc	$+604    	;abs 0x3438
    31de:	2d 2d       	jc	$+604    	;abs 0x343a
    31e0:	2d 2d       	jc	$+604    	;abs 0x343c
    31e2:	2d 2d       	jc	$+604    	;abs 0x343e
    31e4:	2d 2d       	jc	$+604    	;abs 0x3440
    31e6:	2d 2d       	jc	$+604    	;abs 0x3442
    31e8:	2d 2d       	jc	$+604    	;abs 0x3444
    31ea:	2d 2d       	jc	$+604    	;abs 0x3446
    31ec:	2d 2d       	jc	$+604    	;abs 0x3448
    31ee:	2d 2d       	jc	$+604    	;abs 0x344a
    31f0:	2d 2d       	jc	$+604    	;abs 0x344c
    31f2:	2d 2d       	jc	$+604    	;abs 0x344e
    31f4:	2d 2d       	jc	$+604    	;abs 0x3450
    31f6:	2d 2d       	jc	$+604    	;abs 0x3452
    31f8:	2d 2d       	jc	$+604    	;abs 0x3454
    31fa:	2d 2d       	jc	$+604    	;abs 0x3456
    31fc:	2d 2d       	jc	$+604    	;abs 0x3458
    31fe:	2d 2d       	jc	$+604    	;abs 0x345a
    3200:	0a 0a       	mova	@r10,	r10	;
    3202:	00 45       	br	r5		;
    3204:	72 72       	subc.b	#8,	r2	;r2 As==11
    3206:	6f 72       	subc.b	#4,	r15	;r2 As==10
    3208:	21 20       	jnz	$+68     	;abs 0x324c
    320a:	4e 6f       	addc.b	r15,	r14	;
    320c:	20 57       	add	@r7,	r0	;
    320e:	69 73       	subc.b	#2,	r9	;r3 As==10
    3210:	68 62       	addc.b	#4,	r8	;r2 As==10
    3212:	6f 6e       	addc.b	@r14,	r15	;
    3214:	65 20       	jnz	$+204    	;abs 0x32e0
    3216:	61 64       	addc.b	@r4,	r1	;
    3218:	61 70       	subc.b	@r0,	r1	;
    321a:	74 65       	addc.b	@r5+,	r4	;
    321c:	72 20       	jnz	$+230    	;abs 0x3302
    321e:	73 79       	.word	0x7973;	????
    3220:	6e 74       	subc.b	@r4,	r14	;
    3222:	68 65       	addc.b	@r5,	r8	;
    3224:	73 69       	.word	0x6973;	????
    3226:	7a 65       	addc.b	@r5+,	r10	;
    3228:	64 21       	jnz	$+714    	;abs 0x34f2
    322a:	00 53       	add	#0,	r0	;r3 As==00
    322c:	65 74       	subc.b	@r4,	r5	;
    322e:	74 69       	addc.b	@r9+,	r4	;
    3230:	6e 67       	addc.b	@r7,	r14	;
    3232:	20 75       	subc	@r5,	r0	;
    3234:	70 20       	jnz	$+226    	;abs 0x3316
    3236:	49 32       	jn	$-876    	;abs 0x2eca
    3238:	43 20       	jnz	$+136    	;abs 0x32c0
    323a:	63 6f       	.word	0x6f63;	????
    323c:	72 65       	addc.b	@r5+,	r2	;
    323e:	00 0a       	bra	@r10		;
    3240:	53 65       	.word	0x6553;	????
    3242:	74 75       	subc.b	@r5+,	r4	;
    3244:	70 20       	jnz	$+226    	;abs 0x3326
    3246:	64 6f       	addc.b	@r15,	r4	;
    3248:	6e 65       	addc.b	@r5,	r14	;
    324a:	2e 0a 00 0a 	mova	&657920,r14	;0xa0a00
    324e:	45 6e       	addc.b	r14,	r5	;
    3250:	74 65       	addc.b	@r5+,	r4	;
    3252:	72 20       	jnz	$+230    	;abs 0x3338
    3254:	61 20       	jnz	$+196    	;abs 0x3318
    3256:	63 6f       	.word	0x6f63;	????
    3258:	6d 6d       	addc.b	@r13,	r13	;
    325a:	61 6e       	addc.b	@r14,	r1	;
    325c:	64 3a       	jl	$-822    	;abs 0x2f26
    325e:	3e 20       	jnz	$+126    	;abs 0x32dc
    3260:	00 0a       	bra	@r10		;
    3262:	00 68       	addc	r8,	r0	;
    3264:	65 6c       	addc.b	@r12,	r5	;
    3266:	70 00 65 6e 	mova	r0,	28261(r0); PC rel. 0x0a0cd
    326a:	61 62       	addc.b	#4,	r1	;r2 As==10
    326c:	6c 65       	addc.b	@r5,	r12	;
    326e:	00 69       	addc	r9,	r0	;
    3270:	64 00 77 70 	mova	r0,	&290935	; 0x47077
    3274:	72 6f       	addc.b	@r15+,	r2	;
    3276:	6d 5f       	add.b	@r15,	r13	;
    3278:	69 70       	subc.b	@r0,	r9	;
    327a:	00 72       	subc	r2,	r0	;
    327c:	70 72       	subc.b	#8,	r0	;r2 As==11
    327e:	6f 6d       	addc.b	@r13,	r15	;
    3280:	5f 69 70 00 	addc.b	112(r9),r15	;0x00070
    3284:	77 70 72 6f 	subc.b	#28530,	r7	;#0x6f72
    3288:	6d 5f       	add.b	@r15,	r13	;
    328a:	6d 61       	addc.b	@r1,	r13	;
    328c:	63 00 72 70 	mova	r0,	&225394	; 0x37072
    3290:	72 6f       	addc.b	@r15+,	r2	;
    3292:	6d 5f       	add.b	@r15,	r13	;
    3294:	6d 61       	addc.b	@r1,	r13	;
    3296:	63 00 77 62 	mova	r0,	&221815	; 0x36277
    329a:	75 73       	subc.b	#-1,	r5	;r3 As==11
    329c:	5f 69 70 00 	addc.b	112(r9),r15	;0x00070
    32a0:	72 62       	addc.b	#8,	r2	;r2 As==11
    32a2:	75 73       	subc.b	#-1,	r5	;r3 As==11
    32a4:	5f 69 70 00 	addc.b	112(r9),r15	;0x00070
    32a8:	72 62       	addc.b	#8,	r2	;r2 As==11
    32aa:	75 73       	subc.b	#-1,	r5	;r3 As==11
    32ac:	5f 6d 61 63 	addc.b	25441(r13),r15	;0x06361
    32b0:	00 72       	subc	r2,	r0	;
    32b2:	65 73       	subc.b	#2,	r5	;r3 As==10
    32b4:	65 74       	subc.b	@r4,	r5	;
    32b6:	00 41       	br	r1		;
    32b8:	76 61       	addc.b	@r1+,	r6	;
    32ba:	69 6c       	addc.b	@r12,	r9	;
    32bc:	61 62       	addc.b	#4,	r1	;r2 As==10
    32be:	6c 65       	addc.b	@r5,	r12	;
    32c0:	20 63       	addc	#2,	r0	;r3 As==10
    32c2:	6f 6d       	addc.b	@r13,	r15	;
    32c4:	6d 61       	addc.b	@r1,	r13	;
    32c6:	6e 64       	addc.b	@r4,	r14	;
    32c8:	73 3a       	jl	$-792    	;abs 0x2fb0
    32ca:	0a 20       	jnz	$+22     	;abs 0x32e0
    32cc:	68 65       	addc.b	@r5,	r8	;
    32ce:	6c 70       	subc.b	@r0,	r12	;
    32d0:	20 20       	jnz	$+66     	;abs 0x3312
    32d2:	20 20       	jnz	$+66     	;abs 0x3314
    32d4:	20 20       	jnz	$+66     	;abs 0x3316
    32d6:	20 20       	jnz	$+66     	;abs 0x3318
    32d8:	2d 20       	jnz	$+92     	;abs 0x3334
    32da:	73 68       	.word	0x6873;	????
    32dc:	6f 77       	subc.b	@r7,	r15	;
    32de:	20 74       	subc	@r4,	r0	;
    32e0:	68 69       	addc.b	@r9,	r8	;
    32e2:	73 20       	jnz	$+232    	;abs 0x33ca
    32e4:	74 65       	addc.b	@r5+,	r4	;
    32e6:	78 74       	subc.b	@r4+,	r8	;
    32e8:	0a 20       	jnz	$+22     	;abs 0x32fe
    32ea:	65 6e       	addc.b	@r14,	r5	;
    32ec:	61 62       	addc.b	#4,	r1	;r2 As==10
    32ee:	6c 65       	addc.b	@r5,	r12	;
    32f0:	20 20       	jnz	$+66     	;abs 0x3332
    32f2:	20 20       	jnz	$+66     	;abs 0x3334
    32f4:	20 20       	jnz	$+66     	;abs 0x3336
    32f6:	2d 20       	jnz	$+92     	;abs 0x3352
    32f8:	65 6e       	addc.b	@r14,	r5	;
    32fa:	61 62       	addc.b	#4,	r1	;r2 As==10
    32fc:	6c 65       	addc.b	@r5,	r12	;
    32fe:	20 49       	br	@r9		;
    3300:	32 43       	mov	#-1,	r2	;r3 As==11
    3302:	20 62       	addc	#4,	r0	;r2 As==10
    3304:	72 69       	addc.b	@r9+,	r2	;
    3306:	64 67       	addc.b	@r7,	r4	;
    3308:	65 20       	jnz	$+204    	;abs 0x33d4
    330a:	6f 6e       	addc.b	@r14,	r15	;
    330c:	20 45       	br	@r5		;
    330e:	6e 63       	addc.b	#2,	r14	;r3 As==10
    3310:	6c 75       	subc.b	@r5,	r12	;
    3312:	73 74       	.word	0x7473;	????
    3314:	72 61       	addc.b	@r1+,	r2	;
    3316:	0a 20       	jnz	$+22     	;abs 0x332c
    3318:	69 64       	addc.b	@r4,	r9	;
    331a:	20 20       	jnz	$+66     	;abs 0x335c
    331c:	20 20       	jnz	$+66     	;abs 0x335e
    331e:	20 20       	jnz	$+66     	;abs 0x3360
    3320:	20 20       	jnz	$+66     	;abs 0x3362
    3322:	20 20       	jnz	$+66     	;abs 0x3364
    3324:	2d 20       	jnz	$+92     	;abs 0x3380
    3326:	52 65 61 64 	addc.b	25697(r5),r2	;0x06461
    332a:	20 66       	addc	@r6,	r0	;
    332c:	72 6f       	addc.b	@r15+,	r2	;
    332e:	6d 20       	jnz	$+220    	;abs 0x340a
    3330:	45 32       	jn	$-884    	;abs 0x2fbc
    3332:	34 41       	pop	r4		;
    3334:	41 30       	jn	$+132    	;abs 0x33b8
    3336:	32 35       	jge	$+614    	;abs 0x359c
    3338:	45 34       	jge	$+140    	;abs 0x33c4
    333a:	38 54       	add	@r4+,	r8	;
    333c:	20 55       	add	@r5,	r0	;
    333e:	6e 69       	addc.b	@r9,	r14	;
    3340:	71 75       	subc.b	@r5+,	r1	;
    3342:	65 20       	jnz	$+204    	;abs 0x340e
    3344:	49 44       	mov.b	r4,	r9	;
    3346:	0a 20       	jnz	$+22     	;abs 0x335c
    3348:	77 70 72 6f 	subc.b	#28530,	r7	;#0x6f72
    334c:	6d 5f       	add.b	@r15,	r13	;
    334e:	69 70       	subc.b	@r0,	r9	;
    3350:	20 20       	jnz	$+66     	;abs 0x3392
    3352:	20 20       	jnz	$+66     	;abs 0x3394
    3354:	2d 20       	jnz	$+92     	;abs 0x33b0
    3356:	77 72       	subc.b	#8,	r7	;r2 As==11
    3358:	69 74       	subc.b	@r4,	r9	;
    335a:	65 20       	jnz	$+204    	;abs 0x3426
    335c:	38 20       	jnz	$+114    	;abs 0x33ce
    335e:	68 65       	addc.b	@r5,	r8	;
    3360:	78 20       	jnz	$+242    	;abs 0x3452
    3362:	63 68       	.word	0x6863;	????
    3364:	61 72       	subc.b	#4,	r1	;r2 As==10
    3366:	20 28       	jnc	$+66     	;abs 0x33a8
    3368:	33 32       	jn	$-920    	;abs 0x2fd0
    336a:	20 62       	addc	#4,	r0	;r2 As==10
    336c:	69 74       	subc.b	@r4,	r9	;
    336e:	29 20       	jnz	$+84     	;abs 0x33c2
    3370:	20 0a 20 72 	bra	&684576	;0xa7220
    3374:	70 72       	subc.b	#8,	r0	;r2 As==11
    3376:	6f 6d       	addc.b	@r13,	r15	;
    3378:	5f 69 70 20 	addc.b	8304(r9),r15	;0x02070
    337c:	20 20       	jnz	$+66     	;abs 0x33be
    337e:	20 20       	jnz	$+66     	;abs 0x33c0
    3380:	2d 20       	jnz	$+92     	;abs 0x33dc
    3382:	72 65       	addc.b	@r5+,	r2	;
    3384:	61 64       	addc.b	@r4,	r1	;
    3386:	20 49       	br	@r9		;
    3388:	50 20       	jnz	$+162    	;abs 0x342a
    338a:	61 64       	addc.b	@r4,	r1	;
    338c:	64 72       	subc.b	#4,	r4	;r2 As==10
    338e:	65 73       	subc.b	#2,	r5	;r3 As==10
    3390:	73 20       	jnz	$+232    	;abs 0x3478
    3392:	20 0a 77 70 	bra	&684151	;0xa7077
    3396:	72 6f       	addc.b	@r15+,	r2	;
    3398:	6d 5f       	add.b	@r15,	r13	;
    339a:	6d 61       	addc.b	@r1,	r13	;
    339c:	63 20       	jnz	$+200    	;abs 0x3464
    339e:	20 20       	jnz	$+66     	;abs 0x33e0
    33a0:	20 2d       	jc	$+578    	;abs 0x35e2
    33a2:	20 77       	subc	@r7,	r0	;
    33a4:	72 69       	addc.b	@r9+,	r2	;
    33a6:	74 65       	addc.b	@r5+,	r4	;
    33a8:	20 31       	jn	$+578    	;abs 0x35ea
    33aa:	32 20       	jnz	$+102    	;abs 0x3410
    33ac:	68 65       	addc.b	@r5,	r8	;
    33ae:	78 20       	jnz	$+242    	;abs 0x34a0
    33b0:	63 68       	.word	0x6863;	????
    33b2:	61 72       	subc.b	#4,	r1	;r2 As==10
    33b4:	20 28       	jnc	$+66     	;abs 0x33f6
    33b6:	34 38       	jl	$+106    	;abs 0x3420
    33b8:	20 62       	addc	#4,	r0	;r2 As==10
    33ba:	69 74       	subc.b	@r4,	r9	;
    33bc:	29 72       	subc	#4,	r9	;r2 As==10
    33be:	70 72       	subc.b	#8,	r0	;r2 As==11
    33c0:	6f 6d       	addc.b	@r13,	r15	;
    33c2:	5f 6d 61 63 	addc.b	25441(r13),r15	;0x06361
    33c6:	20 20       	jnz	$+66     	;abs 0x3408
    33c8:	20 20       	jnz	$+66     	;abs 0x340a
    33ca:	20 2d       	jc	$+578    	;abs 0x360c
    33cc:	20 72       	subc	#4,	r0	;r2 As==10
    33ce:	65 61       	addc.b	@r1,	r5	;
    33d0:	64 20       	jnz	$+202    	;abs 0x349a
    33d2:	6d 61       	addc.b	@r1,	r13	;
    33d4:	63 20       	jnz	$+200    	;abs 0x349c
    33d6:	61 64       	addc.b	@r4,	r1	;
    33d8:	64 72       	subc.b	#4,	r4	;r2 As==10
    33da:	65 73       	subc.b	#2,	r5	;r3 As==10
    33dc:	73 20       	jnz	$+232    	;abs 0x34c4
    33de:	77 62       	addc.b	#8,	r7	;r2 As==11
    33e0:	75 73       	subc.b	#-1,	r5	;r3 As==11
    33e2:	5f 69 70 20 	addc.b	8304(r9),r15	;0x02070
    33e6:	20 20       	jnz	$+66     	;abs 0x3428
    33e8:	2d 20       	jnz	$+92     	;abs 0x3444
    33ea:	77 72       	subc.b	#8,	r7	;r2 As==11
    33ec:	69 74       	subc.b	@r4,	r9	;
    33ee:	65 20       	jnz	$+204    	;abs 0x34ba
    33f0:	74 6f       	addc.b	@r15+,	r4	;
    33f2:	20 42       	br	#4		;r2 As==10
    33f4:	75 73       	subc.b	#-1,	r5	;r3 As==11
    33f6:	20 6d       	addc	@r13,	r0	;
    33f8:	65 6d       	addc.b	@r13,	r5	;
    33fa:	6f 72       	subc.b	#4,	r15	;r2 As==10
    33fc:	79 20       	jnz	$+244    	;abs 0x34f0
    33fe:	0a 20       	jnz	$+22     	;abs 0x3414
    3400:	72 62       	addc.b	#8,	r2	;r2 As==11
    3402:	75 73       	subc.b	#-1,	r5	;r3 As==11
    3404:	5f 69 70 20 	addc.b	8304(r9),r15	;0x02070
    3408:	20 20       	jnz	$+66     	;abs 0x344a
    340a:	20 2d       	jc	$+578    	;abs 0x364c
    340c:	20 72       	subc	#4,	r0	;r2 As==10
    340e:	65 61       	addc.b	@r1,	r5	;
    3410:	64 20       	jnz	$+202    	;abs 0x34da
    3412:	66 72       	subc.b	#4,	r6	;r2 As==10
    3414:	6f 6d       	addc.b	@r13,	r15	;
    3416:	20 42       	br	#4		;r2 As==10
    3418:	75 73       	subc.b	#-1,	r5	;r3 As==11
    341a:	20 6d       	addc	@r13,	r0	;
    341c:	65 6d       	addc.b	@r13,	r5	;
    341e:	6f 72       	subc.b	#4,	r15	;r2 As==10
    3420:	79 20       	jnz	$+244    	;abs 0x3514
    3422:	0a 20       	jnz	$+22     	;abs 0x3438
    3424:	77 62       	addc.b	#8,	r7	;r2 As==11
    3426:	75 73       	subc.b	#-1,	r5	;r3 As==11
    3428:	5f 6d 61 63 	addc.b	25441(r13),r15	;0x06361
    342c:	20 20       	jnz	$+66     	;abs 0x346e
    342e:	20 2d       	jc	$+578    	;abs 0x3670
    3430:	20 77       	subc	@r7,	r0	;
    3432:	72 69       	addc.b	@r9+,	r2	;
    3434:	74 65       	addc.b	@r5+,	r4	;
    3436:	20 74       	subc	@r4,	r0	;
    3438:	6f 20       	jnz	$+224    	;abs 0x3518
    343a:	42 75       	subc.b	r5,	r2	;
    343c:	73 20       	jnz	$+232    	;abs 0x3524
    343e:	6d 65       	addc.b	@r5,	r13	;
    3440:	6d 6f       	addc.b	@r15,	r13	;
    3442:	72 79       	subc.b	@r9+,	r2	;
    3444:	20 0a 20 72 	bra	&684576	;0xa7220
    3448:	62 75       	subc.b	@r5,	r2	;
    344a:	73 5f       	.word	0x5f73;	????
    344c:	6d 61       	addc.b	@r1,	r13	;
    344e:	63 20       	jnz	$+200    	;abs 0x3516
    3450:	20 20       	jnz	$+66     	;abs 0x3492
    3452:	20 2d       	jc	$+578    	;abs 0x3694
    3454:	20 72       	subc	#4,	r0	;r2 As==10
    3456:	65 61       	addc.b	@r1,	r5	;
    3458:	64 20       	jnz	$+202    	;abs 0x3522
    345a:	66 72       	subc.b	#4,	r6	;r2 As==10
    345c:	6f 6d       	addc.b	@r13,	r15	;
    345e:	20 42       	br	#4		;r2 As==10
    3460:	75 73       	subc.b	#-1,	r5	;r3 As==11
    3462:	20 6d       	addc	@r13,	r0	;
    3464:	65 6d       	addc.b	@r13,	r5	;
    3466:	6f 72       	subc.b	#4,	r15	;r2 As==10
    3468:	79 20       	jnz	$+244    	;abs 0x355c
    346a:	0a 20       	jnz	$+22     	;abs 0x3480
    346c:	72 65       	addc.b	@r5+,	r2	;
    346e:	73 65       	.word	0x6573;	????
    3470:	74 20       	jnz	$+234    	;abs 0x355a
    3472:	20 20       	jnz	$+66     	;abs 0x34b4
    3474:	20 20       	jnz	$+66     	;abs 0x34b6
    3476:	20 20       	jnz	$+66     	;abs 0x34b8
    3478:	2d 20       	jnz	$+92     	;abs 0x34d4
    347a:	72 65       	addc.b	@r5+,	r2	;
    347c:	73 65       	.word	0x6573;	????
    347e:	74 20       	jnz	$+234    	;abs 0x3568
    3480:	43 50       	.word	0x5043;	????
    3482:	55 0a       	rlam	#3,	r5	;
    3484:	00 0a       	bra	@r10		;
    3486:	45 6e       	addc.b	r14,	r5	;
    3488:	61 62       	addc.b	#4,	r1	;r2 As==10
    348a:	6c 69       	addc.b	@r9,	r12	;
    348c:	6e 67       	addc.b	@r7,	r14	;
    348e:	20 49       	br	@r9		;
    3490:	32 43       	mov	#-1,	r2	;r3 As==11
    3492:	20 62       	addc	#4,	r0	;r2 As==10
    3494:	72 69       	addc.b	@r9+,	r2	;
    3496:	64 67       	addc.b	@r7,	r4	;
    3498:	65 3a       	jl	$-820    	;abs 0x3164
    349a:	0a 00       	mova	@r0,	r10	;
    349c:	50 6f 73 74 	addc.b	29811(r15),r0	;0x07473
    34a0:	20 52       	add	#4,	r0	;r2 As==10
    34a2:	65 67       	addc.b	@r7,	r5	;
    34a4:	44 69       	addc.b	r9,	r4	;
    34a6:	72 3a       	jl	$-794    	;abs 0x318c
    34a8:	20 00 0a 55 	bra	&21770		;0x0550a
    34ac:	49 44       	mov.b	r4,	r9	;
    34ae:	20 66       	addc	@r6,	r0	;
    34b0:	72 6f       	addc.b	@r15+,	r2	;
    34b2:	6d 20       	jnz	$+220    	;abs 0x358e
    34b4:	45 32       	jn	$-884    	;abs 0x3140
    34b6:	34 41       	pop	r4		;
    34b8:	41 30       	jn	$+132    	;abs 0x353c
    34ba:	32 35       	jge	$+614    	;abs 0x3720
    34bc:	45 34       	jge	$+140    	;abs 0x3548
    34be:	38 54       	add	@r4+,	r8	;
    34c0:	20 3d       	jmp	$+578    	;abs 0x3702
    34c2:	20 00 45 6e 	bra	&28229		;0x06e45
    34c6:	74 65       	addc.b	@r5+,	r4	;
    34c8:	72 20       	jnz	$+230    	;abs 0x35ae
    34ca:	68 65       	addc.b	@r5,	r8	;
    34cc:	78 61       	addc.b	@r1+,	r8	;
    34ce:	64 65       	addc.b	@r5,	r4	;
    34d0:	63 69       	.word	0x6963;	????
    34d2:	6d 61       	addc.b	@r1,	r13	;
    34d4:	6c 20       	jnz	$+218    	;abs 0x35ae
    34d6:	64 61       	addc.b	@r1,	r4	;
    34d8:	74 61       	addc.b	@r1+,	r4	;
    34da:	20 74       	subc	@r4,	r0	;
    34dc:	6f 20       	jnz	$+224    	;abs 0x35bc
    34de:	77 72       	subc.b	#8,	r7	;r2 As==11
    34e0:	69 74       	subc.b	@r4,	r9	;
    34e2:	65 20       	jnz	$+204    	;abs 0x35ae
    34e4:	74 6f       	addc.b	@r15+,	r4	;
    34e6:	20 50       	add	@r0,	r0	;
    34e8:	52 4f 4d 3a 	mov.b	14925(r15),r2	;0x03a4d
    34ec:	20 30       	jn	$+66     	;abs 0x352e
    34ee:	78 00 0a 44 	mova	r0,	17418(r8); 0x0440a
    34f2:	61 74       	subc.b	@r4,	r1	;
    34f4:	61 20       	jnz	$+196    	;abs 0x35b8
    34f6:	66 72       	subc.b	#4,	r6	;r2 As==10
    34f8:	6f 6d       	addc.b	@r13,	r15	;
    34fa:	20 50       	add	@r0,	r0	;
    34fc:	52 4f 4d 20 	mov.b	8269(r15),r2	;0x0204d
    3500:	3d 20       	jnz	$+124    	;abs 0x357c
    3502:	00 0a       	bra	@r10		;
    3504:	49 50       	add.b	r0,	r9	;
    3506:	20 41       	br	@r1		;
    3508:	64 64       	addc.b	@r4,	r4	;
    350a:	72 65       	addc.b	@r5+,	r2	;
    350c:	73 73       	.word	0x7373;	????
    350e:	20 3d       	jmp	$+578    	;abs 0x3750
    3510:	20 31       	jn	$+578    	;abs 0x3752
    3512:	39 32       	jn	$-908    	;abs 0x3186
    3514:	2e 31       	jn	$+606    	;abs 0x3772
    3516:	36 38       	jl	$+110    	;abs 0x3584
    3518:	2e 00 2e 00 	mova	&46,	r14	;0x0002e
    351c:	20 00 0a 49 	bra	&18698		;0x0490a
    3520:	50 42 75 73 	br	&0x7375		;
    3524:	20 77       	subc	@r7,	r0	;
    3526:	72 69       	addc.b	@r9+,	r2	;
    3528:	74 65       	addc.b	@r5+,	r4	;
    352a:	20 66       	addc	@r6,	r0	;
    352c:	72 6f       	addc.b	@r15+,	r2	;
    352e:	6d 20       	jnz	$+220    	;abs 0x360a
    3530:	50 72 6f 6d 	subc.b	&0x6d6f,r0	;0x6d6f
    3534:	3a 20       	jnz	$+118    	;abs 0x35aa
    3536:	49 50       	add.b	r0,	r9	;
    3538:	20 41       	br	@r1		;
    353a:	64 64       	addc.b	@r4,	r4	;
    353c:	72 65       	addc.b	@r5+,	r2	;
    353e:	73 73       	.word	0x7373;	????
    3540:	00 0a       	bra	@r10		;
    3542:	20 45       	br	@r5		;
    3544:	6e 74       	subc.b	@r4,	r14	;
    3546:	65 72       	subc.b	#4,	r5	;r2 As==10
    3548:	20 68       	addc	@r8,	r0	;
    354a:	65 78       	subc.b	@r8,	r5	;
    354c:	61 64       	addc.b	@r4,	r1	;
    354e:	65 63       	addc.b	#2,	r5	;r3 As==10
    3550:	69 6d       	addc.b	@r13,	r9	;
    3552:	61 6c       	addc.b	@r12,	r1	;
    3554:	20 64       	addc	@r4,	r0	;
    3556:	61 74       	subc.b	@r4,	r1	;
    3558:	61 20       	jnz	$+196    	;abs 0x361c
    355a:	61 64       	addc.b	@r4,	r1	;
    355c:	64 72       	subc.b	#4,	r4	;r2 As==10
    355e:	65 73       	subc.b	#2,	r5	;r3 As==10
    3560:	73 20       	jnz	$+232    	;abs 0x3648
    3562:	6f 6e       	addc.b	@r14,	r15	;
    3564:	20 41       	br	@r1		;
    3566:	33 32       	jn	$-920    	;abs 0x31ce
    3568:	3a 20       	jnz	$+118    	;abs 0x35de
    356a:	30 78       	subc	@r8+,	r0	;
    356c:	00 0a       	bra	@r10		;
    356e:	20 49       	br	@r9		;
    3570:	6e 63       	addc.b	#2,	r14	;r3 As==10
    3572:	72 65       	addc.b	@r5+,	r2	;
    3574:	6d 65       	addc.b	@r5,	r13	;
    3576:	6e 74       	subc.b	@r4,	r14	;
    3578:	69 6e       	addc.b	@r14,	r9	;
    357a:	67 20       	jnz	$+208    	;abs 0x364a
    357c:	3f 20       	jnz	$+128    	;abs 0x35fc
    357e:	28 59       	add	@r9,	r8	;
    3580:	2f 4e       	mov	@r14,	r15	;
    3582:	29 00 59 00 	mova	&89,	r9	;0x00059
    3586:	0a 20       	jnz	$+22     	;abs 0x359c
    3588:	55 73       	subc.b	#1,	r5	;r3 As==01
    358a:	65 20       	jnz	$+204    	;abs 0x3656
    358c:	43 6f       	.word	0x6f43;	????
    358e:	6e 66       	addc.b	@r6,	r14	;
    3590:	69 67       	addc.b	@r7,	r9	;
    3592:	75 72       	subc.b	#8,	r5	;r2 As==11
    3594:	61 74       	subc.b	@r4,	r1	;
    3596:	69 6f       	addc.b	@r15,	r9	;
    3598:	6e 20       	jnz	$+222    	;abs 0x3676
    359a:	53 70       	.word	0x7053;	????
    359c:	61 63       	addc.b	#2,	r1	;r3 As==10
    359e:	65 20       	jnz	$+204    	;abs 0x366a
    35a0:	3f 20       	jnz	$+128    	;abs 0x3620
    35a2:	28 59       	add	@r9,	r8	;
    35a4:	2f 4e       	mov	@r14,	r15	;
    35a6:	29 00 43 61 	mova	&24899,	r9	;0x06143
    35aa:	6e 6e       	addc.b	@r14,	r14	;
    35ac:	6f 74       	subc.b	@r4,	r15	;
    35ae:	20 75       	subc	@r5,	r0	;
    35b0:	73 65       	.word	0x6573;	????
    35b2:	20 4e       	br	@r14		;
    35b4:	6f 6e       	addc.b	@r14,	r15	;
    35b6:	2d 49       	mov	@r9,	r13	;
    35b8:	6e 63       	addc.b	#2,	r14	;r3 As==10
    35ba:	72 65       	addc.b	@r5+,	r2	;
    35bc:	6d 65       	addc.b	@r5,	r13	;
    35be:	6e 74       	subc.b	@r4,	r14	;
    35c0:	69 6e       	addc.b	@r14,	r9	;
    35c2:	67 20       	jnz	$+208    	;abs 0x3692
    35c4:	54 72 61 6e 	subc.b	&0x6e61,r4	;0x6e61
    35c8:	73 61       	.word	0x6173;	????
    35ca:	63 74       	.word	0x7463;	????
    35cc:	69 6f       	addc.b	@r15,	r9	;
    35ce:	6e 73       	subc.b	#2,	r14	;r3 As==10
    35d0:	20 69       	addc	@r9,	r0	;
    35d2:	6e 20       	jnz	$+222    	;abs 0x36b0
    35d4:	43 6f       	.word	0x6f43;	????
    35d6:	6e 66       	addc.b	@r6,	r14	;
    35d8:	69 67       	addc.b	@r7,	r9	;
    35da:	75 72       	subc.b	#8,	r5	;r2 As==11
    35dc:	61 74       	subc.b	@r4,	r1	;
    35de:	69 6f       	addc.b	@r15,	r9	;
    35e0:	6e 20       	jnz	$+222    	;abs 0x36be
    35e2:	53 70       	.word	0x7053;	????
    35e4:	61 63       	addc.b	#2,	r1	;r3 As==10
    35e6:	65 00 49 50 	mova	r0,	&348233	; 0x55049
    35ea:	62 75       	subc.b	@r5,	r2	;
    35ec:	73 20       	jnz	$+232    	;abs 0x36d4
    35ee:	52 65 70 6c 	addc.b	27760(r5),r2	;0x06c70
    35f2:	79 20       	jnz	$+244    	;abs 0x36e6
    35f4:	48 65       	addc.b	r5,	r8	;
    35f6:	61 64       	addc.b	@r4,	r1	;
    35f8:	65 72       	subc.b	#4,	r5	;r2 As==10
    35fa:	20 4d       	br	@r13		;
    35fc:	69 73       	subc.b	#2,	r9	;r3 As==10
    35fe:	6d 61       	addc.b	@r1,	r13	;
    3600:	74 63       	addc.b	#-1,	r4	;r3 As==11
    3602:	68 2e       	jc	$-814    	;abs 0x32d4
    3604:	20 53       	incd	r0		;
    3606:	65 6e       	addc.b	@r14,	r5	;
    3608:	74 20       	jnz	$+234    	;abs 0x36f2
    360a:	30 78       	subc	@r8+,	r0	;
    360c:	25 30       	jn	$+76     	;abs 0x3658
    360e:	38 6c       	addc	@r12+,	r8	;
    3610:	58 20       	jnz	$+178    	;abs 0x36c2
    3612:	2c 20       	jnz	$+90     	;abs 0x366c
    3614:	47 6f       	addc.b	r15,	r7	;
    3616:	74 20       	jnz	$+234    	;abs 0x3700
    3618:	30 78       	subc	@r8+,	r0	;
    361a:	25 30       	jn	$+76     	;abs 0x3666
    361c:	38 6c       	addc	@r12+,	r8	;
    361e:	58 20       	jnz	$+178    	;abs 0x36d0
    3620:	2c 20       	jnz	$+90     	;abs 0x367a
    3622:	45 78       	subc.b	r8,	r5	;
    3624:	70 65       	addc.b	@r5+,	r0	;
    3626:	63 74       	.word	0x7463;	????
    3628:	65 64       	addc.b	@r4,	r5	;
    362a:	20 30       	jn	$+66     	;abs 0x366c
    362c:	78 25       	jz	$+754    	;abs 0x391e
    362e:	30 38       	jl	$+98     	;abs 0x3690
    3630:	6c 58       	add.b	@r8,	r12	;
    3632:	20 0a 00 0a 	bra	&657920	;0xa0a00
    3636:	49 50       	add.b	r0,	r9	;
    3638:	42 75       	subc.b	r5,	r2	;
    363a:	73 20       	jnz	$+232    	;abs 0x3722
    363c:	52 65 61 64 	addc.b	25697(r5),r2	;0x06461
    3640:	3a 20       	jnz	$+118    	;abs 0x36b6
    3642:	49 50       	add.b	r0,	r9	;
    3644:	20 41       	br	@r1		;
    3646:	64 64       	addc.b	@r4,	r4	;
    3648:	72 65       	addc.b	@r5+,	r2	;
    364a:	73 73       	.word	0x7373;	????
    364c:	00 0a       	bra	@r10		;
    364e:	20 45       	br	@r5		;
    3650:	6e 74       	subc.b	@r4,	r14	;
    3652:	65 72       	subc.b	#4,	r5	;r2 As==10
    3654:	20 68       	addc	@r8,	r0	;
    3656:	65 78       	subc.b	@r8,	r5	;
    3658:	61 64       	addc.b	@r4,	r1	;
    365a:	65 63       	addc.b	#2,	r5	;r3 As==10
    365c:	69 6d       	addc.b	@r13,	r9	;
    365e:	61 6c       	addc.b	@r12,	r1	;
    3660:	20 61       	addc	@r1,	r0	;
    3662:	64 64       	addc.b	@r4,	r4	;
    3664:	72 65       	addc.b	@r5+,	r2	;
    3666:	73 73       	.word	0x7373;	????
    3668:	20 6f       	addc	@r15,	r0	;
    366a:	6e 20       	jnz	$+222    	;abs 0x3748
    366c:	41 33       	jn	$-380    	;abs 0x34f0
    366e:	32 3a       	jl	$-922    	;abs 0x32d4
    3670:	20 30       	jn	$+66     	;abs 0x36b2
    3672:	78 00 49 50 	mova	r0,	20553(r8); 0x05049
    3676:	62 75       	subc.b	@r5,	r2	;
    3678:	73 20       	jnz	$+232    	;abs 0x3760
    367a:	52 65 70 6c 	addc.b	27760(r5),r2	;0x06c70
    367e:	79 20       	jnz	$+244    	;abs 0x3772
    3680:	48 65       	addc.b	r5,	r8	;
    3682:	61 64       	addc.b	@r4,	r1	;
    3684:	65 72       	subc.b	#4,	r5	;r2 As==10
    3686:	20 4d       	br	@r13		;
    3688:	69 73       	subc.b	#2,	r9	;r3 As==10
    368a:	6d 61       	addc.b	@r1,	r13	;
    368c:	74 63       	addc.b	#-1,	r4	;r3 As==11
    368e:	68 2e       	jc	$-814    	;abs 0x3360
    3690:	20 53       	incd	r0		;
    3692:	65 6e       	addc.b	@r14,	r5	;
    3694:	74 20       	jnz	$+234    	;abs 0x377e
    3696:	30 78       	subc	@r8+,	r0	;
    3698:	25 30       	jn	$+76     	;abs 0x36e4
    369a:	38 6c       	addc	@r12+,	r8	;
    369c:	58 20       	jnz	$+178    	;abs 0x374e
    369e:	2c 20       	jnz	$+90     	;abs 0x36f8
    36a0:	47 6f       	addc.b	r15,	r7	;
    36a2:	74 20       	jnz	$+234    	;abs 0x378c
    36a4:	30 78       	subc	@r8+,	r0	;
    36a6:	25 30       	jn	$+76     	;abs 0x36f2
    36a8:	38 6c       	addc	@r12+,	r8	;
    36aa:	58 20       	jnz	$+178    	;abs 0x375c
    36ac:	2c 20       	jnz	$+90     	;abs 0x3706
    36ae:	45 78       	subc.b	r8,	r5	;
    36b0:	70 65       	addc.b	@r5+,	r0	;
    36b2:	63 74       	.word	0x7463;	????
    36b4:	65 64       	addc.b	@r4,	r5	;
    36b6:	20 30       	jn	$+66     	;abs 0x36f8
    36b8:	78 25       	jz	$+754    	;abs 0x39aa
    36ba:	30 38       	jl	$+98     	;abs 0x371c
    36bc:	6c 58       	add.b	@r8,	r12	;
    36be:	20 20       	jnz	$+66     	;abs 0x3700
    36c0:	0a 00       	mova	@r0,	r10	;
    36c2:	0a 49       	mov	r9,	r10	;
    36c4:	50 42 75 73 	br	&0x7375		;
    36c8:	20 77       	subc	@r7,	r0	;
    36ca:	72 69       	addc.b	@r9+,	r2	;
    36cc:	74 65       	addc.b	@r5+,	r4	;
    36ce:	20 66       	addc	@r6,	r0	;
    36d0:	72 6f       	addc.b	@r15+,	r2	;
    36d2:	6d 20       	jnz	$+220    	;abs 0x37ae
    36d4:	50 72 6f 6d 	subc.b	&0x6d6f,r0	;0x6d6f
    36d8:	3a 20       	jnz	$+118    	;abs 0x374e
    36da:	4d 41       	mov.b	r1,	r13	;
    36dc:	43 20       	jnz	$+136    	;abs 0x3764
    36de:	41 64       	addc.b	r4,	r1	;
    36e0:	64 72       	subc.b	#4,	r4	;r2 As==10
    36e2:	65 73       	subc.b	#2,	r5	;r3 As==10
    36e4:	73 00 0a 49 	mova	r0,	18698(r3); 0x0490a
    36e8:	50 42 75 73 	br	&0x7375		;
    36ec:	20 52       	add	#4,	r0	;r2 As==10
    36ee:	65 61       	addc.b	@r1,	r5	;
    36f0:	64 3a       	jl	$-822    	;abs 0x33ba
    36f2:	20 4d       	br	@r13		;
    36f4:	41 43       	clr.b	r1		;
    36f6:	20 41       	br	@r1		;
    36f8:	64 64       	addc.b	@r4,	r4	;
    36fa:	72 65       	addc.b	@r5+,	r2	;
    36fc:	73 73       	.word	0x7373;	????
    36fe:	00 49       	br	r9		;
    3700:	6e 76       	subc.b	@r6,	r14	;
    3702:	61 6c       	addc.b	@r12,	r1	;
    3704:	69 64       	addc.b	@r4,	r9	;
    3706:	20 63       	addc	#2,	r0	;r3 As==10
    3708:	6f 6d       	addc.b	@r13,	r15	;
    370a:	6d 61       	addc.b	@r1,	r13	;
    370c:	6e 64       	addc.b	@r4,	r14	;
    370e:	2e 20       	jnz	$+94     	;abs 0x376c
    3710:	54 79 70 65 	subc.b	25968(r9),r4	;0x06570
    3714:	20 27       	jz	$-446    	;abs 0x3556
    3716:	68 65       	addc.b	@r5,	r8	;
    3718:	6c 70       	subc.b	@r0,	r12	;
    371a:	27 20       	jnz	$+80     	;abs 0x376a
    371c:	74 6f       	addc.b	@r15+,	r4	;
    371e:	20 73       	subc	#2,	r0	;r3 As==10
    3720:	65 65       	addc.b	@r5,	r5	;
    3722:	20 61       	addc	@r1,	r0	;
    3724:	6c 6c       	addc.b	@r12,	r12	;
    3726:	20 63       	addc	#2,	r0	;r3 As==10
    3728:	6f 6d       	addc.b	@r13,	r15	;
    372a:	6d 61       	addc.b	@r1,	r13	;
    372c:	6e 64       	addc.b	@r4,	r14	;
    372e:	73 2e       	jc	$-792    	;abs 0x3416
    3730:	0a 00       	mova	@r0,	r10	;
    3732:	0a 00       	mova	@r0,	r10	;

00003734 <__sf_fake_stderr>:
    3734:	00 00       	beq			
    3736:	00 00       	beq			
    3738:	00 00       	beq			
    373a:	00 00       	beq			
    373c:	00 00       	beq			
    373e:	00 00       	beq			
    3740:	00 00       	beq			
    3742:	00 00       	beq			
    3744:	00 00       	beq			

00003746 <__sf_fake_stdout>:
    3746:	00 00       	beq			
    3748:	00 00       	beq			
    374a:	00 00       	beq			
    374c:	00 00       	beq			
    374e:	00 00       	beq			
    3750:	00 00       	beq			
    3752:	00 00       	beq			
    3754:	00 00       	beq			
    3756:	00 00       	beq			

00003758 <__sf_fake_stdin>:
    3758:	00 00       	beq			
    375a:	00 00       	beq			
    375c:	00 00       	beq			
    375e:	00 00       	beq			
    3760:	00 00       	beq			
    3762:	00 00       	beq			
    3764:	00 00       	beq			
    3766:	00 00       	beq			
    3768:	00 00       	beq			

0000376a <_global_impure_ptr>:
    376a:	0a 80       	sub	r0,	r10	;
    376c:	43 00       	rrcm.a	#1,	r3	;
    376e:	23 2d       	jc	$+584    	;abs 0x39b6
    3770:	30 2b       	jnc	$-414    	;abs 0x35d2
    3772:	20 00 68 6c 	bra	&27752		;0x06c68
    3776:	4c 00       	rrcm.a	#1,	r12	;
    3778:	65 66       	addc.b	@r6,	r5	;
    377a:	67 45       	mov.b	@r5,	r7	;
    377c:	46 47       	mov.b	r7,	r6	;
    377e:	00 30       	jn	$+2      	;abs 0x3780
    3780:	31 32       	jn	$-924    	;abs 0x33e4
    3782:	33 34       	jge	$+104    	;abs 0x37ea
    3784:	35 36       	jge	$-916    	;abs 0x33f0
    3786:	37 38       	jl	$+112    	;abs 0x37f6
    3788:	39 41       	pop	r9		;
    378a:	42 43       	clr.b	r2		;
    378c:	44 45       	mov.b	r5,	r4	;
    378e:	46 00       	rrcm.a	#1,	r6	;
    3790:	30 31       	jn	$+610    	;abs 0x39f2
    3792:	32 33       	jn	$-410    	;abs 0x35f8
    3794:	34 35       	jge	$+618    	;abs 0x39fe
    3796:	36 37       	jge	$-402    	;abs 0x3604
    3798:	38 39       	jl	$+626    	;abs 0x3a0a
    379a:	61 62       	addc.b	#4,	r1	;r2 As==10
    379c:	63 64       	.word	0x6463;	????
    379e:	65 66       	addc.b	@r6,	r5	;
    37a0:	00 48       	br	r8		;
    37a2:	65 61       	addc.b	@r1,	r5	;
    37a4:	70 20       	jnz	$+226    	;abs 0x3886
    37a6:	61 6e       	addc.b	@r14,	r1	;
    37a8:	64 20       	jnz	$+202    	;abs 0x3872
    37aa:	73 74       	.word	0x7473;	????
    37ac:	61 63       	addc.b	#2,	r1	;r3 As==10
    37ae:	6b 20       	jnz	$+216    	;abs 0x3886
    37b0:	63 6f       	.word	0x6f63;	????
    37b2:	6c 6c       	addc.b	@r12,	r12	;
    37b4:	69 73       	subc.b	#2,	r9	;r3 As==10
    37b6:	69 6f       	addc.b	@r15,	r9	;
    37b8:	6e 0a 00 00 	mova	r10,	&917504	; 0xe0000

Disassembly of section .data:

00008008 <__data_start>:
    8008:	0a 80       	sub	r0,	r10	;

0000800a <impure_data>:
    800a:	00 00       	beq			
    800c:	58 37       	jge	$-334    	;abs 0x7ebe
    800e:	46 37       	jge	$-370    	;abs 0x7e9c
    8010:	34 37       	jge	$-406    	;abs 0x7e7a
    8012:	00 00       	beq			
    8014:	00 00       	beq			
    8016:	00 00       	beq			
    8018:	00 00       	beq			
    801a:	6c 37       	jge	$-294    	;abs 0x7ef4
    801c:	00 00       	beq			
    801e:	00 00       	beq			
    8020:	00 00       	beq			
    8022:	00 00       	beq			
    8024:	00 00       	beq			
    8026:	00 00       	beq			
    8028:	00 00       	beq			
    802a:	00 00       	beq			
    802c:	00 00       	beq			
    802e:	00 00       	beq			
    8030:	00 00       	beq			
    8032:	00 00       	beq			
    8034:	00 00       	beq			
    8036:	00 00       	beq			
    8038:	00 00       	beq			
    803a:	00 00       	beq			
    803c:	00 00       	beq			
    803e:	00 00       	beq			
    8040:	00 00       	beq			
    8042:	00 00       	beq			
    8044:	00 00       	beq			
    8046:	00 00       	beq			
    8048:	00 00       	beq			
    804a:	00 00       	beq			
    804c:	00 00       	beq			
    804e:	00 00       	beq			
    8050:	00 00       	beq			
    8052:	00 00       	beq			
    8054:	00 00       	beq			
    8056:	00 00       	beq			
    8058:	00 00       	beq			
    805a:	00 00       	beq			
    805c:	00 00       	beq			
    805e:	00 00       	beq			
    8060:	00 00       	beq			
    8062:	00 00       	beq			
    8064:	00 00       	beq			
    8066:	00 00       	beq			
    8068:	00 00       	beq			
    806a:	00 00       	beq			
    806c:	00 00       	beq			
    806e:	00 00       	beq			
    8070:	00 00       	beq			
    8072:	00 00       	beq			
    8074:	00 00       	beq			
    8076:	00 00       	beq			
    8078:	00 00       	beq			
    807a:	00 00       	beq			
    807c:	00 00       	beq			
    807e:	00 00       	beq			
    8080:	00 00       	beq			

00008082 <lc_ctype_charset>:
    8082:	41 53       	add.b	#0,	r1	;r3 As==00
    8084:	43 49       	.word	0x4943;	????
    8086:	49 00       	rrcm.a	#1,	r9	;
    8088:	00 00       	beq			
    808a:	00 00       	beq			
    808c:	00 00       	beq			
    808e:	00 00       	beq			
    8090:	00 00       	beq			
    8092:	00 00       	beq			
    8094:	00 00       	beq			
    8096:	00 00       	beq			
    8098:	00 00       	beq			
    809a:	00 00       	beq			
    809c:	00 00       	beq			
    809e:	00 00       	beq			
    80a0:	00 00       	beq			

000080a2 <__mb_cur_max>:
    80a2:	01 00       	mova	@r0,	r1	;

000080a4 <__wctomb>:
    80a4:	e8 2d       	jc	$+978    	;abs 0x8476

000080a6 <heap.1381>:
    80a6:	26 81       	sub	@r1,	r6	;

000080a8 <_CIOBUF_>:
    80a8:	00 00       	beq			
    80aa:	00 00       	beq			
    80ac:	00 00       	beq			
    80ae:	00 00       	beq			
    80b0:	00 00       	beq			
    80b2:	00 00       	beq			
    80b4:	00 00       	beq			
    80b6:	00 00       	beq			
    80b8:	00 00       	beq			
    80ba:	00 00       	beq			
    80bc:	00 00       	beq			
    80be:	00 00       	beq			
    80c0:	00 00       	beq			
    80c2:	00 00       	beq			
    80c4:	00 00       	beq			
    80c6:	00 00       	beq			
    80c8:	00 00       	beq			
    80ca:	00 00       	beq			
    80cc:	00 00       	beq			
    80ce:	00 00       	beq			
    80d0:	00 00       	beq			
    80d2:	00 00       	beq			
    80d4:	00 00       	beq			
    80d6:	00 00       	beq			
    80d8:	00 00       	beq			
    80da:	00 00       	beq			
    80dc:	00 00       	beq			
    80de:	00 00       	beq			
    80e0:	00 00       	beq			
    80e2:	00 00       	beq			
    80e4:	00 00       	beq			
    80e6:	00 00       	beq			
    80e8:	00 00       	beq			
    80ea:	00 00       	beq			
    80ec:	00 00       	beq			
    80ee:	00 00       	beq			
    80f0:	00 00       	beq			
    80f2:	00 00       	beq			

Disassembly of section .bss:

000080f4 <__bssstart>:
    80f4:	00 00       	beq			
    80f6:	00 00       	beq			
    80f8:	00 00       	beq			

000080fa <reply>:
    80fa:	00 00       	beq			
    80fc:	00 00       	beq			

000080fe <incrementing>:
    80fe:	00 00       	beq			

000080ff <ConfigurationSpace>:
    80ff:	00 00       	beq			

00008100 <command>:
    8100:	00 00       	beq			
    8102:	00 00       	beq			
    8104:	00 00       	beq			
    8106:	00 00       	beq			
    8108:	00 00       	beq			
    810a:	00 00       	beq			
    810c:	00 00       	beq			
    810e:	00 00       	beq			

00008110 <buffer>:
    8110:	00 00       	beq			
    8112:	00 00       	beq			
    8114:	00 00       	beq			
    8116:	00 00       	beq			
    8118:	00 00       	beq			
    811a:	00 00       	beq			
    811c:	00 00       	beq			
    811e:	00 00       	beq			

00008120 <__malloc_sbrk_start>:
    8120:	00 00       	beq			

00008122 <__malloc_free_list>:
    8122:	00 00       	beq			

00008124 <errno>:
    8124:	00 00       	beq			

Disassembly of section .MP430.attributes:

00000000 <.MP430.attributes>:

__crt0_begin:
; -----------------------------------------------------------
; Get required system info
; -----------------------------------------------------------
    mov  &0xFFF8, r8 ; = DMEM (RAM) base address
   0:	41 16       	popm.a	#5,	r5	;20-bit words
   2:	00 00       	beq			
    mov  &0xFFFA, r1 ; = DMEM (RAM) size in byte
   4:	00 6d       	addc	r13,	r0	;
   6:	73 70       	.word	0x7073;	????


; -----------------------------------------------------------
; Minimal required hardware setup
; -----------------------------------------------------------
    mov  #0, r2           ; clear status register & disable interrupts
   8:	61 62       	addc.b	#4,	r1	;r2 As==10
    add  r8, r1           ; r1 = stack pointer = end of RAM
   a:	69 00 01 0b 	mova	r0,	&592641	; 0x90b01
    mov  #0x4700, &0xFFB8 ; deactivate watchdog
   e:	00 00       	beq			
  10:	00 04       	bra	@r4		;
; Initialize all IO device registers (set to zero)
; -----------------------------------------------------------
; This loop does not trigger any operations as the CTRL registers, which are located
; at offset 0 of the according device, are set to zero resulting in disabling the
; specific device.
    mov  #0xFF80, r9 ; beginning of IO section
  12:	01 06       	mova	@r6,	r1	;
  14:	01 08       	mova	@r8,	r1	;
__crt0_clr_io:
      tst  r9 ; until the end -> wrap-around to 0
  16:	01 41       	mov	r1,	r1	;
      jeq  __crt0_clr_io_end
  18:	16 00       	mova	@r0+,	r6	;
      mov  #0, 0(r9) ; clear entry
  1a:	00 00       	beq			
  1c:	6d 73       	subc.b	#2,	r13	;r3 As==10
      incd r9
  1e:	70 61       	addc.b	@r1+,	r0	;
      jmp  __crt0_clr_io
  20:	62 69       	addc.b	@r9,	r2	;

; -----------------------------------------------------------
; Clear complete DMEM (including .bss section)
; -----------------------------------------------------------
__crt0_clr_dmem:
      cmp  r8, r1 ; base address equal to end of RAM?
  22:	00 01       	bra	@r1		;
      jeq  __crt0_clr_dmem_end
  24:	0b 00       	mova	@r0,	r11	;
      mov  #0, 0(r8) ; clear entry
  26:	00 00       	beq			
  28:	04 01       	mova	@r1,	r4	;
      incd r8
  2a:	06 01       	mova	@r1,	r6	;
      jmp  __crt0_clr_dmem
  2c:	08 01       	mova	@r1,	r8	;


; -----------------------------------------------------------
; Copy initialized .data section from ROM to RAM
; -----------------------------------------------------------
    mov  #__data_start_rom, r5
  2e:	41 16       	popm.a	#5,	r5	;20-bit words
  30:	00 00       	beq			
    mov  #__data_end_rom, r6
  32:	00 6d       	addc	r13,	r0	;
  34:	73 70       	.word	0x7073;	????
    mov  #__data_start, r7
  36:	61 62       	addc.b	#4,	r1	;r2 As==10
  38:	69 00 01 0b 	mova	r0,	&592641	; 0x90b01
__crt0_cpy_data:
      cmp  r5, r6
      jeq  __crt0_cpy_data_end
  3c:	00 00       	beq			
      mov  @r5+, 0(r7)
  3e:	00 04       	bra	@r4		;
  40:	01 06       	mova	@r6,	r1	;
      incd r7
  42:	01 08       	mova	@r8,	r1	;
      jmp  __crt0_cpy_data
  44:	01 41       	mov	r1,	r1	;


; -----------------------------------------------------------
; Re-init SR and clear all pending IRQs from buffer
; -----------------------------------------------------------
    mov  #(1<<14), r2 ; this flag auto clears
  46:	16 00       	mova	@r0+,	r6	;
  48:	00 00       	beq			


; -----------------------------------------------------------
; Initialize all remaining registers
; -----------------------------------------------------------
    mov  #0, r4
  4a:	6d 73       	subc.b	#2,	r13	;r3 As==10
;   mov  #0, r5 ; -- is already initialized
;   mov  #0, r6 ; -- is already initialized
;   mov  #0, r7 ; -- is already initialized
;   mov  #0, r8 ; -- is already initialized
;   mov  #0, r9 ; -- is already initialized
    mov  #0, r10
  4c:	70 61       	addc.b	@r1+,	r0	;
    mov  #0, r11
  4e:	62 69       	addc.b	@r9,	r2	;
    mov  #0, r12 ; set argc = 0
  50:	00 01       	bra	@r1		;
    mov  #0, r13
  52:	0b 00       	mova	@r0,	r11	;
    mov  #0, r14
  54:	00 00       	beq			
    mov  #0, r15
  56:	04 01       	mova	@r1,	r4	;

; -----------------------------------------------------------
; This is where the actual application is started
; -----------------------------------------------------------
__crt0_start_main:
    call  #main
  58:	06 01       	mova	@r1,	r6	;
  5a:	08 01       	mova	@r1,	r8	;

; -----------------------------------------------------------
; Go to endless sleep mode if main returns
; -----------------------------------------------------------
__crt0_this_is_the_end:
    mov  #0, r2 ; deactivate IRQs
  5c:	41 16       	popm.a	#5,	r5	;20-bit words
    mov  #0x4700, &0xFFB8 ; deactivate watchdog
  5e:	00 00       	beq			
  60:	00 6d       	addc	r13,	r0	;
  62:	73 70       	.word	0x7073;	????
    mov  #(1<<4), r2 ; set CPU to sleep mode
  64:	61 62       	addc.b	#4,	r1	;r2 As==10
  66:	69 00 01 0b 	mova	r0,	&592641	; 0x90b01
  6a:	00 00       	beq			
  6c:	00 04       	bra	@r4		;
  6e:	01 06       	mova	@r6,	r1	;
  70:	01 08       	mova	@r8,	r1	;
  72:	01 41       	mov	r1,	r1	;
  74:	16 00       	mova	@r0+,	r6	;
  76:	00 00       	beq			
  78:	6d 73       	subc.b	#2,	r13	;r3 As==10
  7a:	70 61       	addc.b	@r1+,	r0	;
  7c:	62 69       	addc.b	@r9,	r2	;
  7e:	00 01       	bra	@r1		;
  80:	0b 00       	mova	@r0,	r11	;
  82:	00 00       	beq			
  84:	04 01       	mova	@r1,	r4	;
  86:	06 01       	mova	@r1,	r6	;
  88:	08 01       	mova	@r1,	r8	;
  8a:	41 16       	popm.a	#5,	r5	;20-bit words
  8c:	00 00       	beq			
  8e:	00 6d       	addc	r13,	r0	;
  90:	73 70       	.word	0x7073;	????
  92:	61 62       	addc.b	#4,	r1	;r2 As==10
  94:	69 00 01 0b 	mova	r0,	&592641	; 0x90b01
  98:	00 00       	beq			
  9a:	00 04       	bra	@r4		;
  9c:	01 06       	mova	@r6,	r1	;
  9e:	01 08       	mova	@r8,	r1	;
  a0:	01 41       	mov	r1,	r1	;
  a2:	16 00       	mova	@r0+,	r6	;
  a4:	00 00       	beq			
  a6:	6d 73       	subc.b	#2,	r13	;r3 As==10
  a8:	70 61       	addc.b	@r1+,	r0	;
  aa:	62 69       	addc.b	@r9,	r2	;
  ac:	00 01       	bra	@r1		;
  ae:	0b 00       	mova	@r0,	r11	;
  b0:	00 00       	beq			
  b2:	04 01       	mova	@r1,	r4	;
  b4:	06 01       	mova	@r1,	r6	;
  b6:	08 01       	mova	@r1,	r8	;
  b8:	41 16       	popm.a	#5,	r5	;20-bit words
  ba:	00 00       	beq			
  bc:	00 6d       	addc	r13,	r0	;
  be:	73 70       	.word	0x7073;	????
  c0:	61 62       	addc.b	#4,	r1	;r2 As==10
  c2:	69 00 01 0b 	mova	r0,	&592641	; 0x90b01
  c6:	00 00       	beq			
  c8:	00 04       	bra	@r4		;
  ca:	01 06       	mova	@r6,	r1	;
  cc:	01 08       	mova	@r8,	r1	;
  ce:	01 41       	mov	r1,	r1	;
  d0:	16 00       	mova	@r0+,	r6	;
  d2:	00 00       	beq			
  d4:	6d 73       	subc.b	#2,	r13	;r3 As==10
  d6:	70 61       	addc.b	@r1+,	r0	;
  d8:	62 69       	addc.b	@r9,	r2	;
  da:	00 01       	bra	@r1		;
  dc:	0b 00       	mova	@r0,	r11	;
  de:	00 00       	beq			
  e0:	04 01       	mova	@r1,	r4	;
  e2:	06 01       	mova	@r1,	r6	;
  e4:	08 01       	mova	@r1,	r8	;
  e6:	41 16       	popm.a	#5,	r5	;20-bit words
  e8:	00 00       	beq			
  ea:	00 6d       	addc	r13,	r0	;
  ec:	73 70       	.word	0x7073;	????
  ee:	61 62       	addc.b	#4,	r1	;r2 As==10
  f0:	69 00 01 0b 	mova	r0,	&592641	; 0x90b01
  f4:	00 00       	beq			
  f6:	00 04       	bra	@r4		;
  f8:	01 06       	mova	@r6,	r1	;
  fa:	01 08       	mova	@r8,	r1	;
  fc:	01 41       	mov	r1,	r1	;
  fe:	16 00       	mova	@r0+,	r6	;
 100:	00 00       	beq			
 102:	6d 73       	subc.b	#2,	r13	;r3 As==10
 104:	70 61       	addc.b	@r1+,	r0	;
 106:	62 69       	addc.b	@r9,	r2	;
 108:	00 01       	bra	@r1		;
 10a:	0b 00       	mova	@r0,	r11	;
 10c:	00 00       	beq			
 10e:	04 01       	mova	@r1,	r4	;
 110:	06 01       	mova	@r1,	r6	;
 112:	08 01       	mova	@r1,	r8	;
 114:	41 16       	popm.a	#5,	r5	;20-bit words
 116:	00 00       	beq			
 118:	00 6d       	addc	r13,	r0	;
 11a:	73 70       	.word	0x7073;	????
 11c:	61 62       	addc.b	#4,	r1	;r2 As==10
 11e:	69 00 01 0b 	mova	r0,	&592641	; 0x90b01
 122:	00 00       	beq			
 124:	00 04       	bra	@r4		;
 126:	01 06       	mova	@r6,	r1	;
 128:	01 08       	mova	@r8,	r1	;
 12a:	01 41       	mov	r1,	r1	;
 12c:	16 00       	mova	@r0+,	r6	;
 12e:	00 00       	beq			
 130:	6d 73       	subc.b	#2,	r13	;r3 As==10
 132:	70 61       	addc.b	@r1+,	r0	;
 134:	62 69       	addc.b	@r9,	r2	;
 136:	00 01       	bra	@r1		;
 138:	0b 00       	mova	@r0,	r11	;
 13a:	00 00       	beq			
 13c:	04 01       	mova	@r1,	r4	;
 13e:	06 01       	mova	@r1,	r6	;
 140:	08 01       	mova	@r1,	r8	;
 142:	41 16       	popm.a	#5,	r5	;20-bit words
 144:	00 00       	beq			
 146:	00 6d       	addc	r13,	r0	;
 148:	73 70       	.word	0x7073;	????
 14a:	61 62       	addc.b	#4,	r1	;r2 As==10
 14c:	69 00 01 0b 	mova	r0,	&592641	; 0x90b01
 150:	00 00       	beq			
 152:	00 04       	bra	@r4		;
 154:	01 06       	mova	@r6,	r1	;
 156:	01 08       	mova	@r8,	r1	;
 158:	01 41       	mov	r1,	r1	;
 15a:	16 00       	mova	@r0+,	r6	;
 15c:	00 00       	beq			
 15e:	6d 73       	subc.b	#2,	r13	;r3 As==10
 160:	70 61       	addc.b	@r1+,	r0	;
 162:	62 69       	addc.b	@r9,	r2	;
 164:	00 01       	bra	@r1		;
 166:	0b 00       	mova	@r0,	r11	;
 168:	00 00       	beq			
 16a:	04 01       	mova	@r1,	r4	;
 16c:	06 01       	mova	@r1,	r6	;
 16e:	08 01       	mova	@r1,	r8	;
 170:	41 16       	popm.a	#5,	r5	;20-bit words
 172:	00 00       	beq			
 174:	00 6d       	addc	r13,	r0	;
 176:	73 70       	.word	0x7073;	????
 178:	61 62       	addc.b	#4,	r1	;r2 As==10
 17a:	69 00 01 0b 	mova	r0,	&592641	; 0x90b01
 17e:	00 00       	beq			
 180:	00 04       	bra	@r4		;
 182:	01 06       	mova	@r6,	r1	;
 184:	01 08       	mova	@r8,	r1	;
 186:	01 41       	mov	r1,	r1	;
 188:	16 00       	mova	@r0+,	r6	;
 18a:	00 00       	beq			
 18c:	6d 73       	subc.b	#2,	r13	;r3 As==10
 18e:	70 61       	addc.b	@r1+,	r0	;
 190:	62 69       	addc.b	@r9,	r2	;
 192:	00 01       	bra	@r1		;
 194:	0b 00       	mova	@r0,	r11	;
 196:	00 00       	beq			
 198:	04 01       	mova	@r1,	r4	;
 19a:	06 01       	mova	@r1,	r6	;
 19c:	08 01       	mova	@r1,	r8	;
 19e:	41 16       	popm.a	#5,	r5	;20-bit words
 1a0:	00 00       	beq			
 1a2:	00 6d       	addc	r13,	r0	;
 1a4:	73 70       	.word	0x7073;	????
 1a6:	61 62       	addc.b	#4,	r1	;r2 As==10
 1a8:	69 00 01 0b 	mova	r0,	&592641	; 0x90b01
 1ac:	00 00       	beq			
 1ae:	00 04       	bra	@r4		;
 1b0:	01 06       	mova	@r6,	r1	;
 1b2:	01 08       	mova	@r8,	r1	;
 1b4:	01 41       	mov	r1,	r1	;
 1b6:	16 00       	mova	@r0+,	r6	;
 1b8:	00 00       	beq			
 1ba:	6d 73       	subc.b	#2,	r13	;r3 As==10
 1bc:	70 61       	addc.b	@r1+,	r0	;
 1be:	62 69       	addc.b	@r9,	r2	;
 1c0:	00 01       	bra	@r1		;
 1c2:	0b 00       	mova	@r0,	r11	;
 1c4:	00 00       	beq			
 1c6:	04 01       	mova	@r1,	r4	;
 1c8:	06 01       	mova	@r1,	r6	;
 1ca:	08 01       	mova	@r1,	r8	;
 1cc:	41 16       	popm.a	#5,	r5	;20-bit words
 1ce:	00 00       	beq			
 1d0:	00 6d       	addc	r13,	r0	;
 1d2:	73 70       	.word	0x7073;	????
 1d4:	61 62       	addc.b	#4,	r1	;r2 As==10
 1d6:	69 00 01 0b 	mova	r0,	&592641	; 0x90b01
 1da:	00 00       	beq			
 1dc:	00 04       	bra	@r4		;
 1de:	01 06       	mova	@r6,	r1	;
 1e0:	01 08       	mova	@r8,	r1	;
 1e2:	01 41       	mov	r1,	r1	;
 1e4:	16 00       	mova	@r0+,	r6	;
 1e6:	00 00       	beq			
 1e8:	6d 73       	subc.b	#2,	r13	;r3 As==10
 1ea:	70 61       	addc.b	@r1+,	r0	;
 1ec:	62 69       	addc.b	@r9,	r2	;
 1ee:	00 01       	bra	@r1		;
 1f0:	0b 00       	mova	@r0,	r11	;
 1f2:	00 00       	beq			
 1f4:	04 01       	mova	@r1,	r4	;
 1f6:	06 01       	mova	@r1,	r6	;
 1f8:	08 01       	mova	@r1,	r8	;
 1fa:	41 16       	popm.a	#5,	r5	;20-bit words
 1fc:	00 00       	beq			
 1fe:	00 6d       	addc	r13,	r0	;
 200:	73 70       	.word	0x7073;	????
 202:	61 62       	addc.b	#4,	r1	;r2 As==10
 204:	69 00 01 0b 	mova	r0,	&592641	; 0x90b01
 208:	00 00       	beq			
 20a:	00 04       	bra	@r4		;
 20c:	01 06       	mova	@r6,	r1	;
 20e:	01 08       	mova	@r8,	r1	;
 210:	01 41       	mov	r1,	r1	;
 212:	16 00       	mova	@r0+,	r6	;
 214:	00 00       	beq			
 216:	6d 73       	subc.b	#2,	r13	;r3 As==10
 218:	70 61       	addc.b	@r1+,	r0	;
 21a:	62 69       	addc.b	@r9,	r2	;
 21c:	00 01       	bra	@r1		;
 21e:	0b 00       	mova	@r0,	r11	;
 220:	00 00       	beq			
 222:	04 01       	mova	@r1,	r4	;
 224:	06 01       	mova	@r1,	r6	;
 226:	08 01       	mova	@r1,	r8	;
 228:	41 16       	popm.a	#5,	r5	;20-bit words
 22a:	00 00       	beq			
 22c:	00 6d       	addc	r13,	r0	;
 22e:	73 70       	.word	0x7073;	????
 230:	61 62       	addc.b	#4,	r1	;r2 As==10
 232:	69 00 01 0b 	mova	r0,	&592641	; 0x90b01
 236:	00 00       	beq			
 238:	00 04       	bra	@r4		;
 23a:	01 06       	mova	@r6,	r1	;
 23c:	01 08       	mova	@r8,	r1	;
 23e:	01 41       	mov	r1,	r1	;
 240:	16 00       	mova	@r0+,	r6	;
 242:	00 00       	beq			
 244:	6d 73       	subc.b	#2,	r13	;r3 As==10
 246:	70 61       	addc.b	@r1+,	r0	;
 248:	62 69       	addc.b	@r9,	r2	;
 24a:	00 01       	bra	@r1		;
 24c:	0b 00       	mova	@r0,	r11	;
 24e:	00 00       	beq			
 250:	04 01       	mova	@r1,	r4	;
 252:	06 01       	mova	@r1,	r6	;
 254:	08 01       	mova	@r1,	r8	;
 256:	41 16       	popm.a	#5,	r5	;20-bit words
 258:	00 00       	beq			
 25a:	00 6d       	addc	r13,	r0	;
 25c:	73 70       	.word	0x7073;	????
 25e:	61 62       	addc.b	#4,	r1	;r2 As==10
 260:	69 00 01 0b 	mova	r0,	&592641	; 0x90b01
 264:	00 00       	beq			
 266:	00 04       	bra	@r4		;
 268:	01 06       	mova	@r6,	r1	;
 26a:	01 08       	mova	@r8,	r1	;
 26c:	01 41       	mov	r1,	r1	;
 26e:	16 00       	mova	@r0+,	r6	;
 270:	00 00       	beq			
 272:	6d 73       	subc.b	#2,	r13	;r3 As==10
 274:	70 61       	addc.b	@r1+,	r0	;
 276:	62 69       	addc.b	@r9,	r2	;
 278:	00 01       	bra	@r1		;
 27a:	0b 00       	mova	@r0,	r11	;
 27c:	00 00       	beq			
 27e:	04 01       	mova	@r1,	r4	;
 280:	06 01       	mova	@r1,	r6	;
 282:	08 01       	mova	@r1,	r8	;
 284:	41 16       	popm.a	#5,	r5	;20-bit words
 286:	00 00       	beq			
 288:	00 6d       	addc	r13,	r0	;
 28a:	73 70       	.word	0x7073;	????
 28c:	61 62       	addc.b	#4,	r1	;r2 As==10
 28e:	69 00 01 0b 	mova	r0,	&592641	; 0x90b01
 292:	00 00       	beq			
 294:	00 04       	bra	@r4		;
 296:	01 06       	mova	@r6,	r1	;
 298:	01 08       	mova	@r8,	r1	;
 29a:	01 41       	mov	r1,	r1	;
 29c:	16 00       	mova	@r0+,	r6	;
 29e:	00 00       	beq			
 2a0:	6d 73       	subc.b	#2,	r13	;r3 As==10
 2a2:	70 61       	addc.b	@r1+,	r0	;
 2a4:	62 69       	addc.b	@r9,	r2	;
 2a6:	00 01       	bra	@r1		;
 2a8:	0b 00       	mova	@r0,	r11	;
 2aa:	00 00       	beq			
 2ac:	04 01       	mova	@r1,	r4	;
 2ae:	06 01       	mova	@r1,	r6	;
 2b0:	08 01       	mova	@r1,	r8	;
 2b2:	41 16       	popm.a	#5,	r5	;20-bit words
 2b4:	00 00       	beq			
 2b6:	00 6d       	addc	r13,	r0	;
 2b8:	73 70       	.word	0x7073;	????
 2ba:	61 62       	addc.b	#4,	r1	;r2 As==10
 2bc:	69 00 01 0b 	mova	r0,	&592641	; 0x90b01
 2c0:	00 00       	beq			
 2c2:	00 04       	bra	@r4		;
 2c4:	01 06       	mova	@r6,	r1	;
 2c6:	01 08       	mova	@r8,	r1	;
 2c8:	01 41       	mov	r1,	r1	;
 2ca:	16 00       	mova	@r0+,	r6	;
 2cc:	00 00       	beq			
 2ce:	6d 73       	subc.b	#2,	r13	;r3 As==10
 2d0:	70 61       	addc.b	@r1+,	r0	;
 2d2:	62 69       	addc.b	@r9,	r2	;
 2d4:	00 01       	bra	@r1		;
 2d6:	0b 00       	mova	@r0,	r11	;
 2d8:	00 00       	beq			
 2da:	04 01       	mova	@r1,	r4	;
 2dc:	06 01       	mova	@r1,	r6	;
 2de:	08 01       	mova	@r1,	r8	;
 2e0:	41 16       	popm.a	#5,	r5	;20-bit words
 2e2:	00 00       	beq			
 2e4:	00 6d       	addc	r13,	r0	;
 2e6:	73 70       	.word	0x7073;	????
 2e8:	61 62       	addc.b	#4,	r1	;r2 As==10
 2ea:	69 00 01 0b 	mova	r0,	&592641	; 0x90b01
 2ee:	00 00       	beq			
 2f0:	00 04       	bra	@r4		;
 2f2:	01 06       	mova	@r6,	r1	;
 2f4:	01 08       	mova	@r8,	r1	;
 2f6:	01 41       	mov	r1,	r1	;
 2f8:	16 00       	mova	@r0+,	r6	;
 2fa:	00 00       	beq			
 2fc:	6d 73       	subc.b	#2,	r13	;r3 As==10
 2fe:	70 61       	addc.b	@r1+,	r0	;
 300:	62 69       	addc.b	@r9,	r2	;
 302:	00 01       	bra	@r1		;
 304:	0b 00       	mova	@r0,	r11	;
 306:	00 00       	beq			
 308:	04 01       	mova	@r1,	r4	;
 30a:	06 01       	mova	@r1,	r6	;
 30c:	08 01       	mova	@r1,	r8	;
 30e:	41 16       	popm.a	#5,	r5	;20-bit words
 310:	00 00       	beq			
 312:	00 6d       	addc	r13,	r0	;
 314:	73 70       	.word	0x7073;	????
 316:	61 62       	addc.b	#4,	r1	;r2 As==10
 318:	69 00 01 0b 	mova	r0,	&592641	; 0x90b01
 31c:	00 00       	beq			
 31e:	00 04       	bra	@r4		;
 320:	01 06       	mova	@r6,	r1	;
 322:	01 08       	mova	@r8,	r1	;
 324:	01 41       	mov	r1,	r1	;
 326:	16 00       	mova	@r0+,	r6	;
 328:	00 00       	beq			
 32a:	6d 73       	subc.b	#2,	r13	;r3 As==10
 32c:	70 61       	addc.b	@r1+,	r0	;
 32e:	62 69       	addc.b	@r9,	r2	;
 330:	00 01       	bra	@r1		;
 332:	0b 00       	mova	@r0,	r11	;
 334:	00 00       	beq			
 336:	04 01       	mova	@r1,	r4	;
 338:	06 01       	mova	@r1,	r6	;
 33a:	08 01       	mova	@r1,	r8	;
 33c:	41 16       	popm.a	#5,	r5	;20-bit words
 33e:	00 00       	beq			
 340:	00 6d       	addc	r13,	r0	;
 342:	73 70       	.word	0x7073;	????
 344:	61 62       	addc.b	#4,	r1	;r2 As==10
 346:	69 00 01 0b 	mova	r0,	&592641	; 0x90b01
 34a:	00 00       	beq			
 34c:	00 04       	bra	@r4		;
 34e:	01 06       	mova	@r6,	r1	;
 350:	01 08       	mova	@r8,	r1	;
 352:	01 41       	mov	r1,	r1	;
 354:	16 00       	mova	@r0+,	r6	;
 356:	00 00       	beq			
 358:	6d 73       	subc.b	#2,	r13	;r3 As==10
 35a:	70 61       	addc.b	@r1+,	r0	;
 35c:	62 69       	addc.b	@r9,	r2	;
 35e:	00 01       	bra	@r1		;
 360:	0b 00       	mova	@r0,	r11	;
 362:	00 00       	beq			
 364:	04 01       	mova	@r1,	r4	;
 366:	06 01       	mova	@r1,	r6	;
 368:	08 01       	mova	@r1,	r8	;
 36a:	41 16       	popm.a	#5,	r5	;20-bit words
 36c:	00 00       	beq			
 36e:	00 6d       	addc	r13,	r0	;
 370:	73 70       	.word	0x7073;	????
 372:	61 62       	addc.b	#4,	r1	;r2 As==10
 374:	69 00 01 0b 	mova	r0,	&592641	; 0x90b01
 378:	00 00       	beq			
 37a:	00 04       	bra	@r4		;
 37c:	01 06       	mova	@r6,	r1	;
 37e:	01 08       	mova	@r8,	r1	;
 380:	01 41       	mov	r1,	r1	;
 382:	16 00       	mova	@r0+,	r6	;
 384:	00 00       	beq			
 386:	6d 73       	subc.b	#2,	r13	;r3 As==10
 388:	70 61       	addc.b	@r1+,	r0	;
 38a:	62 69       	addc.b	@r9,	r2	;
 38c:	00 01       	bra	@r1		;
 38e:	0b 00       	mova	@r0,	r11	;
 390:	00 00       	beq			
 392:	04 01       	mova	@r1,	r4	;
 394:	06 01       	mova	@r1,	r6	;
 396:	08 01       	mova	@r1,	r8	;
 398:	41 16       	popm.a	#5,	r5	;20-bit words
 39a:	00 00       	beq			
 39c:	00 6d       	addc	r13,	r0	;
 39e:	73 70       	.word	0x7073;	????
 3a0:	61 62       	addc.b	#4,	r1	;r2 As==10
 3a2:	69 00 01 0b 	mova	r0,	&592641	; 0x90b01
 3a6:	00 00       	beq			
 3a8:	00 04       	bra	@r4		;
 3aa:	01 06       	mova	@r6,	r1	;
 3ac:	01 08       	mova	@r8,	r1	;
 3ae:	01 41       	mov	r1,	r1	;
 3b0:	16 00       	mova	@r0+,	r6	;
 3b2:	00 00       	beq			
 3b4:	6d 73       	subc.b	#2,	r13	;r3 As==10
 3b6:	70 61       	addc.b	@r1+,	r0	;
 3b8:	62 69       	addc.b	@r9,	r2	;
 3ba:	00 01       	bra	@r1		;
 3bc:	0b 00       	mova	@r0,	r11	;
 3be:	00 00       	beq			
 3c0:	04 01       	mova	@r1,	r4	;
 3c2:	06 01       	mova	@r1,	r6	;
 3c4:	08 01       	mova	@r1,	r8	;
 3c6:	41 16       	popm.a	#5,	r5	;20-bit words
 3c8:	00 00       	beq			
 3ca:	00 6d       	addc	r13,	r0	;
 3cc:	73 70       	.word	0x7073;	????
 3ce:	61 62       	addc.b	#4,	r1	;r2 As==10
 3d0:	69 00 01 0b 	mova	r0,	&592641	; 0x90b01
 3d4:	00 00       	beq			
 3d6:	00 04       	bra	@r4		;
 3d8:	01 06       	mova	@r6,	r1	;
 3da:	01 08       	mova	@r8,	r1	;
 3dc:	01 41       	mov	r1,	r1	;
 3de:	16 00       	mova	@r0+,	r6	;
 3e0:	00 00       	beq			
 3e2:	6d 73       	subc.b	#2,	r13	;r3 As==10
 3e4:	70 61       	addc.b	@r1+,	r0	;
 3e6:	62 69       	addc.b	@r9,	r2	;
 3e8:	00 01       	bra	@r1		;
 3ea:	0b 00       	mova	@r0,	r11	;
 3ec:	00 00       	beq			
 3ee:	04 01       	mova	@r1,	r4	;
 3f0:	06 01       	mova	@r1,	r6	;
 3f2:	08 01       	mova	@r1,	r8	;
 3f4:	41 16       	popm.a	#5,	r5	;20-bit words
 3f6:	00 00       	beq			
 3f8:	00 6d       	addc	r13,	r0	;
 3fa:	73 70       	.word	0x7073;	????
 3fc:	61 62       	addc.b	#4,	r1	;r2 As==10
 3fe:	69 00 01 0b 	mova	r0,	&592641	; 0x90b01
 402:	00 00       	beq			
 404:	00 04       	bra	@r4		;
 406:	01 06       	mova	@r6,	r1	;
 408:	01 08       	mova	@r8,	r1	;
 40a:	01 41       	mov	r1,	r1	;
 40c:	16 00       	mova	@r0+,	r6	;
 40e:	00 00       	beq			
 410:	6d 73       	subc.b	#2,	r13	;r3 As==10
 412:	70 61       	addc.b	@r1+,	r0	;
 414:	62 69       	addc.b	@r9,	r2	;
 416:	00 01       	bra	@r1		;
 418:	0b 00       	mova	@r0,	r11	;
 41a:	00 00       	beq			
 41c:	04 01       	mova	@r1,	r4	;
 41e:	06 01       	mova	@r1,	r6	;
 420:	08 01       	mova	@r1,	r8	;
 422:	41 16       	popm.a	#5,	r5	;20-bit words
 424:	00 00       	beq			
 426:	00 6d       	addc	r13,	r0	;
 428:	73 70       	.word	0x7073;	????
 42a:	61 62       	addc.b	#4,	r1	;r2 As==10
 42c:	69 00 01 0b 	mova	r0,	&592641	; 0x90b01
 430:	00 00       	beq			
 432:	00 04       	bra	@r4		;
 434:	01 06       	mova	@r6,	r1	;
 436:	01 08       	mova	@r8,	r1	;
 438:	01 41       	mov	r1,	r1	;
 43a:	16 00       	mova	@r0+,	r6	;
 43c:	00 00       	beq			
 43e:	6d 73       	subc.b	#2,	r13	;r3 As==10
 440:	70 61       	addc.b	@r1+,	r0	;
 442:	62 69       	addc.b	@r9,	r2	;
 444:	00 01       	bra	@r1		;
 446:	0b 00       	mova	@r0,	r11	;
 448:	00 00       	beq			
 44a:	04 01       	mova	@r1,	r4	;
 44c:	06 01       	mova	@r1,	r6	;
 44e:	08 01       	mova	@r1,	r8	;
 450:	41 16       	popm.a	#5,	r5	;20-bit words
 452:	00 00       	beq			
 454:	00 6d       	addc	r13,	r0	;
 456:	73 70       	.word	0x7073;	????
 458:	61 62       	addc.b	#4,	r1	;r2 As==10
 45a:	69 00 01 0b 	mova	r0,	&592641	; 0x90b01
 45e:	00 00       	beq			
 460:	00 04       	bra	@r4		;
 462:	01 06       	mova	@r6,	r1	;
 464:	01 08       	mova	@r8,	r1	;
 466:	01 41       	mov	r1,	r1	;
 468:	16 00       	mova	@r0+,	r6	;
 46a:	00 00       	beq			
 46c:	6d 73       	subc.b	#2,	r13	;r3 As==10
 46e:	70 61       	addc.b	@r1+,	r0	;
 470:	62 69       	addc.b	@r9,	r2	;
 472:	00 01       	bra	@r1		;
 474:	0b 00       	mova	@r0,	r11	;
 476:	00 00       	beq			
 478:	04 01       	mova	@r1,	r4	;
 47a:	06 01       	mova	@r1,	r6	;
 47c:	08 01       	mova	@r1,	r8	;
 47e:	41 16       	popm.a	#5,	r5	;20-bit words
 480:	00 00       	beq			
 482:	00 6d       	addc	r13,	r0	;
 484:	73 70       	.word	0x7073;	????
 486:	61 62       	addc.b	#4,	r1	;r2 As==10
 488:	69 00 01 0b 	mova	r0,	&592641	; 0x90b01
 48c:	00 00       	beq			
 48e:	00 04       	bra	@r4		;
 490:	01 06       	mova	@r6,	r1	;
 492:	01 08       	mova	@r8,	r1	;
 494:	01 41       	mov	r1,	r1	;
 496:	16 00       	mova	@r0+,	r6	;
 498:	00 00       	beq			
 49a:	6d 73       	subc.b	#2,	r13	;r3 As==10
 49c:	70 61       	addc.b	@r1+,	r0	;
 49e:	62 69       	addc.b	@r9,	r2	;
 4a0:	00 01       	bra	@r1		;
 4a2:	0b 00       	mova	@r0,	r11	;
 4a4:	00 00       	beq			
 4a6:	04 01       	mova	@r1,	r4	;
 4a8:	06 01       	mova	@r1,	r6	;
 4aa:	08 01       	mova	@r1,	r8	;
 4ac:	41 16       	popm.a	#5,	r5	;20-bit words
 4ae:	00 00       	beq			
 4b0:	00 6d       	addc	r13,	r0	;
 4b2:	73 70       	.word	0x7073;	????
 4b4:	61 62       	addc.b	#4,	r1	;r2 As==10
 4b6:	69 00 01 0b 	mova	r0,	&592641	; 0x90b01
 4ba:	00 00       	beq			
 4bc:	00 04       	bra	@r4		;
 4be:	01 06       	mova	@r6,	r1	;
 4c0:	01 08       	mova	@r8,	r1	;
 4c2:	01 41       	mov	r1,	r1	;
 4c4:	16 00       	mova	@r0+,	r6	;
 4c6:	00 00       	beq			
 4c8:	6d 73       	subc.b	#2,	r13	;r3 As==10
 4ca:	70 61       	addc.b	@r1+,	r0	;
 4cc:	62 69       	addc.b	@r9,	r2	;
 4ce:	00 01       	bra	@r1		;
 4d0:	0b 00       	mova	@r0,	r11	;
 4d2:	00 00       	beq			
 4d4:	04 01       	mova	@r1,	r4	;
 4d6:	06 01       	mova	@r1,	r6	;
 4d8:	08 01       	mova	@r1,	r8	;
 4da:	41 16       	popm.a	#5,	r5	;20-bit words
 4dc:	00 00       	beq			
 4de:	00 6d       	addc	r13,	r0	;
 4e0:	73 70       	.word	0x7073;	????
 4e2:	61 62       	addc.b	#4,	r1	;r2 As==10
 4e4:	69 00 01 0b 	mova	r0,	&592641	; 0x90b01
 4e8:	00 00       	beq			
 4ea:	00 04       	bra	@r4		;
 4ec:	01 06       	mova	@r6,	r1	;
 4ee:	01 08       	mova	@r8,	r1	;
 4f0:	01 41       	mov	r1,	r1	;
 4f2:	16 00       	mova	@r0+,	r6	;
 4f4:	00 00       	beq			
 4f6:	6d 73       	subc.b	#2,	r13	;r3 As==10
 4f8:	70 61       	addc.b	@r1+,	r0	;
 4fa:	62 69       	addc.b	@r9,	r2	;
 4fc:	00 01       	bra	@r1		;
 4fe:	0b 00       	mova	@r0,	r11	;
 500:	00 00       	beq			
 502:	04 01       	mova	@r1,	r4	;
 504:	06 01       	mova	@r1,	r6	;
 506:	08 01       	mova	@r1,	r8	;
 508:	41 16       	popm.a	#5,	r5	;20-bit words
 50a:	00 00       	beq			
 50c:	00 6d       	addc	r13,	r0	;
 50e:	73 70       	.word	0x7073;	????
 510:	61 62       	addc.b	#4,	r1	;r2 As==10
 512:	69 00 01 0b 	mova	r0,	&592641	; 0x90b01
 516:	00 00       	beq			
 518:	00 04       	bra	@r4		;
 51a:	01 06       	mova	@r6,	r1	;
 51c:	01 08       	mova	@r8,	r1	;
 51e:	01 41       	mov	r1,	r1	;
 520:	16 00       	mova	@r0+,	r6	;
 522:	00 00       	beq			
 524:	6d 73       	subc.b	#2,	r13	;r3 As==10
 526:	70 61       	addc.b	@r1+,	r0	;
 528:	62 69       	addc.b	@r9,	r2	;
 52a:	00 01       	bra	@r1		;
 52c:	0b 00       	mova	@r0,	r11	;
 52e:	00 00       	beq			
 530:	04 01       	mova	@r1,	r4	;
 532:	06 01       	mova	@r1,	r6	;
 534:	08 01       	mova	@r1,	r8	;
 536:	41 16       	popm.a	#5,	r5	;20-bit words
 538:	00 00       	beq			
 53a:	00 6d       	addc	r13,	r0	;
 53c:	73 70       	.word	0x7073;	????
 53e:	61 62       	addc.b	#4,	r1	;r2 As==10
 540:	69 00 01 0b 	mova	r0,	&592641	; 0x90b01
 544:	00 00       	beq			
 546:	00 04       	bra	@r4		;
 548:	01 06       	mova	@r6,	r1	;
 54a:	01 08       	mova	@r8,	r1	;
 54c:	01 41       	mov	r1,	r1	;
 54e:	16 00       	mova	@r0+,	r6	;
 550:	00 00       	beq			
 552:	6d 73       	subc.b	#2,	r13	;r3 As==10
 554:	70 61       	addc.b	@r1+,	r0	;
 556:	62 69       	addc.b	@r9,	r2	;
 558:	00 01       	bra	@r1		;
 55a:	0b 00       	mova	@r0,	r11	;
 55c:	00 00       	beq			
 55e:	04 01       	mova	@r1,	r4	;
 560:	06 01       	mova	@r1,	r6	;
 562:	08 01       	mova	@r1,	r8	;
 564:	41 16       	popm.a	#5,	r5	;20-bit words
 566:	00 00       	beq			
 568:	00 6d       	addc	r13,	r0	;
 56a:	73 70       	.word	0x7073;	????
 56c:	61 62       	addc.b	#4,	r1	;r2 As==10
 56e:	69 00 01 0b 	mova	r0,	&592641	; 0x90b01
 572:	00 00       	beq			
 574:	00 04       	bra	@r4		;
 576:	01 06       	mova	@r6,	r1	;
 578:	01 08       	mova	@r8,	r1	;
 57a:	01 13       	Address 0x0000057a is out of bounds.
.word	0xffff;	????

Disassembly of section .comment:

00000000 <.comment>:

__crt0_begin:
; -----------------------------------------------------------
; Get required system info
; -----------------------------------------------------------
    mov  &0xFFF8, r8 ; = DMEM (RAM) base address
   0:	47 43       	clr.b	r7		;
   2:	43 3a       	jl	$-888    	;abs 0xfffffc8a
    mov  &0xFFFA, r1 ; = DMEM (RAM) size in byte
   4:	20 28       	jnc	$+66     	;abs 0x46
   6:	53 4f       	.word	0x4f53;	????


; -----------------------------------------------------------
; Minimal required hardware setup
; -----------------------------------------------------------
    mov  #0, r2           ; clear status register & disable interrupts
   8:	4d 4e       	mov.b	r14,	r13	;
    add  r8, r1           ; r1 = stack pointer = end of RAM
   a:	49 55       	add.b	r5,	r9	;
    mov  #0x4700, &0xFFB8 ; deactivate watchdog
   c:	4d 20       	jnz	$+156    	;abs 0xa8
   e:	54 65 63 68 	addc.b	26723(r5),r4	;0x06863
; Initialize all IO device registers (set to zero)
; -----------------------------------------------------------
; This loop does not trigger any operations as the CTRL registers, which are located
; at offset 0 of the according device, are set to zero resulting in disabling the
; specific device.
    mov  #0xFF80, r9 ; beginning of IO section
  12:	6e 6f       	addc.b	@r15,	r14	;
  14:	6c 6f       	addc.b	@r15,	r12	;
__crt0_clr_io:
      tst  r9 ; until the end -> wrap-around to 0
  16:	67 69       	addc.b	@r9,	r7	;
      jeq  __crt0_clr_io_end
  18:	65 73       	subc.b	#2,	r5	;r3 As==10
      mov  #0, 0(r9) ; clear entry
  1a:	20 4c       	br	@r12		;
  1c:	69 6d       	addc.b	@r13,	r9	;
      incd r9
  1e:	69 74       	subc.b	@r4,	r9	;
      jmp  __crt0_clr_io
  20:	65 64       	addc.b	@r4,	r5	;

; -----------------------------------------------------------
; Clear complete DMEM (including .bss section)
; -----------------------------------------------------------
__crt0_clr_dmem:
      cmp  r8, r1 ; base address equal to end of RAM?
  22:	20 2d       	jc	$+578    	;abs 0x264
      jeq  __crt0_clr_dmem_end
  24:	20 6d       	addc	@r13,	r0	;
      mov  #0, 0(r8) ; clear entry
  26:	73 70       	.word	0x7073;	????
  28:	34 33       	jn	$-406    	;abs 0xfffffe92
      incd r8
  2a:	30 2d       	jc	$+610    	;abs 0x28c
      jmp  __crt0_clr_dmem
  2c:	67 63       	addc.b	#2,	r7	;r3 As==10


; -----------------------------------------------------------
; Copy initialized .data section from ROM to RAM
; -----------------------------------------------------------
    mov  #__data_start_rom, r5
  2e:	63 20       	jnz	$+200    	;abs 0xf6
  30:	36 2e       	jc	$-914    	;abs 0xfffffc9e
    mov  #__data_end_rom, r6
  32:	32 2e       	jc	$-922    	;abs 0xfffffc98
  34:	31 2e       	jc	$-924    	;abs 0xfffffc98
    mov  #__data_start, r7
  36:	31 36       	jge	$-924    	;abs 0xfffffc9a
  38:	29 20       	jnz	$+84     	;abs 0x8c
__crt0_cpy_data:
      cmp  r5, r6
  3a:	36 2e       	jc	$-914    	;abs 0xfffffca8
      jeq  __crt0_cpy_data_end
  3c:	32 2e       	jc	$-922    	;abs 0xfffffca2
      mov  @r5+, 0(r7)
  3e:	31 20       	jnz	$+100    	;abs 0xa2
  40:	32 30       	jn	$+102    	;abs 0xa6
      incd r7
  42:	31 36       	jge	$-924    	;abs 0xfffffca6
      jmp  __crt0_cpy_data
  44:	31 32       	jn	$-924    	;abs 0xfffffca8


; -----------------------------------------------------------
; Re-init SR and clear all pending IRQs from buffer
; -----------------------------------------------------------
    mov  #(1<<14), r2 ; this flag auto clears
  46:	31 32       	jn	$-924    	;abs 0xfffffcaa
  48:	00 00       	Address 0x00000048 is out of bounds.
.word	0xffff;	????

Disassembly of section .debug_aranges:

00000000 <L0>:

__crt0_begin:
; -----------------------------------------------------------
; Get required system info
; -----------------------------------------------------------
    mov  &0xFFF8, r8 ; = DMEM (RAM) base address
   0:	1c 00       	mova	@r0+,	r12	;
   2:	00 00       	beq			
    mov  &0xFFFA, r1 ; = DMEM (RAM) size in byte
   4:	02 00       	mova	@r0,	r2	;
   6:	00 00       	beq			


; -----------------------------------------------------------
; Minimal required hardware setup
; -----------------------------------------------------------
    mov  #0, r2           ; clear status register & disable interrupts
   8:	00 00       	beq			
    add  r8, r1           ; r1 = stack pointer = end of RAM
   a:	04 00       	mova	@r0,	r4	;
    mov  #0x4700, &0xFFB8 ; deactivate watchdog
   c:	00 00       	beq			
   e:	00 00       	beq			
  10:	00 00       	beq			
; Initialize all IO device registers (set to zero)
; -----------------------------------------------------------
; This loop does not trigger any operations as the CTRL registers, which are located
; at offset 0 of the according device, are set to zero resulting in disabling the
; specific device.
    mov  #0xFF80, r9 ; beginning of IO section
  12:	00 00       	beq			
  14:	6a 00 00 00 	mova	r0,	&655360	; 0xa0000
__crt0_clr_io:
      tst  r9 ; until the end -> wrap-around to 0
      jeq  __crt0_clr_io_end
  18:	00 00       	beq			
      mov  #0, 0(r9) ; clear entry
  1a:	00 00       	beq			
  1c:	00 00       	beq			
      incd r9
  1e:	00 00       	beq			

Disassembly of section .debug_info:

00000000 <L0>:

__crt0_begin:
; -----------------------------------------------------------
; Get required system info
; -----------------------------------------------------------
    mov  &0xFFF8, r8 ; = DMEM (RAM) base address
   0:	8f 00 00 00 	mova	#0,	r15	;
    mov  &0xFFFA, r1 ; = DMEM (RAM) size in byte
   4:	02 00       	mova	@r0,	r2	;
   6:	00 00       	beq			


; -----------------------------------------------------------
; Minimal required hardware setup
; -----------------------------------------------------------
    mov  #0, r2           ; clear status register & disable interrupts
   8:	00 00       	beq			
    add  r8, r1           ; r1 = stack pointer = end of RAM
   a:	04 01       	mova	@r1,	r4	;
    mov  #0x4700, &0xFFB8 ; deactivate watchdog
   c:	00 00       	beq			
   e:	00 00       	beq			
  10:	00 00       	beq			
; Initialize all IO device registers (set to zero)
; -----------------------------------------------------------
; This loop does not trigger any operations as the CTRL registers, which are located
; at offset 0 of the according device, are set to zero resulting in disabling the
; specific device.
    mov  #0xFF80, r9 ; beginning of IO section
  12:	00 00       	beq			
  14:	6a 00 00 00 	mova	r0,	&655360	; 0xa0000
__crt0_clr_io:
      tst  r9 ; until the end -> wrap-around to 0
      jeq  __crt0_clr_io_end
  18:	2e 2e       	jc	$-930    	;abs 0xfffffc76
      mov  #0, 0(r9) ; clear entry
  1a:	2f 63       	addc	#2,	r15	;r3 As==10
  1c:	6f 6d       	addc.b	@r13,	r15	;
      incd r9
  1e:	6d 6f       	addc.b	@r15,	r13	;
      jmp  __crt0_clr_io
  20:	6e 2f       	jc	$-290    	;abs 0xfffffefe

; -----------------------------------------------------------
; Clear complete DMEM (including .bss section)
; -----------------------------------------------------------
__crt0_clr_dmem:
      cmp  r8, r1 ; base address equal to end of RAM?
  22:	63 72       	.word	0x7263;	????
      jeq  __crt0_clr_dmem_end
  24:	74 30       	jn	$+234    	;abs 0x10e
      mov  #0, 0(r8) ; clear entry
  26:	2e 61       	addc	@r1,	r14	;
  28:	73 6d       	.word	0x6d73;	????
      incd r8
  2a:	00 2f       	jc	$-510    	;abs 0xfffffe2c
      jmp  __crt0_clr_dmem
  2c:	75 73       	subc.b	#-1,	r5	;r3 As==11


; -----------------------------------------------------------
; Copy initialized .data section from ROM to RAM
; -----------------------------------------------------------
    mov  #__data_start_rom, r5
  2e:	65 72       	subc.b	#4,	r5	;r2 As==10
  30:	73 63       	.word	0x6373;	????
    mov  #__data_end_rom, r6
  32:	2f 6e       	addc	@r14,	r15	;
  34:	67 31       	jn	$+720    	;abs 0x304
    mov  #__data_start, r7
  36:	38 37       	jge	$-398    	;abs 0xfffffea8
  38:	33 31       	jn	$+616    	;abs 0x2a0
__crt0_cpy_data:
      cmp  r5, r6
  3a:	2f 41       	mov	@r1,	r15	;
      jeq  __crt0_cpy_data_end
  3c:	54 46 43 5f 	mov.b	24387(r6),r4	;0x05f43
      mov  @r5+, 0(r7)
  40:	49 50       	add.b	r0,	r9	;
      incd r7
  42:	42 75       	subc.b	r5,	r2	;
      jmp  __crt0_cpy_data
  44:	73 5f       	.word	0x5f73;	????


; -----------------------------------------------------------
; Re-init SR and clear all pending IRQs from buffer
; -----------------------------------------------------------
    mov  #(1<<14), r2 ; this flag auto clears
  46:	6e 65       	addc.b	@r5,	r14	;
  48:	6f 5f       	add.b	@r15,	r15	;


; -----------------------------------------------------------
; Initialize all remaining registers
; -----------------------------------------------------------
    mov  #0, r4
  4a:	74 65       	addc.b	@r5+,	r4	;
;   mov  #0, r5 ; -- is already initialized
;   mov  #0, r6 ; -- is already initialized
;   mov  #0, r7 ; -- is already initialized
;   mov  #0, r8 ; -- is already initialized
;   mov  #0, r9 ; -- is already initialized
    mov  #0, r10
  4c:	73 74       	.word	0x7473;	????
    mov  #0, r11
  4e:	2f 6e       	addc	@r14,	r15	;
    mov  #0, r12 ; set argc = 0
  50:	65 6f       	addc.b	@r15,	r5	;
    mov  #0, r13
  52:	34 33       	jn	$-406    	;abs 0xfffffebc
    mov  #0, r14
  54:	30 5f       	add	@r15+,	r0	;
    mov  #0, r15
  56:	74 65       	addc.b	@r5+,	r4	;

; -----------------------------------------------------------
; This is where the actual application is started
; -----------------------------------------------------------
__crt0_start_main:
    call  #main
  58:	73 74       	.word	0x7473;	????
  5a:	2f 6d       	addc	@r13,	r15	;

; -----------------------------------------------------------
; Go to endless sleep mode if main returns
; -----------------------------------------------------------
__crt0_this_is_the_end:
    mov  #0, r2 ; deactivate IRQs
  5c:	79 46       	mov.b	@r6+,	r9	;
    mov  #0x4700, &0xFFB8 ; deactivate watchdog
  5e:	77 41       	pop.b	r7		;
  60:	72 65       	addc.b	@r5+,	r2	;
  62:	61 2f       	jc	$-316    	;abs 0xffffff26
    mov  #(1<<4), r2 ; set CPU to sleep mode
  64:	73 72       	.word	0x7273;	????
  66:	63 2f       	jc	$-312    	;abs 0xffffff2e
    nop
  68:	6e 65       	addc.b	@r5,	r14	;
  6a:	6f 34       	jge	$+224    	;abs 0x14a
  6c:	33 30       	jn	$+104    	;abs 0xd4
  6e:	5f 69 70 62 	addc.b	25200(r9),r15	;0x06270
  72:	75 73       	subc.b	#-1,	r5	;r3 As==11
  74:	2f 73       	subc	#2,	r15	;r3 As==10
  76:	6f 66       	addc.b	@r6,	r15	;
  78:	74 77       	subc.b	@r7+,	r4	;
  7a:	61 72       	subc.b	#4,	r1	;r2 As==10
  7c:	65 2f       	jc	$-308    	;abs 0xffffff48
  7e:	63 6f       	.word	0x6f63;	????
  80:	6d 6d       	addc.b	@r13,	r13	;
  82:	6f 6e       	addc.b	@r14,	r15	;
  84:	00 47       	br	r7		;
  86:	4e 55       	add.b	r5,	r14	;
  88:	20 41       	br	@r1		;
  8a:	53 20       	jnz	$+168    	;abs 0x132
  8c:	32 2e       	jc	$-922    	;abs 0xfffffcf2
  8e:	32 36       	jge	$-922    	;abs 0xfffffcf4
  90:	00 01       	bra	@r1		;
  92:	80 00       	Address 0x00000092 is out of bounds.
.word	0xffff;	????

Disassembly of section .debug_abbrev:

00000000 <.debug_abbrev>:

__crt0_begin:
; -----------------------------------------------------------
; Get required system info
; -----------------------------------------------------------
    mov  &0xFFF8, r8 ; = DMEM (RAM) base address
   0:	01 11       	rra	r1		;
   2:	00 10       	rrc	r0		;
    mov  &0xFFFA, r1 ; = DMEM (RAM) size in byte
   4:	06 11       	rra	r6		;
   6:	01 12       	push	r1		;


; -----------------------------------------------------------
; Minimal required hardware setup
; -----------------------------------------------------------
    mov  #0, r2           ; clear status register & disable interrupts
   8:	01 03       	mova	@r3,	r1	;
    add  r8, r1           ; r1 = stack pointer = end of RAM
   a:	08 1b 08 25 	rpt #9 { jzx.?	$+530    	;abs 0x21e, Reserved use of A/L and B/W bits detected
    mov  #0x4700, &0xFFB8 ; deactivate watchdog
   e:	08 13       	reti			;return from interupt
  10:	05 00       	mova	@r0,	r5	;
; Initialize all IO device registers (set to zero)
; -----------------------------------------------------------
; This loop does not trigger any operations as the CTRL registers, which are located
; at offset 0 of the according device, are set to zero resulting in disabling the
; specific device.
    mov  #0xFF80, r9 ; beginning of IO section
  12:	00 00       	beq			

Disassembly of section .debug_line:

00000000 <L0>:

__crt0_begin:
; -----------------------------------------------------------
; Get required system info
; -----------------------------------------------------------
    mov  &0xFFF8, r8 ; = DMEM (RAM) base address
   0:	17 01       	mova	@r1+,	r7	;
   2:	00 00       	beq			
    mov  &0xFFFA, r1 ; = DMEM (RAM) size in byte
   4:	02 00       	mova	@r0,	r2	;
   6:	29 00 00 00 	mova	&0,	r9	;

0000000a <L0>:

; -----------------------------------------------------------
; Minimal required hardware setup
; -----------------------------------------------------------
    mov  #0, r2           ; clear status register & disable interrupts
    add  r8, r1           ; r1 = stack pointer = end of RAM
   a:	01 01       	mova	@r1,	r1	;
    mov  #0x4700, &0xFFB8 ; deactivate watchdog
   c:	fb 0e       	suba	r14,	r11	;
   e:	0d 00       	mova	@r0,	r13	;
  10:	01 01       	mova	@r1,	r1	;
; Initialize all IO device registers (set to zero)
; -----------------------------------------------------------
; This loop does not trigger any operations as the CTRL registers, which are located
; at offset 0 of the according device, are set to zero resulting in disabling the
; specific device.
    mov  #0xFF80, r9 ; beginning of IO section
  12:	01 01       	mova	@r1,	r1	;
  14:	00 00       	beq			
__crt0_clr_io:
      tst  r9 ; until the end -> wrap-around to 0
  16:	00 01       	bra	@r1		;
      jeq  __crt0_clr_io_end
  18:	00 00       	beq			
      mov  #0, 0(r9) ; clear entry
  1a:	01 2e       	jc	$-1020   	;abs 0xfffffc1e
  1c:	2e 2f       	jc	$-418    	;abs 0xfffffe7a
      incd r9
  1e:	63 6f       	.word	0x6f63;	????
      jmp  __crt0_clr_io
  20:	6d 6d       	addc.b	@r13,	r13	;

; -----------------------------------------------------------
; Clear complete DMEM (including .bss section)
; -----------------------------------------------------------
__crt0_clr_dmem:
      cmp  r8, r1 ; base address equal to end of RAM?
  22:	6f 6e       	addc.b	@r14,	r15	;
      jeq  __crt0_clr_dmem_end
  24:	00 00       	beq			
      mov  #0, 0(r8) ; clear entry
  26:	63 72       	.word	0x7263;	????
  28:	74 30       	jn	$+234    	;abs 0x112
      incd r8
  2a:	2e 61       	addc	@r1,	r14	;
      jmp  __crt0_clr_dmem
  2c:	73 6d       	.word	0x6d73;	????


; -----------------------------------------------------------
; Copy initialized .data section from ROM to RAM
; -----------------------------------------------------------
    mov  #__data_start_rom, r5
  2e:	00 01       	bra	@r1		;
  30:	00 00       	beq			
    mov  #__data_end_rom, r6
  32:	00 00       	beq			
  34:	05 02       	mova	@r2,	r5	;
    mov  #__data_start, r7
  36:	00 00       	beq			
  38:	00 00       	beq			
__crt0_cpy_data:
      cmp  r5, r6
  3a:	03 20       	jnz	$+8      	;abs 0x42
      jeq  __crt0_cpy_data_end
  3c:	01 03       	mova	@r3,	r1	;
      mov  @r5+, 0(r7)
  3e:	01 09       	mova	@r9,	r1	;
  40:	04 00       	mova	@r0,	r4	;
      incd r7
  42:	01 03       	mova	@r3,	r1	;
      jmp  __crt0_cpy_data
  44:	06 09       	mova	@r9,	r6	;


; -----------------------------------------------------------
; Re-init SR and clear all pending IRQs from buffer
; -----------------------------------------------------------
    mov  #(1<<14), r2 ; this flag auto clears
  46:	04 00       	mova	@r0,	r4	;
  48:	01 03       	mova	@r3,	r1	;


; -----------------------------------------------------------
; Initialize all remaining registers
; -----------------------------------------------------------
    mov  #0, r4
  4a:	01 09       	mova	@r9,	r1	;
;   mov  #0, r5 ; -- is already initialized
;   mov  #0, r6 ; -- is already initialized
;   mov  #0, r7 ; -- is already initialized
;   mov  #0, r8 ; -- is already initialized
;   mov  #0, r9 ; -- is already initialized
    mov  #0, r10
  4c:	02 00       	mova	@r0,	r2	;
    mov  #0, r11
  4e:	01 03       	mova	@r3,	r1	;
    mov  #0, r12 ; set argc = 0
  50:	01 09       	mova	@r9,	r1	;
    mov  #0, r13
  52:	02 00       	mova	@r0,	r2	;
    mov  #0, r14
  54:	01 03       	mova	@r3,	r1	;
    mov  #0, r15
  56:	09 09       	mova	@r9,	r9	;

; -----------------------------------------------------------
; This is where the actual application is started
; -----------------------------------------------------------
__crt0_start_main:
    call  #main
  58:	06 00       	mova	@r0,	r6	;
  5a:	01 03       	mova	@r3,	r1	;

; -----------------------------------------------------------
; Go to endless sleep mode if main returns
; -----------------------------------------------------------
__crt0_this_is_the_end:
    mov  #0, r2 ; deactivate IRQs
  5c:	02 09       	mova	@r9,	r2	;
    mov  #0x4700, &0xFFB8 ; deactivate watchdog
  5e:	04 00       	mova	@r0,	r4	;
  60:	01 03       	mova	@r3,	r1	;
  62:	01 09       	mova	@r9,	r1	;
    mov  #(1<<4), r2 ; set CPU to sleep mode
  64:	02 00       	mova	@r0,	r2	;
  66:	01 03       	mova	@r3,	r1	;
    nop
  68:	01 09       	mova	@r9,	r1	;
  6a:	02 00       	mova	@r0,	r2	;
  6c:	01 03       	mova	@r3,	r1	;
  6e:	01 09       	mova	@r9,	r1	;
  70:	04 00       	mova	@r0,	r4	;
  72:	01 03       	mova	@r3,	r1	;
  74:	01 09       	mova	@r9,	r1	;
  76:	02 00       	mova	@r0,	r2	;
  78:	01 03       	mova	@r3,	r1	;
  7a:	08 09       	mova	@r9,	r8	;
  7c:	02 00       	mova	@r0,	r2	;
  7e:	01 03       	mova	@r3,	r1	;
  80:	01 09       	mova	@r9,	r1	;
  82:	02 00       	mova	@r0,	r2	;
  84:	01 03       	mova	@r3,	r1	;
  86:	01 09       	mova	@r9,	r1	;
  88:	02 00       	mova	@r0,	r2	;
  8a:	01 03       	mova	@r3,	r1	;
  8c:	01 09       	mova	@r9,	r1	;
  8e:	04 00       	mova	@r0,	r4	;
  90:	01 03       	mova	@r3,	r1	;
  92:	01 09       	mova	@r9,	r1	;
  94:	02 00       	mova	@r0,	r2	;
  96:	01 03       	mova	@r3,	r1	;
  98:	07 09       	mova	@r9,	r7	;
  9a:	02 00       	mova	@r0,	r2	;
  9c:	01 03       	mova	@r3,	r1	;
  9e:	01 09       	mova	@r9,	r1	;
  a0:	04 00       	mova	@r0,	r4	;
  a2:	01 03       	mova	@r3,	r1	;
  a4:	01 09       	mova	@r9,	r1	;
  a6:	04 00       	mova	@r0,	r4	;
  a8:	01 03       	mova	@r3,	r1	;
  aa:	02 09       	mova	@r9,	r2	;
  ac:	04 00       	mova	@r0,	r4	;
  ae:	01 03       	mova	@r3,	r1	;
  b0:	01 09       	mova	@r9,	r1	;
  b2:	02 00       	mova	@r0,	r2	;
  b4:	01 03       	mova	@r3,	r1	;
  b6:	01 09       	mova	@r9,	r1	;
  b8:	02 00       	mova	@r0,	r2	;
  ba:	01 03       	mova	@r3,	r1	;
  bc:	01 09       	mova	@r9,	r1	;
  be:	04 00       	mova	@r0,	r4	;
  c0:	01 03       	mova	@r3,	r1	;
  c2:	01 09       	mova	@r9,	r1	;
  c4:	02 00       	mova	@r0,	r2	;
  c6:	01 03       	mova	@r3,	r1	;
  c8:	07 09       	mova	@r9,	r7	;
  ca:	02 00       	mova	@r0,	r2	;
  cc:	01 03       	mova	@r3,	r1	;
  ce:	06 09       	mova	@r9,	r6	;
  d0:	04 00       	mova	@r0,	r4	;
  d2:	01 03       	mova	@r3,	r1	;
  d4:	06 09       	mova	@r9,	r6	;
  d6:	02 00       	mova	@r0,	r2	;
  d8:	01 03       	mova	@r3,	r1	;
  da:	01 09       	mova	@r9,	r1	;
  dc:	02 00       	mova	@r0,	r2	;
  de:	01 03       	mova	@r3,	r1	;
  e0:	01 09       	mova	@r9,	r1	;
  e2:	02 00       	mova	@r0,	r2	;
  e4:	01 03       	mova	@r3,	r1	;
  e6:	01 09       	mova	@r9,	r1	;
  e8:	02 00       	mova	@r0,	r2	;
  ea:	01 03       	mova	@r3,	r1	;
  ec:	01 09       	mova	@r9,	r1	;
  ee:	02 00       	mova	@r0,	r2	;
  f0:	01 03       	mova	@r3,	r1	;
  f2:	01 09       	mova	@r9,	r1	;
  f4:	02 00       	mova	@r0,	r2	;
  f6:	01 03       	mova	@r3,	r1	;
  f8:	07 09       	mova	@r9,	r7	;
  fa:	02 00       	mova	@r0,	r2	;
  fc:	01 03       	mova	@r3,	r1	;
  fe:	07 09       	mova	@r9,	r7	;
 100:	04 00       	mova	@r0,	r4	;
 102:	01 03       	mova	@r3,	r1	;
 104:	01 09       	mova	@r9,	r1	;
 106:	02 00       	mova	@r0,	r2	;
 108:	01 03       	mova	@r3,	r1	;
 10a:	01 09       	mova	@r9,	r1	;
 10c:	06 00       	mova	@r0,	r6	;
 10e:	01 03       	mova	@r3,	r1	;
 110:	01 09       	mova	@r9,	r1	;
 112:	04 00       	mova	@r0,	r4	;
 114:	01 09       	mova	@r9,	r1	;
 116:	02 00       	mova	@r0,	r2	;
 118:	00 01       	bra	@r1		;
 11a:	01 f7       	Address 0x0000011a is out of bounds.
.word	0xffff;	????
