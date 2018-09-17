
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
      2e:	35 40 ee 31 	mov	#12782,	r5	;#0x31ee

00000032 <.Loc.77.1>:
    mov  #__data_end_rom, r6
      32:	36 40 da 32 	mov	#13018,	r6	;#0x32da

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
      58:	b0 12 7a 06 	call	#1658		;#0x067a

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
      96:	30 40 1c 0e 	br	#0x0e1c		;

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
      e8:	b0 12 4a 0e 	call	#3658		;#0x0e4a
      ec:	3d 40 90 ff 	mov	#65424,	r13	;#0xff90
      f0:	8d 4c 00 00 	mov	r12,	0(r13)	;
      f4:	ca 47 9a ff 	mov.b	r7,	-102(r10); 0xff9a
      f8:	82 48 96 ff 	mov	r8,	&0xff96	;
      fc:	82 49 98 ff 	mov	r9,	&0xff98	;

00000100 <.L13>:
     100:	2c 4d       	mov	@r13,	r12	;
     102:	0c 93       	cmp	#0,	r12	;r3 As==00
     104:	fd 3b       	jl	$-4      	;abs 0x100
     106:	30 40 1c 0e 	br	#0x0e1c		;

0000010a <spi_read.constprop.5>:
     10a:	3d 40 11 27 	mov	#10001,	r13	;#0x2711

0000010e <.L16>:
     10e:	1e 42 12 24 	mov	&0x2412,r14	;0x2412
     112:	1f 42 14 24 	mov	&0x2414,r15	;0x2414
     116:	3e f0 01 02 	and	#513,	r14	;#0x0201
     11a:	3e 90 01 02 	cmp	#513,	r14	;#0x0201
     11e:	08 20       	jnz	$+18     	;abs 0x130
     120:	1e 42 0a 24 	mov	&0x240a,r14	;0x240a
     124:	1f 42 0c 24 	mov	&0x240c,r15	;0x240c
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

0000013c <spi_write.constprop.6>:
     13c:	3d 40 11 27 	mov	#10001,	r13	;#0x2711

00000140 <.L21>:
     140:	1e 42 12 24 	mov	&0x2412,r14	;0x2412
     144:	1f 42 14 24 	mov	&0x2414,r15	;0x2414
     148:	6e f3       	and.b	#2,	r14	;r3 As==10
     14a:	0e 93       	cmp	#0,	r14	;r3 As==00
     14c:	07 24       	jz	$+16     	;abs 0x15c
     14e:	4f 43       	clr.b	r15		;
     150:	82 4c 0e 24 	mov	r12,	&0x240e	;
     154:	82 4f 10 24 	mov	r15,	&0x2410	;
     158:	0c 4f       	mov	r15,	r12	;

0000015a <.L20>:
     15a:	30 41       	ret			

0000015c <.L23>:
     15c:	3d 53       	add	#-1,	r13	;r3 As==11
     15e:	0d 93       	cmp	#0,	r13	;r3 As==00
     160:	ef 23       	jnz	$-32     	;abs 0x140
     162:	5c 43       	mov.b	#1,	r12	;r3 As==01
     164:	30 40 5a 01 	br	#0x015a		;

00000168 <spi_transfer16>:
     168:	21 83       	decd	r1		;
     16a:	b0 12 3c 01 	call	#316		;#0x013c
     16e:	0c 41       	mov	r1,	r12	;
     170:	b0 12 0a 01 	call	#266		;#0x010a
     174:	2c 41       	mov	@r1,	r12	;
     176:	21 53       	incd	r1		;
     178:	30 41       	ret			

0000017a <hex_str_to_uint32.constprop.10>:
     17a:	0a 12       	push	r10		;
     17c:	09 12       	push	r9		;
     17e:	08 12       	push	r8		;
     180:	07 12       	push	r7		;
     182:	06 12       	push	r6		;
     184:	05 12       	push	r5		;
     186:	04 12       	push	r4		;
     188:	3c 40 f6 80 	mov	#33014,	r12	;#0x80f6
     18c:	b0 12 60 10 	call	#4192		;#0x1060
     190:	04 4c       	mov	r12,	r4	;
     192:	0a 4c       	mov	r12,	r10	;
     194:	3a 50 ff 3f 	add	#16383,	r10	;#0x3fff
     198:	0a 5a       	rla	r10		;
     19a:	0a 5a       	rla	r10		;
     19c:	45 43       	clr.b	r5		;
     19e:	48 43       	clr.b	r8		;
     1a0:	49 43       	clr.b	r9		;
     1a2:	06 48       	mov	r8,	r6	;
     1a4:	07 49       	mov	r9,	r7	;

000001a6 <.L28>:
     1a6:	04 95       	cmp	r5,	r4	;
     1a8:	04 20       	jnz	$+10     	;abs 0x1b2
     1aa:	0c 48       	mov	r8,	r12	;
     1ac:	0d 49       	mov	r9,	r13	;
     1ae:	30 40 16 0e 	br	#0x0e16		;

000001b2 <.L32>:
     1b2:	5c 45 f6 80 	mov.b	-32522(r5),r12	;0xffff80f6
     1b6:	4d 4c       	mov.b	r12,	r13	;
     1b8:	7d 50 d0 ff 	add.b	#65488,	r13	;#0xffd0
     1bc:	7e 40 09 00 	mov.b	#9,	r14	;
     1c0:	4e 9d       	cmp.b	r13,	r14	;
     1c2:	10 28       	jnc	$+34     	;abs 0x1e4
     1c4:	3c 50 d0 ff 	add	#65488,	r12	;#0xffd0

000001c8 <.L34>:
     1c8:	3c b0 00 80 	bit	#32768,	r12	;#0x8000
     1cc:	0d 7d       	subc	r13,	r13	;
     1ce:	3d e3       	inv	r13		;

000001d0 <.L30>:
     1d0:	0e 4a       	mov	r10,	r14	;
     1d2:	b0 12 94 0e 	call	#3732		;#0x0e94
     1d6:	08 5c       	add	r12,	r8	;
     1d8:	09 6d       	addc	r13,	r9	;
     1da:	15 53       	inc	r5		;
     1dc:	3a 50 fc ff 	add	#65532,	r10	;#0xfffc
     1e0:	30 40 a6 01 	br	#0x01a6		;

000001e4 <.L29>:
     1e4:	4d 4c       	mov.b	r12,	r13	;
     1e6:	7d 50 9f ff 	add.b	#65439,	r13	;#0xff9f
     1ea:	7e 40 05 00 	mov.b	#5,	r14	;
     1ee:	4e 9d       	cmp.b	r13,	r14	;
     1f0:	04 28       	jnc	$+10     	;abs 0x1fa
     1f2:	3c 50 a9 ff 	add	#65449,	r12	;#0xffa9
     1f6:	30 40 c8 01 	br	#0x01c8		;

000001fa <.L31>:
     1fa:	4d 4c       	mov.b	r12,	r13	;
     1fc:	7d 50 bf ff 	add.b	#65471,	r13	;#0xffbf
     200:	7e 40 05 00 	mov.b	#5,	r14	;
     204:	4e 9d       	cmp.b	r13,	r14	;
     206:	04 28       	jnc	$+10     	;abs 0x210
     208:	3c 50 c9 ff 	add	#65481,	r12	;#0xffc9
     20c:	30 40 c8 01 	br	#0x01c8		;

00000210 <.L33>:
     210:	0c 46       	mov	r6,	r12	;
     212:	0d 47       	mov	r7,	r13	;
     214:	30 40 d0 01 	br	#0x01d0		;

00000218 <uart_scan.constprop.16>:
     218:	0a 12       	push	r10		;
     21a:	09 12       	push	r9		;
     21c:	08 12       	push	r8		;
     21e:	07 12       	push	r7		;
     220:	06 12       	push	r6		;
     222:	4a 43       	clr.b	r10		;
     224:	38 40 f6 80 	mov	#33014,	r8	;#0x80f6
     228:	06 4c       	mov	r12,	r6	;
     22a:	36 53       	add	#-1,	r6	;r3 As==11
     22c:	37 40 6a 00 	mov	#106,	r7	;#0x006a

00000230 <.L36>:
     230:	3c 40 a4 ff 	mov	#65444,	r12	;#0xffa4

00000234 <.L37>:
     234:	29 4c       	mov	@r12,	r9	;
     236:	09 93       	cmp	#0,	r9	;r3 As==00
     238:	fd 37       	jge	$-4      	;abs 0x234
     23a:	39 f0 ff 00 	and	#255,	r9	;#0x00ff
     23e:	79 92       	cmp.b	#8,	r9	;r2 As==11
     240:	10 20       	jnz	$+34     	;abs 0x262
     242:	0a 93       	cmp	#0,	r10	;r3 As==00
     244:	f5 27       	jz	$-20     	;abs 0x230
     246:	39 40 f8 2c 	mov	#11512,	r9	;#0x2cf8

0000024a <.L40>:
     24a:	19 53       	inc	r9		;
     24c:	5c 49 ff ff 	mov.b	-1(r9),	r12	;
     250:	0c 93       	cmp	#0,	r12	;r3 As==00
     252:	04 20       	jnz	$+10     	;abs 0x25c
     254:	38 53       	add	#-1,	r8	;r3 As==11
     256:	3a 53       	add	#-1,	r10	;r3 As==11
     258:	30 40 30 02 	br	#0x0230		;

0000025c <.L41>:
     25c:	87 12       	call	r7		;
     25e:	30 40 4a 02 	br	#0x024a		;

00000262 <.L38>:
     262:	79 90 0d 00 	cmp.b	#13,	r9	;#0x000d
     266:	11 24       	jz	$+36     	;abs 0x28a
     268:	4c 49       	mov.b	r9,	r12	;
     26a:	7c 50 e0 ff 	add.b	#65504,	r12	;#0xffe0
     26e:	7d 40 5e 00 	mov.b	#94,	r13	;#0x005e
     272:	4d 9c       	cmp.b	r12,	r13	;
     274:	dd 2b       	jnc	$-68     	;abs 0x230
     276:	0a 96       	cmp	r6,	r10	;
     278:	db 2f       	jc	$-72     	;abs 0x230
     27a:	4c 49       	mov.b	r9,	r12	;
     27c:	87 12       	call	r7		;
     27e:	c8 49 00 00 	mov.b	r9,	0(r8)	;
     282:	1a 53       	inc	r10		;
     284:	18 53       	inc	r8		;
     286:	30 40 30 02 	br	#0x0230		;

0000028a <.L42>:
     28a:	c8 43 00 00 	mov.b	#0,	0(r8)	;r3 As==00
     28e:	0c 4a       	mov	r10,	r12	;
     290:	30 40 1a 0e 	br	#0x0e1a		;

00000294 <spi_unselectChip.isra.2.constprop.19>:
     294:	3e 40 11 27 	mov	#10001,	r14	;#0x2711

00000298 <.L48>:
     298:	1c 42 12 24 	mov	&0x2412,r12	;0x2412
     29c:	1d 42 14 24 	mov	&0x2414,r13	;0x2414
     2a0:	3c f0 00 02 	and	#512,	r12	;#0x0200
     2a4:	0c 93       	cmp	#0,	r12	;r3 As==00
     2a6:	12 24       	jz	$+38     	;abs 0x2cc
     2a8:	1e 42 06 24 	mov	&0x2406,r14	;0x2406
     2ac:	1f 42 08 24 	mov	&0x2408,r15	;0x2408
     2b0:	0d 4f       	mov	r15,	r13	;
     2b2:	3d d0 0f 00 	bis	#15,	r13	;#0x000f
     2b6:	82 4e 06 24 	mov	r14,	&0x2406	;
     2ba:	82 4d 08 24 	mov	r13,	&0x2408	;
     2be:	82 43 00 24 	mov	#0,	&0x2400	;r3 As==00
     2c2:	b2 40 00 01 	mov	#256,	&0x2402	;#0x0100
     2c6:	02 24 
     2c8:	4c 43       	clr.b	r12		;

000002ca <.L47>:
     2ca:	30 41       	ret			

000002cc <.L50>:
     2cc:	3e 53       	add	#-1,	r14	;r3 As==11
     2ce:	0e 93       	cmp	#0,	r14	;r3 As==00
     2d0:	e3 23       	jnz	$-56     	;abs 0x298
     2d2:	5c 43       	mov.b	#1,	r12	;r3 As==01
     2d4:	30 40 ca 02 	br	#0x02ca		;

000002d8 <spi_selectChip.constprop.7>:
     2d8:	1e 42 06 24 	mov	&0x2406,r14	;0x2406
     2dc:	1f 42 08 24 	mov	&0x2408,r15	;0x2408
     2e0:	0d 4f       	mov	r15,	r13	;
     2e2:	3d d0 0f 00 	bis	#15,	r13	;#0x000f
     2e6:	82 4e 06 24 	mov	r14,	&0x2406	;
     2ea:	82 4d 08 24 	mov	r13,	&0x2408	;
     2ee:	1c 42 06 24 	mov	&0x2406,r12	;0x2406
     2f2:	1d 42 08 24 	mov	&0x2408,r13	;0x2408
     2f6:	6c f2       	and.b	#4,	r12	;r2 As==10
     2f8:	0c 93       	cmp	#0,	r12	;r3 As==00
     2fa:	0e 24       	jz	$+30     	;abs 0x318
     2fc:	1e 42 06 24 	mov	&0x2406,r14	;0x2406
     300:	1f 42 08 24 	mov	&0x2408,r15	;0x2408
     304:	0c 4e       	mov	r14,	r12	;
     306:	0d 4f       	mov	r15,	r13	;
     308:	3d f0 f0 ff 	and	#65520,	r13	;#0xfff0

0000030c <.L57>:
     30c:	82 4c 06 24 	mov	r12,	&0x2406	;
     310:	82 4d 08 24 	mov	r13,	&0x2408	;
     314:	4c 43       	clr.b	r12		;
     316:	30 41       	ret			

00000318 <.L54>:
     318:	1c 42 06 24 	mov	&0x2406,r12	;0x2406
     31c:	1d 42 08 24 	mov	&0x2408,r13	;0x2408
     320:	30 40 0c 03 	br	#0x030c		;

00000324 <checkack.constprop.15>:
     324:	3d 40 90 ff 	mov	#65424,	r13	;#0xff90
     328:	3e 40 9a ff 	mov	#65434,	r14	;#0xff9a

0000032c <.L59>:
     32c:	4c 43       	clr.b	r12		;

0000032e <.L60>:
     32e:	03 43       	nop			
     330:	1c 53       	inc	r12		;
     332:	3c 90 00 02 	cmp	#512,	r12	;#0x0200
     336:	fb 23       	jnz	$-8      	;abs 0x32e
     338:	92 43 90 ff 	mov	#1,	&0xff90	;r3 As==01
     33c:	b2 40 10 00 	mov	#16,	&0xff92	;#0x0010
     340:	92 ff 
     342:	82 43 94 ff 	mov	#0,	&0xff94	;r3 As==00

00000346 <.L61>:
     346:	2c 4d       	mov	@r13,	r12	;
     348:	0c 93       	cmp	#0,	r12	;r3 As==00
     34a:	fd 3b       	jl	$-4      	;abs 0x346
     34c:	6c 4e       	mov.b	@r14,	r12	;
     34e:	2c b3       	bit	#2,	r12	;r3 As==10
     350:	ed 23       	jnz	$-36     	;abs 0x32c
     352:	7c e3       	xor.b	#-1,	r12	;r3 As==11
     354:	3c f0 ff 00 	and	#255,	r12	;#0x00ff
     358:	b0 12 ba 0e 	call	#3770		;#0x0eba
     35c:	30 41       	ret			

0000035e <read_i2c_address.constprop.13>:
     35e:	0a 12       	push	r10		;
     360:	09 12       	push	r9		;
     362:	08 12       	push	r8		;
     364:	07 12       	push	r7		;
     366:	06 12       	push	r6		;
     368:	05 12       	push	r5		;
     36a:	04 12       	push	r4		;
     36c:	21 83       	decd	r1		;
     36e:	4e 4c       	mov.b	r12,	r14	;
     370:	47 4d       	mov.b	r13,	r7	;
     372:	4e 5e       	rla.b	r14		;
     374:	38 40 d0 00 	mov	#208,	r8	;#0x00d0
     378:	5e d3       	bis.b	#1,	r14	;r3 As==01
     37a:	7c 40 0c 00 	mov.b	#12,	r12	;#0x000c
     37e:	4d 43       	clr.b	r13		;
     380:	88 12       	call	r8		;
     382:	7e 40 90 ff 	mov.b	#65424,	r14	;#0xff90
     386:	7c 40 10 00 	mov.b	#16,	r12	;#0x0010
     38a:	4d 43       	clr.b	r13		;
     38c:	88 12       	call	r8		;
     38e:	39 40 24 03 	mov	#804,	r9	;#0x0324
     392:	89 12       	call	r9		;
     394:	4a 4c       	mov.b	r12,	r10	;
     396:	06 48       	mov	r8,	r6	;
     398:	0a 93       	cmp	#0,	r10	;r3 As==00
     39a:	24 24       	jz	$+74     	;abs 0x3e4
     39c:	4a 43       	clr.b	r10		;
     39e:	0c 47       	mov	r7,	r12	;
     3a0:	3c 53       	add	#-1,	r12	;r3 As==11
     3a2:	81 4c 00 00 	mov	r12,	0(r1)	;
     3a6:	74 40 10 00 	mov.b	#16,	r4	;#0x0010
     3aa:	45 43       	clr.b	r5		;
     3ac:	38 40 90 ff 	mov	#65424,	r8	;#0xff90

000003b0 <.L67>:
     3b0:	0a 97       	cmp	r7,	r10	;
     3b2:	1e 24       	jz	$+62     	;abs 0x3f0
     3b4:	2a 91       	cmp	@r1,	r10	;
     3b6:	20 34       	jge	$+66     	;abs 0x3f8
     3b8:	7e 40 20 00 	mov.b	#32,	r14	;#0x0020

000003bc <.L74>:
     3bc:	0c 44       	mov	r4,	r12	;
     3be:	0d 45       	mov	r5,	r13	;
     3c0:	86 12       	call	r6		;
     3c2:	89 12       	call	r9		;
     3c4:	92 43 90 ff 	mov	#1,	&0xff90	;r3 As==01
     3c8:	b2 40 0c 00 	mov	#12,	&0xff92	;#0x000c
     3cc:	92 ff 
     3ce:	82 43 94 ff 	mov	#0,	&0xff94	;r3 As==00

000003d2 <.L71>:
     3d2:	2c 48       	mov	@r8,	r12	;
     3d4:	0c 93       	cmp	#0,	r12	;r3 As==00
     3d6:	fd 3b       	jl	$-4      	;abs 0x3d2
     3d8:	da 42 9a ff 	mov.b	&0xff9a,-32506(r10);0xff9a, 0x8106
     3dc:	06 81 
     3de:	1a 53       	inc	r10		;
     3e0:	30 40 b0 03 	br	#0x03b0		;

000003e4 <.L66>:
     3e4:	7e 40 40 00 	mov.b	#64,	r14	;#0x0040
     3e8:	7c 40 10 00 	mov.b	#16,	r12	;#0x0010
     3ec:	4d 43       	clr.b	r13		;
     3ee:	88 12       	call	r8		;

000003f0 <.L75>:
     3f0:	0c 4a       	mov	r10,	r12	;
     3f2:	21 53       	incd	r1		;
     3f4:	30 40 16 0e 	br	#0x0e16		;

000003f8 <.L69>:
     3f8:	7e 40 68 00 	mov.b	#104,	r14	;#0x0068
     3fc:	30 40 bc 03 	br	#0x03bc		;

00000400 <write_i2c_address.constprop.12>:
     400:	0a 12       	push	r10		;
     402:	09 12       	push	r9		;
     404:	08 12       	push	r8		;
     406:	07 12       	push	r7		;
     408:	06 12       	push	r6		;
     40a:	05 12       	push	r5		;
     40c:	04 12       	push	r4		;
     40e:	3c f0 ff 00 	and	#255,	r12	;#0x00ff
     412:	47 4d       	mov.b	r13,	r7	;
     414:	48 4e       	mov.b	r14,	r8	;
     416:	4c 5c       	rla.b	r12		;
     418:	3a 40 d0 00 	mov	#208,	r10	;#0x00d0
     41c:	4e 4c       	mov.b	r12,	r14	;
     41e:	7c 40 0c 00 	mov.b	#12,	r12	;#0x000c
     422:	4d 43       	clr.b	r13		;
     424:	8a 12       	call	r10		;
     426:	7e 40 90 ff 	mov.b	#65424,	r14	;#0xff90
     42a:	7c 40 10 00 	mov.b	#16,	r12	;#0x0010
     42e:	4d 43       	clr.b	r13		;
     430:	8a 12       	call	r10		;
     432:	39 40 24 03 	mov	#804,	r9	;#0x0324
     436:	89 12       	call	r9		;
     438:	06 4a       	mov	r10,	r6	;
     43a:	4c 93       	cmp.b	#0,	r12	;r3 As==00
     43c:	0a 24       	jz	$+22     	;abs 0x452
     43e:	4a 43       	clr.b	r10		;
     440:	74 40 10 00 	mov.b	#16,	r4	;#0x0010
     444:	45 43       	clr.b	r5		;

00000446 <.L78>:
     446:	0a 97       	cmp	r7,	r10	;
     448:	0e 20       	jnz	$+30     	;abs 0x466
     44a:	08 93       	cmp	#0,	r8	;r3 As==00
     44c:	09 24       	jz	$+20     	;abs 0x460
     44e:	30 40 82 04 	br	#0x0482		;

00000452 <.L77>:
     452:	7e 40 40 00 	mov.b	#64,	r14	;#0x0040
     456:	7c 40 10 00 	mov.b	#16,	r12	;#0x0010
     45a:	4d 43       	clr.b	r13		;
     45c:	8a 12       	call	r10		;
     45e:	3a 43       	mov	#-1,	r10	;r3 As==11

00000460 <.L76>:
     460:	0c 4a       	mov	r10,	r12	;
     462:	30 40 16 0e 	br	#0x0e16		;

00000466 <.L81>:
     466:	5e 4a 06 81 	mov.b	-32506(r10),r14	;0xffff8106
     46a:	7c 40 0c 00 	mov.b	#12,	r12	;#0x000c
     46e:	4d 43       	clr.b	r13		;
     470:	86 12       	call	r6		;
     472:	7e 40 10 00 	mov.b	#16,	r14	;#0x0010
     476:	0c 44       	mov	r4,	r12	;
     478:	0d 45       	mov	r5,	r13	;
     47a:	86 12       	call	r6		;
     47c:	89 12       	call	r9		;
     47e:	4c 93       	cmp.b	#0,	r12	;r3 As==00
     480:	08 20       	jnz	$+18     	;abs 0x492

00000482 <.L85>:
     482:	7e 40 40 00 	mov.b	#64,	r14	;#0x0040
     486:	7c 40 10 00 	mov.b	#16,	r12	;#0x0010
     48a:	4d 43       	clr.b	r13		;
     48c:	86 12       	call	r6		;
     48e:	30 40 60 04 	br	#0x0460		;

00000492 <.L80>:
     492:	1a 53       	inc	r10		;
     494:	30 40 46 04 	br	#0x0446		;

00000498 <read_i2c_prom.constprop.11>:
     498:	0a 12       	push	r10		;
     49a:	4a 4d       	mov.b	r13,	r10	;
     49c:	c2 4c 06 81 	mov.b	r12,	&0x8106	;
     4a0:	4e 43       	clr.b	r14		;
     4a2:	5d 43       	mov.b	#1,	r13	;r3 As==01
     4a4:	7c 40 53 00 	mov.b	#83,	r12	;#0x0053
     4a8:	b0 12 00 04 	call	#1024		;#0x0400
     4ac:	4c 43       	clr.b	r12		;

000004ae <.L87>:
     4ae:	0c 9a       	cmp	r10,	r12	;
     4b0:	08 28       	jnc	$+18     	;abs 0x4c2
     4b2:	4d 4a       	mov.b	r10,	r13	;
     4b4:	7c 40 53 00 	mov.b	#83,	r12	;#0x0053
     4b8:	b0 12 5e 03 	call	#862		;#0x035e
     4bc:	0c 4a       	mov	r10,	r12	;
     4be:	3a 41       	pop	r10		;
     4c0:	30 41       	ret			

000004c2 <.L88>:
     4c2:	cc 43 06 81 	mov.b	#0,	-32506(r12);r3 As==00, 0x8106
     4c6:	1c 53       	inc	r12		;
     4c8:	30 40 ae 04 	br	#0x04ae		;

000004cc <read_Prom>:
     4cc:	0a 12       	push	r10		;
     4ce:	09 12       	push	r9		;
     4d0:	08 12       	push	r8		;
     4d2:	07 12       	push	r7		;
     4d4:	6d 42       	mov.b	#4,	r13	;r2 As==10
     4d6:	4c 43       	clr.b	r12		;
     4d8:	b0 12 98 04 	call	#1176		;#0x0498
     4dc:	3a 40 06 81 	mov	#33030,	r10	;#0x8106
     4e0:	4c 43       	clr.b	r12		;
     4e2:	0d 4c       	mov	r12,	r13	;
     4e4:	5c 4a 01 00 	mov.b	1(r10),	r12	;
     4e8:	0c 5c       	rla	r12		;
     4ea:	0d 6d       	rlc	r13		;
     4ec:	0c 5c       	rla	r12		;
     4ee:	0d 6d       	rlc	r13		;
     4f0:	0c 5c       	rla	r12		;
     4f2:	0d 6d       	rlc	r13		;
     4f4:	0c 5c       	rla	r12		;
     4f6:	0d 6d       	rlc	r13		;
     4f8:	0c 5c       	rla	r12		;
     4fa:	0d 6d       	rlc	r13		;
     4fc:	0c 5c       	rla	r12		;
     4fe:	0d 6d       	rlc	r13		;
     500:	0c 5c       	rla	r12		;
     502:	0d 6d       	rlc	r13		;
     504:	09 4c       	mov	r12,	r9	;
     506:	09 5c       	add	r12,	r9	;
     508:	08 4d       	mov	r13,	r8	;
     50a:	08 6d       	addc	r13,	r8	;
     50c:	47 43       	clr.b	r7		;
     50e:	5c 4a 02 00 	mov.b	2(r10),	r12	;
     512:	0d 47       	mov	r7,	r13	;
     514:	7e 40 10 00 	mov.b	#16,	r14	;#0x0010
     518:	b0 12 94 0e 	call	#3732		;#0x0e94
     51c:	0c 59       	add	r9,	r12	;
     51e:	08 6d       	addc	r13,	r8	;
     520:	0d 47       	mov	r7,	r13	;
     522:	69 4a       	mov.b	@r10,	r9	;
     524:	09 5c       	add	r12,	r9	;
     526:	08 67       	addc	r7,	r8	;
     528:	5c 4a 03 00 	mov.b	3(r10),	r12	;
     52c:	7e 40 18 00 	mov.b	#24,	r14	;#0x0018
     530:	b0 12 94 0e 	call	#3732		;#0x0e94
     534:	0c 59       	add	r9,	r12	;
     536:	0d 68       	addc	r8,	r13	;
     538:	30 40 1c 0e 	br	#0x0e1c		;

0000053c <uart_print_hex_word>:
     53c:	0a 12       	push	r10		;
     53e:	09 12       	push	r9		;
     540:	08 12       	push	r8		;
     542:	09 4c       	mov	r12,	r9	;
     544:	b0 12 b6 0e 	call	#3766		;#0x0eb6
     548:	48 4c       	mov.b	r12,	r8	;
     54a:	0c 48       	mov	r8,	r12	;
     54c:	b0 12 c6 0e 	call	#3782		;#0x0ec6
     550:	3a 40 ae 00 	mov	#174,	r10	;#0x00ae
     554:	8a 12       	call	r10		;
     556:	4c 48       	mov.b	r8,	r12	;
     558:	8a 12       	call	r10		;
     55a:	39 f0 ff 00 	and	#255,	r9	;#0x00ff
     55e:	0c 49       	mov	r9,	r12	;
     560:	b0 12 c6 0e 	call	#3782		;#0x0ec6
     564:	8a 12       	call	r10		;
     566:	4c 49       	mov.b	r9,	r12	;
     568:	8a 12       	call	r10		;
     56a:	30 40 1e 0e 	br	#0x0e1e		;

0000056e <uart_print_hex_dword>:
     56e:	0a 12       	push	r10		;
     570:	09 12       	push	r9		;
     572:	09 4c       	mov	r12,	r9	;
     574:	7e 40 10 00 	mov.b	#16,	r14	;#0x0010
     578:	b0 12 48 0f 	call	#3912		;#0x0f48
     57c:	3a 40 3c 05 	mov	#1340,	r10	;#0x053c
     580:	8a 12       	call	r10		;
     582:	0c 49       	mov	r9,	r12	;
     584:	8a 12       	call	r10		;
     586:	30 40 20 0e 	br	#0x0e20		;

0000058a <spi_transfer32>:
     58a:	0a 12       	push	r10		;
     58c:	09 12       	push	r9		;
     58e:	08 12       	push	r8		;
     590:	07 12       	push	r7		;
     592:	31 82       	sub	#8,	r1	;r2 As==11
     594:	0a 4c       	mov	r12,	r10	;
     596:	09 4d       	mov	r13,	r9	;
     598:	7e 40 18 00 	mov.b	#24,	r14	;#0x0018
     59c:	b0 12 94 0e 	call	#3732		;#0x0e94
     5a0:	08 4c       	mov	r12,	r8	;
     5a2:	07 4d       	mov	r13,	r7	;
     5a4:	0c 4a       	mov	r10,	r12	;
     5a6:	0d 49       	mov	r9,	r13	;
     5a8:	7e 40 18 00 	mov.b	#24,	r14	;#0x0018
     5ac:	b0 12 48 0f 	call	#3912		;#0x0f48
     5b0:	08 dc       	bis	r12,	r8	;
     5b2:	07 dd       	bis	r13,	r7	;
     5b4:	0e 4a       	mov	r10,	r14	;
     5b6:	0e 5a       	add	r10,	r14	;
     5b8:	0c 49       	mov	r9,	r12	;
     5ba:	0c 69       	addc	r9,	r12	;
     5bc:	0e 5e       	rla	r14		;
     5be:	0c 6c       	rlc	r12		;
     5c0:	0e 5e       	rla	r14		;
     5c2:	0c 6c       	rlc	r12		;
     5c4:	0e 5e       	rla	r14		;
     5c6:	0c 6c       	rlc	r12		;
     5c8:	0e 5e       	rla	r14		;
     5ca:	0c 6c       	rlc	r12		;
     5cc:	0e 5e       	rla	r14		;
     5ce:	0c 6c       	rlc	r12		;
     5d0:	0e 5e       	rla	r14		;
     5d2:	0c 6c       	rlc	r12		;
     5d4:	0e 5e       	rla	r14		;
     5d6:	0c 6c       	rlc	r12		;
     5d8:	7c f0 ff 00 	and.b	#255,	r12	;#0x00ff
     5dc:	07 dc       	bis	r12,	r7	;
     5de:	0c 4a       	mov	r10,	r12	;
     5e0:	0d 49       	mov	r9,	r13	;
     5e2:	b0 12 0e 0f 	call	#3854		;#0x0f0e
     5e6:	3c f0 00 ff 	and	#65280,	r12	;#0xff00
     5ea:	08 dc       	bis	r12,	r8	;
     5ec:	81 48 00 00 	mov	r8,	0(r1)	;
     5f0:	81 47 02 00 	mov	r7,	2(r1)	;
     5f4:	39 40 3c 01 	mov	#316,	r9	;#0x013c
     5f8:	0c 47       	mov	r7,	r12	;
     5fa:	89 12       	call	r9		;
     5fc:	3a 40 0a 01 	mov	#266,	r10	;#0x010a
     600:	0c 41       	mov	r1,	r12	;
     602:	3c 50 06 00 	add	#6,	r12	;
     606:	8a 12       	call	r10		;
     608:	2c 41       	mov	@r1,	r12	;
     60a:	89 12       	call	r9		;
     60c:	0c 41       	mov	r1,	r12	;
     60e:	2c 52       	add	#4,	r12	;r2 As==10
     610:	8a 12       	call	r10		;
     612:	1a 41 04 00 	mov	4(r1),	r10	;
     616:	18 41 06 00 	mov	6(r1),	r8	;
     61a:	0c 4a       	mov	r10,	r12	;
     61c:	0d 48       	mov	r8,	r13	;
     61e:	7e 40 18 00 	mov.b	#24,	r14	;#0x0018
     622:	b0 12 94 0e 	call	#3732		;#0x0e94
     626:	09 4c       	mov	r12,	r9	;
     628:	07 4d       	mov	r13,	r7	;
     62a:	0c 4a       	mov	r10,	r12	;
     62c:	0d 48       	mov	r8,	r13	;
     62e:	7e 40 18 00 	mov.b	#24,	r14	;#0x0018
     632:	b0 12 48 0f 	call	#3912		;#0x0f48
     636:	09 dc       	bis	r12,	r9	;
     638:	07 dd       	bis	r13,	r7	;
     63a:	0e 4a       	mov	r10,	r14	;
     63c:	0e 5a       	add	r10,	r14	;
     63e:	0c 48       	mov	r8,	r12	;
     640:	0c 68       	addc	r8,	r12	;
     642:	0e 5e       	rla	r14		;
     644:	0c 6c       	rlc	r12		;
     646:	0e 5e       	rla	r14		;
     648:	0c 6c       	rlc	r12		;
     64a:	0e 5e       	rla	r14		;
     64c:	0c 6c       	rlc	r12		;
     64e:	0e 5e       	rla	r14		;
     650:	0c 6c       	rlc	r12		;
     652:	0e 5e       	rla	r14		;
     654:	0c 6c       	rlc	r12		;
     656:	0e 5e       	rla	r14		;
     658:	0c 6c       	rlc	r12		;
     65a:	0e 5e       	rla	r14		;
     65c:	0c 6c       	rlc	r12		;
     65e:	7c f0 ff 00 	and.b	#255,	r12	;#0x00ff
     662:	07 dc       	bis	r12,	r7	;
     664:	0c 4a       	mov	r10,	r12	;
     666:	0d 48       	mov	r8,	r13	;
     668:	b0 12 0e 0f 	call	#3854		;#0x0f0e
     66c:	3c f0 00 ff 	and	#65280,	r12	;#0xff00
     670:	0c d9       	bis	r9,	r12	;
     672:	0d 47       	mov	r7,	r13	;
     674:	31 52       	add	#8,	r1	;r2 As==11
     676:	30 40 1c 0e 	br	#0x0e1c		;

0000067a <main>:
     67a:	0a 12       	push	r10		;
     67c:	09 12       	push	r9		;
     67e:	08 12       	push	r8		;
     680:	07 12       	push	r7		;
     682:	06 12       	push	r6		;
     684:	05 12       	push	r5		;
     686:	04 12       	push	r4		;
     688:	31 80 2c 00 	sub	#44,	r1	;#0x002c
     68c:	1e 42 fc ff 	mov	&0xfffc,r14	;0xfffc
     690:	1f 42 fe ff 	mov	&0xfffe,r15	;0xfffe
     694:	4c 43       	clr.b	r12		;

00000696 <.L94>:
     696:	0a 4f       	mov	r15,	r10	;
     698:	0f 93       	cmp	#0,	r15	;r3 As==00
     69a:	a4 20       	jnz	$+330    	;abs 0x7e4
     69c:	3d 40 ff 95 	mov	#38399,	r13	;#0x95ff
     6a0:	0d 9e       	cmp	r14,	r13	;
     6a2:	a0 28       	jnc	$+322    	;abs 0x7e4

000006a4 <.L97>:
     6a4:	7f 40 ff 00 	mov.b	#255,	r15	;#0x00ff
     6a8:	0f 9c       	cmp	r12,	r15	;
     6aa:	a2 28       	jnc	$+326    	;abs 0x7f0
     6ac:	0d 4a       	mov	r10,	r13	;
     6ae:	0d 5a       	add	r10,	r13	;
     6b0:	0d 5d       	rla	r13		;
     6b2:	0d 5d       	rla	r13		;
     6b4:	0d 5d       	rla	r13		;
     6b6:	0d 5d       	rla	r13		;
     6b8:	0d 5d       	rla	r13		;
     6ba:	0d 5d       	rla	r13		;
     6bc:	0d 5d       	rla	r13		;
     6be:	0d dc       	bis	r12,	r13	;
     6c0:	82 4d a6 ff 	mov	r13,	&0xffa6	;
     6c4:	92 43 a0 ff 	mov	#1,	&0xffa0	;r3 As==01
     6c8:	3a 40 7e 00 	mov	#126,	r10	;#0x007e
     6cc:	3c 40 fc 2c 	mov	#11516,	r12	;#0x2cfc
     6d0:	8a 12       	call	r10		;
     6d2:	09 4a       	mov	r10,	r9	;
     6d4:	a2 b3 f2 ff 	bit	#2,	&0xfff2	;r3 As==10
     6d8:	02 20       	jnz	$+6      	;abs 0x6de
     6da:	30 40 50 0d 	br	#0x0d50		;
     6de:	3c 40 9b 2d 	mov	#11675,	r12	;#0x2d9b
     6e2:	8a 12       	call	r10		;
     6e4:	3a 40 d0 00 	mov	#208,	r10	;#0x00d0
     6e8:	4e 43       	clr.b	r14		;
     6ea:	7c 42       	mov.b	#8,	r12	;r2 As==11
     6ec:	4d 43       	clr.b	r13		;
     6ee:	8a 12       	call	r10		;
     6f0:	4e 43       	clr.b	r14		;
     6f2:	4c 43       	clr.b	r12		;
     6f4:	4d 43       	clr.b	r13		;
     6f6:	8a 12       	call	r10		;
     6f8:	6e 42       	mov.b	#4,	r14	;r2 As==10
     6fa:	6c 42       	mov.b	#4,	r12	;r2 As==10
     6fc:	4d 43       	clr.b	r13		;
     6fe:	8a 12       	call	r10		;
     700:	7e 40 80 ff 	mov.b	#65408,	r14	;#0xff80
     704:	7c 42       	mov.b	#8,	r12	;r2 As==11
     706:	4d 43       	clr.b	r13		;
     708:	8a 12       	call	r10		;
     70a:	4c 43       	clr.b	r12		;

0000070c <.L103>:
     70c:	03 43       	nop			
     70e:	1c 53       	inc	r12		;
     710:	3c 90 e8 03 	cmp	#1000,	r12	;#0x03e8
     714:	fb 23       	jnz	$-8      	;abs 0x70c
     716:	3c 40 af 2d 	mov	#11695,	r12	;#0x2daf
     71a:	89 12       	call	r9		;
     71c:	3a 40 f6 80 	mov	#33014,	r10	;#0x80f6

00000720 <.L104>:
     720:	37 40 7e 00 	mov	#126,	r7	;#0x007e
     724:	36 40 18 02 	mov	#536,	r6	;#0x0218
     728:	08 47       	mov	r7,	r8	;

0000072a <.L105>:
     72a:	3c 40 bd 2d 	mov	#11709,	r12	;#0x2dbd
     72e:	87 12       	call	r7		;
     730:	7c 40 10 00 	mov.b	#16,	r12	;#0x0010
     734:	86 12       	call	r6		;
     736:	05 4c       	mov	r12,	r5	;
     738:	3c 40 d1 2d 	mov	#11729,	r12	;#0x2dd1
     73c:	87 12       	call	r7		;
     73e:	05 93       	cmp	#0,	r5	;r3 As==00
     740:	f4 27       	jz	$-22     	;abs 0x72a
     742:	37 40 44 10 	mov	#4164,	r7	;#0x1044
     746:	3d 40 d3 2d 	mov	#11731,	r13	;#0x2dd3
     74a:	0c 4a       	mov	r10,	r12	;
     74c:	87 12       	call	r7		;
     74e:	04 4c       	mov	r12,	r4	;
     750:	3d 40 d8 2d 	mov	#11736,	r13	;#0x2dd8
     754:	0c 4a       	mov	r10,	r12	;
     756:	87 12       	call	r7		;
     758:	0c 93       	cmp	#0,	r12	;r3 As==00
     75a:	59 24       	jz	$+180    	;abs 0x80e
     75c:	55 43       	mov.b	#1,	r5	;r3 As==01
     75e:	04 93       	cmp	#0,	r4	;r3 As==00
     760:	01 24       	jz	$+4      	;abs 0x764
     762:	45 43       	clr.b	r5		;

00000764 <.L106>:
     764:	3d 40 df 2d 	mov	#11743,	r13	;#0x2ddf
     768:	0c 4a       	mov	r10,	r12	;
     76a:	87 12       	call	r7		;
     76c:	0c 93       	cmp	#0,	r12	;r3 As==00
     76e:	02 20       	jnz	$+6      	;abs 0x774
     770:	75 40 03 00 	mov.b	#3,	r5	;

00000774 <.L108>:
     774:	3d 40 e2 2d 	mov	#11746,	r13	;#0x2de2
     778:	0c 4a       	mov	r10,	r12	;
     77a:	87 12       	call	r7		;
     77c:	0c 93       	cmp	#0,	r12	;r3 As==00
     77e:	01 20       	jnz	$+4      	;abs 0x782
     780:	65 42       	mov.b	#4,	r5	;r2 As==10

00000782 <.L109>:
     782:	3d 40 ed 2d 	mov	#11757,	r13	;#0x2ded
     786:	0c 4a       	mov	r10,	r12	;
     788:	87 12       	call	r7		;
     78a:	0c 93       	cmp	#0,	r12	;r3 As==00
     78c:	02 20       	jnz	$+6      	;abs 0x792
     78e:	75 40 05 00 	mov.b	#5,	r5	;

00000792 <.L110>:
     792:	3d 40 f7 2d 	mov	#11767,	r13	;#0x2df7
     796:	0c 4a       	mov	r10,	r12	;
     798:	87 12       	call	r7		;
     79a:	0c 93       	cmp	#0,	r12	;r3 As==00
     79c:	02 20       	jnz	$+6      	;abs 0x7a2
     79e:	75 40 06 00 	mov.b	#6,	r5	;

000007a2 <.L111>:
     7a2:	3d 40 01 2e 	mov	#11777,	r13	;#0x2e01
     7a6:	0c 4a       	mov	r10,	r12	;
     7a8:	87 12       	call	r7		;
     7aa:	0c 93       	cmp	#0,	r12	;r3 As==00
     7ac:	02 20       	jnz	$+6      	;abs 0x7b2
     7ae:	75 40 07 00 	mov.b	#7,	r5	;

000007b2 <.L112>:
     7b2:	3d 40 0a 2e 	mov	#11786,	r13	;#0x2e0a
     7b6:	0c 4a       	mov	r10,	r12	;
     7b8:	87 12       	call	r7		;
     7ba:	04 4c       	mov	r12,	r4	;
     7bc:	0c 93       	cmp	#0,	r12	;r3 As==00
     7be:	02 20       	jnz	$+6      	;abs 0x7c4
     7c0:	30 40 fa 0b 	br	#0x0bfa		;
     7c4:	25 92       	cmp	#4,	r5	;r2 As==10
     7c6:	c0 24       	jz	$+386    	;abs 0x948
     7c8:	6c 42       	mov.b	#4,	r12	;r2 As==10
     7ca:	0c 95       	cmp	r5,	r12	;
     7cc:	23 28       	jnc	$+72     	;abs 0x814
     7ce:	25 93       	cmp	#2,	r5	;r3 As==10
     7d0:	6f 24       	jz	$+224    	;abs 0x8b0
     7d2:	6d 43       	mov.b	#2,	r13	;r3 As==10
     7d4:	0d 95       	cmp	r5,	r13	;
     7d6:	94 28       	jnc	$+298    	;abs 0x900
     7d8:	15 93       	cmp	#1,	r5	;r3 As==01
     7da:	65 24       	jz	$+204    	;abs 0x8a6

000007dc <.L114>:
     7dc:	3c 40 31 31 	mov	#12593,	r12	;#0x3131
     7e0:	30 40 aa 08 	br	#0x08aa		;

000007e4 <.L95>:
     7e4:	3e 50 00 6a 	add	#27136,	r14	;#0x6a00
     7e8:	3f 63       	addc	#-1,	r15	;r3 As==11
     7ea:	1c 53       	inc	r12		;
     7ec:	30 40 96 06 	br	#0x0696		;

000007f0 <.L101>:
     7f0:	6a 93       	cmp.b	#2,	r10	;r3 As==10
     7f2:	02 24       	jz	$+6      	;abs 0x7f8
     7f4:	6a 92       	cmp.b	#4,	r10	;r2 As==10
     7f6:	07 20       	jnz	$+16     	;abs 0x806

000007f8 <.L98>:
     7f8:	b0 12 ca 0e 	call	#3786		;#0x0eca

000007fc <.L100>:
     7fc:	5a 53       	inc.b	r10		;
     7fe:	3a f0 ff 00 	and	#255,	r10	;#0x00ff
     802:	30 40 a4 06 	br	#0x06a4		;

00000806 <.L99>:
     806:	b0 12 d2 0e 	call	#3794		;#0x0ed2
     80a:	30 40 fc 07 	br	#0x07fc		;

0000080e <.L145>:
     80e:	65 43       	mov.b	#2,	r5	;r3 As==10
     810:	30 40 64 07 	br	#0x0764		;

00000814 <.L116>:
     814:	35 90 06 00 	cmp	#6,	r5	;
     818:	2f 25       	jz	$+608    	;abs 0xa78
     81a:	35 90 06 00 	cmp	#6,	r5	;
     81e:	c1 28       	jnc	$+388    	;abs 0x9a2
     820:	35 90 07 00 	cmp	#7,	r5	;
     824:	db 23       	jnz	$-72     	;abs 0x7dc
     826:	7d 40 06 00 	mov.b	#6,	r13	;
     82a:	4c 43       	clr.b	r12		;
     82c:	b0 12 98 04 	call	#1176		;#0x0498
     830:	3c 40 06 81 	mov	#33030,	r12	;#0x8106
     834:	57 4c 01 00 	mov.b	1(r12),	r7	;
     838:	07 57       	rla	r7		;
     83a:	07 57       	rla	r7		;
     83c:	07 57       	rla	r7		;
     83e:	07 57       	rla	r7		;
     840:	07 57       	rla	r7		;
     842:	07 57       	rla	r7		;
     844:	07 57       	rla	r7		;
     846:	07 57       	rla	r7		;
     848:	6f 4c       	mov.b	@r12,	r15	;
     84a:	07 5f       	add	r15,	r7	;
     84c:	56 4c 03 00 	mov.b	3(r12),	r6	;
     850:	06 56       	rla	r6		;
     852:	06 56       	rla	r6		;
     854:	06 56       	rla	r6		;
     856:	06 56       	rla	r6		;
     858:	06 56       	rla	r6		;
     85a:	06 56       	rla	r6		;
     85c:	06 56       	rla	r6		;
     85e:	06 56       	rla	r6		;
     860:	5d 4c 02 00 	mov.b	2(r12),	r13	;
     864:	06 5d       	add	r13,	r6	;
     866:	55 4c 05 00 	mov.b	5(r12),	r5	;
     86a:	05 55       	rla	r5		;
     86c:	05 55       	rla	r5		;
     86e:	05 55       	rla	r5		;
     870:	05 55       	rla	r5		;
     872:	05 55       	rla	r5		;
     874:	05 55       	rla	r5		;
     876:	05 55       	rla	r5		;
     878:	05 55       	rla	r5		;
     87a:	5c 4c 04 00 	mov.b	4(r12),	r12	;
     87e:	05 5c       	add	r12,	r5	;
     880:	3c 40 02 30 	mov	#12290,	r12	;#0x3002
     884:	88 12       	call	r8		;
     886:	34 40 3c 05 	mov	#1340,	r4	;#0x053c
     88a:	0c 45       	mov	r5,	r12	;
     88c:	84 12       	call	r4		;
     88e:	3c 40 2e 30 	mov	#12334,	r12	;#0x302e
     892:	88 12       	call	r8		;
     894:	0c 46       	mov	r6,	r12	;
     896:	84 12       	call	r4		;
     898:	3c 40 2e 30 	mov	#12334,	r12	;#0x302e
     89c:	88 12       	call	r8		;
     89e:	0c 47       	mov	r7,	r12	;
     8a0:	84 12       	call	r4		;
     8a2:	30 40 40 09 	br	#0x0940		;

000008a6 <.L119>:
     8a6:	3c 40 10 2e 	mov	#11792,	r12	;#0x2e10

000008aa <.L164>:
     8aa:	88 12       	call	r8		;
     8ac:	30 40 20 07 	br	#0x0720		;

000008b0 <.L117>:
     8b0:	3c 40 97 2f 	mov	#12183,	r12	;#0x2f97
     8b4:	89 12       	call	r9		;
     8b6:	d2 43 06 81 	mov.b	#1,	&0x8106	;r3 As==01
     8ba:	f2 40 7f 00 	mov.b	#127,	&0x8107	;#0x007f
     8be:	07 81 
     8c0:	38 40 00 04 	mov	#1024,	r8	;#0x0400
     8c4:	5e 43       	mov.b	#1,	r14	;r3 As==01
     8c6:	4d 45       	mov.b	r5,	r13	;
     8c8:	7c 40 21 00 	mov.b	#33,	r12	;#0x0021
     8cc:	88 12       	call	r8		;
     8ce:	d2 43 06 81 	mov.b	#1,	&0x8106	;r3 As==01
     8d2:	4e 43       	clr.b	r14		;
     8d4:	5d 43       	mov.b	#1,	r13	;r3 As==01
     8d6:	7c 40 21 00 	mov.b	#33,	r12	;#0x0021
     8da:	88 12       	call	r8		;
     8dc:	5d 43       	mov.b	#1,	r13	;r3 As==01
     8de:	7c 40 21 00 	mov.b	#33,	r12	;#0x0021
     8e2:	b0 12 5e 03 	call	#862		;#0x035e
     8e6:	3c 40 ae 2f 	mov	#12206,	r12	;#0x2fae
     8ea:	89 12       	call	r9		;
     8ec:	5c 42 06 81 	mov.b	&0x8106,r12	;0x8106
     8f0:	4d 43       	clr.b	r13		;
     8f2:	b0 12 6e 05 	call	#1390		;#0x056e

000008f6 <.L165>:
     8f6:	3c 40 d1 2d 	mov	#11729,	r12	;#0x2dd1
     8fa:	89 12       	call	r9		;
     8fc:	30 40 20 07 	br	#0x0720		;

00000900 <.L118>:
     900:	7d 40 06 00 	mov.b	#6,	r13	;
     904:	7c 40 fa ff 	mov.b	#65530,	r12	;#0xfffa
     908:	b0 12 98 04 	call	#1176		;#0x0498
     90c:	3c 40 06 81 	mov	#33030,	r12	;#0x8106
     910:	56 4c 04 00 	mov.b	4(r12),	r6	;
     914:	06 56       	rla	r6		;
     916:	06 56       	rla	r6		;
     918:	06 56       	rla	r6		;
     91a:	06 56       	rla	r6		;
     91c:	06 56       	rla	r6		;
     91e:	06 56       	rla	r6		;
     920:	06 56       	rla	r6		;
     922:	06 56       	rla	r6		;
     924:	5c 4c 05 00 	mov.b	5(r12),	r12	;
     928:	06 5c       	add	r12,	r6	;
     92a:	36 b0 00 80 	bit	#32768,	r6	;#0x8000
     92e:	07 77       	subc	r7,	r7	;
     930:	37 e3       	inv	r7		;
     932:	3c 40 bc 2f 	mov	#12220,	r12	;#0x2fbc
     936:	88 12       	call	r8		;
     938:	0c 46       	mov	r6,	r12	;
     93a:	0d 47       	mov	r7,	r13	;
     93c:	b0 12 6e 05 	call	#1390		;#0x056e

00000940 <.L166>:
     940:	3c 40 d1 2d 	mov	#11729,	r12	;#0x2dd1
     944:	30 40 aa 08 	br	#0x08aa		;

00000948 <.L115>:
     948:	3c 40 d6 2f 	mov	#12246,	r12	;#0x2fd6
     94c:	89 12       	call	r9		;
     94e:	7c 40 09 00 	mov.b	#9,	r12	;
     952:	86 12       	call	r6		;
     954:	b0 12 7a 01 	call	#378		;#0x017a
     958:	07 4c       	mov	r12,	r7	;
     95a:	06 4d       	mov	r13,	r6	;
     95c:	38 40 06 81 	mov	#33030,	r8	;#0x8106
     960:	c2 43 06 81 	mov.b	#0,	&0x8106	;r3 As==00
     964:	c8 4c 01 00 	mov.b	r12,	1(r8)	;
     968:	b0 12 0e 0f 	call	#3854		;#0x0f0e
     96c:	c8 4c 02 00 	mov.b	r12,	2(r8)	;
     970:	0c 47       	mov	r7,	r12	;
     972:	0d 46       	mov	r6,	r13	;
     974:	7e 40 10 00 	mov.b	#16,	r14	;#0x0010
     978:	b0 12 48 0f 	call	#3912		;#0x0f48
     97c:	c8 4c 03 00 	mov.b	r12,	3(r8)	;
     980:	0c 47       	mov	r7,	r12	;
     982:	0d 46       	mov	r6,	r13	;
     984:	7e 40 18 00 	mov.b	#24,	r14	;#0x0018
     988:	b0 12 48 0f 	call	#3912		;#0x0f48
     98c:	c8 4c 04 00 	mov.b	r12,	4(r8)	;
     990:	5e 43       	mov.b	#1,	r14	;r3 As==01
     992:	7d 40 05 00 	mov.b	#5,	r13	;
     996:	7c 40 53 00 	mov.b	#83,	r12	;#0x0053
     99a:	b0 12 00 04 	call	#1024		;#0x0400
     99e:	30 40 20 07 	br	#0x0720		;

000009a2 <.L121>:
     9a2:	b0 12 cc 04 	call	#1228		;#0x04cc
     9a6:	08 4c       	mov	r12,	r8	;
     9a8:	07 4d       	mov	r13,	r7	;
     9aa:	3c 40 02 30 	mov	#12290,	r12	;#0x3002
     9ae:	89 12       	call	r9		;
     9b0:	0c 48       	mov	r8,	r12	;
     9b2:	0d 47       	mov	r7,	r13	;
     9b4:	b0 12 6e 05 	call	#1390		;#0x056e
     9b8:	3c 40 d1 2d 	mov	#11729,	r12	;#0x2dd1
     9bc:	89 12       	call	r9		;
     9be:	3c 40 15 30 	mov	#12309,	r12	;#0x3015
     9c2:	89 12       	call	r9		;
     9c4:	0c 48       	mov	r8,	r12	;
     9c6:	0d 47       	mov	r7,	r13	;
     9c8:	b0 12 0e 0f 	call	#3854		;#0x0f0e
     9cc:	46 4c       	mov.b	r12,	r6	;
     9ce:	37 40 06 0e 	mov	#3590,	r7	;#0x0e06
     9d2:	7d 40 64 00 	mov.b	#100,	r13	;#0x0064
     9d6:	0c 46       	mov	r6,	r12	;
     9d8:	87 12       	call	r7		;
     9da:	45 4c       	mov.b	r12,	r5	;
     9dc:	4f 45       	mov.b	r5,	r15	;
     9de:	7f 50 30 00 	add.b	#48,	r15	;#0x0030
     9e2:	ca 4f 00 00 	mov.b	r15,	0(r10)	;
     9e6:	7d 40 0a 00 	mov.b	#10,	r13	;#0x000a
     9ea:	0c 46       	mov	r6,	r12	;
     9ec:	87 12       	call	r7		;
     9ee:	7c 50 30 00 	add.b	#48,	r12	;#0x0030
     9f2:	4d 45       	mov.b	r5,	r13	;
     9f4:	4d 55       	add.b	r5,	r13	;
     9f6:	4d 5d       	rla.b	r13		;
     9f8:	4d 55       	add.b	r5,	r13	;
     9fa:	4d 5d       	rla.b	r13		;
     9fc:	4c 8d       	sub.b	r13,	r12	;
     9fe:	ca 4c 01 00 	mov.b	r12,	1(r10)	;
     a02:	35 40 0e 0e 	mov	#3598,	r5	;#0x0e0e
     a06:	7d 40 0a 00 	mov.b	#10,	r13	;#0x000a
     a0a:	0c 46       	mov	r6,	r12	;
     a0c:	85 12       	call	r5		;
     a0e:	7c 50 30 00 	add.b	#48,	r12	;#0x0030
     a12:	ca 4c 02 00 	mov.b	r12,	2(r10)	;
     a16:	c2 43 f9 80 	mov.b	#0,	&0x80f9	;r3 As==00
     a1a:	3c 40 f6 80 	mov	#33014,	r12	;#0x80f6
     a1e:	89 12       	call	r9		;
     a20:	3c 40 2c 30 	mov	#12332,	r12	;#0x302c
     a24:	89 12       	call	r9		;
     a26:	38 f0 ff 00 	and	#255,	r8	;#0x00ff
     a2a:	7d 40 64 00 	mov.b	#100,	r13	;#0x0064
     a2e:	0c 48       	mov	r8,	r12	;
     a30:	87 12       	call	r7		;
     a32:	46 4c       	mov.b	r12,	r6	;
     a34:	4c 46       	mov.b	r6,	r12	;
     a36:	7c 50 30 00 	add.b	#48,	r12	;#0x0030
     a3a:	ca 4c 00 00 	mov.b	r12,	0(r10)	;
     a3e:	7d 40 0a 00 	mov.b	#10,	r13	;#0x000a
     a42:	0c 48       	mov	r8,	r12	;
     a44:	87 12       	call	r7		;
     a46:	7c 50 30 00 	add.b	#48,	r12	;#0x0030
     a4a:	4d 46       	mov.b	r6,	r13	;
     a4c:	4d 56       	add.b	r6,	r13	;
     a4e:	4d 5d       	rla.b	r13		;
     a50:	4d 56       	add.b	r6,	r13	;
     a52:	4d 5d       	rla.b	r13		;
     a54:	4c 8d       	sub.b	r13,	r12	;
     a56:	ca 4c 01 00 	mov.b	r12,	1(r10)	;
     a5a:	7d 40 0a 00 	mov.b	#10,	r13	;#0x000a
     a5e:	0c 48       	mov	r8,	r12	;
     a60:	85 12       	call	r5		;
     a62:	7c 50 30 00 	add.b	#48,	r12	;#0x0030
     a66:	ca 4c 02 00 	mov.b	r12,	2(r10)	;
     a6a:	c2 43 f9 80 	mov.b	#0,	&0x80f9	;r3 As==00
     a6e:	3c 40 f6 80 	mov	#33014,	r12	;#0x80f6
     a72:	89 12       	call	r9		;
     a74:	30 40 f6 08 	br	#0x08f6		;

00000a78 <.L120>:
     a78:	3c 40 d6 2f 	mov	#12246,	r12	;#0x2fd6
     a7c:	88 12       	call	r8		;
     a7e:	7c 40 0d 00 	mov.b	#13,	r12	;#0x000d
     a82:	86 12       	call	r6		;
     a84:	38 40 60 10 	mov	#4192,	r8	;#0x1060
     a88:	0c 4a       	mov	r10,	r12	;
     a8a:	88 12       	call	r8		;
     a8c:	05 4c       	mov	r12,	r5	;
     a8e:	07 41       	mov	r1,	r7	;
     a90:	37 50 26 00 	add	#38,	r7	;#0x0026
     a94:	4c 43       	clr.b	r12		;
     a96:	04 4c       	mov	r12,	r4	;
     a98:	0f 45       	mov	r5,	r15	;
     a9a:	3f 53       	add	#-1,	r15	;r3 As==11
     a9c:	81 4f 14 00 	mov	r15,	20(r1)	; 0x0014

00000aa0 <.L133>:
     aa0:	06 4c       	mov	r12,	r6	;
     aa2:	26 52       	add	#4,	r6	;r2 As==10
     aa4:	0d 4c       	mov	r12,	r13	;

00000aa6 <.L124>:
     aa6:	0d 96       	cmp	r6,	r13	;
     aa8:	3f 28       	jnc	$+128    	;abs 0xb28
     aaa:	0c 41       	mov	r1,	r12	;
     aac:	3c 50 20 00 	add	#32,	r12	;#0x0020
     ab0:	b0 12 60 10 	call	#4192		;#0x1060
     ab4:	0b 4c       	mov	r12,	r11	;
     ab6:	08 4c       	mov	r12,	r8	;
     ab8:	38 50 ff 3f 	add	#16383,	r8	;#0x3fff
     abc:	08 58       	rla	r8		;
     abe:	08 58       	rla	r8		;
     ac0:	4e 43       	clr.b	r14		;
     ac2:	0f 4e       	mov	r14,	r15	;

00000ac4 <.L127>:
     ac4:	0b 9e       	cmp	r14,	r11	;
     ac6:	3f 20       	jnz	$+128    	;abs 0xb46
     ac8:	87 4f 00 00 	mov	r15,	0(r7)	;
     acc:	81 94 14 00 	cmp	r4,	20(r1)	; 0x0014
     ad0:	05 24       	jz	$+12     	;abs 0xadc
     ad2:	27 53       	incd	r7		;
     ad4:	0c 46       	mov	r6,	r12	;
     ad6:	36 90 0c 00 	cmp	#12,	r6	;#0x000c
     ada:	e2 23       	jnz	$-58     	;abs 0xaa0

00000adc <.L134>:
     adc:	91 41 26 00 	mov	38(r1),	32(r1)	;0x00026, 0x0020
     ae0:	20 00 
     ae2:	91 41 28 00 	mov	40(r1),	34(r1)	;0x00028, 0x0022
     ae6:	22 00 
     ae8:	91 41 2a 00 	mov	42(r1),	36(r1)	;0x0002a, 0x0024
     aec:	24 00 
     aee:	c2 43 06 81 	mov.b	#0,	&0x8106	;r3 As==00
     af2:	08 41       	mov	r1,	r8	;
     af4:	38 50 24 00 	add	#36,	r8	;#0x0024
     af8:	44 43       	clr.b	r4		;
     afa:	35 40 06 81 	mov	#33030,	r5	;#0x8106
     afe:	36 40 00 04 	mov	#1024,	r6	;#0x0400

00000b02 <.L137>:
     b02:	4e 44       	mov.b	r4,	r14	;
     b04:	3e f0 ff 00 	and	#255,	r14	;#0x00ff
     b08:	24 53       	incd	r4		;

00000b0a <.L135>:
     b0a:	0e 94       	cmp	r4,	r14	;
     b0c:	61 38       	jl	$+196    	;abs 0xbd0
     b0e:	5e 43       	mov.b	#1,	r14	;r3 As==01
     b10:	7d 40 07 00 	mov.b	#7,	r13	;
     b14:	7c 40 53 00 	mov.b	#83,	r12	;#0x0053
     b18:	86 12       	call	r6		;
     b1a:	38 50 fe ff 	add	#65534,	r8	;#0xfffe
     b1e:	34 90 06 00 	cmp	#6,	r4	;
     b22:	ef 23       	jnz	$-32     	;abs 0xb02
     b24:	30 40 20 07 	br	#0x0720		;

00000b28 <.L126>:
     b28:	0d 95       	cmp	r5,	r13	;
     b2a:	0a 2c       	jc	$+22     	;abs 0xb40
     b2c:	0e 4d       	mov	r13,	r14	;
     b2e:	0e 8c       	sub	r12,	r14	;
     b30:	7f 40 20 00 	mov.b	#32,	r15	;#0x0020
     b34:	0f 51       	add	r1,	r15	;
     b36:	0e 5f       	add	r15,	r14	;
     b38:	de 4d f6 80 	mov.b	-32522(r13),0(r14)	;0xffff80f6
     b3c:	00 00 
     b3e:	04 4d       	mov	r13,	r4	;

00000b40 <.L125>:
     b40:	1d 53       	inc	r13		;
     b42:	30 40 a6 0a 	br	#0x0aa6		;

00000b46 <.L131>:
     b46:	7c 40 20 00 	mov.b	#32,	r12	;#0x0020
     b4a:	0c 51       	add	r1,	r12	;
     b4c:	0c 5e       	add	r14,	r12	;
     b4e:	6c 4c       	mov.b	@r12,	r12	;
     b50:	4d 4c       	mov.b	r12,	r13	;
     b52:	7d 50 d0 ff 	add.b	#65488,	r13	;#0xffd0
     b56:	c1 4d 18 00 	mov.b	r13,	24(r1)	; 0x0018
     b5a:	7d 40 09 00 	mov.b	#9,	r13	;
     b5e:	5d 91 18 00 	cmp.b	24(r1),	r13	;0x00018
     b62:	17 28       	jnc	$+48     	;abs 0xb92
     b64:	3c 50 d0 ff 	add	#65488,	r12	;#0xffd0

00000b68 <.L129>:
     b68:	0d 48       	mov	r8,	r13	;
     b6a:	81 4b 12 00 	mov	r11,	18(r1)	; 0x0012
     b6e:	81 4e 10 00 	mov	r14,	16(r1)	; 0x0010
     b72:	81 4f 0e 00 	mov	r15,	14(r1)	; 0x000e
     b76:	b0 12 4a 0e 	call	#3658		;#0x0e4a
     b7a:	1f 41 0e 00 	mov	14(r1),	r15	;0x0000e
     b7e:	0f 5c       	add	r12,	r15	;
     b80:	1e 41 10 00 	mov	16(r1),	r14	;0x00010
     b84:	1e 53       	inc	r14		;
     b86:	38 50 fc ff 	add	#65532,	r8	;#0xfffc
     b8a:	1b 41 12 00 	mov	18(r1),	r11	;0x00012
     b8e:	30 40 c4 0a 	br	#0x0ac4		;

00000b92 <.L128>:
     b92:	4d 4c       	mov.b	r12,	r13	;
     b94:	7d 50 9f ff 	add.b	#65439,	r13	;#0xff9f
     b98:	c1 4d 18 00 	mov.b	r13,	24(r1)	; 0x0018
     b9c:	7d 40 05 00 	mov.b	#5,	r13	;
     ba0:	5d 91 18 00 	cmp.b	24(r1),	r13	;0x00018
     ba4:	04 28       	jnc	$+10     	;abs 0xbae
     ba6:	3c 50 a9 ff 	add	#65449,	r12	;#0xffa9
     baa:	30 40 68 0b 	br	#0x0b68		;

00000bae <.L130>:
     bae:	4d 4c       	mov.b	r12,	r13	;
     bb0:	7d 50 bf ff 	add.b	#65471,	r13	;#0xffbf
     bb4:	c1 4d 18 00 	mov.b	r13,	24(r1)	; 0x0018
     bb8:	7d 40 05 00 	mov.b	#5,	r13	;
     bbc:	5d 91 18 00 	cmp.b	24(r1),	r13	;0x00018
     bc0:	04 28       	jnc	$+10     	;abs 0xbca
     bc2:	3c 50 c9 ff 	add	#65481,	r12	;#0xffc9
     bc6:	30 40 68 0b 	br	#0x0b68		;

00000bca <.L146>:
     bca:	4c 43       	clr.b	r12		;
     bcc:	30 40 68 0b 	br	#0x0b68		;

00000bd0 <.L136>:
     bd0:	07 45       	mov	r5,	r7	;
     bd2:	07 5e       	add	r14,	r7	;
     bd4:	17 53       	inc	r7		;
     bd6:	0d 4e       	mov	r14,	r13	;
     bd8:	0d 5e       	add	r14,	r13	;
     bda:	0d 5d       	rla	r13		;
     bdc:	0d 5d       	rla	r13		;
     bde:	2c 48       	mov	@r8,	r12	;
     be0:	81 4e 10 00 	mov	r14,	16(r1)	; 0x0010
     be4:	b0 12 de 0e 	call	#3806		;#0x0ede
     be8:	c7 4c 00 00 	mov.b	r12,	0(r7)	;
     bec:	1e 41 10 00 	mov	16(r1),	r14	;0x00010
     bf0:	5e 53       	inc.b	r14		;
     bf2:	3e f0 ff 00 	and	#255,	r14	;#0x00ff
     bf6:	30 40 0a 0b 	br	#0x0b0a		;

00000bfa <.L113>:
     bfa:	3c 40 30 30 	mov	#12336,	r12	;#0x3030
     bfe:	88 12       	call	r8		;
     c00:	3c 40 3d 30 	mov	#12349,	r12	;#0x303d
     c04:	88 12       	call	r8		;
     c06:	7c 40 09 00 	mov.b	#9,	r12	;
     c0a:	86 12       	call	r6		;
     c0c:	b0 12 7a 01 	call	#378		;#0x017a
     c10:	81 4c 18 00 	mov	r12,	24(r1)	; 0x0018
     c14:	81 4d 1a 00 	mov	r13,	26(r1)	; 0x001a
     c18:	3c 40 69 30 	mov	#12393,	r12	;#0x3069
     c1c:	88 12       	call	r8		;
     c1e:	7c 40 10 00 	mov.b	#16,	r12	;#0x0010
     c22:	86 12       	call	r6		;
     c24:	3d 40 80 30 	mov	#12416,	r13	;#0x3080
     c28:	0c 4a       	mov	r10,	r12	;
     c2a:	87 12       	call	r7		;
     c2c:	0c 93       	cmp	#0,	r12	;r3 As==00
     c2e:	6e 20       	jnz	$+222    	;abs 0xd0c
     c30:	d2 43 f4 80 	mov.b	#1,	&0x80f4	;r3 As==01

00000c34 <.L139>:
     c34:	3c 40 82 30 	mov	#12418,	r12	;#0x3082
     c38:	88 12       	call	r8		;
     c3a:	5c 43       	mov.b	#1,	r12	;r3 As==01
     c3c:	86 12       	call	r6		;
     c3e:	3d 40 80 30 	mov	#12416,	r13	;#0x3080
     c42:	0c 4a       	mov	r10,	r12	;
     c44:	87 12       	call	r7		;
     c46:	0c 93       	cmp	#0,	r12	;r3 As==00
     c48:	65 20       	jnz	$+204    	;abs 0xd14
     c4a:	d2 43 f5 80 	mov.b	#1,	&0x80f5	;r3 As==01

00000c4e <.L141>:
     c4e:	b0 12 cc 04 	call	#1228		;#0x04cc
     c52:	81 4c 1c 00 	mov	r12,	28(r1)	; 0x001c
     c56:	81 4d 1e 00 	mov	r13,	30(r1)	; 0x001e
     c5a:	5c 42 f4 80 	mov.b	&0x80f4,r12	;0x80f4
     c5e:	c2 93 f5 80 	cmp.b	#0,	&0x80f5	;r3 As==00
     c62:	5c 20       	jnz	$+186    	;abs 0xd1c
     c64:	0c 93       	cmp	#0,	r12	;r3 As==00
     c66:	62 24       	jz	$+198    	;abs 0xd2c
     c68:	35 40 30 01 	mov	#304,	r5	;#0x0130
     c6c:	34 40 00 20 	mov	#8192,	r4	;#0x2000
     c70:	b1 40 3f 01 	mov	#319,	20(r1)	;#0x013f, 0x0014
     c74:	14 00 

00000c76 <.L167>:
     c76:	b1 40 00 20 	mov	#8192,	22(r1)	;#0x2000, 0x0016
     c7a:	16 00 
     c7c:	3f 40 d8 02 	mov	#728,	r15	;#0x02d8
     c80:	81 4f 0e 00 	mov	r15,	14(r1)	; 0x000e
     c84:	8f 12       	call	r15		;
     c86:	36 40 68 01 	mov	#360,	r6	;#0x0168
     c8a:	4c 43       	clr.b	r12		;
     c8c:	86 12       	call	r6		;
     c8e:	38 40 8a 05 	mov	#1418,	r8	;#0x058a
     c92:	7c 40 03 00 	mov.b	#3,	r12	;
     c96:	4d 43       	clr.b	r13		;
     c98:	88 12       	call	r8		;
     c9a:	1c 41 14 00 	mov	20(r1),	r12	;0x00014
     c9e:	1d 41 16 00 	mov	22(r1),	r13	;0x00016
     ca2:	88 12       	call	r8		;
     ca4:	1c 41 18 00 	mov	24(r1),	r12	;0x00018
     ca8:	1d 41 1a 00 	mov	26(r1),	r13	;0x0001a
     cac:	88 12       	call	r8		;
     cae:	1c 41 1c 00 	mov	28(r1),	r12	;0x0001c
     cb2:	1d 41 1e 00 	mov	30(r1),	r13	;0x0001e
     cb6:	88 12       	call	r8		;
     cb8:	37 40 94 02 	mov	#660,	r7	;#0x0294
     cbc:	87 12       	call	r7		;
     cbe:	1f 41 0e 00 	mov	14(r1),	r15	;0x0000e
     cc2:	8f 12       	call	r15		;
     cc4:	5c 43       	mov.b	#1,	r12	;r3 As==01
     cc6:	86 12       	call	r6		;
     cc8:	3c 43       	mov	#-1,	r12	;r3 As==11
     cca:	4d 43       	clr.b	r13		;
     ccc:	88 12       	call	r8		;
     cce:	08 4c       	mov	r12,	r8	;
     cd0:	06 4d       	mov	r13,	r6	;
     cd2:	87 12       	call	r7		;
     cd4:	08 95       	cmp	r5,	r8	;
     cd6:	05 20       	jnz	$+12     	;abs 0xce2
     cd8:	36 90 00 20 	cmp	#8192,	r6	;#0x2000
     cdc:	02 20       	jnz	$+6      	;abs 0xce2
     cde:	30 40 20 07 	br	#0x0720		;

00000ce2 <.L150>:
     ce2:	81 45 0a 00 	mov	r5,	10(r1)	; 0x000a
     ce6:	81 44 0c 00 	mov	r4,	12(r1)	; 0x000c
     cea:	81 48 06 00 	mov	r8,	6(r1)	;
     cee:	81 46 08 00 	mov	r6,	8(r1)	;
     cf2:	91 41 14 00 	mov	20(r1),	2(r1)	;0x00014
     cf6:	02 00 
     cf8:	91 41 16 00 	mov	22(r1),	4(r1)	;0x00016
     cfc:	04 00 
     cfe:	b1 40 e4 30 	mov	#12516,	0(r1)	;#0x30e4
     d02:	00 00 
     d04:	b0 12 4e 0f 	call	#3918		;#0x0f4e
     d08:	30 40 20 07 	br	#0x0720		;

00000d0c <.L138>:
     d0c:	c2 44 f4 80 	mov.b	r4,	&0x80f4	;
     d10:	30 40 34 0c 	br	#0x0c34		;

00000d14 <.L140>:
     d14:	c2 43 f5 80 	mov.b	#0,	&0x80f5	;r3 As==00
     d18:	30 40 4e 0c 	br	#0x0c4e		;

00000d1c <.L142>:
     d1c:	0c 93       	cmp	#0,	r12	;r3 As==00
     d1e:	0f 24       	jz	$+32     	;abs 0xd3e
     d20:	3c 40 a4 30 	mov	#12452,	r12	;#0x30a4
     d24:	b0 12 38 10 	call	#4152		;#0x1038
     d28:	30 40 20 07 	br	#0x0720		;

00000d2c <.L147>:
     d2c:	35 40 10 01 	mov	#272,	r5	;#0x0110
     d30:	34 40 00 20 	mov	#8192,	r4	;#0x2000
     d34:	b1 40 1f 01 	mov	#287,	20(r1)	;#0x011f, 0x0014
     d38:	14 00 
     d3a:	30 40 76 0c 	br	#0x0c76		;

00000d3e <.L148>:
     d3e:	35 40 70 02 	mov	#624,	r5	;#0x0270
     d42:	34 40 00 20 	mov	#8192,	r4	;#0x2000
     d46:	b1 40 7f 01 	mov	#383,	20(r1)	;#0x017f, 0x0014
     d4a:	14 00 
     d4c:	30 40 76 0c 	br	#0x0c76		;

00000d50 <.L163>:
     d50:	3c 40 73 2d 	mov	#11635,	r12	;#0x2d73
     d54:	8a 12       	call	r10		;
     d56:	5c 43       	mov.b	#1,	r12	;r3 As==01
     d58:	31 50 2c 00 	add	#44,	r1	;#0x002c
     d5c:	30 40 16 0e 	br	#0x0e16		;

00000d60 <udivmodhi4>:
     d60:	0a 12       	push	r10		;

00000d62 <.LCFI0>:
     d62:	09 12       	push	r9		;

00000d64 <.LCFI1>:
     d64:	08 12       	push	r8		;

00000d66 <.LCFI2>:
     d66:	07 12       	push	r7		;

00000d68 <.LCFI3>:
     d68:	06 12       	push	r6		;

00000d6a <.LCFI4>:
     d6a:	07 4c       	mov	r12,	r7	;
     d6c:	09 4d       	mov	r13,	r9	;
     d6e:	06 4e       	mov	r14,	r6	;

00000d70 <.LVL1>:
     d70:	7a 40 11 00 	mov.b	#17,	r10	;#0x0011

00000d74 <.Loc.35.1>:
     d74:	58 43       	mov.b	#1,	r8	;r3 As==01

00000d76 <.L2>:
     d76:	09 97       	cmp	r7,	r9	;
     d78:	09 28       	jnc	$+20     	;abs 0xd8c

00000d7a <.L15>:
     d7a:	4a 43       	clr.b	r10		;

00000d7c <.L4>:
     d7c:	08 93       	cmp	#0,	r8	;r3 As==00
     d7e:	0f 20       	jnz	$+32     	;abs 0xd9e

00000d80 <.L5>:
     d80:	06 93       	cmp	#0,	r6	;r3 As==00
     d82:	01 24       	jz	$+4      	;abs 0xd86
     d84:	0a 47       	mov	r7,	r10	;

00000d86 <.L1>:
     d86:	0c 4a       	mov	r10,	r12	;
     d88:	30 40 1a 0e 	br	#0x0e1a		;

00000d8c <.L3>:
     d8c:	3a 53       	add	#-1,	r10	;r3 As==11

00000d8e <.Loc.38.1>:
     d8e:	0a 93       	cmp	#0,	r10	;r3 As==00
     d90:	f7 27       	jz	$-16     	;abs 0xd80

00000d92 <.Loc.38.1>:
     d92:	09 93       	cmp	#0,	r9	;r3 As==00
     d94:	f2 3b       	jl	$-26     	;abs 0xd7a

00000d96 <.Loc.40.1>:
     d96:	09 59       	rla	r9		;

00000d98 <.Loc.41.1>:
     d98:	08 58       	rla	r8		;
     d9a:	30 40 76 0d 	br	#0x0d76		;

00000d9e <.L9>:
     d9e:	07 99       	cmp	r9,	r7	;
     da0:	02 28       	jnc	$+6      	;abs 0xda6

00000da2 <.Loc.47.1>:
     da2:	07 89       	sub	r9,	r7	;

00000da4 <.Loc.48.1>:
     da4:	0a d8       	bis	r8,	r10	;

00000da6 <.L8>:
     da6:	0c 48       	mov	r8,	r12	;
     da8:	b0 12 d2 0e 	call	#3794		;#0x0ed2
     dac:	08 4c       	mov	r12,	r8	;

00000dae <.Loc.51.1>:
     dae:	0c 49       	mov	r9,	r12	;
     db0:	b0 12 d2 0e 	call	#3794		;#0x0ed2
     db4:	09 4c       	mov	r12,	r9	;
     db6:	30 40 7c 0d 	br	#0x0d7c		;

00000dba <__mspabi_divi>:
     dba:	0a 12       	push	r10		;

00000dbc <.LCFI5>:
     dbc:	0f 4c       	mov	r12,	r15	;
     dbe:	0e 4d       	mov	r13,	r14	;

00000dc0 <.LVL16>:
     dc0:	3b 40 60 0d 	mov	#3424,	r11	;#0x0d60

00000dc4 <.Loc.64.1>:
     dc4:	0c 93       	cmp	#0,	r12	;r3 As==00
     dc6:	1a 34       	jge	$+54     	;abs 0xdfc

00000dc8 <.Loc.66.1>:
     dc8:	4c 43       	clr.b	r12		;

00000dca <.LVL17>:
     dca:	0c 8f       	sub	r15,	r12	;
     dcc:	0f 4c       	mov	r12,	r15	;

00000dce <.LVL18>:
     dce:	0d 93       	cmp	#0,	r13	;r3 As==00
     dd0:	0d 34       	jge	$+28     	;abs 0xdec

00000dd2 <.Loc.67.1>:
     dd2:	5a 43       	mov.b	#1,	r10	;r3 As==01

00000dd4 <.L21>:
     dd4:	0d 43       	clr	r13		;
     dd6:	0d 8e       	sub	r14,	r13	;

00000dd8 <.LVL20>:
     dd8:	4e 43       	clr.b	r14		;

00000dda <.LVL21>:
     dda:	0c 4f       	mov	r15,	r12	;

00000ddc <.LVL22>:
     ddc:	8b 12       	call	r11		;

00000dde <.LVL23>:
     dde:	1a 93       	cmp	#1,	r10	;r3 As==01
     de0:	03 24       	jz	$+8      	;abs 0xde8

00000de2 <.L20>:
     de2:	4d 43       	clr.b	r13		;
     de4:	0d 8c       	sub	r12,	r13	;
     de6:	0c 4d       	mov	r13,	r12	;

00000de8 <.L16>:
     de8:	3a 41       	pop	r10		;
     dea:	30 41       	ret			

00000dec <.L18>:
     dec:	4e 43       	clr.b	r14		;
     dee:	8b 12       	call	r11		;

00000df0 <.LVL27>:
     df0:	30 40 e2 0d 	br	#0x0de2		;

00000df4 <.L27>:
     df4:	4e 43       	clr.b	r14		;
     df6:	8b 12       	call	r11		;

00000df8 <.LVL29>:
     df8:	30 40 e8 0d 	br	#0x0de8		;

00000dfc <.L17>:
     dfc:	0d 93       	cmp	#0,	r13	;r3 As==00
     dfe:	fa 37       	jge	$-10     	;abs 0xdf4

00000e00 <.Loc.61.1>:
     e00:	4a 43       	clr.b	r10		;
     e02:	30 40 d4 0d 	br	#0x0dd4		;

00000e06 <__mspabi_divu>:
     e06:	4e 43       	clr.b	r14		;
     e08:	b0 12 60 0d 	call	#3424		;#0x0d60

00000e0c <.LVL41>:
     e0c:	30 41       	ret			

00000e0e <__mspabi_remu>:
     e0e:	5e 43       	mov.b	#1,	r14	;r3 As==01
     e10:	b0 12 60 0d 	call	#3424		;#0x0d60

00000e14 <.LVL43>:
     e14:	30 41       	ret			

00000e16 <__mspabi_func_epilog_7>:
     e16:	34 41       	pop	r4		;

00000e18 <__mspabi_func_epilog_6>:
     e18:	35 41       	pop	r5		;

00000e1a <__mspabi_func_epilog_5>:
     e1a:	36 41       	pop	r6		;

00000e1c <__mspabi_func_epilog_4>:
     e1c:	37 41       	pop	r7		;

00000e1e <__mspabi_func_epilog_3>:
     e1e:	38 41       	pop	r8		;

00000e20 <__mspabi_func_epilog_2>:
     e20:	39 41       	pop	r9		;

00000e22 <__mspabi_func_epilog_1>:
     e22:	3a 41       	pop	r10		;
     e24:	30 41       	ret			

00000e26 <__mspabi_slli_15>:
     e26:	0c 5c       	rla	r12		;

00000e28 <__mspabi_slli_14>:
     e28:	0c 5c       	rla	r12		;

00000e2a <__mspabi_slli_13>:
     e2a:	0c 5c       	rla	r12		;

00000e2c <__mspabi_slli_12>:
     e2c:	0c 5c       	rla	r12		;

00000e2e <__mspabi_slli_11>:
     e2e:	0c 5c       	rla	r12		;

00000e30 <__mspabi_slli_10>:
     e30:	0c 5c       	rla	r12		;

00000e32 <__mspabi_slli_9>:
     e32:	0c 5c       	rla	r12		;

00000e34 <__mspabi_slli_8>:
     e34:	0c 5c       	rla	r12		;

00000e36 <__mspabi_slli_7>:
     e36:	0c 5c       	rla	r12		;

00000e38 <__mspabi_slli_6>:
     e38:	0c 5c       	rla	r12		;

00000e3a <__mspabi_slli_5>:
     e3a:	0c 5c       	rla	r12		;

00000e3c <__mspabi_slli_4>:
     e3c:	0c 5c       	rla	r12		;

00000e3e <__mspabi_slli_3>:
     e3e:	0c 5c       	rla	r12		;

00000e40 <__mspabi_slli_2>:
     e40:	0c 5c       	rla	r12		;

00000e42 <__mspabi_slli_1>:
     e42:	0c 5c       	rla	r12		;
     e44:	30 41       	ret			

00000e46 <.L11>:
     e46:	3d 53       	add	#-1,	r13	;r3 As==11
     e48:	0c 5c       	rla	r12		;

00000e4a <__mspabi_slli>:
     e4a:	0d 93       	cmp	#0,	r13	;r3 As==00
     e4c:	fc 23       	jnz	$-6      	;abs 0xe46
     e4e:	30 41       	ret			

00000e50 <__mspabi_slll_15>:
     e50:	0c 5c       	rla	r12		;
     e52:	0d 6d       	rlc	r13		;

00000e54 <__mspabi_slll_14>:
     e54:	0c 5c       	rla	r12		;
     e56:	0d 6d       	rlc	r13		;

00000e58 <__mspabi_slll_13>:
     e58:	0c 5c       	rla	r12		;
     e5a:	0d 6d       	rlc	r13		;

00000e5c <__mspabi_slll_12>:
     e5c:	0c 5c       	rla	r12		;
     e5e:	0d 6d       	rlc	r13		;

00000e60 <__mspabi_slll_11>:
     e60:	0c 5c       	rla	r12		;
     e62:	0d 6d       	rlc	r13		;

00000e64 <__mspabi_slll_10>:
     e64:	0c 5c       	rla	r12		;
     e66:	0d 6d       	rlc	r13		;

00000e68 <__mspabi_slll_9>:
     e68:	0c 5c       	rla	r12		;
     e6a:	0d 6d       	rlc	r13		;

00000e6c <__mspabi_slll_8>:
     e6c:	0c 5c       	rla	r12		;
     e6e:	0d 6d       	rlc	r13		;

00000e70 <__mspabi_slll_7>:
     e70:	0c 5c       	rla	r12		;
     e72:	0d 6d       	rlc	r13		;

00000e74 <__mspabi_slll_6>:
     e74:	0c 5c       	rla	r12		;
     e76:	0d 6d       	rlc	r13		;

00000e78 <__mspabi_slll_5>:
     e78:	0c 5c       	rla	r12		;
     e7a:	0d 6d       	rlc	r13		;

00000e7c <__mspabi_slll_4>:
     e7c:	0c 5c       	rla	r12		;
     e7e:	0d 6d       	rlc	r13		;

00000e80 <__mspabi_slll_3>:
     e80:	0c 5c       	rla	r12		;
     e82:	0d 6d       	rlc	r13		;

00000e84 <__mspabi_slll_2>:
     e84:	0c 5c       	rla	r12		;
     e86:	0d 6d       	rlc	r13		;

00000e88 <__mspabi_slll_1>:
     e88:	0c 5c       	rla	r12		;
     e8a:	0d 6d       	rlc	r13		;
     e8c:	30 41       	ret			

00000e8e <.L12>:
     e8e:	3e 53       	add	#-1,	r14	;r3 As==11
     e90:	0c 5c       	rla	r12		;
     e92:	0d 6d       	rlc	r13		;

00000e94 <__mspabi_slll>:
     e94:	0e 93       	cmp	#0,	r14	;r3 As==00
     e96:	fb 23       	jnz	$-8      	;abs 0xe8e
     e98:	30 41       	ret			

00000e9a <__mspabi_srli_15>:
     e9a:	12 c3       	clrc			
     e9c:	0c 10       	rrc	r12		;

00000e9e <__mspabi_srli_14>:
     e9e:	12 c3       	clrc			
     ea0:	0c 10       	rrc	r12		;

00000ea2 <__mspabi_srli_13>:
     ea2:	12 c3       	clrc			
     ea4:	0c 10       	rrc	r12		;

00000ea6 <__mspabi_srli_12>:
     ea6:	12 c3       	clrc			
     ea8:	0c 10       	rrc	r12		;

00000eaa <__mspabi_srli_11>:
     eaa:	12 c3       	clrc			
     eac:	0c 10       	rrc	r12		;

00000eae <__mspabi_srli_10>:
     eae:	12 c3       	clrc			
     eb0:	0c 10       	rrc	r12		;

00000eb2 <__mspabi_srli_9>:
     eb2:	12 c3       	clrc			
     eb4:	0c 10       	rrc	r12		;

00000eb6 <__mspabi_srli_8>:
     eb6:	12 c3       	clrc			
     eb8:	0c 10       	rrc	r12		;

00000eba <__mspabi_srli_7>:
     eba:	12 c3       	clrc			
     ebc:	0c 10       	rrc	r12		;

00000ebe <__mspabi_srli_6>:
     ebe:	12 c3       	clrc			
     ec0:	0c 10       	rrc	r12		;

00000ec2 <__mspabi_srli_5>:
     ec2:	12 c3       	clrc			
     ec4:	0c 10       	rrc	r12		;

00000ec6 <__mspabi_srli_4>:
     ec6:	12 c3       	clrc			
     ec8:	0c 10       	rrc	r12		;

00000eca <__mspabi_srli_3>:
     eca:	12 c3       	clrc			
     ecc:	0c 10       	rrc	r12		;

00000ece <__mspabi_srli_2>:
     ece:	12 c3       	clrc			
     ed0:	0c 10       	rrc	r12		;

00000ed2 <__mspabi_srli_1>:
     ed2:	12 c3       	clrc			
     ed4:	0c 10       	rrc	r12		;
     ed6:	30 41       	ret			

00000ed8 <.L11>:
     ed8:	3d 53       	add	#-1,	r13	;r3 As==11
     eda:	12 c3       	clrc			
     edc:	0c 10       	rrc	r12		;

00000ede <__mspabi_srli>:
     ede:	0d 93       	cmp	#0,	r13	;r3 As==00
     ee0:	fb 23       	jnz	$-8      	;abs 0xed8
     ee2:	30 41       	ret			

00000ee4 <__mspabi_srll_15>:
     ee4:	12 c3       	clrc			
     ee6:	0d 10       	rrc	r13		;
     ee8:	0c 10       	rrc	r12		;

00000eea <__mspabi_srll_14>:
     eea:	12 c3       	clrc			
     eec:	0d 10       	rrc	r13		;
     eee:	0c 10       	rrc	r12		;

00000ef0 <__mspabi_srll_13>:
     ef0:	12 c3       	clrc			
     ef2:	0d 10       	rrc	r13		;
     ef4:	0c 10       	rrc	r12		;

00000ef6 <__mspabi_srll_12>:
     ef6:	12 c3       	clrc			
     ef8:	0d 10       	rrc	r13		;
     efa:	0c 10       	rrc	r12		;

00000efc <__mspabi_srll_11>:
     efc:	12 c3       	clrc			
     efe:	0d 10       	rrc	r13		;
     f00:	0c 10       	rrc	r12		;

00000f02 <__mspabi_srll_10>:
     f02:	12 c3       	clrc			
     f04:	0d 10       	rrc	r13		;
     f06:	0c 10       	rrc	r12		;

00000f08 <__mspabi_srll_9>:
     f08:	12 c3       	clrc			
     f0a:	0d 10       	rrc	r13		;
     f0c:	0c 10       	rrc	r12		;

00000f0e <__mspabi_srll_8>:
     f0e:	12 c3       	clrc			
     f10:	0d 10       	rrc	r13		;
     f12:	0c 10       	rrc	r12		;

00000f14 <__mspabi_srll_7>:
     f14:	12 c3       	clrc			
     f16:	0d 10       	rrc	r13		;
     f18:	0c 10       	rrc	r12		;

00000f1a <__mspabi_srll_6>:
     f1a:	12 c3       	clrc			
     f1c:	0d 10       	rrc	r13		;
     f1e:	0c 10       	rrc	r12		;

00000f20 <__mspabi_srll_5>:
     f20:	12 c3       	clrc			
     f22:	0d 10       	rrc	r13		;
     f24:	0c 10       	rrc	r12		;

00000f26 <__mspabi_srll_4>:
     f26:	12 c3       	clrc			
     f28:	0d 10       	rrc	r13		;
     f2a:	0c 10       	rrc	r12		;

00000f2c <__mspabi_srll_3>:
     f2c:	12 c3       	clrc			
     f2e:	0d 10       	rrc	r13		;
     f30:	0c 10       	rrc	r12		;

00000f32 <__mspabi_srll_2>:
     f32:	12 c3       	clrc			
     f34:	0d 10       	rrc	r13		;
     f36:	0c 10       	rrc	r12		;

00000f38 <__mspabi_srll_1>:
     f38:	12 c3       	clrc			
     f3a:	0d 10       	rrc	r13		;
     f3c:	0c 10       	rrc	r12		;
     f3e:	30 41       	ret			

00000f40 <.L12>:
     f40:	3e 53       	add	#-1,	r14	;r3 As==11
     f42:	12 c3       	clrc			
     f44:	0d 10       	rrc	r13		;
     f46:	0c 10       	rrc	r12		;

00000f48 <__mspabi_srll>:
     f48:	0e 93       	cmp	#0,	r14	;r3 As==00
     f4a:	fa 23       	jnz	$-10     	;abs 0xf40
     f4c:	30 41       	ret			

00000f4e <iprintf>:
     f4e:	0a 12       	push	r10		;

00000f50 <.LCFI1>:
     f50:	1a 42 08 80 	mov	&0x8008,r10	;0x8008

00000f54 <.LVL5>:
     f54:	0a 93       	cmp	#0,	r10	;r3 As==00
     f56:	06 24       	jz	$+14     	;abs 0xf64

00000f58 <.Loc.56.1>:
     f58:	8a 93 0c 00 	cmp	#0,	12(r10)	;r3 As==00, 0x000c
     f5c:	03 20       	jnz	$+8      	;abs 0xf64

00000f5e <.Loc.56.1>:
     f5e:	0c 4a       	mov	r10,	r12	;
     f60:	b0 12 20 11 	call	#4384		;#0x1120

00000f64 <.L7>:
     f64:	0f 41       	mov	r1,	r15	;
     f66:	3f 50 06 00 	add	#6,	r15	;
     f6a:	1e 41 04 00 	mov	4(r1),	r14	;
     f6e:	1d 4a 04 00 	mov	4(r10),	r13	;
     f72:	0c 4a       	mov	r10,	r12	;
     f74:	b0 12 54 19 	call	#6484		;#0x1954

00000f78 <.LVL7>:
     f78:	3a 41       	pop	r10		;

00000f7a <.LVL8>:
     f7a:	30 41       	ret			

00000f7c <_puts_r>:
     f7c:	0a 12       	push	r10		;

00000f7e <.LCFI0>:
     f7e:	09 12       	push	r9		;

00000f80 <.LCFI1>:
     f80:	31 80 0e 00 	sub	#14,	r1	;#0x000e

00000f84 <.LCFI2>:
     f84:	09 4c       	mov	r12,	r9	;
     f86:	0a 4d       	mov	r13,	r10	;

00000f88 <.Loc.83.1>:
     f88:	0c 4d       	mov	r13,	r12	;

00000f8a <.LVL1>:
     f8a:	b0 12 60 10 	call	#4192		;#0x1060

00000f8e <.LVL2>:
     f8e:	81 4a 06 00 	mov	r10,	6(r1)	;

00000f92 <.Loc.89.1>:
     f92:	81 4c 08 00 	mov	r12,	8(r1)	;

00000f96 <.Loc.90.1>:
     f96:	b1 40 64 31 	mov	#12644,	10(r1)	;#0x3164, 0x000a
     f9a:	0a 00 

00000f9c <.Loc.91.1>:
     f9c:	91 43 0c 00 	mov	#1,	12(r1)	;r3 As==01, 0x000c

00000fa0 <.Loc.92.1>:
     fa0:	1c 53       	inc	r12		;

00000fa2 <.LVL3>:
     fa2:	81 4c 04 00 	mov	r12,	4(r1)	;

00000fa6 <.Loc.93.1>:
     fa6:	7c 40 06 00 	mov.b	#6,	r12	;
     faa:	0c 51       	add	r1,	r12	;
     fac:	81 4c 00 00 	mov	r12,	0(r1)	;

00000fb0 <.Loc.94.1>:
     fb0:	a1 43 02 00 	mov	#2,	2(r1)	;r3 As==10

00000fb4 <.Loc.96.1>:
     fb4:	09 93       	cmp	#0,	r9	;r3 As==00
     fb6:	06 24       	jz	$+14     	;abs 0xfc4

00000fb8 <.Loc.96.1>:
     fb8:	89 93 0c 00 	cmp	#0,	12(r9)	;r3 As==00, 0x000c
     fbc:	03 20       	jnz	$+8      	;abs 0xfc4

00000fbe <.Loc.96.1>:
     fbe:	0c 49       	mov	r9,	r12	;
     fc0:	b0 12 20 11 	call	#4384		;#0x1120

00000fc4 <.L2>:
     fc4:	1a 49 04 00 	mov	4(r9),	r10	;

00000fc8 <.LBB2>:
     fc8:	89 93 0c 00 	cmp	#0,	12(r9)	;r3 As==00, 0x000c
     fcc:	03 20       	jnz	$+8      	;abs 0xfd4

00000fce <.Loc.98.1>:
     fce:	0c 49       	mov	r9,	r12	;
     fd0:	b0 12 20 11 	call	#4384		;#0x1120

00000fd4 <.L3>:
     fd4:	3a 90 8a 31 	cmp	#12682,	r10	;#0x318a
     fd8:	1e 20       	jnz	$+62     	;abs 0x1016

00000fda <.Loc.98.1>:
     fda:	1a 49 02 00 	mov	2(r9),	r10	;

00000fde <.L5>:
     fde:	1c 4a 06 00 	mov	6(r10),	r12	;
     fe2:	3c b0 00 20 	bit	#8192,	r12	;#0x2000
     fe6:	0a 20       	jnz	$+22     	;abs 0xffc

00000fe8 <.Loc.100.1>:
     fe8:	3c d0 00 20 	bis	#8192,	r12	;#0x2000
     fec:	8a 4c 06 00 	mov	r12,	6(r10)	;
     ff0:	1c 4a 3a 00 	mov	58(r10),r12	;0x0003a
     ff4:	3c f0 ff df 	and	#57343,	r12	;#0xdfff
     ff8:	8a 4c 3a 00 	mov	r12,	58(r10)	; 0x003a

00000ffc <.L7>:
     ffc:	0e 41       	mov	r1,	r14	;
     ffe:	0d 4a       	mov	r10,	r13	;
    1000:	0c 49       	mov	r9,	r12	;
    1002:	b0 12 4e 12 	call	#4686		;#0x124e

00001006 <.LVL8>:
    1006:	0c 93       	cmp	#0,	r12	;r3 As==00
    1008:	14 20       	jnz	$+42     	;abs 0x1032
    100a:	7c 40 0a 00 	mov.b	#10,	r12	;#0x000a

0000100e <.L1>:
    100e:	31 50 0e 00 	add	#14,	r1	;#0x000e
    1012:	30 40 20 0e 	br	#0x0e20		;

00001016 <.L4>:
    1016:	3a 90 78 31 	cmp	#12664,	r10	;#0x3178
    101a:	04 20       	jnz	$+10     	;abs 0x1024

0000101c <.Loc.98.1>:
    101c:	1a 49 04 00 	mov	4(r9),	r10	;
    1020:	30 40 de 0f 	br	#0x0fde		;

00001024 <.L6>:
    1024:	3a 90 66 31 	cmp	#12646,	r10	;#0x3166
    1028:	da 23       	jnz	$-74     	;abs 0xfde

0000102a <.Loc.98.1>:
    102a:	1a 49 06 00 	mov	6(r9),	r10	;
    102e:	30 40 de 0f 	br	#0x0fde		;

00001032 <.L9>:
    1032:	3c 43       	mov	#-1,	r12	;r3 As==11

00001034 <.Loc.103.1>:
    1034:	30 40 0e 10 	br	#0x100e		;

00001038 <puts>:
    1038:	0d 4c       	mov	r12,	r13	;
    103a:	1c 42 08 80 	mov	&0x8008,r12	;0x8008

0000103e <.LVL13>:
    103e:	b0 12 7c 0f 	call	#3964		;#0x0f7c

00001042 <.LVL14>:
    1042:	30 41       	ret			

00001044 <strcmp>:
    1044:	6e 4c       	mov.b	@r12,	r14	;
    1046:	0e 93       	cmp	#0,	r14	;r3 As==00
    1048:	03 24       	jz	$+8      	;abs 0x1050

0000104a <.Loc.66.1>:
    104a:	cd 9e 00 00 	cmp.b	r14,	0(r13)	;
    104e:	04 24       	jz	$+10     	;abs 0x1058

00001050 <.L3>:
    1050:	0c 4e       	mov	r14,	r12	;

00001052 <.LVL1>:
    1052:	6d 4d       	mov.b	@r13,	r13	;

00001054 <.LVL2>:
    1054:	0c 8d       	sub	r13,	r12	;
    1056:	30 41       	ret			

00001058 <.L4>:
    1058:	1c 53       	inc	r12		;

0000105a <.Loc.69.1>:
    105a:	1d 53       	inc	r13		;
    105c:	30 40 44 10 	br	#0x1044		;

00001060 <strlen>:
    1060:	0d 4c       	mov	r12,	r13	;

00001062 <.L2>:
    1062:	cd 93 00 00 	cmp.b	#0,	0(r13)	;r3 As==00
    1066:	03 20       	jnz	$+8      	;abs 0x106e

00001068 <.Loc.88.1>:
    1068:	0d 8c       	sub	r12,	r13	;

0000106a <.LVL3>:
    106a:	0c 4d       	mov	r13,	r12	;

0000106c <.LVL4>:
    106c:	30 41       	ret			

0000106e <.L3>:
    106e:	1d 53       	inc	r13		;
    1070:	30 40 62 10 	br	#0x1062		;

00001074 <_cleanup_r>:
    1074:	3d 40 06 1f 	mov	#7942,	r13	;#0x1f06
    1078:	b0 12 82 15 	call	#5506		;#0x1582

0000107c <.LVL4>:
    107c:	30 41       	ret			

0000107e <std.isra.0>:
    107e:	0a 12       	push	r10		;

00001080 <.LCFI0>:
    1080:	0a 4c       	mov	r12,	r10	;

00001082 <.Loc.49.1>:
    1082:	8c 43 00 00 	mov	#0,	0(r12)	;r3 As==00

00001086 <.Loc.50.1>:
    1086:	8c 43 02 00 	mov	#0,	2(r12)	;r3 As==00

0000108a <.Loc.51.1>:
    108a:	8c 43 04 00 	mov	#0,	4(r12)	;r3 As==00

0000108e <.Loc.52.1>:
    108e:	8c 4d 06 00 	mov	r13,	6(r12)	;

00001092 <.Loc.53.1>:
    1092:	8c 43 3a 00 	mov	#0,	58(r12)	;r3 As==00, 0x003a

00001096 <.Loc.54.1>:
    1096:	8c 4e 08 00 	mov	r14,	8(r12)	;

0000109a <.Loc.55.1>:
    109a:	8c 43 0a 00 	mov	#0,	10(r12)	;r3 As==00, 0x000a

0000109e <.Loc.56.1>:
    109e:	8c 43 0c 00 	mov	#0,	12(r12)	;r3 As==00, 0x000c

000010a2 <.Loc.57.1>:
    10a2:	8c 43 0e 00 	mov	#0,	14(r12)	;r3 As==00, 0x000e

000010a6 <.Loc.58.1>:
    10a6:	7e 40 06 00 	mov.b	#6,	r14	;

000010aa <.LVL7>:
    10aa:	4d 43       	clr.b	r13		;

000010ac <.LVL8>:
    10ac:	3c 50 34 00 	add	#52,	r12	;#0x0034

000010b0 <.LVL9>:
    10b0:	b0 12 48 16 	call	#5704		;#0x1648

000010b4 <.LVL10>:
    10b4:	8a 4a 12 00 	mov	r10,	18(r10)	; 0x0012

000010b8 <.Loc.60.1>:
    10b8:	ba 40 1e 1c 	mov	#7198,	20(r10)	;#0x1c1e, 0x0014
    10bc:	14 00 

000010be <.Loc.62.1>:
    10be:	ba 40 5e 1c 	mov	#7262,	22(r10)	;#0x1c5e, 0x0016
    10c2:	16 00 

000010c4 <.Loc.68.1>:
    10c4:	ba 40 a0 1c 	mov	#7328,	24(r10)	;#0x1ca0, 0x0018
    10c8:	18 00 

000010ca <.Loc.70.1>:
    10ca:	ba 40 da 1c 	mov	#7386,	26(r10)	;#0x1cda, 0x001a
    10ce:	1a 00 

000010d0 <.Loc.86.1>:
    10d0:	3a 41       	pop	r10		;

000010d2 <.LVL11>:
    10d2:	30 41       	ret			

000010d4 <__sfmoreglue>:
    10d4:	0a 12       	push	r10		;

000010d6 <.LCFI1>:
    10d6:	09 12       	push	r9		;

000010d8 <.LCFI2>:
    10d8:	08 12       	push	r8		;

000010da <.LCFI3>:
    10da:	0a 4c       	mov	r12,	r10	;
    10dc:	08 4d       	mov	r13,	r8	;

000010de <.Loc.101.1>:
    10de:	7d 40 3c 00 	mov.b	#60,	r13	;#0x003c

000010e2 <.LVL13>:
    10e2:	0c 48       	mov	r8,	r12	;

000010e4 <.LVL14>:
    10e4:	3c 53       	add	#-1,	r12	;r3 As==11
    10e6:	b0 12 90 2b 	call	#11152		;#0x2b90
    10ea:	09 4c       	mov	r12,	r9	;

000010ec <.Loc.100.1>:
    10ec:	0d 4c       	mov	r12,	r13	;
    10ee:	3d 50 42 00 	add	#66,	r13	;#0x0042
    10f2:	0c 4a       	mov	r10,	r12	;
    10f4:	b0 12 52 17 	call	#5970		;#0x1752

000010f8 <.LVL16>:
    10f8:	0a 4c       	mov	r12,	r10	;

000010fa <.LVL17>:
    10fa:	0c 93       	cmp	#0,	r12	;r3 As==00
    10fc:	0e 24       	jz	$+30     	;abs 0x111a

000010fe <.Loc.104.1>:
    10fe:	8c 43 00 00 	mov	#0,	0(r12)	;r3 As==00

00001102 <.Loc.105.1>:
    1102:	8c 48 02 00 	mov	r8,	2(r12)	;

00001106 <.Loc.106.1>:
    1106:	3c 50 06 00 	add	#6,	r12	;
    110a:	8a 4c 04 00 	mov	r12,	4(r10)	;

0000110e <.Loc.107.1>:
    110e:	0e 49       	mov	r9,	r14	;
    1110:	3e 50 3c 00 	add	#60,	r14	;#0x003c
    1114:	4d 43       	clr.b	r13		;
    1116:	b0 12 48 16 	call	#5704		;#0x1648

0000111a <.L6>:
    111a:	0c 4a       	mov	r10,	r12	;
    111c:	30 40 1e 0e 	br	#0x0e1e		;

00001120 <__sinit>:
    1120:	0a 12       	push	r10		;

00001122 <.LCFI4>:
    1122:	09 12       	push	r9		;

00001124 <.LCFI5>:
    1124:	0a 4c       	mov	r12,	r10	;

00001126 <.Loc.213.1>:
    1126:	8c 93 0c 00 	cmp	#0,	12(r12)	;r3 As==00, 0x000c
    112a:	31 20       	jnz	$+100    	;abs 0x118e

0000112c <.LBB20>:
    112c:	bc 40 74 10 	mov	#4212,	20(r12)	;#0x1074, 0x0014
    1130:	14 00 

00001132 <.Loc.222.1>:
    1132:	8c 43 6c 00 	mov	#0,	108(r12);r3 As==00, 0x006c

00001136 <.Loc.227.1>:
    1136:	8c 43 6e 00 	mov	#0,	110(r12);r3 As==00, 0x006e

0000113a <.Loc.228.1>:
    113a:	8c 43 70 00 	mov	#0,	112(r12);r3 As==00, 0x0070

0000113e <.Loc.232.1>:
    113e:	1c 92 9c 31 	cmp	&0x319c,r12	;0x319c
    1142:	02 20       	jnz	$+6      	;abs 0x1148

00001144 <.Loc.233.1>:
    1144:	9c 43 0c 00 	mov	#1,	12(r12)	;r3 As==01, 0x000c

00001148 <.L13>:
    1148:	39 40 92 11 	mov	#4498,	r9	;#0x1192
    114c:	0c 4a       	mov	r10,	r12	;

0000114e <.LVL22>:
    114e:	89 12       	call	r9		;

00001150 <.LVL23>:
    1150:	8a 4c 02 00 	mov	r12,	2(r10)	;

00001154 <.Loc.235.1>:
    1154:	0c 4a       	mov	r10,	r12	;
    1156:	89 12       	call	r9		;

00001158 <.LVL24>:
    1158:	8a 4c 04 00 	mov	r12,	4(r10)	;

0000115c <.Loc.236.1>:
    115c:	0c 4a       	mov	r10,	r12	;
    115e:	89 12       	call	r9		;

00001160 <.LVL25>:
    1160:	8a 4c 06 00 	mov	r12,	6(r10)	;

00001164 <.Loc.239.1>:
    1164:	39 40 7e 10 	mov	#4222,	r9	;#0x107e
    1168:	4e 43       	clr.b	r14		;
    116a:	6d 42       	mov.b	#4,	r13	;r2 As==10
    116c:	1c 4a 02 00 	mov	2(r10),	r12	;
    1170:	89 12       	call	r9		;

00001172 <.LVL26>:
    1172:	5e 43       	mov.b	#1,	r14	;r3 As==01
    1174:	7d 40 09 00 	mov.b	#9,	r13	;
    1178:	1c 4a 04 00 	mov	4(r10),	r12	;
    117c:	89 12       	call	r9		;

0000117e <.LVL27>:
    117e:	6e 43       	mov.b	#2,	r14	;r3 As==10
    1180:	7d 40 12 00 	mov.b	#18,	r13	;#0x0012
    1184:	1c 4a 06 00 	mov	6(r10),	r12	;
    1188:	89 12       	call	r9		;

0000118a <.LVL28>:
    118a:	9a 43 0c 00 	mov	#1,	12(r10)	;r3 As==01, 0x000c

0000118e <.L11>:
    118e:	30 40 20 0e 	br	#0x0e20		;

00001192 <__sfp>:
    1192:	0a 12       	push	r10		;

00001194 <.LCFI6>:
    1194:	09 12       	push	r9		;

00001196 <.LCFI7>:
    1196:	08 12       	push	r8		;

00001198 <.LCFI8>:
    1198:	07 12       	push	r7		;

0000119a <.LCFI9>:
    119a:	06 12       	push	r6		;

0000119c <.LCFI10>:
    119c:	08 4c       	mov	r12,	r8	;

0000119e <.Loc.125.1>:
    119e:	19 42 9c 31 	mov	&0x319c,r9	;0x319c
    11a2:	89 93 0c 00 	cmp	#0,	12(r9)	;r3 As==00, 0x000c
    11a6:	03 20       	jnz	$+8      	;abs 0x11ae

000011a8 <.Loc.126.1>:
    11a8:	0c 49       	mov	r9,	r12	;

000011aa <.LVL31>:
    11aa:	b0 12 20 11 	call	#4384		;#0x1120

000011ae <.L15>:
    11ae:	39 50 6c 00 	add	#108,	r9	;#0x006c

000011b2 <.Loc.133.1>:
    11b2:	37 40 d4 10 	mov	#4308,	r7	;#0x10d4
    11b6:	66 42       	mov.b	#4,	r6	;r2 As==10

000011b8 <.L20>:
    11b8:	1d 49 02 00 	mov	2(r9),	r13	;

000011bc <.LVL35>:
    11bc:	1c 49 04 00 	mov	4(r9),	r12	;
    11c0:	3c 50 06 00 	add	#6,	r12	;

000011c4 <.L16>:
    11c4:	0a 4c       	mov	r12,	r10	;
    11c6:	3a 50 fa ff 	add	#65530,	r10	;#0xfffa

000011ca <.LVL37>:
    11ca:	3d 53       	add	#-1,	r13	;r3 As==11
    11cc:	0d 93       	cmp	#0,	r13	;r3 As==00
    11ce:	06 34       	jge	$+14     	;abs 0x11dc

000011d0 <.Loc.132.1>:
    11d0:	89 93 00 00 	cmp	#0,	0(r9)	;r3 As==00
    11d4:	2c 24       	jz	$+90     	;abs 0x122e

000011d6 <.L21>:
    11d6:	29 49       	mov	@r9,	r9	;

000011d8 <.Loc.129.1>:
    11d8:	30 40 b8 11 	br	#0x11b8		;

000011dc <.L18>:
    11dc:	3c 50 3c 00 	add	#60,	r12	;#0x003c

000011e0 <.Loc.130.1>:
    11e0:	8c 93 c4 ff 	cmp	#0,	-60(r12);r3 As==00, 0xffc4
    11e4:	ef 23       	jnz	$-32     	;abs 0x11c4

000011e6 <.L17>:
    11e6:	ba 43 08 00 	mov	#-1,	8(r10)	;r3 As==11

000011ea <.Loc.142.1>:
    11ea:	9a 43 06 00 	mov	#1,	6(r10)	;r3 As==01

000011ee <.Loc.143.1>:
    11ee:	8a 43 3a 00 	mov	#0,	58(r10)	;r3 As==00, 0x003a

000011f2 <.Loc.149.1>:
    11f2:	8a 43 00 00 	mov	#0,	0(r10)	;r3 As==00

000011f6 <.Loc.150.1>:
    11f6:	8a 43 04 00 	mov	#0,	4(r10)	;r3 As==00

000011fa <.Loc.151.1>:
    11fa:	8a 43 02 00 	mov	#0,	2(r10)	;r3 As==00

000011fe <.Loc.152.1>:
    11fe:	8a 43 0a 00 	mov	#0,	10(r10)	;r3 As==00, 0x000a

00001202 <.Loc.153.1>:
    1202:	8a 43 0c 00 	mov	#0,	12(r10)	;r3 As==00, 0x000c

00001206 <.Loc.154.1>:
    1206:	8a 43 0e 00 	mov	#0,	14(r10)	;r3 As==00, 0x000e

0000120a <.Loc.155.1>:
    120a:	7e 40 06 00 	mov.b	#6,	r14	;
    120e:	4d 43       	clr.b	r13		;

00001210 <.LVL42>:
    1210:	0c 4a       	mov	r10,	r12	;
    1212:	3c 50 34 00 	add	#52,	r12	;#0x0034
    1216:	b0 12 48 16 	call	#5704		;#0x1648

0000121a <.LVL43>:
    121a:	8a 43 1c 00 	mov	#0,	28(r10)	;r3 As==00, 0x001c

0000121e <.Loc.158.1>:
    121e:	8a 43 1e 00 	mov	#0,	30(r10)	;r3 As==00, 0x001e

00001222 <.Loc.159.1>:
    1222:	8a 43 28 00 	mov	#0,	40(r10)	;r3 As==00, 0x0028

00001226 <.Loc.160.1>:
    1226:	8a 43 2a 00 	mov	#0,	42(r10)	;r3 As==00, 0x002a

0000122a <.Loc.162.1>:
    122a:	30 40 44 12 	br	#0x1244		;

0000122e <.L19>:
    122e:	0d 46       	mov	r6,	r13	;

00001230 <.LVL45>:
    1230:	0c 48       	mov	r8,	r12	;
    1232:	87 12       	call	r7		;

00001234 <.LVL46>:
    1234:	89 4c 00 00 	mov	r12,	0(r9)	;

00001238 <.Loc.132.1>:
    1238:	0c 93       	cmp	#0,	r12	;r3 As==00
    123a:	cd 23       	jnz	$-100    	;abs 0x11d6

0000123c <.Loc.137.1>:
    123c:	b8 40 0c 00 	mov	#12,	0(r8)	;#0x000c
    1240:	00 00 

00001242 <.Loc.138.1>:
    1242:	0a 4c       	mov	r12,	r10	;

00001244 <.L14>:
    1244:	0c 4a       	mov	r10,	r12	;
    1246:	30 40 1a 0e 	br	#0x0e1a		;

0000124a <__sfp_lock_acquire>:
    124a:	30 41       	ret			

0000124c <__sfp_lock_release>:
    124c:	30 41       	ret			

0000124e <__sfvwrite_r>:
    124e:	0a 12       	push	r10		;

00001250 <.LCFI0>:
    1250:	09 12       	push	r9		;

00001252 <.LCFI1>:
    1252:	08 12       	push	r8		;

00001254 <.LCFI2>:
    1254:	07 12       	push	r7		;

00001256 <.LCFI3>:
    1256:	06 12       	push	r6		;

00001258 <.LCFI4>:
    1258:	05 12       	push	r5		;

0000125a <.LCFI5>:
    125a:	04 12       	push	r4		;

0000125c <.LCFI6>:
    125c:	31 80 0a 00 	sub	#10,	r1	;#0x000a

00001260 <.LCFI7>:
    1260:	07 4c       	mov	r12,	r7	;
    1262:	06 4d       	mov	r13,	r6	;
    1264:	81 4e 04 00 	mov	r14,	4(r1)	;

00001268 <.LVL1>:
    1268:	8e 93 04 00 	cmp	#0,	4(r14)	;r3 As==00
    126c:	05 20       	jnz	$+12     	;abs 0x1278

0000126e <.L12>:
    126e:	4c 43       	clr.b	r12		;

00001270 <.L1>:
    1270:	31 50 0a 00 	add	#10,	r1	;#0x000a
    1274:	30 40 16 0e 	br	#0x0e16		;

00001278 <.L2>:
    1278:	fd b2 06 00 	bit.b	#8,	6(r13)	;r2 As==11
    127c:	31 24       	jz	$+100    	;abs 0x12e0

0000127e <.Loc.64.1>:
    127e:	8d 93 0a 00 	cmp	#0,	10(r13)	;r3 As==00, 0x000a
    1282:	2e 24       	jz	$+94     	;abs 0x12e0

00001284 <.L7>:
    1284:	14 41 04 00 	mov	4(r1),	r4	;
    1288:	28 44       	mov	@r4,	r8	;

0000128a <.LVL5>:
    128a:	15 46 06 00 	mov	6(r6),	r5	;
    128e:	09 45       	mov	r5,	r9	;
    1290:	69 f3       	and.b	#2,	r9	;r3 As==10
    1292:	81 49 06 00 	mov	r9,	6(r1)	;
    1296:	09 93       	cmp	#0,	r9	;r3 As==00
    1298:	32 24       	jz	$+102    	;abs 0x12fe
    129a:	49 43       	clr.b	r9		;
    129c:	0a 49       	mov	r9,	r10	;

0000129e <.Loc.100.1>:
    129e:	35 40 00 7c 	mov	#31744,	r5	;#0x7c00

000012a2 <.L6>:
    12a2:	0a 93       	cmp	#0,	r10	;r3 As==00
    12a4:	26 24       	jz	$+78     	;abs 0x12f2

000012a6 <.Loc.100.1>:
    12a6:	0f 4a       	mov	r10,	r15	;
    12a8:	3c 40 00 7c 	mov	#31744,	r12	;#0x7c00
    12ac:	0c 9a       	cmp	r10,	r12	;
    12ae:	01 2c       	jc	$+4      	;abs 0x12b2
    12b0:	0f 45       	mov	r5,	r15	;

000012b2 <.L9>:
    12b2:	0e 49       	mov	r9,	r14	;
    12b4:	1d 46 12 00 	mov	18(r6),	r13	;0x00012
    12b8:	0c 47       	mov	r7,	r12	;
    12ba:	14 46 16 00 	mov	22(r6),	r4	;0x00016
    12be:	84 12       	call	r4		;

000012c0 <.LVL7>:
    12c0:	4d 43       	clr.b	r13		;
    12c2:	0d 9c       	cmp	r12,	r13	;
    12c4:	9e 34       	jge	$+318    	;abs 0x1402

000012c6 <.LVL8>:
    12c6:	09 5c       	add	r12,	r9	;

000012c8 <.LVL9>:
    12c8:	0a 8c       	sub	r12,	r10	;

000012ca <.Loc.106.1>:
    12ca:	14 41 04 00 	mov	4(r1),	r4	;
    12ce:	1d 44 04 00 	mov	4(r4),	r13	;
    12d2:	0d 8c       	sub	r12,	r13	;
    12d4:	84 4d 04 00 	mov	r13,	4(r4)	;
    12d8:	0d 93       	cmp	#0,	r13	;r3 As==00
    12da:	e3 23       	jnz	$-56     	;abs 0x12a2
    12dc:	30 40 6e 12 	br	#0x126e		;

000012e0 <.L4>:
    12e0:	0d 46       	mov	r6,	r13	;
    12e2:	0c 47       	mov	r7,	r12	;
    12e4:	b0 12 e2 1d 	call	#7650		;#0x1de2

000012e8 <.LVL12>:
    12e8:	0c 93       	cmp	#0,	r12	;r3 As==00
    12ea:	cc 27       	jz	$-102    	;abs 0x1284

000012ec <.L40>:
    12ec:	3c 43       	mov	#-1,	r12	;r3 As==11
    12ee:	30 40 70 12 	br	#0x1270		;

000012f2 <.L8>:
    12f2:	29 48       	mov	@r8,	r9	;
    12f4:	1a 48 02 00 	mov	2(r8),	r10	;

000012f8 <.LVL15>:
    12f8:	28 52       	add	#4,	r8	;r2 As==10

000012fa <.LVL16>:
    12fa:	30 40 a2 12 	br	#0x12a2		;

000012fe <.L5>:
    12fe:	55 f3       	and.b	#1,	r5	;r3 As==01
    1300:	81 45 08 00 	mov	r5,	8(r1)	;
    1304:	05 93       	cmp	#0,	r5	;r3 As==00
    1306:	45 24       	jz	$+140    	;abs 0x1392
    1308:	1a 41 06 00 	mov	6(r1),	r10	;
    130c:	0c 4a       	mov	r10,	r12	;
    130e:	05 4a       	mov	r10,	r5	;
    1310:	09 4a       	mov	r10,	r9	;

00001312 <.L14>:
    1312:	09 93       	cmp	#0,	r9	;r3 As==00
    1314:	07 25       	jz	$+528    	;abs 0x1524

00001316 <.Loc.220.1>:
    1316:	0c 93       	cmp	#0,	r12	;r3 As==00
    1318:	0b 20       	jnz	$+24     	;abs 0x1330

0000131a <.Loc.222.1>:
    131a:	0e 49       	mov	r9,	r14	;
    131c:	7d 40 0a 00 	mov.b	#10,	r13	;#0x000a
    1320:	0c 45       	mov	r5,	r12	;

00001322 <.LVL19>:
    1322:	b0 12 dc 15 	call	#5596		;#0x15dc

00001326 <.LVL20>:
    1326:	0c 93       	cmp	#0,	r12	;r3 As==00
    1328:	05 25       	jz	$+524    	;abs 0x1534

0000132a <.Loc.223.1>:
    132a:	1c 53       	inc	r12		;

0000132c <.LVL21>:
    132c:	0a 4c       	mov	r12,	r10	;
    132e:	0a 85       	sub	r5,	r10	;

00001330 <.L32>:
    1330:	0f 4a       	mov	r10,	r15	;
    1332:	09 9a       	cmp	r10,	r9	;
    1334:	01 2c       	jc	$+4      	;abs 0x1338
    1336:	0f 49       	mov	r9,	r15	;

00001338 <.L34>:
    1338:	1d 46 0c 00 	mov	12(r6),	r13	;0x0000c

0000133c <.LVL24>:
    133c:	2c 46       	mov	@r6,	r12	;
    133e:	86 9c 0a 00 	cmp	r12,	10(r6)	; 0x000a
    1342:	fc 2c       	jc	$+506    	;abs 0x153c

00001344 <.Loc.227.1>:
    1344:	04 4d       	mov	r13,	r4	;
    1346:	14 56 04 00 	add	4(r6),	r4	;

0000134a <.Loc.228.1>:
    134a:	04 9f       	cmp	r15,	r4	;
    134c:	f7 34       	jge	$+496    	;abs 0x153c

0000134e <.Loc.230.1>:
    134e:	0e 44       	mov	r4,	r14	;
    1350:	0d 45       	mov	r5,	r13	;

00001352 <.LVL25>:
    1352:	b0 12 0c 16 	call	#5644		;#0x160c

00001356 <.LVL26>:
    1356:	86 54 00 00 	add	r4,	0(r6)	;

0000135a <.Loc.233.1>:
    135a:	0d 46       	mov	r6,	r13	;
    135c:	0c 47       	mov	r7,	r12	;
    135e:	b0 12 60 21 	call	#8544		;#0x2160

00001362 <.LVL27>:
    1362:	0c 93       	cmp	#0,	r12	;r3 As==00
    1364:	4e 20       	jnz	$+158    	;abs 0x1402

00001366 <.L36>:
    1366:	0a 84       	sub	r4,	r10	;
    1368:	0a 93       	cmp	#0,	r10	;r3 As==00
    136a:	07 21       	jnz	$+528    	;abs 0x157a

0000136c <.Loc.252.1>:
    136c:	0d 46       	mov	r6,	r13	;
    136e:	0c 47       	mov	r7,	r12	;
    1370:	b0 12 60 21 	call	#8544		;#0x2160

00001374 <.LVL30>:
    1374:	0c 93       	cmp	#0,	r12	;r3 As==00
    1376:	45 20       	jnz	$+140    	;abs 0x1402

00001378 <.L38>:
    1378:	05 54       	add	r4,	r5	;

0000137a <.LVL32>:
    137a:	09 84       	sub	r4,	r9	;

0000137c <.Loc.259.1>:
    137c:	1e 41 04 00 	mov	4(r1),	r14	;
    1380:	1d 4e 04 00 	mov	4(r14),	r13	;
    1384:	0d 84       	sub	r4,	r13	;
    1386:	8e 4d 04 00 	mov	r13,	4(r14)	;
    138a:	0d 93       	cmp	#0,	r13	;r3 As==00
    138c:	c2 23       	jnz	$-122    	;abs 0x1312
    138e:	30 40 6e 12 	br	#0x126e		;

00001392 <.L13>:
    1392:	15 41 08 00 	mov	8(r1),	r5	;
    1396:	0a 45       	mov	r5,	r10	;

00001398 <.L15>:
    1398:	0a 93       	cmp	#0,	r10	;r3 As==00
    139a:	38 24       	jz	$+114    	;abs 0x140c

0000139c <.Loc.126.1>:
    139c:	1f 46 04 00 	mov	4(r6),	r15	;

000013a0 <.LVL36>:
    13a0:	1e 46 06 00 	mov	6(r6),	r14	;
    13a4:	3e b0 00 02 	bit	#512,	r14	;#0x0200
    13a8:	82 24       	jz	$+262    	;abs 0x14ae

000013aa <.Loc.129.1>:
    13aa:	0a 9f       	cmp	r15,	r10	;
    13ac:	53 28       	jnc	$+168    	;abs 0x1454

000013ae <.Loc.129.1>:
    13ae:	3e b0 80 04 	bit	#1152,	r14	;#0x0480
    13b2:	4e 24       	jz	$+158    	;abs 0x1450

000013b4 <.LBB2>:
    13b4:	1d 46 0a 00 	mov	10(r6),	r13	;0x0000a
    13b8:	24 46       	mov	@r6,	r4	;
    13ba:	04 8d       	sub	r13,	r4	;

000013bc <.LVL37>:
    13bc:	1c 46 0c 00 	mov	12(r6),	r12	;0x0000c
    13c0:	09 4c       	mov	r12,	r9	;
    13c2:	09 5c       	add	r12,	r9	;
    13c4:	09 5c       	add	r12,	r9	;
    13c6:	0c 49       	mov	r9,	r12	;
    13c8:	81 4d 00 00 	mov	r13,	0(r1)	;
    13cc:	81 4e 02 00 	mov	r14,	2(r1)	;
    13d0:	b0 12 9a 0e 	call	#3738		;#0x0e9a

000013d4 <.LVL38>:
    13d4:	09 5c       	add	r12,	r9	;
    13d6:	09 11       	rra	r9		;

000013d8 <.LVL39>:
    13d8:	0c 44       	mov	r4,	r12	;
    13da:	1c 53       	inc	r12		;
    13dc:	0c 5a       	add	r10,	r12	;
    13de:	2d 41       	mov	@r1,	r13	;
    13e0:	1e 41 02 00 	mov	2(r1),	r14	;
    13e4:	09 9c       	cmp	r12,	r9	;
    13e6:	01 2c       	jc	$+4      	;abs 0x13ea

000013e8 <.Loc.142.1>:
    13e8:	09 4c       	mov	r12,	r9	;

000013ea <.L19>:
    13ea:	3e b0 00 04 	bit	#1024,	r14	;#0x0400
    13ee:	4e 24       	jz	$+158    	;abs 0x148c

000013f0 <.Loc.146.1>:
    13f0:	0d 49       	mov	r9,	r13	;
    13f2:	0c 47       	mov	r7,	r12	;
    13f4:	b0 12 52 17 	call	#5970		;#0x1752

000013f8 <.LVL41>:
    13f8:	0c 93       	cmp	#0,	r12	;r3 As==00
    13fa:	0e 20       	jnz	$+30     	;abs 0x1418

000013fc <.L49>:
    13fc:	b7 40 0c 00 	mov	#12,	0(r7)	;#0x000c
    1400:	00 00 

00001402 <.L22>:
    1402:	b6 d0 40 00 	bis	#64,	6(r6)	;#0x0040
    1406:	06 00 
    1408:	30 40 ec 12 	br	#0x12ec		;

0000140c <.L16>:
    140c:	25 48       	mov	@r8,	r5	;
    140e:	1a 48 02 00 	mov	2(r8),	r10	;

00001412 <.LVL45>:
    1412:	28 52       	add	#4,	r8	;r2 As==10

00001414 <.LVL46>:
    1414:	30 40 98 13 	br	#0x1398		;

00001418 <.L21>:
    1418:	0e 44       	mov	r4,	r14	;
    141a:	1d 46 0a 00 	mov	10(r6),	r13	;0x0000a
    141e:	81 4c 02 00 	mov	r12,	2(r1)	;
    1422:	b0 12 f6 15 	call	#5622		;#0x15f6

00001426 <.LVL48>:
    1426:	1c 46 06 00 	mov	6(r6),	r12	;
    142a:	3c f0 7f fb 	and	#64383,	r12	;#0xfb7f
    142e:	3c d0 80 00 	bis	#128,	r12	;#0x0080
    1432:	86 4c 06 00 	mov	r12,	6(r6)	;
    1436:	1f 41 02 00 	mov	2(r1),	r15	;

0000143a <.L23>:
    143a:	86 4f 0a 00 	mov	r15,	10(r6)	; 0x000a

0000143e <.Loc.171.1>:
    143e:	0f 54       	add	r4,	r15	;

00001440 <.LVL50>:
    1440:	86 4f 00 00 	mov	r15,	0(r6)	;

00001444 <.Loc.172.1>:
    1444:	86 49 0c 00 	mov	r9,	12(r6)	; 0x000c

00001448 <.LVL51>:
    1448:	0f 4a       	mov	r10,	r15	;

0000144a <.Loc.174.1>:
    144a:	09 84       	sub	r4,	r9	;

0000144c <.LVL52>:
    144c:	86 49 04 00 	mov	r9,	4(r6)	;

00001450 <.L18>:
    1450:	0a 9f       	cmp	r15,	r10	;
    1452:	01 2c       	jc	$+4      	;abs 0x1456

00001454 <.L42>:
    1454:	0f 4a       	mov	r10,	r15	;

00001456 <.L24>:
    1456:	0e 4f       	mov	r15,	r14	;
    1458:	0d 45       	mov	r5,	r13	;
    145a:	2c 46       	mov	@r6,	r12	;
    145c:	81 4f 02 00 	mov	r15,	2(r1)	;
    1460:	b0 12 0c 16 	call	#5644		;#0x160c

00001464 <.LVL56>:
    1464:	1f 41 02 00 	mov	2(r1),	r15	;
    1468:	86 8f 04 00 	sub	r15,	4(r6)	;

0000146c <.Loc.180.1>:
    146c:	86 5f 00 00 	add	r15,	0(r6)	;

00001470 <.Loc.181.1>:
    1470:	09 4a       	mov	r10,	r9	;

00001472 <.L25>:
    1472:	05 59       	add	r9,	r5	;

00001474 <.LVL58>:
    1474:	0a 89       	sub	r9,	r10	;

00001476 <.Loc.204.1>:
    1476:	14 41 04 00 	mov	4(r1),	r4	;
    147a:	1c 44 04 00 	mov	4(r4),	r12	;
    147e:	0c 89       	sub	r9,	r12	;
    1480:	84 4c 04 00 	mov	r12,	4(r4)	;
    1484:	0c 93       	cmp	#0,	r12	;r3 As==00
    1486:	88 23       	jnz	$-238    	;abs 0x1398
    1488:	30 40 6e 12 	br	#0x126e		;

0000148c <.L20>:
    148c:	0e 49       	mov	r9,	r14	;
    148e:	0c 47       	mov	r7,	r12	;
    1490:	b0 12 50 18 	call	#6224		;#0x1850

00001494 <.LVL61>:
    1494:	0f 4c       	mov	r12,	r15	;

00001496 <.LVL62>:
    1496:	0c 93       	cmp	#0,	r12	;r3 As==00
    1498:	d0 23       	jnz	$-94     	;abs 0x143a

0000149a <.Loc.163.1>:
    149a:	1d 46 0a 00 	mov	10(r6),	r13	;0x0000a
    149e:	0c 47       	mov	r7,	r12	;

000014a0 <.LVL63>:
    14a0:	b0 12 5c 16 	call	#5724		;#0x165c

000014a4 <.LVL64>:
    14a4:	b6 f0 7f ff 	and	#65407,	6(r6)	;#0xff7f
    14a8:	06 00 
    14aa:	30 40 fc 13 	br	#0x13fc		;

000014ae <.L17>:
    14ae:	2c 46       	mov	@r6,	r12	;
    14b0:	86 9c 0a 00 	cmp	r12,	10(r6)	; 0x000a
    14b4:	04 28       	jnc	$+10     	;abs 0x14be

000014b6 <.Loc.183.1>:
    14b6:	19 46 0c 00 	mov	12(r6),	r9	;0x0000c
    14ba:	0a 99       	cmp	r9,	r10	;
    14bc:	19 2c       	jc	$+52     	;abs 0x14f0

000014be <.L26>:
    14be:	09 4f       	mov	r15,	r9	;
    14c0:	0a 9f       	cmp	r15,	r10	;
    14c2:	01 2c       	jc	$+4      	;abs 0x14c6

000014c4 <.LVL66>:
    14c4:	09 4a       	mov	r10,	r9	;

000014c6 <.L28>:
    14c6:	0e 49       	mov	r9,	r14	;
    14c8:	0d 45       	mov	r5,	r13	;
    14ca:	b0 12 0c 16 	call	#5644		;#0x160c

000014ce <.LVL68>:
    14ce:	1c 46 04 00 	mov	4(r6),	r12	;
    14d2:	0c 89       	sub	r9,	r12	;
    14d4:	86 4c 04 00 	mov	r12,	4(r6)	;

000014d8 <.Loc.189.1>:
    14d8:	86 59 00 00 	add	r9,	0(r6)	;

000014dc <.Loc.190.1>:
    14dc:	0c 93       	cmp	#0,	r12	;r3 As==00
    14de:	c9 23       	jnz	$-108    	;abs 0x1472

000014e0 <.Loc.190.1>:
    14e0:	0d 46       	mov	r6,	r13	;
    14e2:	0c 47       	mov	r7,	r12	;
    14e4:	b0 12 60 21 	call	#8544		;#0x2160

000014e8 <.LVL69>:
    14e8:	0c 93       	cmp	#0,	r12	;r3 As==00
    14ea:	c3 27       	jz	$-120    	;abs 0x1472
    14ec:	30 40 02 14 	br	#0x1402		;

000014f0 <.L27>:
    14f0:	0c 4a       	mov	r10,	r12	;
    14f2:	3d 40 ff 7f 	mov	#32767,	r13	;#0x7fff
    14f6:	0d 9a       	cmp	r10,	r13	;
    14f8:	01 2c       	jc	$+4      	;abs 0x14fc
    14fa:	0c 4d       	mov	r13,	r12	;

000014fc <.L29>:
    14fc:	0d 49       	mov	r9,	r13	;
    14fe:	b0 12 ba 0d 	call	#3514		;#0x0dba

00001502 <.LVL71>:
    1502:	0d 49       	mov	r9,	r13	;
    1504:	b0 12 90 2b 	call	#11152		;#0x2b90

00001508 <.LVL72>:
    1508:	0f 4c       	mov	r12,	r15	;
    150a:	0e 45       	mov	r5,	r14	;
    150c:	1d 46 12 00 	mov	18(r6),	r13	;0x00012
    1510:	0c 47       	mov	r7,	r12	;

00001512 <.LVL73>:
    1512:	14 46 16 00 	mov	22(r6),	r4	;0x00016
    1516:	84 12       	call	r4		;

00001518 <.LVL74>:
    1518:	09 4c       	mov	r12,	r9	;

0000151a <.LVL75>:
    151a:	4c 43       	clr.b	r12		;
    151c:	0c 99       	cmp	r9,	r12	;
    151e:	a9 3b       	jl	$-172    	;abs 0x1472
    1520:	30 40 02 14 	br	#0x1402		;

00001524 <.L31>:
    1524:	25 48       	mov	@r8,	r5	;
    1526:	19 48 02 00 	mov	2(r8),	r9	;

0000152a <.LVL77>:
    152a:	28 52       	add	#4,	r8	;r2 As==10

0000152c <.LVL78>:
    152c:	1c 41 06 00 	mov	6(r1),	r12	;
    1530:	30 40 12 13 	br	#0x1312		;

00001534 <.L33>:
    1534:	0a 49       	mov	r9,	r10	;

00001536 <.LVL80>:
    1536:	1a 53       	inc	r10		;
    1538:	30 40 30 13 	br	#0x1330		;

0000153c <.L35>:
    153c:	0f 9d       	cmp	r13,	r15	;
    153e:	0e 38       	jl	$+30     	;abs 0x155c

00001540 <.Loc.238.1>:
    1540:	0f 4d       	mov	r13,	r15	;

00001542 <.LVL82>:
    1542:	0e 45       	mov	r5,	r14	;
    1544:	1d 46 12 00 	mov	18(r6),	r13	;0x00012

00001548 <.LVL83>:
    1548:	0c 47       	mov	r7,	r12	;
    154a:	14 46 16 00 	mov	22(r6),	r4	;0x00016
    154e:	84 12       	call	r4		;

00001550 <.LVL84>:
    1550:	04 4c       	mov	r12,	r4	;

00001552 <.LVL85>:
    1552:	4c 43       	clr.b	r12		;
    1554:	0c 94       	cmp	r4,	r12	;
    1556:	07 3b       	jl	$-496    	;abs 0x1366
    1558:	30 40 02 14 	br	#0x1402		;

0000155c <.L37>:
    155c:	0e 4f       	mov	r15,	r14	;
    155e:	0d 45       	mov	r5,	r13	;
    1560:	81 4f 02 00 	mov	r15,	2(r1)	;
    1564:	b0 12 0c 16 	call	#5644		;#0x160c

00001568 <.LVL87>:
    1568:	1f 41 02 00 	mov	2(r1),	r15	;
    156c:	86 8f 04 00 	sub	r15,	4(r6)	;

00001570 <.Loc.247.1>:
    1570:	86 5f 00 00 	add	r15,	0(r6)	;
    1574:	04 4f       	mov	r15,	r4	;
    1576:	30 40 66 13 	br	#0x1366		;

0000157a <.L41>:
    157a:	1c 41 08 00 	mov	8(r1),	r12	;
    157e:	30 40 78 13 	br	#0x1378		;

00001582 <_fwalk_reent>:
    1582:	0a 12       	push	r10		;

00001584 <.LCFI5>:
    1584:	09 12       	push	r9		;

00001586 <.LCFI6>:
    1586:	08 12       	push	r8		;

00001588 <.LCFI7>:
    1588:	07 12       	push	r7		;

0000158a <.LCFI8>:
    158a:	06 12       	push	r6		;

0000158c <.LCFI9>:
    158c:	05 12       	push	r5		;

0000158e <.LCFI10>:
    158e:	06 4c       	mov	r12,	r6	;
    1590:	05 4d       	mov	r13,	r5	;

00001592 <.LVL14>:
    1592:	0a 4c       	mov	r12,	r10	;
    1594:	3a 50 6c 00 	add	#108,	r10	;#0x006c

00001598 <.Loc.63.1>:
    1598:	48 43       	clr.b	r8		;

0000159a <.L8>:
    159a:	0a 93       	cmp	#0,	r10	;r3 As==00
    159c:	03 20       	jnz	$+8      	;abs 0x15a4

0000159e <.Loc.80.1>:
    159e:	0c 48       	mov	r8,	r12	;
    15a0:	30 40 18 0e 	br	#0x0e18		;

000015a4 <.L12>:
    15a4:	17 4a 02 00 	mov	2(r10),	r7	;
    15a8:	19 4a 04 00 	mov	4(r10),	r9	;
    15ac:	39 50 06 00 	add	#6,	r9	;

000015b0 <.L9>:
    15b0:	0d 49       	mov	r9,	r13	;
    15b2:	3d 50 fa ff 	add	#65530,	r13	;#0xfffa

000015b6 <.LVL20>:
    15b6:	37 53       	add	#-1,	r7	;r3 As==11
    15b8:	07 93       	cmp	#0,	r7	;r3 As==00
    15ba:	03 34       	jge	$+8      	;abs 0x15c2

000015bc <.Loc.74.1>:
    15bc:	2a 4a       	mov	@r10,	r10	;
    15be:	30 40 9a 15 	br	#0x159a		;

000015c2 <.L11>:
    15c2:	5c 43       	mov.b	#1,	r12	;r3 As==01
    15c4:	2c 99       	cmp	@r9,	r12	;
    15c6:	06 2c       	jc	$+14     	;abs 0x15d4

000015c8 <.Loc.76.1>:
    15c8:	b9 93 02 00 	cmp	#-1,	2(r9)	;r3 As==11
    15cc:	03 24       	jz	$+8      	;abs 0x15d4

000015ce <.Loc.77.1>:
    15ce:	0c 46       	mov	r6,	r12	;
    15d0:	85 12       	call	r5		;

000015d2 <.LVL23>:
    15d2:	08 dc       	bis	r12,	r8	;

000015d4 <.L10>:
    15d4:	39 50 3c 00 	add	#60,	r9	;#0x003c

000015d8 <.LVL25>:
    15d8:	30 40 b0 15 	br	#0x15b0		;

000015dc <memchr>:
    15dc:	3d f0 ff 00 	and	#255,	r13	;#0x00ff

000015e0 <.LVL2>:
    15e0:	0e 5c       	add	r12,	r14	;

000015e2 <.L2>:
    15e2:	0c 9e       	cmp	r14,	r12	;
    15e4:	02 20       	jnz	$+6      	;abs 0x15ea

000015e6 <.Loc.133.1>:
    15e6:	4c 43       	clr.b	r12		;

000015e8 <.L1>:
    15e8:	30 41       	ret			

000015ea <.L4>:
    15ea:	cc 9d 00 00 	cmp.b	r13,	0(r12)	;
    15ee:	fc 27       	jz	$-6      	;abs 0x15e8

000015f0 <.Loc.130.1>:
    15f0:	1c 53       	inc	r12		;

000015f2 <.LVL6>:
    15f2:	30 40 e2 15 	br	#0x15e2		;

000015f6 <memcpy>:
    15f6:	0f 4c       	mov	r12,	r15	;
    15f8:	0e 5c       	add	r12,	r14	;

000015fa <.L2>:
    15fa:	0f 9e       	cmp	r14,	r15	;
    15fc:	01 20       	jnz	$+4      	;abs 0x1600

000015fe <.Loc.111.1>:
    15fe:	30 41       	ret			

00001600 <.L3>:
    1600:	ef 4d 00 00 	mov.b	@r13,	0(r15)	;
    1604:	1f 53       	inc	r15		;

00001606 <.LVL4>:
    1606:	1d 53       	inc	r13		;
    1608:	30 40 fa 15 	br	#0x15fa		;

0000160c <memmove>:
    160c:	0b 4c       	mov	r12,	r11	;
    160e:	0b 5e       	add	r14,	r11	;

00001610 <.Loc.69.1>:
    1610:	0d 9c       	cmp	r12,	r13	;
    1612:	09 28       	jnc	$+20     	;abs 0x1626

00001614 <.L4>:
    1614:	0e 4c       	mov	r12,	r14	;

00001616 <.L3>:
    1616:	0b 9e       	cmp	r14,	r11	;
    1618:	10 24       	jz	$+34     	;abs 0x163a

0000161a <.LVL3>:
    161a:	ee 4d 00 00 	mov.b	@r13,	0(r14)	;
    161e:	1e 53       	inc	r14		;

00001620 <.LVL4>:
    1620:	1d 53       	inc	r13		;
    1622:	30 40 16 16 	br	#0x1616		;

00001626 <.L2>:
    1626:	0f 4d       	mov	r13,	r15	;
    1628:	0f 5e       	add	r14,	r15	;
    162a:	0c 9f       	cmp	r15,	r12	;
    162c:	f3 2f       	jc	$-24     	;abs 0x1614

0000162e <.LVL6>:
    162e:	0d 4f       	mov	r15,	r13	;

00001630 <.LVL7>:
    1630:	0e 8f       	sub	r15,	r14	;

00001632 <.L5>:
    1632:	0f 4d       	mov	r13,	r15	;
    1634:	0f 5e       	add	r14,	r15	;
    1636:	0f 93       	cmp	#0,	r15	;r3 As==00
    1638:	01 20       	jnz	$+4      	;abs 0x163c

0000163a <.L9>:
    163a:	30 41       	ret			

0000163c <.L6>:
    163c:	3b 53       	add	#-1,	r11	;r3 As==11
    163e:	3d 53       	add	#-1,	r13	;r3 As==11

00001640 <.LVL12>:
    1640:	eb 4d 00 00 	mov.b	@r13,	0(r11)	;
    1644:	30 40 32 16 	br	#0x1632		;

00001648 <memset>:
    1648:	0f 4c       	mov	r12,	r15	;
    164a:	0e 5c       	add	r12,	r14	;

0000164c <.L2>:
    164c:	0f 9e       	cmp	r14,	r15	;
    164e:	01 20       	jnz	$+4      	;abs 0x1652

00001650 <.Loc.104.1>:
    1650:	30 41       	ret			

00001652 <.L3>:
    1652:	cf 4d 00 00 	mov.b	r13,	0(r15)	;
    1656:	1f 53       	inc	r15		;

00001658 <.LVL4>:
    1658:	30 40 4c 16 	br	#0x164c		;

0000165c <_free_r>:
    165c:	0a 12       	push	r10		;

0000165e <.LCFI0>:
    165e:	09 12       	push	r9		;

00001660 <.LCFI1>:
    1660:	08 12       	push	r8		;

00001662 <.LCFI2>:
    1662:	07 12       	push	r7		;

00001664 <.LCFI3>:
    1664:	0d 93       	cmp	#0,	r13	;r3 As==00
    1666:	28 24       	jz	$+82     	;abs 0x16b8

00001668 <.LBB4>:
    1668:	0e 4d       	mov	r13,	r14	;
    166a:	3e 50 fc ff 	add	#65532,	r14	;#0xfffc

0000166e <.LVL2>:
    166e:	1f 4d fc ff 	mov	-4(r13),r15	;
    1672:	8d 93 fe ff 	cmp	#0,	-2(r13)	;r3 As==00, 0xfffe
    1676:	01 34       	jge	$+4      	;abs 0x167a
    1678:	0e 5f       	add	r15,	r14	;

0000167a <.L4>:
    167a:	1d 42 18 81 	mov	&0x8118,r13	;0x8118

0000167e <.LVL4>:
    167e:	0d 93       	cmp	#0,	r13	;r3 As==00
    1680:	04 20       	jnz	$+10     	;abs 0x168a

00001682 <.L8>:
    1682:	8e 4d 04 00 	mov	r13,	4(r14)	;
    1686:	30 40 b4 16 	br	#0x16b4		;

0000168a <.L6>:
    168a:	0e 9d       	cmp	r13,	r14	;
    168c:	18 2c       	jc	$+50     	;abs 0x16be

0000168e <.Loc.359.1>:
    168e:	2a 4e       	mov	@r14,	r10	;
    1690:	1b 4e 02 00 	mov	2(r14),	r11	;
    1694:	0c 4e       	mov	r14,	r12	;

00001696 <.LVL7>:
    1696:	0c 5a       	add	r10,	r12	;
    1698:	0d 9c       	cmp	r12,	r13	;
    169a:	f3 23       	jnz	$-24     	;abs 0x1682

0000169c <.Loc.363.1>:
    169c:	08 4a       	mov	r10,	r8	;
    169e:	09 4b       	mov	r11,	r9	;
    16a0:	28 5d       	add	@r13,	r8	;
    16a2:	19 6d 02 00 	addc	2(r13),	r9	;
    16a6:	8e 48 00 00 	mov	r8,	0(r14)	;
    16aa:	8e 49 02 00 	mov	r9,	2(r14)	;

000016ae <.Loc.364.1>:
    16ae:	9e 4d 04 00 	mov	4(r13),	4(r14)	;
    16b2:	04 00 

000016b4 <.L9>:
    16b4:	82 4e 18 81 	mov	r14,	&0x8118	;

000016b8 <.L1>:
    16b8:	30 40 1c 0e 	br	#0x0e1c		;

000016bc <.L16>:
    16bc:	0d 4f       	mov	r15,	r13	;

000016be <.L11>:
    16be:	1f 4d 04 00 	mov	4(r13),	r15	;

000016c2 <.LVL10>:
    16c2:	0f 93       	cmp	#0,	r15	;r3 As==00
    16c4:	02 24       	jz	$+6      	;abs 0x16ca

000016c6 <.Loc.382.1>:
    16c6:	0e 9f       	cmp	r15,	r14	;
    16c8:	f9 2f       	jc	$-12     	;abs 0x16bc

000016ca <.L10>:
    16ca:	29 4d       	mov	@r13,	r9	;
    16cc:	17 4d 02 00 	mov	2(r13),	r7	;
    16d0:	08 4d       	mov	r13,	r8	;
    16d2:	08 59       	add	r9,	r8	;
    16d4:	08 9e       	cmp	r14,	r8	;
    16d6:	1b 20       	jnz	$+56     	;abs 0x170e

000016d8 <.Loc.391.1>:
    16d8:	2a 4e       	mov	@r14,	r10	;
    16da:	0a 59       	add	r9,	r10	;
    16dc:	1b 4e 02 00 	mov	2(r14),	r11	;
    16e0:	0b 67       	addc	r7,	r11	;
    16e2:	8d 4a 00 00 	mov	r10,	0(r13)	;
    16e6:	8d 4b 02 00 	mov	r11,	2(r13)	;

000016ea <.Loc.394.1>:
    16ea:	0c 4d       	mov	r13,	r12	;

000016ec <.LVL11>:
    16ec:	0c 5a       	add	r10,	r12	;
    16ee:	0f 9c       	cmp	r12,	r15	;
    16f0:	e3 23       	jnz	$-56     	;abs 0x16b8

000016f2 <.Loc.396.1>:
    16f2:	08 4a       	mov	r10,	r8	;
    16f4:	09 4b       	mov	r11,	r9	;
    16f6:	28 5f       	add	@r15,	r8	;
    16f8:	19 6f 02 00 	addc	2(r15),	r9	;
    16fc:	8d 48 00 00 	mov	r8,	0(r13)	;
    1700:	8d 49 02 00 	mov	r9,	2(r13)	;

00001704 <.Loc.397.1>:
    1704:	9d 4f 04 00 	mov	4(r15),	4(r13)	;
    1708:	04 00 
    170a:	30 40 b8 16 	br	#0x16b8		;

0000170e <.L12>:
    170e:	0e 98       	cmp	r8,	r14	;
    1710:	05 2c       	jc	$+12     	;abs 0x171c

00001712 <.Loc.404.1>:
    1712:	bc 40 0c 00 	mov	#12,	0(r12)	;#0x000c
    1716:	00 00 

00001718 <.Loc.406.1>:
    1718:	30 40 b8 16 	br	#0x16b8		;

0000171c <.L14>:
    171c:	2a 4e       	mov	@r14,	r10	;
    171e:	1b 4e 02 00 	mov	2(r14),	r11	;
    1722:	0c 4e       	mov	r14,	r12	;

00001724 <.LVL13>:
    1724:	0c 5a       	add	r10,	r12	;
    1726:	0f 9c       	cmp	r12,	r15	;
    1728:	10 20       	jnz	$+34     	;abs 0x174a

0000172a <.Loc.413.1>:
    172a:	08 4a       	mov	r10,	r8	;
    172c:	09 4b       	mov	r11,	r9	;
    172e:	28 5f       	add	@r15,	r8	;
    1730:	19 6f 02 00 	addc	2(r15),	r9	;
    1734:	8e 48 00 00 	mov	r8,	0(r14)	;
    1738:	8e 49 02 00 	mov	r9,	2(r14)	;

0000173c <.Loc.414.1>:
    173c:	9e 4f 04 00 	mov	4(r15),	4(r14)	;
    1740:	04 00 

00001742 <.L20>:
    1742:	8d 4e 04 00 	mov	r14,	4(r13)	;
    1746:	30 40 b8 16 	br	#0x16b8		;

0000174a <.L15>:
    174a:	8e 4f 04 00 	mov	r15,	4(r14)	;
    174e:	30 40 42 17 	br	#0x1742		;

00001752 <_malloc_r>:
    1752:	0a 12       	push	r10		;

00001754 <.LCFI0>:
    1754:	09 12       	push	r9		;

00001756 <.LCFI1>:
    1756:	08 12       	push	r8		;

00001758 <.LCFI2>:
    1758:	07 12       	push	r7		;

0000175a <.LCFI3>:
    175a:	08 4c       	mov	r12,	r8	;

0000175c <.Loc.247.1>:
    175c:	09 4d       	mov	r13,	r9	;
    175e:	19 53       	inc	r9		;
    1760:	19 c3       	bic	#1,	r9	;r3 As==01

00001762 <.LVL1>:
    1762:	39 50 0a 00 	add	#10,	r9	;#0x000a

00001766 <.LVL2>:
    1766:	39 90 0c 00 	cmp	#12,	r9	;#0x000c
    176a:	02 2c       	jc	$+6      	;abs 0x1770
    176c:	79 40 0c 00 	mov.b	#12,	r9	;#0x000c

00001770 <.L2>:
    1770:	09 9d       	cmp	r13,	r9	;
    1772:	06 2c       	jc	$+14     	;abs 0x1780

00001774 <.L13>:
    1774:	b8 40 0c 00 	mov	#12,	0(r8)	;#0x000c
    1778:	00 00 

0000177a <.Loc.255.1>:
    177a:	4c 43       	clr.b	r12		;

0000177c <.L1>:
    177c:	30 40 1c 0e 	br	#0x0e1c		;

00001780 <.L3>:
    1780:	1e 42 18 81 	mov	&0x8118,r14	;0x8118

00001784 <.LVL6>:
    1784:	0d 4e       	mov	r14,	r13	;

00001786 <.L5>:
    1786:	0d 93       	cmp	#0,	r13	;r3 As==00
    1788:	21 20       	jnz	$+68     	;abs 0x17cc

0000178a <.LVL8>:
    178a:	37 40 fc 1b 	mov	#7164,	r7	;#0x1bfc

0000178e <.LBB5>:
    178e:	82 93 16 81 	cmp	#0,	&0x8116	;r3 As==00
    1792:	04 20       	jnz	$+10     	;abs 0x179c
    1794:	0c 48       	mov	r8,	r12	;
    1796:	87 12       	call	r7		;

00001798 <.LVL9>:
    1798:	82 4c 16 81 	mov	r12,	&0x8116	;

0000179c <.L17>:
    179c:	0d 49       	mov	r9,	r13	;
    179e:	0c 48       	mov	r8,	r12	;
    17a0:	87 12       	call	r7		;

000017a2 <.LVL10>:
    17a2:	3c 93       	cmp	#-1,	r12	;r3 As==11
    17a4:	e7 27       	jz	$-48     	;abs 0x1774

000017a6 <.Loc.222.1>:
    17a6:	0e 4c       	mov	r12,	r14	;
    17a8:	1e 53       	inc	r14		;
    17aa:	0a 4e       	mov	r14,	r10	;
    17ac:	1a c3       	bic	#1,	r10	;r3 As==01

000017ae <.LVL11>:
    17ae:	0c 9a       	cmp	r10,	r12	;
    17b0:	06 24       	jz	$+14     	;abs 0x17be

000017b2 <.Loc.227.1>:
    17b2:	0d 4a       	mov	r10,	r13	;
    17b4:	0d 8c       	sub	r12,	r13	;
    17b6:	0c 48       	mov	r8,	r12	;

000017b8 <.LVL12>:
    17b8:	87 12       	call	r7		;

000017ba <.LVL13>:
    17ba:	3c 93       	cmp	#-1,	r12	;r3 As==11
    17bc:	db 27       	jz	$-72     	;abs 0x1774

000017be <.L14>:
    17be:	8a 49 00 00 	mov	r9,	0(r10)	;
    17c2:	8a 43 02 00 	mov	#0,	2(r10)	;r3 As==00
    17c6:	0e 4a       	mov	r10,	r14	;
    17c8:	30 40 fa 17 	br	#0x17fa		;

000017cc <.L10>:
    17cc:	2c 4d       	mov	@r13,	r12	;
    17ce:	0c 89       	sub	r9,	r12	;

000017d0 <.LVL16>:
    17d0:	0c 93       	cmp	#0,	r12	;r3 As==00
    17d2:	39 38       	jl	$+116    	;abs 0x1846

000017d4 <.Loc.268.1>:
    17d4:	7a 40 0b 00 	mov.b	#11,	r10	;#0x000b
    17d8:	0a 9c       	cmp	r12,	r10	;
    17da:	28 2c       	jc	$+82     	;abs 0x182c

000017dc <.Loc.272.1>:
    17dc:	0e 4c       	mov	r12,	r14	;
    17de:	3e b0 00 80 	bit	#32768,	r14	;#0x8000
    17e2:	0f 7f       	subc	r15,	r15	;
    17e4:	3f e3       	inv	r15		;

000017e6 <.LVL17>:
    17e6:	8d 4e 00 00 	mov	r14,	0(r13)	;
    17ea:	8d 4f 02 00 	mov	r15,	2(r13)	;

000017ee <.Loc.273.1>:
    17ee:	0e 4d       	mov	r13,	r14	;
    17f0:	0e 5c       	add	r12,	r14	;

000017f2 <.LVL18>:
    17f2:	8e 49 00 00 	mov	r9,	0(r14)	;
    17f6:	8e 43 02 00 	mov	#0,	2(r14)	;r3 As==00

000017fa <.L8>:
    17fa:	0f 4e       	mov	r14,	r15	;
    17fc:	2f 52       	add	#4,	r15	;r2 As==10

000017fe <.LVL20>:
    17fe:	0c 4f       	mov	r15,	r12	;
    1800:	3c 50 07 00 	add	#7,	r12	;
    1804:	3c f0 f8 ff 	and	#65528,	r12	;#0xfff8

00001808 <.LVL21>:
    1808:	0d 4c       	mov	r12,	r13	;
    180a:	0d 8f       	sub	r15,	r13	;

0000180c <.LVL22>:
    180c:	0d 93       	cmp	#0,	r13	;r3 As==00
    180e:	b6 27       	jz	$-146    	;abs 0x177c

00001810 <.Loc.318.1>:
    1810:	0e 5d       	add	r13,	r14	;

00001812 <.LVL23>:
    1812:	0f 43       	clr	r15		;
    1814:	0f 8d       	sub	r13,	r15	;

00001816 <.LVL24>:
    1816:	0a 4f       	mov	r15,	r10	;
    1818:	3a b0 00 80 	bit	#32768,	r10	;#0x8000
    181c:	0b 7b       	subc	r11,	r11	;
    181e:	3b e3       	inv	r11		;
    1820:	8e 4a 00 00 	mov	r10,	0(r14)	;
    1824:	8e 4b 02 00 	mov	r11,	2(r14)	;
    1828:	30 40 7c 17 	br	#0x177c		;

0000182c <.L7>:
    182c:	0e 9d       	cmp	r13,	r14	;
    182e:	05 20       	jnz	$+12     	;abs 0x183a

00001830 <.Loc.282.1>:
    1830:	92 4e 04 00 	mov	4(r14),	&0x8118	;
    1834:	18 81 
    1836:	30 40 fa 17 	br	#0x17fa		;

0000183a <.L9>:
    183a:	9e 4d 04 00 	mov	4(r13),	4(r14)	;
    183e:	04 00 
    1840:	0e 4d       	mov	r13,	r14	;

00001842 <.LVL26>:
    1842:	30 40 fa 17 	br	#0x17fa		;

00001846 <.L6>:
    1846:	0e 4d       	mov	r13,	r14	;
    1848:	1d 4d 04 00 	mov	4(r13),	r13	;

0000184c <.LVL28>:
    184c:	30 40 86 17 	br	#0x1786		;

00001850 <_realloc_r>:
    1850:	0a 12       	push	r10		;

00001852 <.LCFI0>:
    1852:	09 12       	push	r9		;

00001854 <.LCFI1>:
    1854:	08 12       	push	r8		;

00001856 <.LCFI2>:
    1856:	07 12       	push	r7		;

00001858 <.LCFI3>:
    1858:	07 4c       	mov	r12,	r7	;
    185a:	08 4d       	mov	r13,	r8	;
    185c:	0a 4e       	mov	r14,	r10	;

0000185e <.Loc.454.1>:
    185e:	0d 93       	cmp	#0,	r13	;r3 As==00
    1860:	07 20       	jnz	$+16     	;abs 0x1870

00001862 <.Loc.454.1>:
    1862:	0d 4e       	mov	r14,	r13	;

00001864 <.LVL1>:
    1864:	b0 12 52 17 	call	#5970		;#0x1752

00001868 <.LVL2>:
    1868:	09 4c       	mov	r12,	r9	;

0000186a <.L1>:
    186a:	0c 49       	mov	r9,	r12	;
    186c:	30 40 1c 0e 	br	#0x0e1c		;

00001870 <.L2>:
    1870:	0e 93       	cmp	#0,	r14	;r3 As==00
    1872:	05 20       	jnz	$+12     	;abs 0x187e

00001874 <.Loc.458.1>:
    1874:	b0 12 5c 16 	call	#5724		;#0x165c

00001878 <.LVL3>:
    1878:	09 4a       	mov	r10,	r9	;
    187a:	30 40 6a 18 	br	#0x186a		;

0000187e <.L4>:
    187e:	b0 12 e0 23 	call	#9184		;#0x23e0

00001882 <.LVL4>:
    1882:	0c 9a       	cmp	r10,	r12	;
    1884:	11 2c       	jc	$+36     	;abs 0x18a8

00001886 <.Loc.467.1>:
    1886:	0d 4a       	mov	r10,	r13	;
    1888:	0c 47       	mov	r7,	r12	;
    188a:	b0 12 52 17 	call	#5970		;#0x1752

0000188e <.LVL5>:
    188e:	09 4c       	mov	r12,	r9	;

00001890 <.LVL6>:
    1890:	0c 93       	cmp	#0,	r12	;r3 As==00
    1892:	eb 27       	jz	$-40     	;abs 0x186a

00001894 <.Loc.470.1>:
    1894:	0e 4a       	mov	r10,	r14	;
    1896:	0d 48       	mov	r8,	r13	;
    1898:	b0 12 f6 15 	call	#5622		;#0x15f6

0000189c <.LVL7>:
    189c:	0d 48       	mov	r8,	r13	;
    189e:	0c 47       	mov	r7,	r12	;
    18a0:	b0 12 5c 16 	call	#5724		;#0x165c

000018a4 <.LVL8>:
    18a4:	30 40 6a 18 	br	#0x186a		;

000018a8 <.L5>:
    18a8:	09 48       	mov	r8,	r9	;
    18aa:	30 40 6a 18 	br	#0x186a		;

000018ae <__sfputc_r>:
    18ae:	1f 4e 04 00 	mov	4(r14),	r15	;
    18b2:	3f 53       	add	#-1,	r15	;r3 As==11
    18b4:	8e 4f 04 00 	mov	r15,	4(r14)	;
    18b8:	0f 93       	cmp	#0,	r15	;r3 As==00
    18ba:	06 34       	jge	$+14     	;abs 0x18c8

000018bc <.Loc.400.1>:
    18bc:	1f 9e 0e 00 	cmp	14(r14),r15	;0x0000e
    18c0:	0e 38       	jl	$+30     	;abs 0x18de

000018c2 <.Loc.400.1>:
    18c2:	7d 90 0a 00 	cmp.b	#10,	r13	;#0x000a
    18c6:	0b 24       	jz	$+24     	;abs 0x18de

000018c8 <.L2>:
    18c8:	2c 4e       	mov	@r14,	r12	;

000018ca <.LVL1>:
    18ca:	0f 4c       	mov	r12,	r15	;
    18cc:	1f 53       	inc	r15		;
    18ce:	8e 4f 00 00 	mov	r15,	0(r14)	;
    18d2:	cc 4d 00 00 	mov.b	r13,	0(r12)	;
    18d6:	0c 4d       	mov	r13,	r12	;
    18d8:	7c f0 ff 00 	and.b	#255,	r12	;#0x00ff

000018dc <.L1>:
    18dc:	30 41       	ret			

000018de <.L3>:
    18de:	b0 12 e4 1c 	call	#7396		;#0x1ce4

000018e2 <.LVL4>:
    18e2:	30 40 dc 18 	br	#0x18dc		;

000018e6 <__sfputs_r>:
    18e6:	0a 12       	push	r10		;

000018e8 <.LCFI0>:
    18e8:	09 12       	push	r9		;

000018ea <.LCFI1>:
    18ea:	08 12       	push	r8		;

000018ec <.LCFI2>:
    18ec:	07 12       	push	r7		;

000018ee <.LCFI3>:
    18ee:	06 12       	push	r6		;

000018f0 <.LCFI4>:
    18f0:	05 12       	push	r5		;

000018f2 <.LCFI5>:
    18f2:	07 4c       	mov	r12,	r7	;
    18f4:	08 4d       	mov	r13,	r8	;
    18f6:	0c 4f       	mov	r15,	r12	;

000018f8 <.LVL6>:
    18f8:	0a 4e       	mov	r14,	r10	;

000018fa <.Loc.416.1>:
    18fa:	fd b0 20 00 	bit.b	#32,	59(r13)	;#0x0020, 0x003b
    18fe:	3b 00 
    1900:	0f 20       	jnz	$+32     	;abs 0x1920
    1902:	09 4e       	mov	r14,	r9	;
    1904:	09 5f       	add	r15,	r9	;

00001906 <.Loc.433.1>:
    1906:	36 40 ae 18 	mov	#6318,	r6	;#0x18ae

0000190a <.L10>:
    190a:	0a 99       	cmp	r9,	r10	;
    190c:	11 24       	jz	$+36     	;abs 0x1930

0000190e <.Loc.433.1>:
    190e:	0e 48       	mov	r8,	r14	;
    1910:	6d 4a       	mov.b	@r10,	r13	;
    1912:	0c 47       	mov	r7,	r12	;
    1914:	86 12       	call	r6		;

00001916 <.LVL8>:
    1916:	1a 53       	inc	r10		;

00001918 <.LVL9>:
    1918:	3c 93       	cmp	#-1,	r12	;r3 As==11
    191a:	f7 23       	jnz	$-16     	;abs 0x190a
    191c:	30 40 48 19 	br	#0x1948		;

00001920 <.L9>:
    1920:	b0 12 ce 0e 	call	#3790		;#0x0ece

00001924 <.LVL11>:
    1924:	06 4c       	mov	r12,	r6	;
    1926:	49 43       	clr.b	r9		;

00001928 <.Loc.423.1>:
    1928:	35 40 78 22 	mov	#8824,	r5	;#0x2278

0000192c <.L11>:
    192c:	09 96       	cmp	r6,	r9	;
    192e:	03 20       	jnz	$+8      	;abs 0x1936

00001930 <.L17>:
    1930:	4c 43       	clr.b	r12		;
    1932:	30 40 4a 19 	br	#0x194a		;

00001936 <.L14>:
    1936:	0f 48       	mov	r8,	r15	;
    1938:	2d 4a       	mov	@r10,	r13	;
    193a:	1e 4a 02 00 	mov	2(r10),	r14	;
    193e:	0c 47       	mov	r7,	r12	;
    1940:	85 12       	call	r5		;

00001942 <.LVL15>:
    1942:	2a 52       	add	#4,	r10	;r2 As==10
    1944:	3c 93       	cmp	#-1,	r12	;r3 As==11
    1946:	03 20       	jnz	$+8      	;abs 0x194e

00001948 <.L15>:
    1948:	3c 43       	mov	#-1,	r12	;r3 As==11

0000194a <.L8>:
    194a:	30 40 18 0e 	br	#0x0e18		;

0000194e <.L12>:
    194e:	19 53       	inc	r9		;
    1950:	30 40 2c 19 	br	#0x192c		;

00001954 <_vfiprintf_r>:
    1954:	0a 12       	push	r10		;

00001956 <.LCFI14>:
    1956:	09 12       	push	r9		;

00001958 <.LCFI15>:
    1958:	08 12       	push	r8		;

0000195a <.LCFI16>:
    195a:	07 12       	push	r7		;

0000195c <.LCFI17>:
    195c:	06 12       	push	r6		;

0000195e <.LCFI18>:
    195e:	05 12       	push	r5		;

00001960 <.LCFI19>:
    1960:	04 12       	push	r4		;

00001962 <.LCFI20>:
    1962:	31 80 52 00 	sub	#82,	r1	;#0x0052

00001966 <.LCFI21>:
    1966:	08 4c       	mov	r12,	r8	;
    1968:	09 4d       	mov	r13,	r9	;
    196a:	07 4e       	mov	r14,	r7	;
    196c:	81 4f 04 00 	mov	r15,	4(r1)	;

00001970 <.LBB16>:
    1970:	0c 93       	cmp	#0,	r12	;r3 As==00
    1972:	05 24       	jz	$+12     	;abs 0x197e

00001974 <.Loc.493.1>:
    1974:	8c 93 0c 00 	cmp	#0,	12(r12)	;r3 As==00, 0x000c
    1978:	02 20       	jnz	$+6      	;abs 0x197e

0000197a <.Loc.493.1>:
    197a:	b0 12 20 11 	call	#4384		;#0x1120

0000197e <.L32>:
    197e:	39 90 8a 31 	cmp	#12682,	r9	;#0x318a
    1982:	66 20       	jnz	$+206    	;abs 0x1a50

00001984 <.Loc.493.1>:
    1984:	19 48 02 00 	mov	2(r8),	r9	;

00001988 <.L34>:
    1988:	f9 b2 06 00 	bit.b	#8,	6(r9)	;r2 As==11
    198c:	6f 24       	jz	$+224    	;abs 0x1a6c

0000198e <.Loc.497.1>:
    198e:	89 93 0a 00 	cmp	#0,	10(r9)	;r3 As==00, 0x000a
    1992:	6c 24       	jz	$+218    	;abs 0x1a6c

00001994 <.L38>:
    1994:	81 43 10 00 	mov	#0,	16(r1)	;r3 As==00, 0x0010

00001998 <.Loc.519.1>:
    1998:	f1 40 20 00 	mov.b	#32,	19(r1)	;#0x0020, 0x0013
    199c:	13 00 

0000199e <.Loc.520.1>:
    199e:	f1 40 30 00 	mov.b	#48,	20(r1)	;#0x0030, 0x0014
    19a2:	14 00 

000019a4 <.Loc.531.1>:
    19a4:	35 40 e6 18 	mov	#6374,	r5	;#0x18e6

000019a8 <.Loc.554.1>:
    19a8:	34 40 dc 15 	mov	#5596,	r4	;#0x15dc

000019ac <.L37>:
    19ac:	0a 47       	mov	r7,	r10	;

000019ae <.L40>:
    19ae:	6c 4a       	mov.b	@r10,	r12	;
    19b0:	0c 93       	cmp	#0,	r12	;r3 As==00
    19b2:	67 20       	jnz	$+208    	;abs 0x1a82

000019b4 <.L45>:
    19b4:	0b 4a       	mov	r10,	r11	;
    19b6:	0b 87       	sub	r7,	r11	;

000019b8 <.LVL43>:
    19b8:	0b 93       	cmp	#0,	r11	;r3 As==00
    19ba:	0d 24       	jz	$+28     	;abs 0x19d6

000019bc <.Loc.531.1>:
    19bc:	0f 4b       	mov	r11,	r15	;
    19be:	0e 47       	mov	r7,	r14	;
    19c0:	0d 49       	mov	r9,	r13	;
    19c2:	0c 48       	mov	r8,	r12	;
    19c4:	81 4b 02 00 	mov	r11,	2(r1)	;
    19c8:	85 12       	call	r5		;

000019ca <.LVL44>:
    19ca:	1b 41 02 00 	mov	2(r1),	r11	;
    19ce:	3c 93       	cmp	#-1,	r12	;r3 As==11
    19d0:	ff 24       	jz	$+512    	;abs 0x1bd0

000019d2 <.Loc.532.1>:
    19d2:	81 5b 10 00 	add	r11,	16(r1)	; 0x0010

000019d6 <.L43>:
    19d6:	ca 93 00 00 	cmp.b	#0,	0(r10)	;r3 As==00
    19da:	fa 24       	jz	$+502    	;abs 0x1bd0

000019dc <.Loc.537.1>:
    19dc:	1a 53       	inc	r10		;

000019de <.LVL45>:
    19de:	81 43 06 00 	mov	#0,	6(r1)	;r3 As==00

000019e2 <.Loc.540.1>:
    19e2:	81 43 0c 00 	mov	#0,	12(r1)	;r3 As==00, 0x000c

000019e6 <.Loc.541.1>:
    19e6:	b1 43 08 00 	mov	#-1,	8(r1)	;r3 As==11

000019ea <.Loc.542.1>:
    19ea:	81 43 0a 00 	mov	#0,	10(r1)	;r3 As==00, 0x000a

000019ee <.Loc.543.1>:
    19ee:	c1 43 3d 00 	mov.b	#0,	61(r1)	;r3 As==00, 0x003d

000019f2 <.Loc.545.1>:
    19f2:	81 43 50 00 	mov	#0,	80(r1)	;r3 As==00, 0x0050

000019f6 <.L47>:
    19f6:	7e 40 05 00 	mov.b	#5,	r14	;
    19fa:	6d 4a       	mov.b	@r10,	r13	;
    19fc:	3c 40 a0 31 	mov	#12704,	r12	;#0x31a0
    1a00:	84 12       	call	r4		;

00001a02 <.LVL47>:
    1a02:	0d 4c       	mov	r12,	r13	;

00001a04 <.LVL48>:
    1a04:	07 4a       	mov	r10,	r7	;
    1a06:	17 53       	inc	r7		;
    1a08:	0c 93       	cmp	#0,	r12	;r3 As==00
    1a0a:	41 20       	jnz	$+132    	;abs 0x1a8e

00001a0c <.Loc.557.1>:
    1a0c:	1d 41 06 00 	mov	6(r1),	r13	;
    1a10:	3d b0 10 00 	bit	#16,	r13	;#0x0010
    1a14:	03 24       	jz	$+8      	;abs 0x1a1c

00001a16 <.Loc.558.1>:
    1a16:	f1 40 20 00 	mov.b	#32,	61(r1)	;#0x0020, 0x003d
    1a1a:	3d 00 

00001a1c <.L49>:
    1a1c:	3d b2       	bit	#8,	r13	;r2 As==11
    1a1e:	03 24       	jz	$+8      	;abs 0x1a26

00001a20 <.Loc.566.1>:
    1a20:	f1 40 2b 00 	mov.b	#43,	61(r1)	;#0x002b, 0x003d
    1a24:	3d 00 

00001a26 <.L50>:
    1a26:	fa 90 2a 00 	cmp.b	#42,	0(r10)	;#0x002a
    1a2a:	00 00 
    1a2c:	3a 24       	jz	$+118    	;abs 0x1aa2
    1a2e:	1f 41 0c 00 	mov	12(r1),	r15	;0x0000c
    1a32:	4c 43       	clr.b	r12		;

00001a34 <.LVL49>:
    1a34:	5e 43       	mov.b	#1,	r14	;r3 As==01

00001a36 <.L52>:
    1a36:	6d 4a       	mov.b	@r10,	r13	;
    1a38:	3d 50 d0 ff 	add	#65488,	r13	;#0xffd0
    1a3c:	77 40 09 00 	mov.b	#9,	r7	;
    1a40:	07 9d       	cmp	r13,	r7	;
    1a42:	8b 2c       	jc	$+280    	;abs 0x1b5a
    1a44:	0c 93       	cmp	#0,	r12	;r3 As==00
    1a46:	3b 24       	jz	$+120    	;abs 0x1abe
    1a48:	81 4f 0c 00 	mov	r15,	12(r1)	; 0x000c
    1a4c:	30 40 be 1a 	br	#0x1abe		;

00001a50 <.L33>:
    1a50:	39 90 78 31 	cmp	#12664,	r9	;#0x3178
    1a54:	04 20       	jnz	$+10     	;abs 0x1a5e

00001a56 <.Loc.493.1>:
    1a56:	19 48 04 00 	mov	4(r8),	r9	;
    1a5a:	30 40 88 19 	br	#0x1988		;

00001a5e <.L35>:
    1a5e:	39 90 66 31 	cmp	#12646,	r9	;#0x3166
    1a62:	92 23       	jnz	$-218    	;abs 0x1988

00001a64 <.Loc.493.1>:
    1a64:	19 48 06 00 	mov	6(r8),	r9	;
    1a68:	30 40 88 19 	br	#0x1988		;

00001a6c <.L36>:
    1a6c:	0d 49       	mov	r9,	r13	;
    1a6e:	0c 48       	mov	r8,	r12	;
    1a70:	b0 12 e2 1d 	call	#7650		;#0x1de2

00001a74 <.LVL53>:
    1a74:	0c 93       	cmp	#0,	r12	;r3 As==00
    1a76:	8e 27       	jz	$-226    	;abs 0x1994

00001a78 <.L70>:
    1a78:	3c 43       	mov	#-1,	r12	;r3 As==11

00001a7a <.L31>:
    1a7a:	31 50 52 00 	add	#82,	r1	;#0x0052
    1a7e:	30 40 16 0e 	br	#0x0e16		;

00001a82 <.L41>:
    1a82:	3c 90 25 00 	cmp	#37,	r12	;#0x0025
    1a86:	96 27       	jz	$-210    	;abs 0x19b4

00001a88 <.Loc.527.1>:
    1a88:	1a 53       	inc	r10		;
    1a8a:	30 40 ae 19 	br	#0x19ae		;

00001a8e <.L48>:
    1a8e:	5c 43       	mov.b	#1,	r12	;r3 As==01

00001a90 <.LVL58>:
    1a90:	3d 80 a0 31 	sub	#12704,	r13	;#0x31a0

00001a94 <.LVL59>:
    1a94:	b0 12 4a 0e 	call	#3658		;#0x0e4a

00001a98 <.LVL60>:
    1a98:	81 dc 06 00 	bis	r12,	6(r1)	;

00001a9c <.Loc.554.1>:
    1a9c:	0a 47       	mov	r7,	r10	;

00001a9e <.LVL61>:
    1a9e:	30 40 f6 19 	br	#0x19f6		;

00001aa2 <.L51>:
    1aa2:	1c 41 04 00 	mov	4(r1),	r12	;

00001aa6 <.LVL63>:
    1aa6:	1c 53       	inc	r12		;
    1aa8:	1c c3       	bic	#1,	r12	;r3 As==01
    1aaa:	0e 4c       	mov	r12,	r14	;
    1aac:	2e 53       	incd	r14		;
    1aae:	81 4e 04 00 	mov	r14,	4(r1)	;
    1ab2:	2c 4c       	mov	@r12,	r12	;

00001ab4 <.Loc.578.1>:
    1ab4:	0c 93       	cmp	#0,	r12	;r3 As==00
    1ab6:	48 38       	jl	$+146    	;abs 0x1b48

00001ab8 <.Loc.577.1>:
    1ab8:	81 4c 0c 00 	mov	r12,	12(r1)	; 0x000c

00001abc <.L54>:
    1abc:	0a 47       	mov	r7,	r10	;

00001abe <.L55>:
    1abe:	fa 90 2e 00 	cmp.b	#46,	0(r10)	;#0x002e
    1ac2:	00 00 
    1ac4:	14 20       	jnz	$+42     	;abs 0x1aee

00001ac6 <.Loc.594.1>:
    1ac6:	0c 4a       	mov	r10,	r12	;
    1ac8:	1c 53       	inc	r12		;

00001aca <.LVL65>:
    1aca:	fa 90 2a 00 	cmp.b	#42,	1(r10)	;#0x002a
    1ace:	01 00 
    1ad0:	53 20       	jnz	$+168    	;abs 0x1b78

00001ad2 <.Loc.597.1>:
    1ad2:	2a 53       	incd	r10		;

00001ad4 <.LVL66>:
    1ad4:	1c 41 04 00 	mov	4(r1),	r12	;
    1ad8:	1c 53       	inc	r12		;
    1ada:	1c c3       	bic	#1,	r12	;r3 As==01
    1adc:	0d 4c       	mov	r12,	r13	;
    1ade:	2d 53       	incd	r13		;
    1ae0:	81 4d 04 00 	mov	r13,	4(r1)	;
    1ae4:	2c 4c       	mov	@r12,	r12	;

00001ae6 <.Loc.599.1>:
    1ae6:	0c 93       	cmp	#0,	r12	;r3 As==00
    1ae8:	43 38       	jl	$+136    	;abs 0x1b70

00001aea <.Loc.598.1>:
    1aea:	81 4c 08 00 	mov	r12,	8(r1)	;

00001aee <.L58>:
    1aee:	7e 40 03 00 	mov.b	#3,	r14	;
    1af2:	6d 4a       	mov.b	@r10,	r13	;
    1af4:	3c 40 a6 31 	mov	#12710,	r12	;#0x31a6
    1af8:	84 12       	call	r4		;

00001afa <.LVL68>:
    1afa:	0d 4c       	mov	r12,	r13	;

00001afc <.LVL69>:
    1afc:	0c 93       	cmp	#0,	r12	;r3 As==00
    1afe:	09 24       	jz	$+20     	;abs 0x1b12

00001b00 <.Loc.614.1>:
    1b00:	7c 40 40 00 	mov.b	#64,	r12	;#0x0040

00001b04 <.LVL70>:
    1b04:	3d 80 a6 31 	sub	#12710,	r13	;#0x31a6

00001b08 <.LVL71>:
    1b08:	b0 12 4a 0e 	call	#3658		;#0x0e4a

00001b0c <.LVL72>:
    1b0c:	81 dc 06 00 	bis	r12,	6(r1)	;

00001b10 <.Loc.615.1>:
    1b10:	1a 53       	inc	r10		;

00001b12 <.L64>:
    1b12:	07 4a       	mov	r10,	r7	;
    1b14:	17 53       	inc	r7		;

00001b16 <.LVL74>:
    1b16:	6d 4a       	mov.b	@r10,	r13	;
    1b18:	c1 4d 12 00 	mov.b	r13,	18(r1)	; 0x0012

00001b1c <.Loc.620.1>:
    1b1c:	7e 40 06 00 	mov.b	#6,	r14	;
    1b20:	3c 40 aa 31 	mov	#12714,	r12	;#0x31aa
    1b24:	84 12       	call	r4		;

00001b26 <.LVL75>:
    1b26:	0c 93       	cmp	#0,	r12	;r3 As==00
    1b28:	5b 24       	jz	$+184    	;abs 0x1be0

00001b2a <.Loc.627.1>:
    1b2a:	3a 40 00 00 	mov	#0,	r10	;
    1b2e:	0a 93       	cmp	#0,	r10	;r3 As==00
    1b30:	41 20       	jnz	$+132    	;abs 0x1bb4
    1b32:	1c 41 04 00 	mov	4(r1),	r12	;

00001b36 <.LVL76>:
    1b36:	1c 53       	inc	r12		;
    1b38:	1c c3       	bic	#1,	r12	;r3 As==01
    1b3a:	3c 52       	add	#8,	r12	;r2 As==11

00001b3c <.Loc.632.1>:
    1b3c:	81 4c 04 00 	mov	r12,	4(r1)	;

00001b40 <.L68>:
    1b40:	81 56 10 00 	add	r6,	16(r1)	; 0x0010

00001b44 <.Loc.525.1>:
    1b44:	30 40 ac 19 	br	#0x19ac		;

00001b48 <.L53>:
    1b48:	4e 43       	clr.b	r14		;
    1b4a:	0e 8c       	sub	r12,	r14	;
    1b4c:	81 4e 0c 00 	mov	r14,	12(r1)	; 0x000c

00001b50 <.Loc.581.1>:
    1b50:	2d d3       	bis	#2,	r13	;r3 As==10
    1b52:	81 4d 06 00 	mov	r13,	6(r1)	;
    1b56:	30 40 bc 1a 	br	#0x1abc		;

00001b5a <.L56>:
    1b5a:	0c 4f       	mov	r15,	r12	;
    1b5c:	0c 5f       	add	r15,	r12	;
    1b5e:	0c 5c       	rla	r12		;
    1b60:	0c 5f       	add	r15,	r12	;
    1b62:	0c 5c       	rla	r12		;
    1b64:	0f 4c       	mov	r12,	r15	;
    1b66:	0f 5d       	add	r13,	r15	;

00001b68 <.Loc.587.1>:
    1b68:	1a 53       	inc	r10		;
    1b6a:	0c 4e       	mov	r14,	r12	;
    1b6c:	30 40 36 1a 	br	#0x1a36		;

00001b70 <.L60>:
    1b70:	b1 43 08 00 	mov	#-1,	8(r1)	;r3 As==11
    1b74:	30 40 ee 1a 	br	#0x1aee		;

00001b78 <.L59>:
    1b78:	81 43 08 00 	mov	#0,	8(r1)	;r3 As==00

00001b7c <.Loc.594.1>:
    1b7c:	0a 4c       	mov	r12,	r10	;

00001b7e <.Loc.605.1>:
    1b7e:	4c 43       	clr.b	r12		;

00001b80 <.LVL80>:
    1b80:	0f 4c       	mov	r12,	r15	;
    1b82:	5e 43       	mov.b	#1,	r14	;r3 As==01

00001b84 <.L61>:
    1b84:	6d 4a       	mov.b	@r10,	r13	;
    1b86:	3d 50 d0 ff 	add	#65488,	r13	;#0xffd0
    1b8a:	77 40 09 00 	mov.b	#9,	r7	;
    1b8e:	07 9d       	cmp	r13,	r7	;
    1b90:	06 2c       	jc	$+14     	;abs 0x1b9e
    1b92:	0c 93       	cmp	#0,	r12	;r3 As==00
    1b94:	ac 27       	jz	$-166    	;abs 0x1aee
    1b96:	81 4f 08 00 	mov	r15,	8(r1)	;
    1b9a:	30 40 ee 1a 	br	#0x1aee		;

00001b9e <.L62>:
    1b9e:	0c 4f       	mov	r15,	r12	;
    1ba0:	0c 5f       	add	r15,	r12	;
    1ba2:	0c 5c       	rla	r12		;
    1ba4:	0c 5f       	add	r15,	r12	;
    1ba6:	0c 5c       	rla	r12		;
    1ba8:	0f 4c       	mov	r12,	r15	;
    1baa:	0f 5d       	add	r13,	r15	;

00001bac <.Loc.605.1>:
    1bac:	1a 53       	inc	r10		;
    1bae:	0c 4e       	mov	r14,	r12	;
    1bb0:	30 40 84 1b 	br	#0x1b84		;

00001bb4 <.L66>:
    1bb4:	6c 42       	mov.b	#4,	r12	;r2 As==10

00001bb6 <.LVL83>:
    1bb6:	0c 51       	add	r1,	r12	;
    1bb8:	81 4c 00 00 	mov	r12,	0(r1)	;
    1bbc:	0f 45       	mov	r5,	r15	;
    1bbe:	0e 49       	mov	r9,	r14	;
    1bc0:	0d 41       	mov	r1,	r13	;
    1bc2:	3d 50 06 00 	add	#6,	r13	;
    1bc6:	0c 48       	mov	r8,	r12	;
    1bc8:	8a 12       	call	r10		;

00001bca <.L101>:
    1bca:	06 4c       	mov	r12,	r6	;

00001bcc <.Loc.643.1>:
    1bcc:	3c 93       	cmp	#-1,	r12	;r3 As==11
    1bce:	b8 23       	jnz	$-142    	;abs 0x1b40

00001bd0 <.L46>:
    1bd0:	f9 b0 40 00 	bit.b	#64,	6(r9)	;#0x0040
    1bd4:	06 00 
    1bd6:	50 23       	jnz	$-350    	;abs 0x1a78

00001bd8 <.Loc.654.1>:
    1bd8:	1c 41 10 00 	mov	16(r1),	r12	;0x00010
    1bdc:	30 40 7a 1a 	br	#0x1a7a		;

00001be0 <.L65>:
    1be0:	6d 42       	mov.b	#4,	r13	;r2 As==10
    1be2:	0d 51       	add	r1,	r13	;
    1be4:	81 4d 00 00 	mov	r13,	0(r1)	;
    1be8:	0f 45       	mov	r5,	r15	;
    1bea:	0e 49       	mov	r9,	r14	;
    1bec:	0d 41       	mov	r1,	r13	;
    1bee:	3d 50 06 00 	add	#6,	r13	;
    1bf2:	0c 48       	mov	r8,	r12	;

00001bf4 <.LVL88>:
    1bf4:	b0 12 06 25 	call	#9478		;#0x2506

00001bf8 <.LVL89>:
    1bf8:	30 40 ca 1b 	br	#0x1bca		;

00001bfc <_sbrk_r>:
    1bfc:	0a 12       	push	r10		;

00001bfe <.LCFI0>:
    1bfe:	0a 4c       	mov	r12,	r10	;

00001c00 <.Loc.57.1>:
    1c00:	82 43 1a 81 	mov	#0,	&0x811a	;r3 As==00

00001c04 <.Loc.58.1>:
    1c04:	0c 4d       	mov	r13,	r12	;

00001c06 <.LVL1>:
    1c06:	b0 12 5c 2b 	call	#11100		;#0x2b5c

00001c0a <.LVL2>:
    1c0a:	3c 93       	cmp	#-1,	r12	;r3 As==11
    1c0c:	06 20       	jnz	$+14     	;abs 0x1c1a

00001c0e <.Loc.58.1>:
    1c0e:	1d 42 1a 81 	mov	&0x811a,r13	;0x811a
    1c12:	0d 93       	cmp	#0,	r13	;r3 As==00
    1c14:	02 24       	jz	$+6      	;abs 0x1c1a

00001c16 <.Loc.59.1>:
    1c16:	8a 4d 00 00 	mov	r13,	0(r10)	;

00001c1a <.L2>:
    1c1a:	3a 41       	pop	r10		;

00001c1c <.LVL3>:
    1c1c:	30 41       	ret			

00001c1e <__sread>:
    1c1e:	0a 12       	push	r10		;

00001c20 <.LCFI0>:
    1c20:	09 12       	push	r9		;

00001c22 <.LCFI1>:
    1c22:	08 12       	push	r8		;

00001c24 <.LCFI2>:
    1c24:	0a 4d       	mov	r13,	r10	;

00001c26 <.LVL1>:
    1c26:	1d 4d 08 00 	mov	8(r13),	r13	;

00001c2a <.LVL2>:
    1c2a:	b0 12 c2 28 	call	#10434		;#0x28c2

00001c2e <.LVL3>:
    1c2e:	0c 93       	cmp	#0,	r12	;r3 As==00
    1c30:	11 38       	jl	$+36     	;abs 0x1c54

00001c32 <.Loc.58.1>:
    1c32:	0e 4c       	mov	r12,	r14	;
    1c34:	3e b0 00 80 	bit	#32768,	r14	;#0x8000
    1c38:	0f 7f       	subc	r15,	r15	;
    1c3a:	3f e3       	inv	r15		;
    1c3c:	08 4e       	mov	r14,	r8	;
    1c3e:	09 4f       	mov	r15,	r9	;
    1c40:	18 5a 2e 00 	add	46(r10),r8	;0x0002e
    1c44:	19 6a 30 00 	addc	48(r10),r9	;0x00030
    1c48:	8a 48 2e 00 	mov	r8,	46(r10)	; 0x002e
    1c4c:	8a 49 30 00 	mov	r9,	48(r10)	; 0x0030

00001c50 <.L1>:
    1c50:	30 40 1e 0e 	br	#0x0e1e		;

00001c54 <.L2>:
    1c54:	ba f0 ff ef 	and	#61439,	6(r10)	;#0xefff
    1c58:	06 00 

00001c5a <.Loc.61.1>:
    1c5a:	30 40 50 1c 	br	#0x1c50		;

00001c5e <__swrite>:
    1c5e:	0a 12       	push	r10		;

00001c60 <.LCFI3>:
    1c60:	09 12       	push	r9		;

00001c62 <.LCFI4>:
    1c62:	08 12       	push	r8		;

00001c64 <.LCFI5>:
    1c64:	07 12       	push	r7		;

00001c66 <.LCFI6>:
    1c66:	21 83       	decd	r1		;

00001c68 <.LCFI7>:
    1c68:	09 4c       	mov	r12,	r9	;
    1c6a:	0a 4d       	mov	r13,	r10	;
    1c6c:	08 4e       	mov	r14,	r8	;
    1c6e:	07 4f       	mov	r15,	r7	;

00001c70 <.LVL7>:
    1c70:	dd b3 07 00 	bit.b	#1,	7(r13)	;r3 As==01
    1c74:	08 24       	jz	$+18     	;abs 0x1c86

00001c76 <.Loc.89.1>:
    1c76:	1d 4d 08 00 	mov	8(r13),	r13	;

00001c7a <.LVL8>:
    1c7a:	a1 43 00 00 	mov	#2,	0(r1)	;r3 As==10
    1c7e:	4e 43       	clr.b	r14		;

00001c80 <.LVL9>:
    1c80:	4f 43       	clr.b	r15		;

00001c82 <.LVL10>:
    1c82:	b0 12 b4 22 	call	#8884		;#0x22b4

00001c86 <.L6>:
    1c86:	ba f0 ff ef 	and	#61439,	6(r10)	;#0xefff
    1c8a:	06 00 

00001c8c <.Loc.97.1>:
    1c8c:	0f 47       	mov	r7,	r15	;
    1c8e:	0e 48       	mov	r8,	r14	;
    1c90:	1d 4a 08 00 	mov	8(r10),	r13	;
    1c94:	0c 49       	mov	r9,	r12	;
    1c96:	b0 12 bc 1d 	call	#7612		;#0x1dbc

00001c9a <.LVL12>:
    1c9a:	21 53       	incd	r1		;
    1c9c:	30 40 1c 0e 	br	#0x0e1c		;

00001ca0 <__sseek>:
    1ca0:	0a 12       	push	r10		;

00001ca2 <.LCFI8>:
    1ca2:	21 83       	decd	r1		;

00001ca4 <.LCFI9>:
    1ca4:	0a 4d       	mov	r13,	r10	;

00001ca6 <.LVL14>:
    1ca6:	1d 4d 08 00 	mov	8(r13),	r13	;

00001caa <.LVL15>:
    1caa:	91 41 06 00 	mov	6(r1),	0(r1)	;
    1cae:	00 00 
    1cb0:	b0 12 b4 22 	call	#8884		;#0x22b4

00001cb4 <.LVL16>:
    1cb4:	3c 93       	cmp	#-1,	r12	;r3 As==11
    1cb6:	08 20       	jnz	$+18     	;abs 0x1cc8
    1cb8:	3d 93       	cmp	#-1,	r13	;r3 As==11
    1cba:	06 20       	jnz	$+14     	;abs 0x1cc8

00001cbc <.Loc.119.1>:
    1cbc:	ba f0 ff ef 	and	#61439,	6(r10)	;#0xefff
    1cc0:	06 00 

00001cc2 <.L10>:
    1cc2:	21 53       	incd	r1		;
    1cc4:	3a 41       	pop	r10		;

00001cc6 <.LVL17>:
    1cc6:	30 41       	ret			

00001cc8 <.L11>:
    1cc8:	ba d0 00 10 	bis	#4096,	6(r10)	;#0x1000
    1ccc:	06 00 

00001cce <.Loc.123.1>:
    1cce:	8a 4c 2e 00 	mov	r12,	46(r10)	; 0x002e
    1cd2:	8a 4d 30 00 	mov	r13,	48(r10)	; 0x0030

00001cd6 <.Loc.125.1>:
    1cd6:	30 40 c2 1c 	br	#0x1cc2		;

00001cda <__sclose>:
    1cda:	1d 4d 08 00 	mov	8(r13),	r13	;

00001cde <.LVL21>:
    1cde:	b0 12 e4 1e 	call	#7908		;#0x1ee4

00001ce2 <.LVL22>:
    1ce2:	30 41       	ret			

00001ce4 <__swbuf_r>:
    1ce4:	0a 12       	push	r10		;

00001ce6 <.LCFI0>:
    1ce6:	09 12       	push	r9		;

00001ce8 <.LCFI1>:
    1ce8:	08 12       	push	r8		;

00001cea <.LCFI2>:
    1cea:	07 12       	push	r7		;

00001cec <.LCFI3>:
    1cec:	09 4c       	mov	r12,	r9	;
    1cee:	08 4d       	mov	r13,	r8	;
    1cf0:	0a 4e       	mov	r14,	r10	;

00001cf2 <.LBB2>:
    1cf2:	0c 93       	cmp	#0,	r12	;r3 As==00
    1cf4:	05 24       	jz	$+12     	;abs 0x1d00

00001cf6 <.Loc.45.1>:
    1cf6:	8c 93 0c 00 	cmp	#0,	12(r12)	;r3 As==00, 0x000c
    1cfa:	02 20       	jnz	$+6      	;abs 0x1d00

00001cfc <.Loc.45.1>:
    1cfc:	b0 12 20 11 	call	#4384		;#0x1120

00001d00 <.L2>:
    1d00:	3a 90 8a 31 	cmp	#12682,	r10	;#0x318a
    1d04:	3a 20       	jnz	$+118    	;abs 0x1d7a

00001d06 <.Loc.45.1>:
    1d06:	1a 49 02 00 	mov	2(r9),	r10	;

00001d0a <.L4>:
    1d0a:	9a 4a 0e 00 	mov	14(r10),4(r10)	;0x0000e
    1d0e:	04 00 

00001d10 <.Loc.56.1>:
    1d10:	fa b2 06 00 	bit.b	#8,	6(r10)	;r2 As==11
    1d14:	40 24       	jz	$+130    	;abs 0x1d96

00001d16 <.Loc.56.1>:
    1d16:	8a 93 0a 00 	cmp	#0,	10(r10)	;r3 As==00, 0x000a
    1d1a:	3d 24       	jz	$+124    	;abs 0x1d96

00001d1c <.L9>:
    1d1c:	47 48       	mov.b	r8,	r7	;
    1d1e:	78 f0 ff 00 	and.b	#255,	r8	;#0x00ff

00001d22 <.Loc.60.1>:
    1d22:	1c 4a 06 00 	mov	6(r10),	r12	;
    1d26:	3c b0 00 20 	bit	#8192,	r12	;#0x2000
    1d2a:	3f 24       	jz	$+128    	;abs 0x1daa

00001d2c <.L8>:
    1d2c:	2c 4a       	mov	@r10,	r12	;
    1d2e:	1c 8a 0a 00 	sub	10(r10),r12	;0x0000a

00001d32 <.LVL5>:
    1d32:	1c 9a 0c 00 	cmp	12(r10),r12	;0x0000c
    1d36:	06 38       	jl	$+14     	;abs 0x1d44

00001d38 <.Loc.75.1>:
    1d38:	0d 4a       	mov	r10,	r13	;
    1d3a:	0c 49       	mov	r9,	r12	;

00001d3c <.LVL6>:
    1d3c:	b0 12 60 21 	call	#8544		;#0x2160

00001d40 <.LVL7>:
    1d40:	0c 93       	cmp	#0,	r12	;r3 As==00
    1d42:	2f 20       	jnz	$+96     	;abs 0x1da2

00001d44 <.L11>:
    1d44:	ba 53 04 00 	add	#-1,	4(r10)	;r3 As==11

00001d48 <.Loc.80.1>:
    1d48:	2d 4a       	mov	@r10,	r13	;
    1d4a:	0e 4d       	mov	r13,	r14	;
    1d4c:	1e 53       	inc	r14		;
    1d4e:	8a 4e 00 00 	mov	r14,	0(r10)	;
    1d52:	cd 47 00 00 	mov.b	r7,	0(r13)	;

00001d56 <.LVL9>:
    1d56:	1c 53       	inc	r12		;

00001d58 <.LVL10>:
    1d58:	1c 9a 0c 00 	cmp	12(r10),r12	;0x0000c
    1d5c:	06 24       	jz	$+14     	;abs 0x1d6a

00001d5e <.Loc.81.1>:
    1d5e:	da b3 06 00 	bit.b	#1,	6(r10)	;r3 As==01
    1d62:	20 24       	jz	$+66     	;abs 0x1da4

00001d64 <.Loc.81.1>:
    1d64:	38 90 0a 00 	cmp	#10,	r8	;#0x000a
    1d68:	1d 20       	jnz	$+60     	;abs 0x1da4

00001d6a <.L13>:
    1d6a:	0d 4a       	mov	r10,	r13	;
    1d6c:	0c 49       	mov	r9,	r12	;

00001d6e <.LVL11>:
    1d6e:	b0 12 60 21 	call	#8544		;#0x2160

00001d72 <.LVL12>:
    1d72:	0c 93       	cmp	#0,	r12	;r3 As==00
    1d74:	17 24       	jz	$+48     	;abs 0x1da4
    1d76:	30 40 a2 1d 	br	#0x1da2		;

00001d7a <.L3>:
    1d7a:	3a 90 78 31 	cmp	#12664,	r10	;#0x3178
    1d7e:	04 20       	jnz	$+10     	;abs 0x1d88

00001d80 <.Loc.45.1>:
    1d80:	1a 49 04 00 	mov	4(r9),	r10	;
    1d84:	30 40 0a 1d 	br	#0x1d0a		;

00001d88 <.L5>:
    1d88:	3a 90 66 31 	cmp	#12646,	r10	;#0x3166
    1d8c:	be 23       	jnz	$-130    	;abs 0x1d0a

00001d8e <.Loc.45.1>:
    1d8e:	1a 49 06 00 	mov	6(r9),	r10	;
    1d92:	30 40 0a 1d 	br	#0x1d0a		;

00001d96 <.L6>:
    1d96:	0d 4a       	mov	r10,	r13	;
    1d98:	0c 49       	mov	r9,	r12	;
    1d9a:	b0 12 e2 1d 	call	#7650		;#0x1de2

00001d9e <.LVL15>:
    1d9e:	0c 93       	cmp	#0,	r12	;r3 As==00
    1da0:	bd 27       	jz	$-132    	;abs 0x1d1c

00001da2 <.L12>:
    1da2:	38 43       	mov	#-1,	r8	;r3 As==11

00001da4 <.L1>:
    1da4:	0c 48       	mov	r8,	r12	;
    1da6:	30 40 1c 0e 	br	#0x0e1c		;

00001daa <.L7>:
    1daa:	3c d0 00 20 	bis	#8192,	r12	;#0x2000
    1dae:	8a 4c 06 00 	mov	r12,	6(r10)	;
    1db2:	ba f0 ff df 	and	#57343,	58(r10)	;#0xdfff, 0x003a
    1db6:	3a 00 
    1db8:	30 40 2c 1d 	br	#0x1d2c		;

00001dbc <_write_r>:
    1dbc:	0a 12       	push	r10		;

00001dbe <.LCFI0>:
    1dbe:	0a 4c       	mov	r12,	r10	;
    1dc0:	0c 4d       	mov	r13,	r12	;

00001dc2 <.LVL1>:
    1dc2:	0d 4e       	mov	r14,	r13	;

00001dc4 <.LVL2>:
    1dc4:	82 43 1a 81 	mov	#0,	&0x811a	;r3 As==00

00001dc8 <.Loc.58.1>:
    1dc8:	0e 4f       	mov	r15,	r14	;

00001dca <.LVL3>:
    1dca:	b0 12 c4 2a 	call	#10948		;#0x2ac4

00001dce <.LVL4>:
    1dce:	3c 93       	cmp	#-1,	r12	;r3 As==11
    1dd0:	06 20       	jnz	$+14     	;abs 0x1dde

00001dd2 <.Loc.58.1>:
    1dd2:	1d 42 1a 81 	mov	&0x811a,r13	;0x811a
    1dd6:	0d 93       	cmp	#0,	r13	;r3 As==00
    1dd8:	02 24       	jz	$+6      	;abs 0x1dde

00001dda <.Loc.59.1>:
    1dda:	8a 4d 00 00 	mov	r13,	0(r10)	;

00001dde <.L1>:
    1dde:	3a 41       	pop	r10		;

00001de0 <.LVL5>:
    1de0:	30 41       	ret			

00001de2 <__swsetup_r>:
    1de2:	0a 12       	push	r10		;

00001de4 <.LCFI0>:
    1de4:	09 12       	push	r9		;

00001de6 <.LCFI1>:
    1de6:	08 12       	push	r8		;

00001de8 <.LCFI2>:
    1de8:	08 4c       	mov	r12,	r8	;
    1dea:	0a 4d       	mov	r13,	r10	;

00001dec <.LBB2>:
    1dec:	19 42 08 80 	mov	&0x8008,r9	;0x8008
    1df0:	09 93       	cmp	#0,	r9	;r3 As==00
    1df2:	06 24       	jz	$+14     	;abs 0x1e00

00001df4 <.Loc.39.1>:
    1df4:	89 93 0c 00 	cmp	#0,	12(r9)	;r3 As==00, 0x000c
    1df8:	03 20       	jnz	$+8      	;abs 0x1e00

00001dfa <.Loc.39.1>:
    1dfa:	0c 49       	mov	r9,	r12	;

00001dfc <.LVL2>:
    1dfc:	b0 12 20 11 	call	#4384		;#0x1120

00001e00 <.L2>:
    1e00:	3a 90 8a 31 	cmp	#12682,	r10	;#0x318a
    1e04:	13 20       	jnz	$+40     	;abs 0x1e2c

00001e06 <.Loc.39.1>:
    1e06:	1a 49 02 00 	mov	2(r9),	r10	;

00001e0a <.L4>:
    1e0a:	1c 4a 06 00 	mov	6(r10),	r12	;
    1e0e:	3c b2       	bit	#8,	r12	;r2 As==11
    1e10:	35 20       	jnz	$+108    	;abs 0x1e7c

00001e12 <.Loc.47.1>:
    1e12:	3c b0 10 00 	bit	#16,	r12	;#0x0010
    1e16:	18 20       	jnz	$+50     	;abs 0x1e48

00001e18 <.Loc.49.1>:
    1e18:	b8 40 09 00 	mov	#9,	0(r8)	;
    1e1c:	00 00 

00001e1e <.Loc.50.1>:
    1e1e:	3c d0 40 00 	bis	#64,	r12	;#0x0040
    1e22:	8a 4c 06 00 	mov	r12,	6(r10)	;

00001e26 <.L32>:
    1e26:	3c 43       	mov	#-1,	r12	;r3 As==11

00001e28 <.L1>:
    1e28:	30 40 1e 0e 	br	#0x0e1e		;

00001e2c <.L3>:
    1e2c:	3a 90 78 31 	cmp	#12664,	r10	;#0x3178
    1e30:	04 20       	jnz	$+10     	;abs 0x1e3a

00001e32 <.Loc.39.1>:
    1e32:	1a 49 04 00 	mov	4(r9),	r10	;
    1e36:	30 40 0a 1e 	br	#0x1e0a		;

00001e3a <.L5>:
    1e3a:	3a 90 66 31 	cmp	#12646,	r10	;#0x3166
    1e3e:	e5 23       	jnz	$-52     	;abs 0x1e0a

00001e40 <.Loc.39.1>:
    1e40:	1a 49 06 00 	mov	6(r9),	r10	;
    1e44:	30 40 0a 1e 	br	#0x1e0a		;

00001e48 <.L7>:
    1e48:	2c b2       	bit	#4,	r12	;r2 As==10
    1e4a:	16 24       	jz	$+46     	;abs 0x1e78

00001e4c <.Loc.56.1>:
    1e4c:	1d 4a 1c 00 	mov	28(r10),r13	;0x0001c
    1e50:	0d 93       	cmp	#0,	r13	;r3 As==00
    1e52:	0a 24       	jz	$+22     	;abs 0x1e68

00001e54 <.Loc.57.1>:
    1e54:	0c 4a       	mov	r10,	r12	;
    1e56:	3c 50 24 00 	add	#36,	r12	;#0x0024
    1e5a:	0d 9c       	cmp	r12,	r13	;
    1e5c:	03 24       	jz	$+8      	;abs 0x1e64

00001e5e <.Loc.57.1>:
    1e5e:	0c 48       	mov	r8,	r12	;
    1e60:	b0 12 5c 16 	call	#5724		;#0x165c

00001e64 <.L11>:
    1e64:	8a 43 1c 00 	mov	#0,	28(r10)	;r3 As==00, 0x001c

00001e68 <.L10>:
    1e68:	ba f0 db ff 	and	#65499,	6(r10)	;#0xffdb
    1e6c:	06 00 

00001e6e <.Loc.59.1>:
    1e6e:	8a 43 02 00 	mov	#0,	2(r10)	;r3 As==00

00001e72 <.Loc.60.1>:
    1e72:	9a 4a 0a 00 	mov	10(r10),0(r10)	;0x0000a
    1e76:	00 00 

00001e78 <.L9>:
    1e78:	ba d2 06 00 	bis	#8,	6(r10)	;r2 As==11

00001e7c <.L6>:
    1e7c:	8a 93 0a 00 	cmp	#0,	10(r10)	;r3 As==00, 0x000a
    1e80:	0b 20       	jnz	$+24     	;abs 0x1e98

00001e82 <.Loc.71.1>:
    1e82:	1c 4a 06 00 	mov	6(r10),	r12	;
    1e86:	3c f0 80 02 	and	#640,	r12	;#0x0280
    1e8a:	3c 90 00 02 	cmp	#512,	r12	;#0x0200
    1e8e:	04 24       	jz	$+10     	;abs 0x1e98

00001e90 <.Loc.72.1>:
    1e90:	0d 4a       	mov	r10,	r13	;
    1e92:	0c 48       	mov	r8,	r12	;
    1e94:	b0 12 52 23 	call	#9042		;#0x2352

00001e98 <.L12>:
    1e98:	1d 4a 06 00 	mov	6(r10),	r13	;
    1e9c:	0c 4d       	mov	r13,	r12	;
    1e9e:	5c f3       	and.b	#1,	r12	;r3 As==01
    1ea0:	0c 93       	cmp	#0,	r12	;r3 As==00
    1ea2:	15 24       	jz	$+44     	;abs 0x1ece

00001ea4 <.Loc.81.1>:
    1ea4:	8a 43 04 00 	mov	#0,	4(r10)	;r3 As==00

00001ea8 <.Loc.82.1>:
    1ea8:	4c 43       	clr.b	r12		;
    1eaa:	1c 8a 0c 00 	sub	12(r10),r12	;0x0000c
    1eae:	8a 4c 0e 00 	mov	r12,	14(r10)	; 0x000e

00001eb2 <.L14>:
    1eb2:	8a 93 0a 00 	cmp	#0,	10(r10)	;r3 As==00, 0x000a
    1eb6:	13 20       	jnz	$+40     	;abs 0x1ede

00001eb8 <.Loc.87.1>:
    1eb8:	0c 4d       	mov	r13,	r12	;
    1eba:	7c f0 80 00 	and.b	#128,	r12	;#0x0080
    1ebe:	0c 93       	cmp	#0,	r12	;r3 As==00
    1ec0:	b3 27       	jz	$-152    	;abs 0x1e28

00001ec2 <.Loc.90.1>:
    1ec2:	3d d0 40 00 	bis	#64,	r13	;#0x0040
    1ec6:	8a 4d 06 00 	mov	r13,	6(r10)	;
    1eca:	30 40 26 1e 	br	#0x1e26		;

00001ece <.L13>:
    1ece:	2d b3       	bit	#2,	r13	;r3 As==10
    1ed0:	02 20       	jnz	$+6      	;abs 0x1ed6

00001ed2 <.Loc.85.1>:
    1ed2:	1c 4a 0c 00 	mov	12(r10),r12	;0x0000c

00001ed6 <.L15>:
    1ed6:	8a 4c 04 00 	mov	r12,	4(r10)	;
    1eda:	30 40 b2 1e 	br	#0x1eb2		;

00001ede <.L16>:
    1ede:	4c 43       	clr.b	r12		;
    1ee0:	30 40 28 1e 	br	#0x1e28		;

00001ee4 <_close_r>:
    1ee4:	0a 12       	push	r10		;

00001ee6 <.LCFI0>:
    1ee6:	0a 4c       	mov	r12,	r10	;

00001ee8 <.Loc.52.1>:
    1ee8:	82 43 1a 81 	mov	#0,	&0x811a	;r3 As==00

00001eec <.Loc.53.1>:
    1eec:	0c 4d       	mov	r13,	r12	;

00001eee <.LVL1>:
    1eee:	b0 12 7e 2a 	call	#10878		;#0x2a7e

00001ef2 <.LVL2>:
    1ef2:	3c 93       	cmp	#-1,	r12	;r3 As==11
    1ef4:	06 20       	jnz	$+14     	;abs 0x1f02

00001ef6 <.Loc.53.1>:
    1ef6:	1d 42 1a 81 	mov	&0x811a,r13	;0x811a
    1efa:	0d 93       	cmp	#0,	r13	;r3 As==00
    1efc:	02 24       	jz	$+6      	;abs 0x1f02

00001efe <.Loc.54.1>:
    1efe:	8a 4d 00 00 	mov	r13,	0(r10)	;

00001f02 <.L1>:
    1f02:	3a 41       	pop	r10		;

00001f04 <.LVL3>:
    1f04:	30 41       	ret			

00001f06 <_fclose_r>:
    1f06:	0a 12       	push	r10		;

00001f08 <.LCFI0>:
    1f08:	09 12       	push	r9		;

00001f0a <.LCFI1>:
    1f0a:	08 12       	push	r8		;

00001f0c <.LCFI2>:
    1f0c:	09 4c       	mov	r12,	r9	;
    1f0e:	0a 4d       	mov	r13,	r10	;

00001f10 <.Loc.74.1>:
    1f10:	0d 93       	cmp	#0,	r13	;r3 As==00
    1f12:	04 20       	jnz	$+10     	;abs 0x1f1c

00001f14 <.L8>:
    1f14:	48 43       	clr.b	r8		;

00001f16 <.L1>:
    1f16:	0c 48       	mov	r8,	r12	;
    1f18:	30 40 1e 0e 	br	#0x0e1e		;

00001f1c <.L2>:
    1f1c:	0c 93       	cmp	#0,	r12	;r3 As==00
    1f1e:	05 24       	jz	$+12     	;abs 0x1f2a

00001f20 <.Loc.77.1>:
    1f20:	8c 93 0c 00 	cmp	#0,	12(r12)	;r3 As==00, 0x000c
    1f24:	02 20       	jnz	$+6      	;abs 0x1f2a

00001f26 <.Loc.77.1>:
    1f26:	b0 12 20 11 	call	#4384		;#0x1120

00001f2a <.L4>:
    1f2a:	3a 90 8a 31 	cmp	#12682,	r10	;#0x318a
    1f2e:	3f 20       	jnz	$+128    	;abs 0x1fae

00001f30 <.Loc.77.1>:
    1f30:	1a 49 02 00 	mov	2(r9),	r10	;

00001f34 <.L6>:
    1f34:	8a 93 06 00 	cmp	#0,	6(r10)	;r3 As==00
    1f38:	ed 27       	jz	$-36     	;abs 0x1f14

00001f3a <.Loc.104.1>:
    1f3a:	0d 4a       	mov	r10,	r13	;
    1f3c:	0c 49       	mov	r9,	r12	;
    1f3e:	b0 12 ca 1f 	call	#8138		;#0x1fca

00001f42 <.LVL5>:
    1f42:	08 4c       	mov	r12,	r8	;

00001f44 <.LVL6>:
    1f44:	1e 4a 1a 00 	mov	26(r10),r14	;0x0001a
    1f48:	0e 93       	cmp	#0,	r14	;r3 As==00
    1f4a:	07 24       	jz	$+16     	;abs 0x1f5a

00001f4c <.Loc.106.1>:
    1f4c:	1d 4a 12 00 	mov	18(r10),r13	;0x00012
    1f50:	0c 49       	mov	r9,	r12	;
    1f52:	8e 12       	call	r14		;

00001f54 <.LVL7>:
    1f54:	0c 93       	cmp	#0,	r12	;r3 As==00
    1f56:	01 34       	jge	$+4      	;abs 0x1f5a

00001f58 <.Loc.107.1>:
    1f58:	38 43       	mov	#-1,	r8	;r3 As==11

00001f5a <.L9>:
    1f5a:	1c 4a 06 00 	mov	6(r10),	r12	;
    1f5e:	7c f0 80 00 	and.b	#128,	r12	;#0x0080
    1f62:	0c 93       	cmp	#0,	r12	;r3 As==00
    1f64:	05 24       	jz	$+12     	;abs 0x1f70

00001f66 <.Loc.109.1>:
    1f66:	1d 4a 0a 00 	mov	10(r10),r13	;0x0000a
    1f6a:	0c 49       	mov	r9,	r12	;
    1f6c:	b0 12 5c 16 	call	#5724		;#0x165c

00001f70 <.L10>:
    1f70:	1d 4a 1c 00 	mov	28(r10),r13	;0x0001c
    1f74:	0d 93       	cmp	#0,	r13	;r3 As==00
    1f76:	0a 24       	jz	$+22     	;abs 0x1f8c

00001f78 <.Loc.111.1>:
    1f78:	0c 4a       	mov	r10,	r12	;
    1f7a:	3c 50 24 00 	add	#36,	r12	;#0x0024
    1f7e:	0d 9c       	cmp	r12,	r13	;
    1f80:	03 24       	jz	$+8      	;abs 0x1f88

00001f82 <.Loc.111.1>:
    1f82:	0c 49       	mov	r9,	r12	;
    1f84:	b0 12 5c 16 	call	#5724		;#0x165c

00001f88 <.L12>:
    1f88:	8a 43 1c 00 	mov	#0,	28(r10)	;r3 As==00, 0x001c

00001f8c <.L11>:
    1f8c:	1d 4a 28 00 	mov	40(r10),r13	;0x00028
    1f90:	0d 93       	cmp	#0,	r13	;r3 As==00
    1f92:	05 24       	jz	$+12     	;abs 0x1f9e

00001f94 <.Loc.113.1>:
    1f94:	0c 49       	mov	r9,	r12	;
    1f96:	b0 12 5c 16 	call	#5724		;#0x165c

00001f9a <.LVL11>:
    1f9a:	8a 43 28 00 	mov	#0,	40(r10)	;r3 As==00, 0x0028

00001f9e <.L13>:
    1f9e:	b0 12 4a 12 	call	#4682		;#0x124a

00001fa2 <.LVL12>:
    1fa2:	8a 43 06 00 	mov	#0,	6(r10)	;r3 As==00

00001fa6 <.Loc.122.1>:
    1fa6:	b0 12 4c 12 	call	#4684		;#0x124c

00001faa <.LVL13>:
    1faa:	30 40 16 1f 	br	#0x1f16		;

00001fae <.L5>:
    1fae:	3a 90 78 31 	cmp	#12664,	r10	;#0x3178
    1fb2:	04 20       	jnz	$+10     	;abs 0x1fbc

00001fb4 <.Loc.77.1>:
    1fb4:	1a 49 04 00 	mov	4(r9),	r10	;
    1fb8:	30 40 34 1f 	br	#0x1f34		;

00001fbc <.L7>:
    1fbc:	3a 90 66 31 	cmp	#12646,	r10	;#0x3166
    1fc0:	b9 23       	jnz	$-140    	;abs 0x1f34

00001fc2 <.Loc.77.1>:
    1fc2:	1a 49 06 00 	mov	6(r9),	r10	;
    1fc6:	30 40 34 1f 	br	#0x1f34		;

00001fca <__sflush_r>:
    1fca:	0a 12       	push	r10		;

00001fcc <.LCFI0>:
    1fcc:	09 12       	push	r9		;

00001fce <.LCFI1>:
    1fce:	08 12       	push	r8		;

00001fd0 <.LCFI2>:
    1fd0:	07 12       	push	r7		;

00001fd2 <.LCFI3>:
    1fd2:	06 12       	push	r6		;

00001fd4 <.LCFI4>:
    1fd4:	21 83       	decd	r1		;

00001fd6 <.LCFI5>:
    1fd6:	09 4c       	mov	r12,	r9	;
    1fd8:	0a 4d       	mov	r13,	r10	;

00001fda <.Loc.112.1>:
    1fda:	1c 4d 06 00 	mov	6(r13),	r12	;

00001fde <.LVL1>:
    1fde:	08 4c       	mov	r12,	r8	;
    1fe0:	78 f2       	and.b	#8,	r8	;r2 As==11
    1fe2:	08 93       	cmp	#0,	r8	;r3 As==00
    1fe4:	93 20       	jnz	$+296    	;abs 0x210c

00001fe6 <.Loc.119.1>:
    1fe6:	06 4c       	mov	r12,	r6	;
    1fe8:	36 d0 00 08 	bis	#2048,	r6	;#0x0800
    1fec:	8d 46 06 00 	mov	r6,	6(r13)	;

00001ff0 <.Loc.129.1>:
    1ff0:	4d 43       	clr.b	r13		;

00001ff2 <.LVL2>:
    1ff2:	1d 9a 02 00 	cmp	2(r10),	r13	;
    1ff6:	08 38       	jl	$+18     	;abs 0x2008

00001ff8 <.Loc.129.1>:
    1ff8:	1d 9a 22 00 	cmp	34(r10),r13	;0x00022
    1ffc:	05 38       	jl	$+12     	;abs 0x2008

00001ffe <.L5>:
    1ffe:	48 43       	clr.b	r8		;

00002000 <.L1>:
    2000:	0c 48       	mov	r8,	r12	;
    2002:	21 53       	incd	r1		;
    2004:	30 40 1a 0e 	br	#0x0e1a		;

00002008 <.L3>:
    2008:	1b 4a 18 00 	mov	24(r10),r11	;0x00018
    200c:	0b 93       	cmp	#0,	r11	;r3 As==00
    200e:	f7 27       	jz	$-16     	;abs 0x1ffe

00002010 <.LBB2>:
    2010:	27 49       	mov	@r9,	r7	;

00002012 <.LVL5>:
    2012:	89 43 00 00 	mov	#0,	0(r9)	;r3 As==00

00002016 <.Loc.144.1>:
    2016:	3c b0 00 10 	bit	#4096,	r12	;#0x1000
    201a:	5f 24       	jz	$+192    	;abs 0x20da

0000201c <.Loc.145.1>:
    201c:	1c 4a 2e 00 	mov	46(r10),r12	;0x0002e

00002020 <.LVL6>:
    2020:	1d 4a 30 00 	mov	48(r10),r13	;0x00030

00002024 <.L7>:
    2024:	ea b2 06 00 	bit.b	#4,	6(r10)	;r2 As==10
    2028:	15 24       	jz	$+44     	;abs 0x2054

0000202a <.Loc.173.1>:
    202a:	16 4a 02 00 	mov	2(r10),	r6	;
    202e:	0e 46       	mov	r6,	r14	;
    2030:	3e b0 00 80 	bit	#32768,	r14	;#0x8000
    2034:	0f 7f       	subc	r15,	r15	;
    2036:	3f e3       	inv	r15		;
    2038:	0c 8e       	sub	r14,	r12	;
    203a:	0d 7f       	subc	r15,	r13	;

0000203c <.Loc.174.1>:
    203c:	8a 93 1c 00 	cmp	#0,	28(r10)	;r3 As==00, 0x001c
    2040:	09 24       	jz	$+20     	;abs 0x2054

00002042 <.Loc.175.1>:
    2042:	16 4a 22 00 	mov	34(r10),r6	;0x00022
    2046:	0e 46       	mov	r6,	r14	;
    2048:	3e b0 00 80 	bit	#32768,	r14	;#0x8000
    204c:	0f 7f       	subc	r15,	r15	;
    204e:	3f e3       	inv	r15		;
    2050:	0c 8e       	sub	r14,	r12	;
    2052:	0d 7f       	subc	r15,	r13	;

00002054 <.L10>:
    2054:	81 43 00 00 	mov	#0,	0(r1)	;r3 As==00
    2058:	0e 4c       	mov	r12,	r14	;
    205a:	0f 4d       	mov	r13,	r15	;
    205c:	1d 4a 12 00 	mov	18(r10),r13	;0x00012
    2060:	0c 49       	mov	r9,	r12	;

00002062 <.LVL10>:
    2062:	16 4a 18 00 	mov	24(r10),r6	;0x00018
    2066:	86 12       	call	r6		;

00002068 <.LVL11>:
    2068:	3c 93       	cmp	#-1,	r12	;r3 As==11
    206a:	0b 20       	jnz	$+24     	;abs 0x2082
    206c:	3d 93       	cmp	#-1,	r13	;r3 As==11
    206e:	09 20       	jnz	$+20     	;abs 0x2082

00002070 <.Loc.184.1>:
    2070:	2e 49       	mov	@r9,	r14	;
    2072:	0e 93       	cmp	#0,	r14	;r3 As==00
    2074:	06 24       	jz	$+14     	;abs 0x2082

00002076 <.Loc.185.1>:
    2076:	3e 90 1d 00 	cmp	#29,	r14	;#0x001d
    207a:	03 24       	jz	$+8      	;abs 0x2082

0000207c <.Loc.185.1>:
    207c:	3e 90 16 00 	cmp	#22,	r14	;#0x0016
    2080:	62 20       	jnz	$+198    	;abs 0x2146

00002082 <.L11>:
    2082:	1e 4a 06 00 	mov	6(r10),	r14	;
    2086:	0f 4e       	mov	r14,	r15	;
    2088:	3f f0 ff f7 	and	#63487,	r15	;#0xf7ff
    208c:	8a 4f 06 00 	mov	r15,	6(r10)	;

00002090 <.Loc.192.1>:
    2090:	8a 43 02 00 	mov	#0,	2(r10)	;r3 As==00

00002094 <.Loc.193.1>:
    2094:	9a 4a 0a 00 	mov	10(r10),0(r10)	;0x0000a
    2098:	00 00 

0000209a <.Loc.194.1>:
    209a:	3e b0 00 10 	bit	#4096,	r14	;#0x1000
    209e:	0b 24       	jz	$+24     	;abs 0x20b6

000020a0 <.Loc.194.1>:
    20a0:	3c 93       	cmp	#-1,	r12	;r3 As==11
    20a2:	05 20       	jnz	$+12     	;abs 0x20ae
    20a4:	3d 93       	cmp	#-1,	r13	;r3 As==11
    20a6:	03 20       	jnz	$+8      	;abs 0x20ae

000020a8 <.Loc.194.1>:
    20a8:	89 93 00 00 	cmp	#0,	0(r9)	;r3 As==00
    20ac:	04 20       	jnz	$+10     	;abs 0x20b6

000020ae <.L14>:
    20ae:	8a 4c 2e 00 	mov	r12,	46(r10)	; 0x002e
    20b2:	8a 4d 30 00 	mov	r13,	48(r10)	; 0x0030

000020b6 <.L13>:
    20b6:	89 47 00 00 	mov	r7,	0(r9)	;

000020ba <.Loc.197.1>:
    20ba:	1d 4a 1c 00 	mov	28(r10),r13	;0x0001c

000020be <.LVL12>:
    20be:	0d 93       	cmp	#0,	r13	;r3 As==00
    20c0:	9e 27       	jz	$-194    	;abs 0x1ffe

000020c2 <.Loc.198.1>:
    20c2:	0c 4a       	mov	r10,	r12	;
    20c4:	3c 50 24 00 	add	#36,	r12	;#0x0024
    20c8:	0d 9c       	cmp	r12,	r13	;
    20ca:	03 24       	jz	$+8      	;abs 0x20d2

000020cc <.Loc.198.1>:
    20cc:	0c 49       	mov	r9,	r12	;
    20ce:	b0 12 5c 16 	call	#5724		;#0x165c

000020d2 <.L15>:
    20d2:	8a 43 1c 00 	mov	#0,	28(r10)	;r3 As==00, 0x001c
    20d6:	30 40 00 20 	br	#0x2000		;

000020da <.L6>:
    20da:	1d 4a 12 00 	mov	18(r10),r13	;0x00012
    20de:	91 43 00 00 	mov	#1,	0(r1)	;r3 As==01
    20e2:	4e 43       	clr.b	r14		;
    20e4:	4f 43       	clr.b	r15		;
    20e6:	0c 49       	mov	r9,	r12	;

000020e8 <.LVL15>:
    20e8:	8b 12       	call	r11		;

000020ea <.LVL16>:
    20ea:	3c 93       	cmp	#-1,	r12	;r3 As==11
    20ec:	9b 23       	jnz	$-200    	;abs 0x2024
    20ee:	3d 93       	cmp	#-1,	r13	;r3 As==11
    20f0:	99 23       	jnz	$-204    	;abs 0x2024

000020f2 <.Loc.156.1>:
    20f2:	2e 49       	mov	@r9,	r14	;
    20f4:	0e 93       	cmp	#0,	r14	;r3 As==00
    20f6:	96 27       	jz	$-210    	;abs 0x2024

000020f8 <.LBB3>:
    20f8:	3e 90 1d 00 	cmp	#29,	r14	;#0x001d
    20fc:	03 24       	jz	$+8      	;abs 0x2104

000020fe <.Loc.159.1>:
    20fe:	3e 90 16 00 	cmp	#22,	r14	;#0x0016
    2102:	21 20       	jnz	$+68     	;abs 0x2146

00002104 <.L8>:
    2104:	89 47 00 00 	mov	r7,	0(r9)	;
    2108:	30 40 00 20 	br	#0x2000		;

0000210c <.L2>:
    210c:	18 4d 0a 00 	mov	10(r13),r8	;0x0000a

00002110 <.LVL20>:
    2110:	08 93       	cmp	#0,	r8	;r3 As==00
    2112:	75 27       	jz	$-276    	;abs 0x1ffe

00002114 <.Loc.213.1>:
    2114:	27 4d       	mov	@r13,	r7	;
    2116:	07 88       	sub	r8,	r7	;

00002118 <.LVL21>:
    2118:	8d 48 00 00 	mov	r8,	0(r13)	;

0000211c <.Loc.221.1>:
    211c:	3c b0 03 00 	bit	#3,	r12	;
    2120:	18 20       	jnz	$+50     	;abs 0x2152

00002122 <.Loc.221.1>:
    2122:	1c 4d 0c 00 	mov	12(r13),r12	;0x0000c

00002126 <.L16>:
    2126:	8a 4c 04 00 	mov	r12,	4(r10)	;

0000212a <.L17>:
    212a:	4f 43       	clr.b	r15		;
    212c:	0f 97       	cmp	r7,	r15	;
    212e:	67 37       	jge	$-304    	;abs 0x1ffe

00002130 <.Loc.225.1>:
    2130:	0f 47       	mov	r7,	r15	;
    2132:	0e 48       	mov	r8,	r14	;
    2134:	1d 4a 12 00 	mov	18(r10),r13	;0x00012
    2138:	0c 49       	mov	r9,	r12	;
    213a:	16 4a 16 00 	mov	22(r10),r6	;0x00016
    213e:	86 12       	call	r6		;

00002140 <.LVL24>:
    2140:	4d 43       	clr.b	r13		;
    2142:	0d 9c       	cmp	r12,	r13	;
    2144:	09 38       	jl	$+20     	;abs 0x2158

00002146 <.L48>:
    2146:	ba d0 40 00 	bis	#64,	6(r10)	;#0x0040
    214a:	06 00 

0000214c <.Loc.229.1>:
    214c:	38 43       	mov	#-1,	r8	;r3 As==11
    214e:	30 40 00 20 	br	#0x2000		;

00002152 <.L20>:
    2152:	4c 43       	clr.b	r12		;

00002154 <.LVL27>:
    2154:	30 40 26 21 	br	#0x2126		;

00002158 <.L18>:
    2158:	08 5c       	add	r12,	r8	;

0000215a <.Loc.232.1>:
    215a:	07 8c       	sub	r12,	r7	;
    215c:	30 40 2a 21 	br	#0x212a		;

00002160 <_fflush_r>:
    2160:	0a 12       	push	r10		;

00002162 <.LCFI6>:
    2162:	21 83       	decd	r1		;

00002164 <.LCFI7>:
    2164:	0a 4c       	mov	r12,	r10	;

00002166 <.Loc.271.1>:
    2166:	8d 93 0a 00 	cmp	#0,	10(r13)	;r3 As==00, 0x000a
    216a:	04 20       	jnz	$+10     	;abs 0x2174

0000216c <.L56>:
    216c:	4c 43       	clr.b	r12		;

0000216e <.L49>:
    216e:	21 53       	incd	r1		;
    2170:	3a 41       	pop	r10		;

00002172 <.LVL34>:
    2172:	30 41       	ret			

00002174 <.L50>:
    2174:	0c 93       	cmp	#0,	r12	;r3 As==00
    2176:	08 24       	jz	$+18     	;abs 0x2188

00002178 <.Loc.275.1>:
    2178:	8c 93 0c 00 	cmp	#0,	12(r12)	;r3 As==00, 0x000c
    217c:	05 20       	jnz	$+12     	;abs 0x2188

0000217e <.Loc.275.1>:
    217e:	81 4d 00 00 	mov	r13,	0(r1)	;
    2182:	b0 12 20 11 	call	#4384		;#0x1120

00002186 <.LVL36>:
    2186:	2d 41       	mov	@r1,	r13	;

00002188 <.L52>:
    2188:	3d 90 8a 31 	cmp	#12682,	r13	;#0x318a
    218c:	0a 20       	jnz	$+22     	;abs 0x21a2

0000218e <.Loc.275.1>:
    218e:	1d 4a 02 00 	mov	2(r10),	r13	;

00002192 <.L54>:
    2192:	8d 93 06 00 	cmp	#0,	6(r13)	;r3 As==00
    2196:	ea 27       	jz	$-42     	;abs 0x216c

00002198 <.Loc.281.1>:
    2198:	0c 4a       	mov	r10,	r12	;
    219a:	b0 12 ca 1f 	call	#8138		;#0x1fca

0000219e <.LVL38>:
    219e:	30 40 6e 21 	br	#0x216e		;

000021a2 <.L53>:
    21a2:	3d 90 78 31 	cmp	#12664,	r13	;#0x3178
    21a6:	04 20       	jnz	$+10     	;abs 0x21b0

000021a8 <.Loc.275.1>:
    21a8:	1d 4a 04 00 	mov	4(r10),	r13	;

000021ac <.LVL40>:
    21ac:	30 40 92 21 	br	#0x2192		;

000021b0 <.L55>:
    21b0:	3d 90 66 31 	cmp	#12646,	r13	;#0x3166
    21b4:	ee 23       	jnz	$-34     	;abs 0x2192

000021b6 <.Loc.275.1>:
    21b6:	1d 4a 06 00 	mov	6(r10),	r13	;

000021ba <.LVL42>:
    21ba:	30 40 92 21 	br	#0x2192		;

000021be <__fputwc>:
    21be:	0a 12       	push	r10		;

000021c0 <.LCFI0>:
    21c0:	09 12       	push	r9		;

000021c2 <.LCFI1>:
    21c2:	08 12       	push	r8		;

000021c4 <.LCFI2>:
    21c4:	07 12       	push	r7		;

000021c6 <.LCFI3>:
    21c6:	06 12       	push	r6		;

000021c8 <.LCFI4>:
    21c8:	05 12       	push	r5		;

000021ca <.LCFI5>:
    21ca:	21 82       	sub	#4,	r1	;r2 As==10

000021cc <.LCFI6>:
    21cc:	06 4c       	mov	r12,	r6	;
    21ce:	08 4d       	mov	r13,	r8	;
    21d0:	07 4e       	mov	r14,	r7	;
    21d2:	0a 4f       	mov	r15,	r10	;

000021d4 <.Loc.194.1>:
    21d4:	b0 12 ae 22 	call	#8878		;#0x22ae

000021d8 <.LVL1>:
    21d8:	1c 93       	cmp	#1,	r12	;r3 As==01
    21da:	15 20       	jnz	$+44     	;abs 0x2206

000021dc <.Loc.194.1>:
    21dc:	0e 48       	mov	r8,	r14	;
    21de:	3e 53       	add	#-1,	r14	;r3 As==11
    21e0:	0d 47       	mov	r7,	r13	;
    21e2:	3d 63       	addc	#-1,	r13	;r3 As==11
    21e4:	0d 93       	cmp	#0,	r13	;r3 As==00
    21e6:	0f 20       	jnz	$+32     	;abs 0x2206
    21e8:	7d 40 fe 00 	mov.b	#254,	r13	;#0x00fe
    21ec:	0d 9e       	cmp	r14,	r13	;
    21ee:	0b 28       	jnc	$+24     	;abs 0x2206

000021f0 <.Loc.201.1>:
    21f0:	c1 48 03 00 	mov.b	r8,	3(r1)	;

000021f4 <.LVL2>:
    21f4:	09 4c       	mov	r12,	r9	;

000021f6 <.L4>:
    21f6:	47 43       	clr.b	r7		;

000021f8 <.LBB4>:
    21f8:	35 40 e4 1c 	mov	#7396,	r5	;#0x1ce4

000021fc <.L6>:
    21fc:	07 99       	cmp	r9,	r7	;
    21fe:	19 20       	jnz	$+52     	;abs 0x2232

00002200 <.Loc.217.1>:
    2200:	0c 48       	mov	r8,	r12	;
    2202:	30 40 2c 22 	br	#0x222c		;

00002206 <.L2>:
    2206:	0e 4a       	mov	r10,	r14	;
    2208:	3e 50 34 00 	add	#52,	r14	;#0x0034
    220c:	81 4e 00 00 	mov	r14,	0(r1)	;
    2210:	0e 48       	mov	r8,	r14	;
    2212:	0f 47       	mov	r7,	r15	;
    2214:	0d 41       	mov	r1,	r13	;
    2216:	3d 50 03 00 	add	#3,	r13	;
    221a:	0c 46       	mov	r6,	r12	;
    221c:	b0 12 e8 28 	call	#10472		;#0x28e8

00002220 <.LVL6>:
    2220:	09 4c       	mov	r12,	r9	;

00002222 <.LVL7>:
    2222:	3c 93       	cmp	#-1,	r12	;r3 As==11
    2224:	e8 23       	jnz	$-46     	;abs 0x21f6

00002226 <.Loc.208.1>:
    2226:	ba d0 40 00 	bis	#64,	6(r10)	;#0x0040
    222a:	06 00 

0000222c <.L1>:
    222c:	21 52       	add	#4,	r1	;r2 As==10
    222e:	30 40 18 0e 	br	#0x0e18		;

00002232 <.L10>:
    2232:	7c 40 03 00 	mov.b	#3,	r12	;
    2236:	0c 51       	add	r1,	r12	;
    2238:	0c 57       	add	r7,	r12	;
    223a:	6d 4c       	mov.b	@r12,	r13	;

0000223c <.LBB8>:
    223c:	1c 4a 04 00 	mov	4(r10),	r12	;
    2240:	3c 53       	add	#-1,	r12	;r3 As==11
    2242:	8a 4c 04 00 	mov	r12,	4(r10)	;
    2246:	0c 93       	cmp	#0,	r12	;r3 As==00
    2248:	06 34       	jge	$+14     	;abs 0x2256
    224a:	1c 9a 0e 00 	cmp	14(r10),r12	;0x0000e
    224e:	0d 38       	jl	$+28     	;abs 0x226a
    2250:	3d 90 0a 00 	cmp	#10,	r13	;#0x000a
    2254:	0a 24       	jz	$+22     	;abs 0x226a

00002256 <.L7>:
    2256:	2c 4a       	mov	@r10,	r12	;
    2258:	0e 4c       	mov	r12,	r14	;
    225a:	1e 53       	inc	r14		;
    225c:	8a 4e 00 00 	mov	r14,	0(r10)	;
    2260:	cc 4d 00 00 	mov.b	r13,	0(r12)	;

00002264 <.L9>:
    2264:	17 53       	inc	r7		;
    2266:	30 40 fc 21 	br	#0x21fc		;

0000226a <.L8>:
    226a:	0e 4a       	mov	r10,	r14	;
    226c:	0c 46       	mov	r6,	r12	;
    226e:	85 12       	call	r5		;

00002270 <.LBE9>:
    2270:	3c 93       	cmp	#-1,	r12	;r3 As==11
    2272:	f8 23       	jnz	$-14     	;abs 0x2264
    2274:	30 40 2c 22 	br	#0x222c		;

00002278 <_fputwc_r>:
    2278:	0a 12       	push	r10		;

0000227a <.LCFI7>:
    227a:	0a 4d       	mov	r13,	r10	;
    227c:	0b 4e       	mov	r14,	r11	;

0000227e <.Loc.229.1>:
    227e:	1e 4f 06 00 	mov	6(r15),	r14	;
    2282:	3e b0 00 20 	bit	#8192,	r14	;#0x2000
    2286:	0a 20       	jnz	$+22     	;abs 0x229c

00002288 <.Loc.229.1>:
    2288:	3e d0 00 20 	bis	#8192,	r14	;#0x2000
    228c:	8f 4e 06 00 	mov	r14,	6(r15)	;
    2290:	1d 4f 3a 00 	mov	58(r15),r13	;0x0003a

00002294 <.LVL15>:
    2294:	3d d0 00 20 	bis	#8192,	r13	;#0x2000
    2298:	8f 4d 3a 00 	mov	r13,	58(r15)	; 0x003a

0000229c <.L17>:
    229c:	0d 4a       	mov	r10,	r13	;
    229e:	0e 4b       	mov	r11,	r14	;
    22a0:	b0 12 be 21 	call	#8638		;#0x21be

000022a4 <.LVL16>:
    22a4:	3a 41       	pop	r10		;
    22a6:	30 41       	ret			

000022a8 <__locale_charset>:
    22a8:	3c 40 82 80 	mov	#32898,	r12	;#0x8082
    22ac:	30 41       	ret			

000022ae <__locale_mb_cur_max>:
    22ae:	1c 42 a2 80 	mov	&0x80a2,r12	;0x80a2
    22b2:	30 41       	ret			

000022b4 <_lseek_r>:
    22b4:	0a 12       	push	r10		;

000022b6 <.LCFI0>:
    22b6:	0a 4c       	mov	r12,	r10	;
    22b8:	0c 4d       	mov	r13,	r12	;

000022ba <.LVL1>:
    22ba:	0d 4e       	mov	r14,	r13	;

000022bc <.LVL2>:
    22bc:	0e 4f       	mov	r15,	r14	;

000022be <.LVL3>:
    22be:	82 43 1a 81 	mov	#0,	&0x811a	;r3 As==00

000022c2 <.Loc.58.1>:
    22c2:	1f 41 04 00 	mov	4(r1),	r15	;
    22c6:	b0 12 a8 2a 	call	#10920		;#0x2aa8

000022ca <.LVL4>:
    22ca:	3c 93       	cmp	#-1,	r12	;r3 As==11
    22cc:	08 20       	jnz	$+18     	;abs 0x22de
    22ce:	3d 93       	cmp	#-1,	r13	;r3 As==11
    22d0:	06 20       	jnz	$+14     	;abs 0x22de

000022d2 <.Loc.58.1>:
    22d2:	1e 42 1a 81 	mov	&0x811a,r14	;0x811a
    22d6:	0e 93       	cmp	#0,	r14	;r3 As==00
    22d8:	02 24       	jz	$+6      	;abs 0x22de

000022da <.Loc.59.1>:
    22da:	8a 4e 00 00 	mov	r14,	0(r10)	;

000022de <.L1>:
    22de:	3a 41       	pop	r10		;

000022e0 <.LVL5>:
    22e0:	30 41       	ret			

000022e2 <__swhatbuf_r>:
    22e2:	0a 12       	push	r10		;

000022e4 <.LCFI0>:
    22e4:	09 12       	push	r9		;

000022e6 <.LCFI1>:
    22e6:	08 12       	push	r8		;

000022e8 <.LCFI2>:
    22e8:	31 80 3c 00 	sub	#60,	r1	;#0x003c

000022ec <.LCFI3>:
    22ec:	08 4d       	mov	r13,	r8	;
    22ee:	0a 4e       	mov	r14,	r10	;
    22f0:	09 4f       	mov	r15,	r9	;

000022f2 <.Loc.98.1>:
    22f2:	1d 4d 08 00 	mov	8(r13),	r13	;

000022f6 <.LVL2>:
    22f6:	0d 93       	cmp	#0,	r13	;r3 As==00
    22f8:	0d 34       	jge	$+28     	;abs 0x2314

000022fa <.L5>:
    22fa:	89 43 00 00 	mov	#0,	0(r9)	;r3 As==00

000022fe <.Loc.103.1>:
    22fe:	1c 48 06 00 	mov	6(r8),	r12	;
    2302:	7c f0 80 00 	and.b	#128,	r12	;#0x0080
    2306:	0c 93       	cmp	#0,	r12	;r3 As==00
    2308:	1c 20       	jnz	$+58     	;abs 0x2342

0000230a <.Loc.106.1>:
    230a:	ba 40 00 04 	mov	#1024,	0(r10)	;#0x0400
    230e:	00 00 
    2310:	30 40 4a 23 	br	#0x234a		;

00002314 <.L2>:
    2314:	0e 41       	mov	r1,	r14	;
    2316:	b0 12 7e 29 	call	#10622		;#0x297e

0000231a <.LVL5>:
    231a:	0c 93       	cmp	#0,	r12	;r3 As==00
    231c:	ee 3b       	jl	$-34     	;abs 0x22fa

0000231e <.Loc.111.1>:
    231e:	1d 41 04 00 	mov	4(r1),	r13	;
    2322:	3d f0 00 f0 	and	#61440,	r13	;#0xf000
    2326:	5c 43       	mov.b	#1,	r12	;r3 As==01
    2328:	3d 90 00 20 	cmp	#8192,	r13	;#0x2000
    232c:	01 24       	jz	$+4      	;abs 0x2330
    232e:	4c 43       	clr.b	r12		;

00002330 <.L8>:
    2330:	89 4c 00 00 	mov	r12,	0(r9)	;

00002334 <.Loc.125.1>:
    2334:	ba 40 00 04 	mov	#1024,	0(r10)	;#0x0400
    2338:	00 00 

0000233a <.Loc.126.1>:
    233a:	3c 40 00 08 	mov	#2048,	r12	;#0x0800
    233e:	30 40 4a 23 	br	#0x234a		;

00002342 <.L3>:
    2342:	ba 40 40 00 	mov	#64,	0(r10)	;#0x0040
    2346:	00 00 
    2348:	4c 43       	clr.b	r12		;

0000234a <.L1>:
    234a:	31 50 3c 00 	add	#60,	r1	;#0x003c
    234e:	30 40 1e 0e 	br	#0x0e1e		;

00002352 <__smakebuf_r>:
    2352:	0a 12       	push	r10		;

00002354 <.LCFI4>:
    2354:	09 12       	push	r9		;

00002356 <.LCFI5>:
    2356:	08 12       	push	r8		;

00002358 <.LCFI6>:
    2358:	21 82       	sub	#4,	r1	;r2 As==10

0000235a <.LCFI7>:
    235a:	09 4c       	mov	r12,	r9	;
    235c:	0a 4d       	mov	r13,	r10	;

0000235e <.Loc.47.1>:
    235e:	ed b3 06 00 	bit.b	#2,	6(r13)	;r3 As==10
    2362:	0c 24       	jz	$+26     	;abs 0x237c

00002364 <.L23>:
    2364:	0c 4a       	mov	r10,	r12	;
    2366:	3c 50 27 00 	add	#39,	r12	;#0x0027
    236a:	8a 4c 00 00 	mov	r12,	0(r10)	;
    236e:	8a 4c 0a 00 	mov	r12,	10(r10)	; 0x000a

00002372 <.Loc.60.1>:
    2372:	9a 43 0c 00 	mov	#1,	12(r10)	;r3 As==01, 0x000c

00002376 <.L12>:
    2376:	21 52       	add	#4,	r1	;r2 As==10
    2378:	30 40 1e 0e 	br	#0x0e1e		;

0000237c <.L13>:
    237c:	0f 41       	mov	r1,	r15	;
    237e:	2f 53       	incd	r15		;
    2380:	0e 41       	mov	r1,	r14	;
    2382:	b0 12 e2 22 	call	#8930		;#0x22e2

00002386 <.LVL10>:
    2386:	08 4c       	mov	r12,	r8	;

00002388 <.Loc.54.1>:
    2388:	2d 41       	mov	@r1,	r13	;
    238a:	0c 49       	mov	r9,	r12	;
    238c:	b0 12 52 17 	call	#5970		;#0x1752

00002390 <.LVL12>:
    2390:	0c 93       	cmp	#0,	r12	;r3 As==00
    2392:	0a 20       	jnz	$+22     	;abs 0x23a8

00002394 <.Loc.56.1>:
    2394:	1c 4a 06 00 	mov	6(r10),	r12	;

00002398 <.LVL13>:
    2398:	3c b0 00 02 	bit	#512,	r12	;#0x0200
    239c:	ec 23       	jnz	$-38     	;abs 0x2376

0000239e <.Loc.58.1>:
    239e:	2c d3       	bis	#2,	r12	;r3 As==10
    23a0:	8a 4c 06 00 	mov	r12,	6(r10)	;
    23a4:	30 40 64 23 	br	#0x2364		;

000023a8 <.L15>:
    23a8:	b9 40 74 10 	mov	#4212,	20(r9)	;#0x1074, 0x0014
    23ac:	14 00 

000023ae <.Loc.66.1>:
    23ae:	ba d0 80 00 	bis	#128,	6(r10)	;#0x0080
    23b2:	06 00 

000023b4 <.Loc.67.1>:
    23b4:	8a 4c 00 00 	mov	r12,	0(r10)	;
    23b8:	8a 4c 0a 00 	mov	r12,	10(r10)	; 0x000a

000023bc <.Loc.68.1>:
    23bc:	aa 41 0c 00 	mov	@r1,	12(r10)	; 0x000c

000023c0 <.Loc.69.1>:
    23c0:	81 93 02 00 	cmp	#0,	2(r1)	;r3 As==00
    23c4:	09 24       	jz	$+20     	;abs 0x23d8

000023c6 <.Loc.69.1>:
    23c6:	1d 4a 08 00 	mov	8(r10),	r13	;
    23ca:	0c 49       	mov	r9,	r12	;

000023cc <.LVL15>:
    23cc:	b0 12 a2 29 	call	#10658		;#0x29a2

000023d0 <.LVL16>:
    23d0:	0c 93       	cmp	#0,	r12	;r3 As==00
    23d2:	02 24       	jz	$+6      	;abs 0x23d8

000023d4 <.Loc.70.1>:
    23d4:	9a d3 06 00 	bis	#1,	6(r10)	;r3 As==01

000023d8 <.L18>:
    23d8:	8a d8 06 00 	bis	r8,	6(r10)	;
    23dc:	30 40 76 23 	br	#0x2376		;

000023e0 <_malloc_usable_size_r>:
    23e0:	1e 4d fc ff 	mov	-4(r13),r14	;
    23e4:	0c 4e       	mov	r14,	r12	;

000023e6 <.LVL3>:
    23e6:	3c 50 fc ff 	add	#65532,	r12	;#0xfffc

000023ea <.Loc.530.1>:
    23ea:	0e 93       	cmp	#0,	r14	;r3 As==00
    23ec:	02 34       	jge	$+6      	;abs 0x23f2

000023ee <.LVL4>:
    23ee:	0d 5c       	add	r12,	r13	;

000023f0 <.LVL5>:
    23f0:	2c 5d       	add	@r13,	r12	;

000023f2 <.L1>:
    23f2:	30 41       	ret			

000023f4 <_printf_common>:
    23f4:	0a 12       	push	r10		;

000023f6 <.LCFI0>:
    23f6:	09 12       	push	r9		;

000023f8 <.LCFI1>:
    23f8:	08 12       	push	r8		;

000023fa <.LCFI2>:
    23fa:	07 12       	push	r7		;

000023fc <.LCFI3>:
    23fc:	06 12       	push	r6		;

000023fe <.LCFI4>:
    23fe:	05 12       	push	r5		;

00002400 <.LCFI5>:
    2400:	04 12       	push	r4		;

00002402 <.LCFI6>:
    2402:	21 83       	decd	r1		;

00002404 <.LCFI7>:
    2404:	07 4c       	mov	r12,	r7	;
    2406:	0a 4d       	mov	r13,	r10	;
    2408:	08 4e       	mov	r14,	r8	;
    240a:	06 4f       	mov	r15,	r6	;
    240c:	15 41 12 00 	mov	18(r1),	r5	;0x00012

00002410 <.Loc.72.1>:
    2410:	1d 4d 04 00 	mov	4(r13),	r13	;

00002414 <.LVL1>:
    2414:	1c 4a 08 00 	mov	8(r10),	r12	;

00002418 <.LVL2>:
    2418:	0c 9d       	cmp	r13,	r12	;
    241a:	01 34       	jge	$+4      	;abs 0x241e
    241c:	0c 4d       	mov	r13,	r12	;

0000241e <.L2>:
    241e:	88 4c 00 00 	mov	r12,	0(r8)	;

00002422 <.Loc.73.1>:
    2422:	ca 93 37 00 	cmp.b	#0,	55(r10)	;r3 As==00, 0x0037
    2426:	03 24       	jz	$+8      	;abs 0x242e

00002428 <.Loc.74.1>:
    2428:	1c 53       	inc	r12		;
    242a:	88 4c 00 00 	mov	r12,	0(r8)	;

0000242e <.L3>:
    242e:	fa b0 20 00 	bit.b	#32,	0(r10)	;#0x0020
    2432:	00 00 
    2434:	02 24       	jz	$+6      	;abs 0x243a

00002436 <.Loc.77.1>:
    2436:	a8 53 00 00 	incd	0(r8)		;

0000243a <.L4>:
    243a:	29 4a       	mov	@r10,	r9	;
    243c:	79 f0 06 00 	and.b	#6,	r9	;
    2440:	09 93       	cmp	#0,	r9	;r3 As==00
    2442:	0b 20       	jnz	$+24     	;abs 0x245a

00002444 <.LBB2>:
    2444:	0c 4a       	mov	r10,	r12	;
    2446:	3c 50 0d 00 	add	#13,	r12	;#0x000d
    244a:	81 4c 00 00 	mov	r12,	0(r1)	;
    244e:	54 43       	mov.b	#1,	r4	;r3 As==01

00002450 <.L6>:
    2450:	1c 4a 06 00 	mov	6(r10),	r12	;
    2454:	2c 88       	sub	@r8,	r12	;
    2456:	09 9c       	cmp	r12,	r9	;
    2458:	30 38       	jl	$+98     	;abs 0x24ba

0000245a <.L5>:
    245a:	5d 4a 37 00 	mov.b	55(r10),r13	;0x00037
    245e:	0c 43       	clr	r12		;
    2460:	0c 8d       	sub	r13,	r12	;
    2462:	b0 12 9a 0e 	call	#3738		;#0x0e9a

00002466 <.LVL6>:
    2466:	fa b0 20 00 	bit.b	#32,	0(r10)	;#0x0020
    246a:	00 00 
    246c:	34 20       	jnz	$+106    	;abs 0x24d6

0000246e <.L8>:
    246e:	0f 4c       	mov	r12,	r15	;
    2470:	0e 4a       	mov	r10,	r14	;
    2472:	3e 50 37 00 	add	#55,	r14	;#0x0037
    2476:	0d 46       	mov	r6,	r13	;
    2478:	0c 47       	mov	r7,	r12	;

0000247a <.LVL8>:
    247a:	85 12       	call	r5		;

0000247c <.LVL9>:
    247c:	3c 93       	cmp	#-1,	r12	;r3 As==11
    247e:	24 24       	jz	$+74     	;abs 0x24c8

00002480 <.Loc.95.1>:
    2480:	19 4a 06 00 	mov	6(r10),	r9	;
    2484:	2c 48       	mov	@r8,	r12	;

00002486 <.LVL10>:
    2486:	2d 4a       	mov	@r10,	r13	;
    2488:	7d f0 06 00 	and.b	#6,	r13	;
    248c:	2d 92       	cmp	#4,	r13	;r2 As==10
    248e:	03 20       	jnz	$+8      	;abs 0x2496

00002490 <.Loc.95.1>:
    2490:	09 8c       	sub	r12,	r9	;

00002492 <.LVL11>:
    2492:	09 93       	cmp	#0,	r9	;r3 As==00
    2494:	01 34       	jge	$+4      	;abs 0x2498

00002496 <.L18>:
    2496:	49 43       	clr.b	r9		;

00002498 <.L13>:
    2498:	1c 4a 04 00 	mov	4(r10),	r12	;
    249c:	1d 4a 08 00 	mov	8(r10),	r13	;
    24a0:	0d 9c       	cmp	r12,	r13	;
    24a2:	02 34       	jge	$+6      	;abs 0x24a8

000024a4 <.Loc.100.1>:
    24a4:	0c 8d       	sub	r13,	r12	;
    24a6:	09 5c       	add	r12,	r9	;

000024a8 <.L15>:
    24a8:	48 43       	clr.b	r8		;

000024aa <.LVL15>:
    24aa:	3a 50 0e 00 	add	#14,	r10	;#0x000e

000024ae <.LVL16>:
    24ae:	54 43       	mov.b	#1,	r4	;r3 As==01

000024b0 <.L16>:
    24b0:	09 98       	cmp	r8,	r9	;
    24b2:	1f 20       	jnz	$+64     	;abs 0x24f2

000024b4 <.LBE3>:
    24b4:	4c 43       	clr.b	r12		;
    24b6:	30 40 ca 24 	br	#0x24ca		;

000024ba <.L11>:
    24ba:	0f 44       	mov	r4,	r15	;
    24bc:	2e 41       	mov	@r1,	r14	;
    24be:	0d 46       	mov	r6,	r13	;
    24c0:	0c 47       	mov	r7,	r12	;
    24c2:	85 12       	call	r5		;

000024c4 <.LVL19>:
    24c4:	3c 93       	cmp	#-1,	r12	;r3 As==11
    24c6:	04 20       	jnz	$+10     	;abs 0x24d0

000024c8 <.L12>:
    24c8:	3c 43       	mov	#-1,	r12	;r3 As==11

000024ca <.L1>:
    24ca:	21 53       	incd	r1		;
    24cc:	30 40 16 0e 	br	#0x0e16		;

000024d0 <.L9>:
    24d0:	19 53       	inc	r9		;
    24d2:	30 40 50 24 	br	#0x2450		;

000024d6 <.L7>:
    24d6:	0d 4a       	mov	r10,	r13	;
    24d8:	0d 5c       	add	r12,	r13	;
    24da:	fd 40 30 00 	mov.b	#48,	55(r13)	;#0x0030, 0x0037
    24de:	37 00 

000024e0 <.LVL24>:
    24e0:	0d 4c       	mov	r12,	r13	;
    24e2:	1d 53       	inc	r13		;
    24e4:	0d 5a       	add	r10,	r13	;
    24e6:	2c 53       	incd	r12		;

000024e8 <.LVL25>:
    24e8:	dd 4a 39 00 	mov.b	57(r10),55(r13)	;0x00039, 0x0037
    24ec:	37 00 
    24ee:	30 40 6e 24 	br	#0x246e		;

000024f2 <.L17>:
    24f2:	0f 44       	mov	r4,	r15	;
    24f4:	0e 4a       	mov	r10,	r14	;
    24f6:	0d 46       	mov	r6,	r13	;
    24f8:	0c 47       	mov	r7,	r12	;
    24fa:	85 12       	call	r5		;

000024fc <.LVL27>:
    24fc:	3c 93       	cmp	#-1,	r12	;r3 As==11
    24fe:	e4 27       	jz	$-54     	;abs 0x24c8

00002500 <.Loc.102.1>:
    2500:	18 53       	inc	r8		;
    2502:	30 40 b0 24 	br	#0x24b0		;

00002506 <_printf_i>:
    2506:	0a 12       	push	r10		;

00002508 <.LCFI8>:
    2508:	09 12       	push	r9		;

0000250a <.LCFI9>:
    250a:	08 12       	push	r8		;

0000250c <.LCFI10>:
    250c:	07 12       	push	r7		;

0000250e <.LCFI11>:
    250e:	06 12       	push	r6		;

00002510 <.LCFI12>:
    2510:	05 12       	push	r5		;

00002512 <.LCFI13>:
    2512:	04 12       	push	r4		;

00002514 <.LCFI14>:
    2514:	31 80 0e 00 	sub	#14,	r1	;#0x000e

00002518 <.LCFI15>:
    2518:	81 4c 04 00 	mov	r12,	4(r1)	;
    251c:	0a 4d       	mov	r13,	r10	;
    251e:	81 4e 06 00 	mov	r14,	6(r1)	;
    2522:	04 4f       	mov	r15,	r4	;
    2524:	1c 41 1e 00 	mov	30(r1),	r12	;0x0001e

00002528 <.LVL30>:
    2528:	0b 4d       	mov	r13,	r11	;
    252a:	3b 50 37 00 	add	#55,	r11	;#0x0037

0000252e <.LVL31>:
    252e:	5e 4d 0c 00 	mov.b	12(r13),r14	;0x0000c

00002532 <.LVL32>:
    2532:	7e 90 6e 00 	cmp.b	#110,	r14	;#0x006e
    2536:	48 25       	jz	$+658    	;abs 0x27c8
    2538:	79 40 6e 00 	mov.b	#110,	r9	;#0x006e
    253c:	49 9e       	cmp.b	r14,	r9	;
    253e:	3a 28       	jnc	$+118    	;abs 0x25b4
    2540:	7e 90 63 00 	cmp.b	#99,	r14	;#0x0063
    2544:	56 24       	jz	$+174    	;abs 0x25f2
    2546:	7f 40 63 00 	mov.b	#99,	r15	;#0x0063

0000254a <.LVL33>:
    254a:	4f 9e       	cmp.b	r14,	r15	;
    254c:	0c 28       	jnc	$+26     	;abs 0x2566
    254e:	4e 93       	cmp.b	#0,	r14	;r3 As==00
    2550:	50 25       	jz	$+674    	;abs 0x27f2
    2552:	7e 90 58 00 	cmp.b	#88,	r14	;#0x0058
    2556:	cc 24       	jz	$+410    	;abs 0x26f0

00002558 <.L29>:
    2558:	07 4a       	mov	r10,	r7	;
    255a:	37 50 36 00 	add	#54,	r7	;#0x0036

0000255e <.LVL34>:
    255e:	ca 4e 36 00 	mov.b	r14,	54(r10)	; 0x0036
    2562:	30 40 0a 26 	br	#0x260a		;

00002566 <.L33>:
    2566:	7e 90 64 00 	cmp.b	#100,	r14	;#0x0064
    256a:	03 24       	jz	$+8      	;abs 0x2572
    256c:	7e 90 69 00 	cmp.b	#105,	r14	;#0x0069
    2570:	f3 23       	jnz	$-24     	;abs 0x2558

00002572 <.L36>:
    2572:	2e 4a       	mov	@r10,	r14	;
    2574:	2d 4c       	mov	@r12,	r13	;
    2576:	1d 53       	inc	r13		;
    2578:	1d c3       	bic	#1,	r13	;r3 As==01
    257a:	3e b0 80 00 	bit	#128,	r14	;#0x0080
    257e:	49 24       	jz	$+148    	;abs 0x2612
    2580:	0f 4d       	mov	r13,	r15	;
    2582:	2f 52       	add	#4,	r15	;r2 As==10
    2584:	8c 4f 00 00 	mov	r15,	0(r12)	;
    2588:	28 4d       	mov	@r13,	r8	;
    258a:	19 4d 02 00 	mov	2(r13),	r9	;

0000258e <.L44>:
    258e:	09 93       	cmp	#0,	r9	;r3 As==00
    2590:	0b 34       	jge	$+24     	;abs 0x25a8

00002592 <.Loc.132.1>:
    2592:	4c 43       	clr.b	r12		;
    2594:	4d 43       	clr.b	r13		;
    2596:	0e 4c       	mov	r12,	r14	;
    2598:	0f 4d       	mov	r13,	r15	;
    259a:	0e 88       	sub	r8,	r14	;
    259c:	0f 79       	subc	r9,	r15	;
    259e:	08 4e       	mov	r14,	r8	;

000025a0 <.LVL37>:
    25a0:	09 4f       	mov	r15,	r9	;

000025a2 <.LVL38>:
    25a2:	fa 40 2d 00 	mov.b	#45,	55(r10)	;#0x002d, 0x0037
    25a6:	37 00 

000025a8 <.L75>:
    25a8:	35 40 b1 31 	mov	#12721,	r5	;#0x31b1

000025ac <.LBB9>:
    25ac:	76 40 0a 00 	mov.b	#10,	r6	;#0x000a
    25b0:	30 40 6a 26 	br	#0x266a		;

000025b4 <.L31>:
    25b4:	7e 90 73 00 	cmp.b	#115,	r14	;#0x0073
    25b8:	34 25       	jz	$+618    	;abs 0x2822
    25ba:	79 40 73 00 	mov.b	#115,	r9	;#0x0073
    25be:	49 9e       	cmp.b	r14,	r9	;
    25c0:	0b 28       	jnc	$+24     	;abs 0x25d8
    25c2:	7e 90 6f 00 	cmp.b	#111,	r14	;#0x006f
    25c6:	39 24       	jz	$+116    	;abs 0x263a
    25c8:	7e 90 70 00 	cmp.b	#112,	r14	;#0x0070
    25cc:	c5 23       	jnz	$-116    	;abs 0x2558

000025ce <.LBB10>:
    25ce:	ba d0 20 00 	bis	#32,	0(r10)	;#0x0020
    25d2:	00 00 
    25d4:	30 40 e4 25 	br	#0x25e4		;

000025d8 <.L38>:
    25d8:	7e 90 75 00 	cmp.b	#117,	r14	;#0x0075
    25dc:	2e 24       	jz	$+94     	;abs 0x263a
    25de:	7e 90 78 00 	cmp.b	#120,	r14	;#0x0078
    25e2:	ba 23       	jnz	$-138    	;abs 0x2558

000025e4 <.L41>:
    25e4:	fa 40 78 00 	mov.b	#120,	57(r10)	;#0x0078, 0x0039
    25e8:	39 00 

000025ea <.Loc.159.1>:
    25ea:	35 40 c2 31 	mov	#12738,	r5	;#0x31c2
    25ee:	30 40 f8 26 	br	#0x26f8		;

000025f2 <.L32>:
    25f2:	07 4a       	mov	r10,	r7	;
    25f4:	37 50 36 00 	add	#54,	r7	;#0x0036

000025f8 <.LVL42>:
    25f8:	2d 4c       	mov	@r12,	r13	;
    25fa:	1d 53       	inc	r13		;
    25fc:	1d c3       	bic	#1,	r13	;r3 As==01
    25fe:	0e 4d       	mov	r13,	r14	;
    2600:	2e 53       	incd	r14		;
    2602:	8c 4e 00 00 	mov	r14,	0(r12)	;
    2606:	ea 4d 36 00 	mov.b	@r13,	54(r10)	; 0x0036

0000260a <.L117>:
    260a:	9a 43 08 00 	mov	#1,	8(r10)	;r3 As==01
    260e:	30 40 4a 28 	br	#0x284a		;

00002612 <.L43>:
    2612:	3e b0 40 00 	bit	#64,	r14	;#0x0040
    2616:	0b 24       	jz	$+24     	;abs 0x262e

00002618 <.Loc.129.1>:
    2618:	09 4d       	mov	r13,	r9	;
    261a:	29 53       	incd	r9		;
    261c:	8c 49 00 00 	mov	r9,	0(r12)	;

00002620 <.L115>:
    2620:	28 4d       	mov	@r13,	r8	;
    2622:	38 b0 00 80 	bit	#32768,	r8	;#0x8000
    2626:	09 79       	subc	r9,	r9	;
    2628:	39 e3       	inv	r9		;
    262a:	30 40 8e 25 	br	#0x258e		;

0000262e <.L45>:
    262e:	0e 4d       	mov	r13,	r14	;
    2630:	2e 53       	incd	r14		;
    2632:	8c 4e 00 00 	mov	r14,	0(r12)	;
    2636:	30 40 20 26 	br	#0x2620		;

0000263a <.L39>:
    263a:	2f 4a       	mov	@r10,	r15	;
    263c:	07 4f       	mov	r15,	r7	;
    263e:	77 f0 80 00 	and.b	#128,	r7	;#0x0080
    2642:	2d 4c       	mov	@r12,	r13	;
    2644:	07 93       	cmp	#0,	r7	;r3 As==00
    2646:	43 24       	jz	$+136    	;abs 0x26ce
    2648:	1d 53       	inc	r13		;
    264a:	1d c3       	bic	#1,	r13	;r3 As==01
    264c:	0f 4d       	mov	r13,	r15	;
    264e:	2f 52       	add	#4,	r15	;r2 As==10
    2650:	8c 4f 00 00 	mov	r15,	0(r12)	;
    2654:	28 4d       	mov	@r13,	r8	;
    2656:	19 4d 02 00 	mov	2(r13),	r9	;

0000265a <.L50>:
    265a:	35 40 b1 31 	mov	#12721,	r5	;#0x31b1

0000265e <.LBB12>:
    265e:	3e 90 6f 00 	cmp	#111,	r14	;#0x006f
    2662:	85 20       	jnz	$+268    	;abs 0x276e

00002664 <.Loc.140.1>:
    2664:	76 42       	mov.b	#8,	r6	;r2 As==11

00002666 <.L52>:
    2666:	ca 43 37 00 	mov.b	#0,	55(r10)	;r3 As==00, 0x0037

0000266a <.L47>:
    266a:	1c 4a 02 00 	mov	2(r10),	r12	;
    266e:	8a 4c 04 00 	mov	r12,	4(r10)	;
    2672:	0c 93       	cmp	#0,	r12	;r3 As==00
    2674:	1b 39       	jl	$+568    	;abs 0x28ac

00002676 <.Loc.180.1>:
    2676:	aa c2 00 00 	bic	#4,	0(r10)	;r2 As==10

0000267a <.Loc.187.1>:
    267a:	0d 48       	mov	r8,	r13	;
    267c:	0d d9       	bis	r9,	r13	;
    267e:	0d 93       	cmp	#0,	r13	;r3 As==00
    2680:	7a 20       	jnz	$+246    	;abs 0x2776

00002682 <.Loc.187.1>:
    2682:	0c 93       	cmp	#0,	r12	;r3 As==00
    2684:	17 21       	jnz	$+560    	;abs 0x28b4

00002686 <.LBE12>:
    2686:	07 4b       	mov	r11,	r7	;

00002688 <.L61>:
    2688:	36 92       	cmp	#8,	r6	;r2 As==11
    268a:	0b 20       	jnz	$+24     	;abs 0x26a2

0000268c <.Loc.198.1>:
    268c:	da b3 00 00 	bit.b	#1,	0(r10)	;r3 As==01
    2690:	08 24       	jz	$+18     	;abs 0x26a2

00002692 <.Loc.198.1>:
    2692:	9a 9a 02 00 	cmp	2(r10),	8(r10)	;
    2696:	08 00 
    2698:	04 38       	jl	$+10     	;abs 0x26a2

0000269a <.LVL48>:
    269a:	f7 40 30 00 	mov.b	#48,	-1(r7)	;#0x0030, 0xffff
    269e:	ff ff 
    26a0:	37 53       	add	#-1,	r7	;r3 As==11

000026a2 <.L63>:
    26a2:	0b 87       	sub	r7,	r11	;
    26a4:	8a 4b 08 00 	mov	r11,	8(r10)	;

000026a8 <.L64>:
    26a8:	81 44 00 00 	mov	r4,	0(r1)	;
    26ac:	1f 41 06 00 	mov	6(r1),	r15	;
    26b0:	0e 41       	mov	r1,	r14	;
    26b2:	3e 50 0c 00 	add	#12,	r14	;#0x000c
    26b6:	0d 4a       	mov	r10,	r13	;
    26b8:	1c 41 04 00 	mov	4(r1),	r12	;
    26bc:	b0 12 f4 23 	call	#9204		;#0x23f4

000026c0 <.LVL51>:
    26c0:	3c 93       	cmp	#-1,	r12	;r3 As==11
    26c2:	c7 20       	jnz	$+400    	;abs 0x2852

000026c4 <.L70>:
    26c4:	3c 43       	mov	#-1,	r12	;r3 As==11

000026c6 <.L28>:
    26c6:	31 50 0e 00 	add	#14,	r1	;#0x000e
    26ca:	30 40 16 0e 	br	#0x0e16		;

000026ce <.L49>:
    26ce:	7f f0 40 00 	and.b	#64,	r15	;#0x0040
    26d2:	1d 53       	inc	r13		;
    26d4:	1d c3       	bic	#1,	r13	;r3 As==01
    26d6:	09 4d       	mov	r13,	r9	;
    26d8:	29 53       	incd	r9		;
    26da:	8c 49 00 00 	mov	r9,	0(r12)	;
    26de:	28 4d       	mov	@r13,	r8	;
    26e0:	0f 93       	cmp	#0,	r15	;r3 As==00
    26e2:	03 24       	jz	$+8      	;abs 0x26ea

000026e4 <.Loc.139.1>:
    26e4:	09 47       	mov	r7,	r9	;
    26e6:	30 40 5a 26 	br	#0x265a		;

000026ea <.L51>:
    26ea:	09 4f       	mov	r15,	r9	;
    26ec:	30 40 5a 26 	br	#0x265a		;

000026f0 <.L35>:
    26f0:	ca 4e 39 00 	mov.b	r14,	57(r10)	; 0x0039

000026f4 <.LBE14>:
    26f4:	35 40 b1 31 	mov	#12721,	r5	;#0x31b1

000026f8 <.L53>:
    26f8:	2d 4a       	mov	@r10,	r13	;
    26fa:	0f 4d       	mov	r13,	r15	;
    26fc:	7f f0 80 00 	and.b	#128,	r15	;#0x0080
    2700:	29 4c       	mov	@r12,	r9	;
    2702:	0f 93       	cmp	#0,	r15	;r3 As==00
    2704:	1a 24       	jz	$+54     	;abs 0x273a
    2706:	19 53       	inc	r9		;
    2708:	19 c3       	bic	#1,	r9	;r3 As==01
    270a:	0e 49       	mov	r9,	r14	;
    270c:	2e 52       	add	#4,	r14	;r2 As==10
    270e:	8c 4e 00 00 	mov	r14,	0(r12)	;
    2712:	28 49       	mov	@r9,	r8	;
    2714:	19 49 02 00 	mov	2(r9),	r9	;

00002718 <.L55>:
    2718:	1d b3       	bit	#1,	r13	;r3 As==01
    271a:	04 24       	jz	$+10     	;abs 0x2724

0000271c <.Loc.164.1>:
    271c:	3d d0 20 00 	bis	#32,	r13	;#0x0020
    2720:	8a 4d 00 00 	mov	r13,	0(r10)	;

00002724 <.L57>:
    2724:	0c 48       	mov	r8,	r12	;

00002726 <.LVL56>:
    2726:	0c d9       	bis	r9,	r12	;
    2728:	0c 93       	cmp	#0,	r12	;r3 As==00
    272a:	03 20       	jnz	$+8      	;abs 0x2732

0000272c <.Loc.168.1>:
    272c:	ba f0 df ff 	and	#65503,	0(r10)	;#0xffdf
    2730:	00 00 

00002732 <.L77>:
    2732:	76 40 10 00 	mov.b	#16,	r6	;#0x0010
    2736:	30 40 66 26 	br	#0x2666		;

0000273a <.L54>:
    273a:	0e 4d       	mov	r13,	r14	;
    273c:	7e f0 40 00 	and.b	#64,	r14	;#0x0040
    2740:	19 53       	inc	r9		;
    2742:	0e 93       	cmp	#0,	r14	;r3 As==00
    2744:	0a 24       	jz	$+22     	;abs 0x275a

00002746 <.Loc.161.1>:
    2746:	0e 49       	mov	r9,	r14	;
    2748:	1e c3       	bic	#1,	r14	;r3 As==01
    274a:	09 4e       	mov	r14,	r9	;
    274c:	29 53       	incd	r9		;
    274e:	8c 49 00 00 	mov	r9,	0(r12)	;
    2752:	28 4e       	mov	@r14,	r8	;
    2754:	09 4f       	mov	r15,	r9	;
    2756:	30 40 18 27 	br	#0x2718		;

0000275a <.L56>:
    275a:	0f 49       	mov	r9,	r15	;
    275c:	1f c3       	bic	#1,	r15	;r3 As==01
    275e:	09 4f       	mov	r15,	r9	;
    2760:	29 53       	incd	r9		;
    2762:	8c 49 00 00 	mov	r9,	0(r12)	;
    2766:	28 4f       	mov	@r15,	r8	;
    2768:	09 4e       	mov	r14,	r9	;
    276a:	30 40 18 27 	br	#0x2718		;

0000276e <.L76>:
    276e:	76 40 0a 00 	mov.b	#10,	r6	;#0x000a
    2772:	30 40 66 26 	br	#0x2666		;

00002776 <.L59>:
    2776:	07 4b       	mov	r11,	r7	;

00002778 <.Loc.191.1>:
    2778:	0c 46       	mov	r6,	r12	;
    277a:	3c b0 00 80 	bit	#32768,	r12	;#0x8000
    277e:	0d 7d       	subc	r13,	r13	;
    2780:	3d e3       	inv	r13		;
    2782:	81 4c 08 00 	mov	r12,	8(r1)	;
    2786:	81 4d 0a 00 	mov	r13,	10(r1)	; 0x000a

0000278a <.L62>:
    278a:	37 53       	add	#-1,	r7	;r3 As==11
    278c:	1e 41 08 00 	mov	8(r1),	r14	;
    2790:	1f 41 0a 00 	mov	10(r1),	r15	;0x0000a
    2794:	0c 48       	mov	r8,	r12	;
    2796:	0d 49       	mov	r9,	r13	;
    2798:	81 4b 02 00 	mov	r11,	2(r1)	;
    279c:	b0 12 62 2a 	call	#10850		;#0x2a62
    27a0:	0c 55       	add	r5,	r12	;
    27a2:	e7 4c 00 00 	mov.b	@r12,	0(r7)	;

000027a6 <.Loc.192.1>:
    27a6:	1e 41 08 00 	mov	8(r1),	r14	;
    27aa:	1f 41 0a 00 	mov	10(r1),	r15	;0x0000a
    27ae:	0c 48       	mov	r8,	r12	;
    27b0:	0d 49       	mov	r9,	r13	;
    27b2:	b0 12 54 2a 	call	#10836		;#0x2a54
    27b6:	08 4c       	mov	r12,	r8	;

000027b8 <.LVL64>:
    27b8:	09 4d       	mov	r13,	r9	;

000027ba <.LVL65>:
    27ba:	0c dd       	bis	r13,	r12	;
    27bc:	1b 41 02 00 	mov	2(r1),	r11	;
    27c0:	0c 93       	cmp	#0,	r12	;r3 As==00
    27c2:	e3 23       	jnz	$-56     	;abs 0x278a
    27c4:	30 40 88 26 	br	#0x2688		;

000027c8 <.L30>:
    27c8:	2e 4a       	mov	@r10,	r14	;
    27ca:	2d 4c       	mov	@r12,	r13	;
    27cc:	3e b0 80 00 	bit	#128,	r14	;#0x0080
    27d0:	15 24       	jz	$+44     	;abs 0x27fc

000027d2 <.Loc.205.1>:
    27d2:	0e 4d       	mov	r13,	r14	;
    27d4:	2e 53       	incd	r14		;
    27d6:	8c 4e 00 00 	mov	r14,	0(r12)	;
    27da:	2c 4d       	mov	@r13,	r12	;

000027dc <.LVL67>:
    27dc:	1e 4a 0a 00 	mov	10(r10),r14	;0x0000a
    27e0:	0d 4e       	mov	r14,	r13	;
    27e2:	3d b0 00 80 	bit	#32768,	r13	;#0x8000
    27e6:	0e 7e       	subc	r14,	r14	;
    27e8:	3e e3       	inv	r14		;
    27ea:	8c 4d 00 00 	mov	r13,	0(r12)	;
    27ee:	8c 4e 02 00 	mov	r14,	2(r12)	;

000027f2 <.L34>:
    27f2:	8a 43 08 00 	mov	#0,	8(r10)	;r3 As==00

000027f6 <.LBE15>:
    27f6:	07 4b       	mov	r11,	r7	;

000027f8 <.LBB16>:
    27f8:	30 40 a8 26 	br	#0x26a8		;

000027fc <.L65>:
    27fc:	3e b0 40 00 	bit	#64,	r14	;#0x0040
    2800:	0a 24       	jz	$+22     	;abs 0x2816

00002802 <.Loc.207.1>:
    2802:	0f 4d       	mov	r13,	r15	;
    2804:	2f 53       	incd	r15		;
    2806:	8c 4f 00 00 	mov	r15,	0(r12)	;

0000280a <.L116>:
    280a:	2c 4d       	mov	@r13,	r12	;

0000280c <.LVL70>:
    280c:	9c 4a 0a 00 	mov	10(r10),0(r12)	;0x0000a
    2810:	00 00 

00002812 <.LVL71>:
    2812:	30 40 f2 27 	br	#0x27f2		;

00002816 <.L66>:
    2816:	09 4d       	mov	r13,	r9	;
    2818:	29 53       	incd	r9		;
    281a:	8c 49 00 00 	mov	r9,	0(r12)	;
    281e:	30 40 0a 28 	br	#0x280a		;

00002822 <.L37>:
    2822:	2d 4c       	mov	@r12,	r13	;
    2824:	0e 4d       	mov	r13,	r14	;
    2826:	2e 53       	incd	r14		;
    2828:	8c 4e 00 00 	mov	r14,	0(r12)	;
    282c:	27 4d       	mov	@r13,	r7	;

0000282e <.LVL73>:
    282e:	1e 4a 02 00 	mov	2(r10),	r14	;
    2832:	4d 43       	clr.b	r13		;
    2834:	0c 47       	mov	r7,	r12	;

00002836 <.LVL74>:
    2836:	b0 12 dc 15 	call	#5596		;#0x15dc

0000283a <.LVL75>:
    283a:	0c 93       	cmp	#0,	r12	;r3 As==00
    283c:	03 24       	jz	$+8      	;abs 0x2844

0000283e <.Loc.222.1>:
    283e:	0c 87       	sub	r7,	r12	;

00002840 <.LVL76>:
    2840:	8a 4c 02 00 	mov	r12,	2(r10)	;

00002844 <.L67>:
    2844:	9a 4a 02 00 	mov	2(r10),	8(r10)	;
    2848:	08 00 

0000284a <.L42>:
    284a:	ca 43 37 00 	mov.b	#0,	55(r10)	;r3 As==00, 0x0037

0000284e <.Loc.233.1>:
    284e:	30 40 a8 26 	br	#0x26a8		;

00002852 <.L68>:
    2852:	1f 4a 08 00 	mov	8(r10),	r15	;
    2856:	0e 47       	mov	r7,	r14	;
    2858:	1d 41 06 00 	mov	6(r1),	r13	;
    285c:	1c 41 04 00 	mov	4(r1),	r12	;

00002860 <.LVL79>:
    2860:	84 12       	call	r4		;

00002862 <.LVL80>:
    2862:	3c 93       	cmp	#-1,	r12	;r3 As==11
    2864:	2f 27       	jz	$-416    	;abs 0x26c4

00002866 <.Loc.243.1>:
    2866:	ea b3 00 00 	bit.b	#2,	0(r10)	;r3 As==10
    286a:	0b 24       	jz	$+24     	;abs 0x2882
    286c:	49 43       	clr.b	r9		;

0000286e <.LBB17>:
    286e:	08 4a       	mov	r10,	r8	;
    2870:	38 50 0d 00 	add	#13,	r8	;#0x000d
    2874:	57 43       	mov.b	#1,	r7	;r3 As==01

00002876 <.L72>:
    2876:	1c 4a 06 00 	mov	6(r10),	r12	;
    287a:	1c 81 0c 00 	sub	12(r1),	r12	;0x0000c
    287e:	09 9c       	cmp	r12,	r9	;
    2880:	09 38       	jl	$+20     	;abs 0x2894

00002882 <.L71>:
    2882:	1d 41 0c 00 	mov	12(r1),	r13	;0x0000c
    2886:	1c 4a 06 00 	mov	6(r10),	r12	;
    288a:	0c 9d       	cmp	r13,	r12	;
    288c:	1c 37       	jge	$-454    	;abs 0x26c6
    288e:	0c 4d       	mov	r13,	r12	;
    2890:	30 40 c6 26 	br	#0x26c6		;

00002894 <.L74>:
    2894:	0f 47       	mov	r7,	r15	;
    2896:	0e 48       	mov	r8,	r14	;
    2898:	1d 41 06 00 	mov	6(r1),	r13	;
    289c:	1c 41 04 00 	mov	4(r1),	r12	;
    28a0:	84 12       	call	r4		;

000028a2 <.LVL84>:
    28a2:	3c 93       	cmp	#-1,	r12	;r3 As==11
    28a4:	0f 27       	jz	$-480    	;abs 0x26c4

000028a6 <.Loc.244.1>:
    28a6:	19 53       	inc	r9		;
    28a8:	30 40 76 28 	br	#0x2876		;

000028ac <.L58>:
    28ac:	0c 48       	mov	r8,	r12	;
    28ae:	0c d9       	bis	r9,	r12	;
    28b0:	0c 93       	cmp	#0,	r12	;r3 As==00
    28b2:	61 23       	jnz	$-316    	;abs 0x2776

000028b4 <.L60>:
    28b4:	07 4a       	mov	r10,	r7	;
    28b6:	37 50 36 00 	add	#54,	r7	;#0x0036

000028ba <.LVL88>:
    28ba:	ea 45 36 00 	mov.b	@r5,	54(r10)	; 0x0036
    28be:	30 40 88 26 	br	#0x2688		;

000028c2 <_read_r>:
    28c2:	0a 12       	push	r10		;

000028c4 <.LCFI0>:
    28c4:	0a 4c       	mov	r12,	r10	;
    28c6:	0c 4d       	mov	r13,	r12	;

000028c8 <.LVL1>:
    28c8:	0d 4e       	mov	r14,	r13	;

000028ca <.LVL2>:
    28ca:	82 43 1a 81 	mov	#0,	&0x811a	;r3 As==00

000028ce <.Loc.58.1>:
    28ce:	0e 4f       	mov	r15,	r14	;

000028d0 <.LVL3>:
    28d0:	b0 12 8c 2a 	call	#10892		;#0x2a8c

000028d4 <.LVL4>:
    28d4:	3c 93       	cmp	#-1,	r12	;r3 As==11
    28d6:	06 20       	jnz	$+14     	;abs 0x28e4

000028d8 <.Loc.58.1>:
    28d8:	1d 42 1a 81 	mov	&0x811a,r13	;0x811a
    28dc:	0d 93       	cmp	#0,	r13	;r3 As==00
    28de:	02 24       	jz	$+6      	;abs 0x28e4

000028e0 <.Loc.59.1>:
    28e0:	8a 4d 00 00 	mov	r13,	0(r10)	;

000028e4 <.L1>:
    28e4:	3a 41       	pop	r10		;

000028e6 <.LVL5>:
    28e6:	30 41       	ret			

000028e8 <_wcrtomb_r>:
    28e8:	0a 12       	push	r10		;

000028ea <.LCFI0>:
    28ea:	09 12       	push	r9		;

000028ec <.LCFI1>:
    28ec:	08 12       	push	r8		;

000028ee <.LCFI2>:
    28ee:	31 80 14 00 	sub	#20,	r1	;#0x0014

000028f2 <.LCFI3>:
    28f2:	0a 4c       	mov	r12,	r10	;
    28f4:	19 41 1c 00 	mov	28(r1),	r9	;0x0001c

000028f8 <.LVL1>:
    28f8:	18 42 a4 80 	mov	&0x80a4,r8	;0x80a4
    28fc:	3c 40 a8 22 	mov	#8872,	r12	;#0x22a8

00002900 <.LVL2>:
    2900:	0d 93       	cmp	#0,	r13	;r3 As==00
    2902:	17 20       	jnz	$+48     	;abs 0x2932

00002904 <.Loc.28.1>:
    2904:	8c 12       	call	r12		;

00002906 <.LVL3>:
    2906:	81 49 02 00 	mov	r9,	2(r1)	;
    290a:	81 4c 00 00 	mov	r12,	0(r1)	;
    290e:	4e 43       	clr.b	r14		;
    2910:	4f 43       	clr.b	r15		;
    2912:	0d 41       	mov	r1,	r13	;
    2914:	3d 50 0a 00 	add	#10,	r13	;#0x000a

00002918 <.L6>:
    2918:	0c 4a       	mov	r10,	r12	;
    291a:	88 12       	call	r8		;

0000291c <.LVL4>:
    291c:	3c 93       	cmp	#-1,	r12	;r3 As==11
    291e:	05 20       	jnz	$+12     	;abs 0x292a

00002920 <.Loc.34.1>:
    2920:	89 43 00 00 	mov	#0,	0(r9)	;r3 As==00

00002924 <.Loc.35.1>:
    2924:	ba 40 8a 00 	mov	#138,	0(r10)	;#0x008a
    2928:	00 00 

0000292a <.L1>:
    292a:	31 50 14 00 	add	#20,	r1	;#0x0014
    292e:	30 40 1e 0e 	br	#0x0e1e		;

00002932 <.L2>:
    2932:	81 4d 08 00 	mov	r13,	8(r1)	;
    2936:	81 4e 06 00 	mov	r14,	6(r1)	;
    293a:	81 4f 04 00 	mov	r15,	4(r1)	;
    293e:	8c 12       	call	r12		;

00002940 <.LVL6>:
    2940:	81 49 02 00 	mov	r9,	2(r1)	;
    2944:	81 4c 00 00 	mov	r12,	0(r1)	;
    2948:	1e 41 06 00 	mov	6(r1),	r14	;
    294c:	1f 41 04 00 	mov	4(r1),	r15	;
    2950:	1d 41 08 00 	mov	8(r1),	r13	;
    2954:	30 40 18 29 	br	#0x2918		;

00002958 <__ascii_wctomb>:
    2958:	0d 93       	cmp	#0,	r13	;r3 As==00
    295a:	0e 24       	jz	$+30     	;abs 0x2978

0000295c <.Loc.47.1>:
    295c:	7f 40 ff 00 	mov.b	#255,	r15	;#0x00ff
    2960:	0f 9e       	cmp	r14,	r15	;
    2962:	05 2c       	jc	$+12     	;abs 0x296e

00002964 <.Loc.50.1>:
    2964:	bc 40 8a 00 	mov	#138,	0(r12)	;#0x008a
    2968:	00 00 

0000296a <.Loc.51.1>:
    296a:	3c 43       	mov	#-1,	r12	;r3 As==11

0000296c <.L1>:
    296c:	30 41       	ret			

0000296e <.L3>:
    296e:	cd 4e 00 00 	mov.b	r14,	0(r13)	;

00002972 <.Loc.55.1>:
    2972:	5c 43       	mov.b	#1,	r12	;r3 As==01

00002974 <.LVL4>:
    2974:	30 40 6c 29 	br	#0x296c		;

00002978 <.L4>:
    2978:	0c 4d       	mov	r13,	r12	;

0000297a <.LVL6>:
    297a:	30 40 6c 29 	br	#0x296c		;

0000297e <_fstat_r>:
    297e:	0a 12       	push	r10		;

00002980 <.LCFI0>:
    2980:	0a 4c       	mov	r12,	r10	;
    2982:	0c 4d       	mov	r13,	r12	;

00002984 <.LVL1>:
    2984:	82 43 1a 81 	mov	#0,	&0x811a	;r3 As==00

00002988 <.Loc.62.1>:
    2988:	0d 4e       	mov	r14,	r13	;

0000298a <.LVL2>:
    298a:	b0 12 9a 2a 	call	#10906		;#0x2a9a

0000298e <.LVL3>:
    298e:	3c 93       	cmp	#-1,	r12	;r3 As==11
    2990:	06 20       	jnz	$+14     	;abs 0x299e

00002992 <.Loc.62.1>:
    2992:	1d 42 1a 81 	mov	&0x811a,r13	;0x811a
    2996:	0d 93       	cmp	#0,	r13	;r3 As==00
    2998:	02 24       	jz	$+6      	;abs 0x299e

0000299a <.Loc.63.1>:
    299a:	8a 4d 00 00 	mov	r13,	0(r10)	;

0000299e <.L1>:
    299e:	3a 41       	pop	r10		;

000029a0 <.LVL4>:
    29a0:	30 41       	ret			

000029a2 <_isatty_r>:
    29a2:	0a 12       	push	r10		;

000029a4 <.LCFI0>:
    29a4:	0a 4c       	mov	r12,	r10	;

000029a6 <.Loc.57.1>:
    29a6:	82 43 1a 81 	mov	#0,	&0x811a	;r3 As==00

000029aa <.Loc.58.1>:
    29aa:	0c 4d       	mov	r13,	r12	;

000029ac <.LVL1>:
    29ac:	b0 12 74 2a 	call	#10868		;#0x2a74

000029b0 <.LVL2>:
    29b0:	3c 93       	cmp	#-1,	r12	;r3 As==11
    29b2:	06 20       	jnz	$+14     	;abs 0x29c0

000029b4 <.Loc.58.1>:
    29b4:	1d 42 1a 81 	mov	&0x811a,r13	;0x811a
    29b8:	0d 93       	cmp	#0,	r13	;r3 As==00
    29ba:	02 24       	jz	$+6      	;abs 0x29c0

000029bc <.Loc.59.1>:
    29bc:	8a 4d 00 00 	mov	r13,	0(r10)	;

000029c0 <.L1>:
    29c0:	3a 41       	pop	r10		;

000029c2 <.LVL3>:
    29c2:	30 41       	ret			

000029c4 <udivmodsi4>:
    29c4:	0a 12       	push	r10		;

000029c6 <.LCFI0>:
    29c6:	09 12       	push	r9		;

000029c8 <.LCFI1>:
    29c8:	08 12       	push	r8		;

000029ca <.LCFI2>:
    29ca:	07 12       	push	r7		;

000029cc <.LCFI3>:
    29cc:	06 12       	push	r6		;

000029ce <.LCFI4>:
    29ce:	05 12       	push	r5		;

000029d0 <.LCFI5>:
    29d0:	0a 4c       	mov	r12,	r10	;
    29d2:	0b 4d       	mov	r13,	r11	;

000029d4 <.LVL1>:
    29d4:	7d 40 21 00 	mov.b	#33,	r13	;#0x0021

000029d8 <.Loc.35.1>:
    29d8:	58 43       	mov.b	#1,	r8	;r3 As==01
    29da:	49 43       	clr.b	r9		;

000029dc <.Loc.38.1>:
    29dc:	07 4b       	mov	r11,	r7	;

000029de <.L2>:
    29de:	0f 9b       	cmp	r11,	r15	;
    29e0:	11 28       	jnc	$+36     	;abs 0x2a04
    29e2:	07 9f       	cmp	r15,	r7	;
    29e4:	02 20       	jnz	$+6      	;abs 0x29ea
    29e6:	0e 9a       	cmp	r10,	r14	;
    29e8:	0d 28       	jnc	$+28     	;abs 0x2a04

000029ea <.L20>:
    29ea:	4c 43       	clr.b	r12		;

000029ec <.LVL3>:
    29ec:	0d 4c       	mov	r12,	r13	;

000029ee <.L5>:
    29ee:	07 48       	mov	r8,	r7	;
    29f0:	07 d9       	bis	r9,	r7	;
    29f2:	07 93       	cmp	#0,	r7	;r3 As==00
    29f4:	1a 20       	jnz	$+54     	;abs 0x2a2a

000029f6 <.L6>:
    29f6:	81 93 0e 00 	cmp	#0,	14(r1)	;r3 As==00, 0x000e
    29fa:	02 24       	jz	$+6      	;abs 0x2a00
    29fc:	0c 4a       	mov	r10,	r12	;
    29fe:	0d 4b       	mov	r11,	r13	;

00002a00 <.L1>:
    2a00:	30 40 18 0e 	br	#0x0e18		;

00002a04 <.L3>:
    2a04:	3d 53       	add	#-1,	r13	;r3 As==11

00002a06 <.Loc.38.1>:
    2a06:	0d 93       	cmp	#0,	r13	;r3 As==00
    2a08:	22 24       	jz	$+70     	;abs 0x2a4e

00002a0a <.Loc.38.1>:
    2a0a:	0f 93       	cmp	#0,	r15	;r3 As==00
    2a0c:	ee 3b       	jl	$-34     	;abs 0x29ea

00002a0e <.Loc.40.1>:
    2a0e:	05 4e       	mov	r14,	r5	;
    2a10:	06 4f       	mov	r15,	r6	;
    2a12:	05 5e       	add	r14,	r5	;
    2a14:	06 6f       	addc	r15,	r6	;
    2a16:	0e 45       	mov	r5,	r14	;

00002a18 <.LVL7>:
    2a18:	0f 46       	mov	r6,	r15	;

00002a1a <.LVL8>:
    2a1a:	05 48       	mov	r8,	r5	;
    2a1c:	06 49       	mov	r9,	r6	;
    2a1e:	05 58       	add	r8,	r5	;
    2a20:	06 69       	addc	r9,	r6	;
    2a22:	08 45       	mov	r5,	r8	;

00002a24 <.LVL9>:
    2a24:	09 46       	mov	r6,	r9	;

00002a26 <.LVL10>:
    2a26:	30 40 de 29 	br	#0x29de		;

00002a2a <.L12>:
    2a2a:	0b 9f       	cmp	r15,	r11	;
    2a2c:	08 28       	jnc	$+18     	;abs 0x2a3e
    2a2e:	0f 9b       	cmp	r11,	r15	;
    2a30:	02 20       	jnz	$+6      	;abs 0x2a36
    2a32:	0a 9e       	cmp	r14,	r10	;
    2a34:	04 28       	jnc	$+10     	;abs 0x2a3e

00002a36 <.L16>:
    2a36:	0a 8e       	sub	r14,	r10	;
    2a38:	0b 7f       	subc	r15,	r11	;

00002a3a <.Loc.48.1>:
    2a3a:	0c d8       	bis	r8,	r12	;

00002a3c <.LVL13>:
    2a3c:	0d d9       	bis	r9,	r13	;

00002a3e <.L10>:
    2a3e:	12 c3       	clrc			
    2a40:	09 10       	rrc	r9		;
    2a42:	08 10       	rrc	r8		;

00002a44 <.Loc.51.1>:
    2a44:	12 c3       	clrc			
    2a46:	0f 10       	rrc	r15		;
    2a48:	0e 10       	rrc	r14		;
    2a4a:	30 40 ee 29 	br	#0x29ee		;

00002a4e <.L14>:
    2a4e:	0c 4d       	mov	r13,	r12	;

00002a50 <.LVL18>:
    2a50:	30 40 f6 29 	br	#0x29f6		;

00002a54 <__mspabi_divlu>:
    2a54:	21 83       	decd	r1		;

00002a56 <.LCFI19>:
    2a56:	81 43 00 00 	mov	#0,	0(r1)	;r3 As==00
    2a5a:	b0 12 c4 29 	call	#10692		;#0x29c4

00002a5e <.LVL46>:
    2a5e:	21 53       	incd	r1		;
    2a60:	30 41       	ret			

00002a62 <__mspabi_remul>:
    2a62:	21 83       	decd	r1		;

00002a64 <.LCFI20>:
    2a64:	91 43 00 00 	mov	#1,	0(r1)	;r3 As==01
    2a68:	b0 12 c4 29 	call	#10692		;#0x29c4

00002a6c <.LVL48>:
    2a6c:	21 53       	incd	r1		;
    2a6e:	30 41       	ret			

00002a70 <_exit>:
    2a70:	30 40 70 2a 	br	#0x2a70		;

00002a74 <_isatty>:
    2a74:	1c 43       	mov	#1,	r12	;r3 As==01

00002a76 <.Loc.59.1>:
    2a76:	30 41       	ret			

00002a78 <getpid>:
    2a78:	3c 40 2a 00 	mov	#42,	r12	;#0x002a

00002a7c <.Loc.65.1>:
    2a7c:	30 41       	ret			

00002a7e <close>:
    2a7e:	b0 12 e4 2b 	call	#11236		;#0x2be4
    2a82:	bc 40 58 00 	mov	#88,	0(r12)	;#0x0058
    2a86:	00 00 
    2a88:	3c 43       	mov	#-1,	r12	;r3 As==11
    2a8a:	30 41       	ret			

00002a8c <read>:
    2a8c:	b0 12 e4 2b 	call	#11236		;#0x2be4
    2a90:	bc 40 58 00 	mov	#88,	0(r12)	;#0x0058
    2a94:	00 00 
    2a96:	3c 43       	mov	#-1,	r12	;r3 As==11
    2a98:	30 41       	ret			

00002a9a <fstat>:
    2a9a:	b0 12 e4 2b 	call	#11236		;#0x2be4
    2a9e:	bc 40 58 00 	mov	#88,	0(r12)	;#0x0058
    2aa2:	00 00 
    2aa4:	3c 43       	mov	#-1,	r12	;r3 As==11
    2aa6:	30 41       	ret			

00002aa8 <lseek>:
    2aa8:	b0 12 e4 2b 	call	#11236		;#0x2be4
    2aac:	bc 40 58 00 	mov	#88,	0(r12)	;#0x0058
    2ab0:	00 00 
    2ab2:	3c 43       	mov	#-1,	r12	;r3 As==11
    2ab4:	30 41       	ret			

00002ab6 <kill>:
    2ab6:	b0 12 e4 2b 	call	#11236		;#0x2be4
    2aba:	bc 40 58 00 	mov	#88,	0(r12)	;#0x0058
    2abe:	00 00 
    2ac0:	3c 43       	mov	#-1,	r12	;r3 As==11
    2ac2:	30 41       	ret			

00002ac4 <write>:
    2ac4:	0a 12       	push	r10		;

00002ac6 <.LCFI0>:
    2ac6:	09 12       	push	r9		;

00002ac8 <.LCFI1>:
    2ac8:	08 12       	push	r8		;

00002aca <.LCFI2>:
    2aca:	07 12       	push	r7		;

00002acc <.LCFI3>:
    2acc:	06 12       	push	r6		;

00002ace <.LCFI4>:
    2ace:	05 12       	push	r5		;

00002ad0 <.LCFI5>:
    2ad0:	04 12       	push	r4		;

00002ad2 <.LCFI6>:
    2ad2:	21 83       	decd	r1		;

00002ad4 <.LCFI7>:
    2ad4:	81 4c 00 00 	mov	r12,	0(r1)	;
    2ad8:	0a 4d       	mov	r13,	r10	;
    2ada:	04 4e       	mov	r14,	r4	;

00002adc <.LBB5>:
    2adc:	b0 12 92 2c 	call	#11410		;#0x2c92

00002ae0 <.LVL2>:
    2ae0:	49 4c       	mov.b	r12,	r9	;

00002ae2 <.LBE5>:
    2ae2:	4c 43       	clr.b	r12		;

00002ae4 <.LBB14>:
    2ae4:	77 40 40 00 	mov.b	#64,	r7	;#0x0040

00002ae8 <.LBB11>:
    2ae8:	35 40 a8 80 	mov	#32936,	r5	;#0x80a8

00002aec <.Loc.28.1>:
    2aec:	06 45       	mov	r5,	r6	;
    2aee:	36 50 0b 00 	add	#11,	r6	;#0x000b

00002af2 <.L2>:
    2af2:	4d 43       	clr.b	r13		;
    2af4:	0d 94       	cmp	r4,	r13	;
    2af6:	03 38       	jl	$+8      	;abs 0x2afe

00002af8 <.Loc.59.1>:
    2af8:	21 53       	incd	r1		;

00002afa <.LVL4>:
    2afa:	30 40 16 0e 	br	#0x0e16		;

00002afe <.L4>:
    2afe:	08 44       	mov	r4,	r8	;
    2b00:	7c 40 40 00 	mov.b	#64,	r12	;#0x0040

00002b04 <.LVL6>:
    2b04:	0c 94       	cmp	r4,	r12	;
    2b06:	01 34       	jge	$+4      	;abs 0x2b0a
    2b08:	08 47       	mov	r7,	r8	;

00002b0a <.L3>:
    2b0a:	4c 48       	mov.b	r8,	r12	;
    2b0c:	c5 4c 00 00 	mov.b	r12,	0(r5)	;

00002b10 <.Loc.22.1>:
    2b10:	c2 43 a9 80 	mov.b	#0,	&0x80a9	;r3 As==00

00002b14 <.Loc.23.1>:
    2b14:	f2 40 f3 ff 	mov.b	#65523,	&0x80aa	;#0xfff3
    2b18:	aa 80 

00002b1a <.Loc.24.1>:
    2b1a:	2d 41       	mov	@r1,	r13	;
    2b1c:	c5 4d 03 00 	mov.b	r13,	3(r5)	;

00002b20 <.Loc.25.1>:
    2b20:	c5 49 04 00 	mov.b	r9,	4(r5)	;

00002b24 <.Loc.26.1>:
    2b24:	c5 4c 05 00 	mov.b	r12,	5(r5)	;

00002b28 <.Loc.27.1>:
    2b28:	c2 43 ae 80 	mov.b	#0,	&0x80ae	;r3 As==00

00002b2c <.Loc.28.1>:
    2b2c:	0e 48       	mov	r8,	r14	;
    2b2e:	0d 4a       	mov	r10,	r13	;
    2b30:	0c 46       	mov	r6,	r12	;
    2b32:	b0 12 f6 15 	call	#5622		;#0x15f6

00002b36 <.LVL8>:
    2b36:	b0 12 8c 2b 	call	#11148		;#0x2b8c

00002b3a <.LBE12>:
    2b3a:	04 88       	sub	r8,	r4	;

00002b3c <.Loc.56.1>:
    2b3c:	0a 58       	add	r8,	r10	;

00002b3e <.LBB13>:
    2b3e:	5c 45 03 00 	mov.b	3(r5),	r12	;
    2b42:	0c 5c       	rla	r12		;
    2b44:	0c 5c       	rla	r12		;
    2b46:	0c 5c       	rla	r12		;
    2b48:	0c 5c       	rla	r12		;
    2b4a:	0c 5c       	rla	r12		;
    2b4c:	0c 5c       	rla	r12		;
    2b4e:	0c 5c       	rla	r12		;
    2b50:	0c 5c       	rla	r12		;
    2b52:	5d 45 02 00 	mov.b	2(r5),	r13	;
    2b56:	0c 5d       	add	r13,	r12	;
    2b58:	30 40 f2 2a 	br	#0x2af2		;

00002b5c <_sbrk>:
    2b5c:	21 83       	decd	r1		;

00002b5e <.LCFI0>:
    2b5e:	1d 42 a6 80 	mov	&0x80a6,r13	;0x80a6

00002b62 <.LVL1>:
    2b62:	4e 43       	clr.b	r14		;
    2b64:	0e 51       	add	r1,	r14	;
    2b66:	81 4e 00 00 	mov	r14,	0(r1)	;

00002b6a <.Loc.22.1>:
    2b6a:	0c 5d       	add	r13,	r12	;

00002b6c <.LVL2>:
    2b6c:	01 9c       	cmp	r12,	r1	;
    2b6e:	09 2c       	jc	$+20     	;abs 0x2b82

00002b70 <.LBB7>:
    2b70:	7e 40 1a 00 	mov.b	#26,	r14	;#0x001a
    2b74:	3d 40 d3 31 	mov	#12755,	r13	;#0x31d3

00002b78 <.LVL4>:
    2b78:	5c 43       	mov.b	#1,	r12	;r3 As==01
    2b7a:	b0 12 c4 2a 	call	#10948		;#0x2ac4

00002b7e <.LVL5>:
    2b7e:	b0 12 d6 2b 	call	#11222		;#0x2bd6

00002b82 <.L2>:
    2b82:	82 4c a6 80 	mov	r12,	&0x80a6	;

00002b86 <.Loc.31.1>:
    2b86:	0c 4d       	mov	r13,	r12	;
    2b88:	21 53       	incd	r1		;
    2b8a:	30 41       	ret			

00002b8c <C$$IO$$>:
    2b8c:	03 43       	nop			

00002b8e <.Loc.33.1>:
    2b8e:	30 41       	ret			

00002b90 <__mspabi_mpyi>:
    2b90:	0d 93       	cmp	#0,	r13	;r3 As==00
    2b92:	0d 34       	jge	$+28     	;abs 0x2bae

00002b94 <.Loc.13.2>:
    2b94:	4e 43       	clr.b	r14		;
    2b96:	0e 8d       	sub	r13,	r14	;
    2b98:	0d 4e       	mov	r14,	r13	;

00002b9a <.LVL11>:
    2b9a:	5b 43       	mov.b	#1,	r11	;r3 As==01

00002b9c <.L12>:
    2b9c:	7f 40 11 00 	mov.b	#17,	r15	;#0x0011

00002ba0 <.Loc.9.2>:
    2ba0:	4e 43       	clr.b	r14		;

00002ba2 <.L13>:
    2ba2:	0d 93       	cmp	#0,	r13	;r3 As==00
    2ba4:	07 20       	jnz	$+16     	;abs 0x2bb4

00002ba6 <.L19>:
    2ba6:	0b 93       	cmp	#0,	r11	;r3 As==00
    2ba8:	11 20       	jnz	$+36     	;abs 0x2bcc

00002baa <.L11>:
    2baa:	0c 4e       	mov	r14,	r12	;
    2bac:	30 41       	ret			

00002bae <.L20>:
    2bae:	4b 43       	clr.b	r11		;
    2bb0:	30 40 9c 2b 	br	#0x2b9c		;

00002bb4 <.L15>:
    2bb4:	7f 53       	add.b	#-1,	r15	;r3 As==11

00002bb6 <.LVL18>:
    2bb6:	3f f0 ff 00 	and	#255,	r15	;#0x00ff

00002bba <.Loc.17.2>:
    2bba:	0f 93       	cmp	#0,	r15	;r3 As==00
    2bbc:	f4 27       	jz	$-22     	;abs 0x2ba6

00002bbe <.Loc.19.2>:
    2bbe:	1d b3       	bit	#1,	r13	;r3 As==01
    2bc0:	01 24       	jz	$+4      	;abs 0x2bc4

00002bc2 <.Loc.20.2>:
    2bc2:	0e 5c       	add	r12,	r14	;

00002bc4 <.L14>:
    2bc4:	0c 5c       	rla	r12		;

00002bc6 <.Loc.22.2>:
    2bc6:	0d 11       	rra	r13		;
    2bc8:	30 40 a2 2b 	br	#0x2ba2		;

00002bcc <.L16>:
    2bcc:	4c 43       	clr.b	r12		;

00002bce <.LVL22>:
    2bce:	0c 8e       	sub	r14,	r12	;
    2bd0:	0e 4c       	mov	r12,	r14	;

00002bd2 <.LVL23>:
    2bd2:	30 40 aa 2b 	br	#0x2baa		;

00002bd6 <abort>:
    2bd6:	7c 40 06 00 	mov.b	#6,	r12	;
    2bda:	b0 12 4e 2c 	call	#11342		;#0x2c4e

00002bde <.LVL0>:
    2bde:	5c 43       	mov.b	#1,	r12	;r3 As==01
    2be0:	b0 12 70 2a 	call	#10864		;#0x2a70

00002be4 <__errno>:
    2be4:	1c 42 08 80 	mov	&0x8008,r12	;0x8008
    2be8:	30 41       	ret			

00002bea <_raise_r>:
    2bea:	0a 12       	push	r10		;

00002bec <.LCFI4>:
    2bec:	09 12       	push	r9		;

00002bee <.LCFI5>:
    2bee:	09 4c       	mov	r12,	r9	;
    2bf0:	0a 4d       	mov	r13,	r10	;

00002bf2 <.Loc.151.1>:
    2bf2:	7c 40 1f 00 	mov.b	#31,	r12	;#0x001f

00002bf6 <.LVL15>:
    2bf6:	0c 9d       	cmp	r13,	r12	;
    2bf8:	06 2c       	jc	$+14     	;abs 0x2c06

00002bfa <.Loc.153.1>:
    2bfa:	b9 40 16 00 	mov	#22,	0(r9)	;#0x0016
    2bfe:	00 00 

00002c00 <.Loc.154.1>:
    2c00:	3c 43       	mov	#-1,	r12	;r3 As==11

00002c02 <.L17>:
    2c02:	30 40 20 0e 	br	#0x0e20		;

00002c06 <.L18>:
    2c06:	1c 49 22 00 	mov	34(r9),	r12	;0x00022
    2c0a:	0c 93       	cmp	#0,	r12	;r3 As==00
    2c0c:	05 24       	jz	$+12     	;abs 0x2c18

00002c0e <.Loc.160.1>:
    2c0e:	0d 5d       	rla	r13		;
    2c10:	0c 5d       	add	r13,	r12	;
    2c12:	2d 4c       	mov	@r12,	r13	;

00002c14 <.LVL17>:
    2c14:	0d 93       	cmp	#0,	r13	;r3 As==00
    2c16:	0a 20       	jnz	$+22     	;abs 0x2c2c

00002c18 <.L20>:
    2c18:	0c 49       	mov	r9,	r12	;
    2c1a:	b0 12 7e 2c 	call	#11390		;#0x2c7e

00002c1e <.LVL19>:
    2c1e:	0e 4a       	mov	r10,	r14	;
    2c20:	0d 4c       	mov	r12,	r13	;
    2c22:	0c 49       	mov	r9,	r12	;
    2c24:	b0 12 5a 2c 	call	#11354		;#0x2c5a

00002c28 <.LVL20>:
    2c28:	30 40 02 2c 	br	#0x2c02		;

00002c2c <.L21>:
    2c2c:	1d 93       	cmp	#1,	r13	;r3 As==01
    2c2e:	0c 24       	jz	$+26     	;abs 0x2c48

00002c30 <.Loc.166.1>:
    2c30:	3d 93       	cmp	#-1,	r13	;r3 As==11
    2c32:	06 20       	jnz	$+14     	;abs 0x2c40

00002c34 <.Loc.168.1>:
    2c34:	b9 40 16 00 	mov	#22,	0(r9)	;#0x0016
    2c38:	00 00 

00002c3a <.Loc.169.1>:
    2c3a:	5c 43       	mov.b	#1,	r12	;r3 As==01
    2c3c:	30 40 02 2c 	br	#0x2c02		;

00002c40 <.L22>:
    2c40:	8c 43 00 00 	mov	#0,	0(r12)	;r3 As==00

00002c44 <.Loc.174.1>:
    2c44:	0c 4a       	mov	r10,	r12	;
    2c46:	8d 12       	call	r13		;

00002c48 <.L23>:
    2c48:	4c 43       	clr.b	r12		;
    2c4a:	30 40 02 2c 	br	#0x2c02		;

00002c4e <raise>:
    2c4e:	0d 4c       	mov	r12,	r13	;
    2c50:	1c 42 08 80 	mov	&0x8008,r12	;0x8008

00002c54 <.LVL33>:
    2c54:	b0 12 ea 2b 	call	#11242		;#0x2bea

00002c58 <.LVL34>:
    2c58:	30 41       	ret			

00002c5a <_kill_r>:
    2c5a:	0a 12       	push	r10		;

00002c5c <.LCFI0>:
    2c5c:	0a 4c       	mov	r12,	r10	;
    2c5e:	0c 4d       	mov	r13,	r12	;

00002c60 <.LVL1>:
    2c60:	82 43 1a 81 	mov	#0,	&0x811a	;r3 As==00

00002c64 <.Loc.61.1>:
    2c64:	0d 4e       	mov	r14,	r13	;

00002c66 <.LVL2>:
    2c66:	b0 12 b6 2a 	call	#10934		;#0x2ab6

00002c6a <.LVL3>:
    2c6a:	3c 93       	cmp	#-1,	r12	;r3 As==11
    2c6c:	06 20       	jnz	$+14     	;abs 0x2c7a

00002c6e <.Loc.61.1>:
    2c6e:	1d 42 1a 81 	mov	&0x811a,r13	;0x811a
    2c72:	0d 93       	cmp	#0,	r13	;r3 As==00
    2c74:	02 24       	jz	$+6      	;abs 0x2c7a

00002c76 <.Loc.62.1>:
    2c76:	8a 4d 00 00 	mov	r13,	0(r10)	;

00002c7a <.L1>:
    2c7a:	3a 41       	pop	r10		;

00002c7c <.LVL4>:
    2c7c:	30 41       	ret			

00002c7e <_getpid_r>:
    2c7e:	b0 12 78 2a 	call	#10872		;#0x2a78

00002c82 <.LVL6>:
    2c82:	30 41       	ret			

00002c84 <__mspabi_srai_15>:
    2c84:	0c 11       	rra	r12		;

00002c86 <__mspabi_srai_14>:
    2c86:	0c 11       	rra	r12		;

00002c88 <__mspabi_srai_13>:
    2c88:	0c 11       	rra	r12		;

00002c8a <__mspabi_srai_12>:
    2c8a:	0c 11       	rra	r12		;

00002c8c <__mspabi_srai_11>:
    2c8c:	0c 11       	rra	r12		;

00002c8e <__mspabi_srai_10>:
    2c8e:	0c 11       	rra	r12		;

00002c90 <__mspabi_srai_9>:
    2c90:	0c 11       	rra	r12		;

00002c92 <__mspabi_srai_8>:
    2c92:	0c 11       	rra	r12		;

00002c94 <__mspabi_srai_7>:
    2c94:	0c 11       	rra	r12		;

00002c96 <__mspabi_srai_6>:
    2c96:	0c 11       	rra	r12		;

00002c98 <__mspabi_srai_5>:
    2c98:	0c 11       	rra	r12		;

00002c9a <__mspabi_srai_4>:
    2c9a:	0c 11       	rra	r12		;

00002c9c <__mspabi_srai_3>:
    2c9c:	0c 11       	rra	r12		;

00002c9e <__mspabi_srai_2>:
    2c9e:	0c 11       	rra	r12		;

00002ca0 <__mspabi_srai_1>:
    2ca0:	0c 11       	rra	r12		;
    2ca2:	30 41       	ret			

00002ca4 <.L11>:
    2ca4:	3d 53       	add	#-1,	r13	;r3 As==11
    2ca6:	0c 11       	rra	r12		;

00002ca8 <__mspabi_srai>:
    2ca8:	0d 93       	cmp	#0,	r13	;r3 As==00
    2caa:	fc 23       	jnz	$-6      	;abs 0x2ca4
    2cac:	30 41       	ret			

00002cae <__mspabi_sral_15>:
    2cae:	0d 11       	rra	r13		;
    2cb0:	0c 10       	rrc	r12		;

00002cb2 <__mspabi_sral_14>:
    2cb2:	0d 11       	rra	r13		;
    2cb4:	0c 10       	rrc	r12		;

00002cb6 <__mspabi_sral_13>:
    2cb6:	0d 11       	rra	r13		;
    2cb8:	0c 10       	rrc	r12		;

00002cba <__mspabi_sral_12>:
    2cba:	0d 11       	rra	r13		;
    2cbc:	0c 10       	rrc	r12		;

00002cbe <__mspabi_sral_11>:
    2cbe:	0d 11       	rra	r13		;
    2cc0:	0c 10       	rrc	r12		;

00002cc2 <__mspabi_sral_10>:
    2cc2:	0d 11       	rra	r13		;
    2cc4:	0c 10       	rrc	r12		;

00002cc6 <__mspabi_sral_9>:
    2cc6:	0d 11       	rra	r13		;
    2cc8:	0c 10       	rrc	r12		;

00002cca <__mspabi_sral_8>:
    2cca:	0d 11       	rra	r13		;
    2ccc:	0c 10       	rrc	r12		;

00002cce <__mspabi_sral_7>:
    2cce:	0d 11       	rra	r13		;
    2cd0:	0c 10       	rrc	r12		;

00002cd2 <__mspabi_sral_6>:
    2cd2:	0d 11       	rra	r13		;
    2cd4:	0c 10       	rrc	r12		;

00002cd6 <__mspabi_sral_5>:
    2cd6:	0d 11       	rra	r13		;
    2cd8:	0c 10       	rrc	r12		;

00002cda <__mspabi_sral_4>:
    2cda:	0d 11       	rra	r13		;
    2cdc:	0c 10       	rrc	r12		;

00002cde <__mspabi_sral_3>:
    2cde:	0d 11       	rra	r13		;
    2ce0:	0c 10       	rrc	r12		;

00002ce2 <__mspabi_sral_2>:
    2ce2:	0d 11       	rra	r13		;
    2ce4:	0c 10       	rrc	r12		;

00002ce6 <__mspabi_sral_1>:
    2ce6:	0d 11       	rra	r13		;
    2ce8:	0c 10       	rrc	r12		;
    2cea:	30 41       	ret			

00002cec <.L12>:
    2cec:	3e 53       	add	#-1,	r14	;r3 As==11
    2cee:	0d 11       	rra	r13		;
    2cf0:	0c 10       	rrc	r12		;

00002cf2 <__mspabi_sral>:
    2cf2:	0e 93       	cmp	#0,	r14	;r3 As==00
    2cf4:	fb 23       	jnz	$-8      	;abs 0x2cec
    2cf6:	30 41       	ret			

Disassembly of section .rodata:

00002cf8 <__sf_fake_stderr-0x46e>:
    2cf8:	08 20       	jnz	$+18     	;abs 0x2d0a
    2cfa:	08 00       	mova	@r0,	r8	;
    2cfc:	0a 2d       	jc	$+534    	;abs 0x2f12
    2cfe:	2d 2d       	jc	$+604    	;abs 0x2f5a
    2d00:	2d 2d       	jc	$+604    	;abs 0x2f5c
    2d02:	2d 2d       	jc	$+604    	;abs 0x2f5e
    2d04:	2d 2d       	jc	$+604    	;abs 0x2f60
    2d06:	2d 2d       	jc	$+604    	;abs 0x2f62
    2d08:	2d 2d       	jc	$+604    	;abs 0x2f64
    2d0a:	2d 2d       	jc	$+604    	;abs 0x2f66
    2d0c:	2d 2d       	jc	$+604    	;abs 0x2f68
    2d0e:	2d 2d       	jc	$+604    	;abs 0x2f6a
    2d10:	2d 2d       	jc	$+604    	;abs 0x2f6c
    2d12:	2d 2d       	jc	$+604    	;abs 0x2f6e
    2d14:	2d 2d       	jc	$+604    	;abs 0x2f70
    2d16:	2d 2d       	jc	$+604    	;abs 0x2f72
    2d18:	2d 2d       	jc	$+604    	;abs 0x2f74
    2d1a:	2d 2d       	jc	$+604    	;abs 0x2f76
    2d1c:	2d 2d       	jc	$+604    	;abs 0x2f78
    2d1e:	2d 2d       	jc	$+604    	;abs 0x2f7a
    2d20:	2d 2d       	jc	$+604    	;abs 0x2f7c
    2d22:	2d 0a 2d 2d 	mova	&666925,r13	;0xa2d2d
    2d26:	2d 20       	jnz	$+92     	;abs 0x2d82
    2d28:	49 32       	jn	$-876    	;abs 0x29bc
    2d2a:	43 20       	jnz	$+136    	;abs 0x2db2
    2d2c:	57 69 73 68 	addc.b	26739(r9),r7	;0x06873
    2d30:	62 6f       	addc.b	@r15,	r2	;
    2d32:	6e 65       	addc.b	@r5,	r14	;
    2d34:	20 45       	br	@r5		;
    2d36:	78 70 6c 6f 	subc.b	#28524,	r8	;#0x6f6c
    2d3a:	72 65       	addc.b	@r5+,	r2	;
    2d3c:	72 20       	jnz	$+230    	;abs 0x2e22
    2d3e:	54 65 72 6d 	addc.b	28018(r5),r4	;0x06d72
    2d42:	69 6e       	addc.b	@r14,	r9	;
    2d44:	61 6c       	addc.b	@r12,	r1	;
    2d46:	20 2d       	jc	$+578    	;abs 0x2f88
    2d48:	2d 0a 2d 2d 	mova	&666925,r13	;0xa2d2d
    2d4c:	2d 2d       	jc	$+604    	;abs 0x2fa8
    2d4e:	2d 2d       	jc	$+604    	;abs 0x2faa
    2d50:	2d 2d       	jc	$+604    	;abs 0x2fac
    2d52:	2d 2d       	jc	$+604    	;abs 0x2fae
    2d54:	2d 2d       	jc	$+604    	;abs 0x2fb0
    2d56:	2d 2d       	jc	$+604    	;abs 0x2fb2
    2d58:	2d 2d       	jc	$+604    	;abs 0x2fb4
    2d5a:	2d 2d       	jc	$+604    	;abs 0x2fb6
    2d5c:	2d 2d       	jc	$+604    	;abs 0x2fb8
    2d5e:	2d 2d       	jc	$+604    	;abs 0x2fba
    2d60:	2d 2d       	jc	$+604    	;abs 0x2fbc
    2d62:	2d 2d       	jc	$+604    	;abs 0x2fbe
    2d64:	2d 2d       	jc	$+604    	;abs 0x2fc0
    2d66:	2d 2d       	jc	$+604    	;abs 0x2fc2
    2d68:	2d 2d       	jc	$+604    	;abs 0x2fc4
    2d6a:	2d 2d       	jc	$+604    	;abs 0x2fc6
    2d6c:	2d 2d       	jc	$+604    	;abs 0x2fc8
    2d6e:	2d 2d       	jc	$+604    	;abs 0x2fca
    2d70:	0a 0a       	mova	@r10,	r10	;
    2d72:	00 45       	br	r5		;
    2d74:	72 72       	subc.b	#8,	r2	;r2 As==11
    2d76:	6f 72       	subc.b	#4,	r15	;r2 As==10
    2d78:	21 20       	jnz	$+68     	;abs 0x2dbc
    2d7a:	4e 6f       	addc.b	r15,	r14	;
    2d7c:	20 57       	add	@r7,	r0	;
    2d7e:	69 73       	subc.b	#2,	r9	;r3 As==10
    2d80:	68 62       	addc.b	#4,	r8	;r2 As==10
    2d82:	6f 6e       	addc.b	@r14,	r15	;
    2d84:	65 20       	jnz	$+204    	;abs 0x2e50
    2d86:	61 64       	addc.b	@r4,	r1	;
    2d88:	61 70       	subc.b	@r0,	r1	;
    2d8a:	74 65       	addc.b	@r5+,	r4	;
    2d8c:	72 20       	jnz	$+230    	;abs 0x2e72
    2d8e:	73 79       	.word	0x7973;	????
    2d90:	6e 74       	subc.b	@r4,	r14	;
    2d92:	68 65       	addc.b	@r5,	r8	;
    2d94:	73 69       	.word	0x6973;	????
    2d96:	7a 65       	addc.b	@r5+,	r10	;
    2d98:	64 21       	jnz	$+714    	;abs 0x3062
    2d9a:	00 53       	add	#0,	r0	;r3 As==00
    2d9c:	65 74       	subc.b	@r4,	r5	;
    2d9e:	74 69       	addc.b	@r9+,	r4	;
    2da0:	6e 67       	addc.b	@r7,	r14	;
    2da2:	20 75       	subc	@r5,	r0	;
    2da4:	70 20       	jnz	$+226    	;abs 0x2e86
    2da6:	49 32       	jn	$-876    	;abs 0x2a3a
    2da8:	43 20       	jnz	$+136    	;abs 0x2e30
    2daa:	63 6f       	.word	0x6f63;	????
    2dac:	72 65       	addc.b	@r5+,	r2	;
    2dae:	00 0a       	bra	@r10		;
    2db0:	53 65       	.word	0x6553;	????
    2db2:	74 75       	subc.b	@r5+,	r4	;
    2db4:	70 20       	jnz	$+226    	;abs 0x2e96
    2db6:	64 6f       	addc.b	@r15,	r4	;
    2db8:	6e 65       	addc.b	@r5,	r14	;
    2dba:	2e 0a 00 0a 	mova	&657920,r14	;0xa0a00
    2dbe:	45 6e       	addc.b	r14,	r5	;
    2dc0:	74 65       	addc.b	@r5+,	r4	;
    2dc2:	72 20       	jnz	$+230    	;abs 0x2ea8
    2dc4:	61 20       	jnz	$+196    	;abs 0x2e88
    2dc6:	63 6f       	.word	0x6f63;	????
    2dc8:	6d 6d       	addc.b	@r13,	r13	;
    2dca:	61 6e       	addc.b	@r14,	r1	;
    2dcc:	64 3a       	jl	$-822    	;abs 0x2a96
    2dce:	3e 20       	jnz	$+126    	;abs 0x2e4c
    2dd0:	00 0a       	bra	@r10		;
    2dd2:	00 68       	addc	r8,	r0	;
    2dd4:	65 6c       	addc.b	@r12,	r5	;
    2dd6:	70 00 65 6e 	mova	r0,	28261(r0); PC rel. 0x09c3d
    2dda:	61 62       	addc.b	#4,	r1	;r2 As==10
    2ddc:	6c 65       	addc.b	@r5,	r12	;
    2dde:	00 69       	addc	r9,	r0	;
    2de0:	64 00 77 72 	mova	r0,	&291447	; 0x47277
    2de4:	69 74       	subc.b	@r4,	r9	;
    2de6:	65 5f       	add.b	@r15,	r5	;
    2de8:	70 72       	subc.b	#8,	r0	;r2 As==11
    2dea:	6f 6d       	addc.b	@r13,	r15	;
    2dec:	00 72       	subc	r2,	r0	;
    2dee:	65 61       	addc.b	@r1,	r5	;
    2df0:	64 5f       	add.b	@r15,	r4	;
    2df2:	70 72       	subc.b	#8,	r0	;r2 As==11
    2df4:	6f 6d       	addc.b	@r13,	r15	;
    2df6:	00 77       	subc	r7,	r0	;
    2df8:	72 69       	addc.b	@r9+,	r2	;
    2dfa:	74 65       	addc.b	@r5+,	r4	;
    2dfc:	5f 62 75 73 	addc.b	&0x7375,r15	;0x7375
    2e00:	00 72       	subc	r2,	r0	;
    2e02:	65 61       	addc.b	@r1,	r5	;
    2e04:	64 5f       	add.b	@r15,	r4	;
    2e06:	62 75       	subc.b	@r5,	r2	;
    2e08:	73 00 72 65 	mova	r0,	25970(r3); 0x06572
    2e0c:	73 65       	.word	0x6573;	????
    2e0e:	74 00 41 76 	mova	r0,	30273(r4); 0x07641
    2e12:	61 69       	addc.b	@r9,	r1	;
    2e14:	6c 61       	addc.b	@r1,	r12	;
    2e16:	62 6c       	addc.b	@r12,	r2	;
    2e18:	65 20       	jnz	$+204    	;abs 0x2ee4
    2e1a:	63 6f       	.word	0x6f63;	????
    2e1c:	6d 6d       	addc.b	@r13,	r13	;
    2e1e:	61 6e       	addc.b	@r14,	r1	;
    2e20:	64 73       	subc.b	#2,	r4	;r3 As==10
    2e22:	3a 0a 20 68 	mova	26656(r10),r10	;0x06820
    2e26:	65 6c       	addc.b	@r12,	r5	;
    2e28:	70 20       	jnz	$+226    	;abs 0x2f0a
    2e2a:	20 20       	jnz	$+66     	;abs 0x2e6c
    2e2c:	20 20       	jnz	$+66     	;abs 0x2e6e
    2e2e:	20 20       	jnz	$+66     	;abs 0x2e70
    2e30:	20 2d       	jc	$+578    	;abs 0x3072
    2e32:	20 73       	subc	#2,	r0	;r3 As==10
    2e34:	68 6f       	addc.b	@r15,	r8	;
    2e36:	77 20       	jnz	$+240    	;abs 0x2f26
    2e38:	74 68       	addc.b	@r8+,	r4	;
    2e3a:	69 73       	subc.b	#2,	r9	;r3 As==10
    2e3c:	20 74       	subc	@r4,	r0	;
    2e3e:	65 78       	subc.b	@r8,	r5	;
    2e40:	74 0a 20 65 	mova	r10,	25888(r4); 0x06520
    2e44:	6e 61       	addc.b	@r1,	r14	;
    2e46:	62 6c       	addc.b	@r12,	r2	;
    2e48:	65 20       	jnz	$+204    	;abs 0x2f14
    2e4a:	20 20       	jnz	$+66     	;abs 0x2e8c
    2e4c:	20 20       	jnz	$+66     	;abs 0x2e8e
    2e4e:	20 2d       	jc	$+578    	;abs 0x3090
    2e50:	20 65       	addc	@r5,	r0	;
    2e52:	6e 61       	addc.b	@r1,	r14	;
    2e54:	62 6c       	addc.b	@r12,	r2	;
    2e56:	65 20       	jnz	$+204    	;abs 0x2f22
    2e58:	49 32       	jn	$-876    	;abs 0x2aec
    2e5a:	43 20       	jnz	$+136    	;abs 0x2ee2
    2e5c:	62 72       	subc.b	#4,	r2	;r2 As==10
    2e5e:	69 64       	addc.b	@r4,	r9	;
    2e60:	67 65       	addc.b	@r5,	r7	;
    2e62:	20 6f       	addc	@r15,	r0	;
    2e64:	6e 20       	jnz	$+222    	;abs 0x2f42
    2e66:	45 6e       	addc.b	r14,	r5	;
    2e68:	63 6c       	.word	0x6c63;	????
    2e6a:	75 73       	subc.b	#-1,	r5	;r3 As==11
    2e6c:	74 72       	subc.b	#8,	r4	;r2 As==11
    2e6e:	61 0a 20 69 	mova	r10,	&92448	; 0x16920
    2e72:	64 20       	jnz	$+202    	;abs 0x2f3c
    2e74:	20 20       	jnz	$+66     	;abs 0x2eb6
    2e76:	20 20       	jnz	$+66     	;abs 0x2eb8
    2e78:	20 20       	jnz	$+66     	;abs 0x2eba
    2e7a:	20 20       	jnz	$+66     	;abs 0x2ebc
    2e7c:	20 2d       	jc	$+578    	;abs 0x30be
    2e7e:	20 52       	add	#4,	r0	;r2 As==10
    2e80:	65 61       	addc.b	@r1,	r5	;
    2e82:	64 20       	jnz	$+202    	;abs 0x2f4c
    2e84:	66 72       	subc.b	#4,	r6	;r2 As==10
    2e86:	6f 6d       	addc.b	@r13,	r15	;
    2e88:	20 45       	br	@r5		;
    2e8a:	32 34       	jge	$+102    	;abs 0x2ef0
    2e8c:	41 41       	mov.b	r1,	r1	;
    2e8e:	30 32       	jn	$-926    	;abs 0x2af0
    2e90:	35 45       	mov	@r5+,	r5	;
    2e92:	34 38       	jl	$+106    	;abs 0x2efc
    2e94:	54 20       	jnz	$+170    	;abs 0x2f3e
    2e96:	55 6e 69 71 	addc.b	29033(r14),r5	;0x07169
    2e9a:	75 65       	addc.b	@r5+,	r5	;
    2e9c:	20 49       	br	@r9		;
    2e9e:	44 0a       	rlam.a	#3,	r4	;
    2ea0:	20 77       	subc	@r7,	r0	;
    2ea2:	72 69       	addc.b	@r9+,	r2	;
    2ea4:	74 65       	addc.b	@r5+,	r4	;
    2ea6:	5f 69 70 20 	addc.b	8304(r9),r15	;0x02070
    2eaa:	20 20       	jnz	$+66     	;abs 0x2eec
    2eac:	20 2d       	jc	$+578    	;abs 0x30ee
    2eae:	20 77       	subc	@r7,	r0	;
    2eb0:	72 69       	addc.b	@r9+,	r2	;
    2eb2:	74 65       	addc.b	@r5+,	r4	;
    2eb4:	20 38       	jl	$+66     	;abs 0x2ef6
    2eb6:	20 68       	addc	@r8,	r0	;
    2eb8:	65 78       	subc.b	@r8,	r5	;
    2eba:	20 63       	addc	#2,	r0	;r3 As==10
    2ebc:	68 61       	addc.b	@r1,	r8	;
    2ebe:	72 20       	jnz	$+230    	;abs 0x2fa4
    2ec0:	28 33       	jn	$-430    	;abs 0x2d12
    2ec2:	32 20       	jnz	$+102    	;abs 0x2f28
    2ec4:	62 69       	addc.b	@r9,	r2	;
    2ec6:	74 29       	jnc	$+746    	;abs 0x31b0
    2ec8:	20 20       	jnz	$+66     	;abs 0x2f0a
    2eca:	0a 20       	jnz	$+22     	;abs 0x2ee0
    2ecc:	72 65       	addc.b	@r5+,	r2	;
    2ece:	61 64       	addc.b	@r4,	r1	;
    2ed0:	5f 69 70 20 	addc.b	8304(r9),r15	;0x02070
    2ed4:	20 20       	jnz	$+66     	;abs 0x2f16
    2ed6:	20 20       	jnz	$+66     	;abs 0x2f18
    2ed8:	2d 20       	jnz	$+92     	;abs 0x2f34
    2eda:	72 65       	addc.b	@r5+,	r2	;
    2edc:	61 64       	addc.b	@r4,	r1	;
    2ede:	20 49       	br	@r9		;
    2ee0:	50 20       	jnz	$+162    	;abs 0x2f82
    2ee2:	61 64       	addc.b	@r4,	r1	;
    2ee4:	64 72       	subc.b	#4,	r4	;r2 As==10
    2ee6:	65 73       	subc.b	#2,	r5	;r3 As==10
    2ee8:	73 20       	jnz	$+232    	;abs 0x2fd0
    2eea:	20 0a 77 72 	bra	&684663	;0xa7277
    2eee:	69 74       	subc.b	@r4,	r9	;
    2ef0:	65 5f       	add.b	@r15,	r5	;
    2ef2:	6d 61       	addc.b	@r1,	r13	;
    2ef4:	63 20       	jnz	$+200    	;abs 0x2fbc
    2ef6:	20 20       	jnz	$+66     	;abs 0x2f38
    2ef8:	20 2d       	jc	$+578    	;abs 0x313a
    2efa:	20 77       	subc	@r7,	r0	;
    2efc:	72 69       	addc.b	@r9+,	r2	;
    2efe:	74 65       	addc.b	@r5+,	r4	;
    2f00:	20 31       	jn	$+578    	;abs 0x3142
    2f02:	32 20       	jnz	$+102    	;abs 0x2f68
    2f04:	68 65       	addc.b	@r5,	r8	;
    2f06:	78 20       	jnz	$+242    	;abs 0x2ff8
    2f08:	63 68       	.word	0x6863;	????
    2f0a:	61 72       	subc.b	#4,	r1	;r2 As==10
    2f0c:	20 28       	jnc	$+66     	;abs 0x2f4e
    2f0e:	34 38       	jl	$+106    	;abs 0x2f78
    2f10:	20 62       	addc	#4,	r0	;r2 As==10
    2f12:	69 74       	subc.b	@r4,	r9	;
    2f14:	29 72       	subc	#4,	r9	;r2 As==10
    2f16:	65 61       	addc.b	@r1,	r5	;
    2f18:	64 5f       	add.b	@r15,	r4	;
    2f1a:	6d 61       	addc.b	@r1,	r13	;
    2f1c:	63 20       	jnz	$+200    	;abs 0x2fe4
    2f1e:	20 20       	jnz	$+66     	;abs 0x2f60
    2f20:	20 20       	jnz	$+66     	;abs 0x2f62
    2f22:	2d 20       	jnz	$+92     	;abs 0x2f7e
    2f24:	72 65       	addc.b	@r5+,	r2	;
    2f26:	61 64       	addc.b	@r4,	r1	;
    2f28:	20 6d       	addc	@r13,	r0	;
    2f2a:	61 63       	addc.b	#2,	r1	;r3 As==10
    2f2c:	20 61       	addc	@r1,	r0	;
    2f2e:	64 64       	addc.b	@r4,	r4	;
    2f30:	72 65       	addc.b	@r5+,	r2	;
    2f32:	73 73       	.word	0x7373;	????
    2f34:	20 77       	subc	@r7,	r0	;
    2f36:	72 69       	addc.b	@r9+,	r2	;
    2f38:	74 65       	addc.b	@r5+,	r4	;
    2f3a:	5f 62 75 73 	addc.b	&0x7375,r15	;0x7375
    2f3e:	20 20       	jnz	$+66     	;abs 0x2f80
    2f40:	20 2d       	jc	$+578    	;abs 0x3182
    2f42:	20 77       	subc	@r7,	r0	;
    2f44:	72 69       	addc.b	@r9+,	r2	;
    2f46:	74 65       	addc.b	@r5+,	r4	;
    2f48:	20 74       	subc	@r4,	r0	;
    2f4a:	6f 20       	jnz	$+224    	;abs 0x302a
    2f4c:	42 75       	subc.b	r5,	r2	;
    2f4e:	73 20       	jnz	$+232    	;abs 0x3036
    2f50:	6d 65       	addc.b	@r5,	r13	;
    2f52:	6d 6f       	addc.b	@r15,	r13	;
    2f54:	72 79       	subc.b	@r9+,	r2	;
    2f56:	20 0a 20 72 	bra	&684576	;0xa7220
    2f5a:	65 61       	addc.b	@r1,	r5	;
    2f5c:	64 5f       	add.b	@r15,	r4	;
    2f5e:	62 75       	subc.b	@r5,	r2	;
    2f60:	73 20       	jnz	$+232    	;abs 0x3048
    2f62:	20 20       	jnz	$+66     	;abs 0x2fa4
    2f64:	20 2d       	jc	$+578    	;abs 0x31a6
    2f66:	20 72       	subc	#4,	r0	;r2 As==10
    2f68:	65 61       	addc.b	@r1,	r5	;
    2f6a:	64 20       	jnz	$+202    	;abs 0x3034
    2f6c:	66 72       	subc.b	#4,	r6	;r2 As==10
    2f6e:	6f 6d       	addc.b	@r13,	r15	;
    2f70:	20 42       	br	#4		;r2 As==10
    2f72:	75 73       	subc.b	#-1,	r5	;r3 As==11
    2f74:	20 6d       	addc	@r13,	r0	;
    2f76:	65 6d       	addc.b	@r13,	r5	;
    2f78:	6f 72       	subc.b	#4,	r15	;r2 As==10
    2f7a:	79 20       	jnz	$+244    	;abs 0x306e
    2f7c:	0a 20       	jnz	$+22     	;abs 0x2f92
    2f7e:	72 65       	addc.b	@r5+,	r2	;
    2f80:	73 65       	.word	0x6573;	????
    2f82:	74 20       	jnz	$+234    	;abs 0x306c
    2f84:	20 20       	jnz	$+66     	;abs 0x2fc6
    2f86:	20 20       	jnz	$+66     	;abs 0x2fc8
    2f88:	20 20       	jnz	$+66     	;abs 0x2fca
    2f8a:	2d 20       	jnz	$+92     	;abs 0x2fe6
    2f8c:	72 65       	addc.b	@r5+,	r2	;
    2f8e:	73 65       	.word	0x6573;	????
    2f90:	74 20       	jnz	$+234    	;abs 0x307a
    2f92:	43 50       	.word	0x5043;	????
    2f94:	55 0a       	rlam	#3,	r5	;
    2f96:	00 0a       	bra	@r10		;
    2f98:	45 6e       	addc.b	r14,	r5	;
    2f9a:	61 62       	addc.b	#4,	r1	;r2 As==10
    2f9c:	6c 69       	addc.b	@r9,	r12	;
    2f9e:	6e 67       	addc.b	@r7,	r14	;
    2fa0:	20 49       	br	@r9		;
    2fa2:	32 43       	mov	#-1,	r2	;r3 As==11
    2fa4:	20 62       	addc	#4,	r0	;r2 As==10
    2fa6:	72 69       	addc.b	@r9+,	r2	;
    2fa8:	64 67       	addc.b	@r7,	r4	;
    2faa:	65 3a       	jl	$-820    	;abs 0x2c76
    2fac:	0a 00       	mova	@r0,	r10	;
    2fae:	50 6f 73 74 	addc.b	29811(r15),r0	;0x07473
    2fb2:	20 52       	add	#4,	r0	;r2 As==10
    2fb4:	65 67       	addc.b	@r7,	r5	;
    2fb6:	44 69       	addc.b	r9,	r4	;
    2fb8:	72 3a       	jl	$-794    	;abs 0x2c9e
    2fba:	20 00 0a 55 	bra	&21770		;0x0550a
    2fbe:	49 44       	mov.b	r4,	r9	;
    2fc0:	20 66       	addc	@r6,	r0	;
    2fc2:	72 6f       	addc.b	@r15+,	r2	;
    2fc4:	6d 20       	jnz	$+220    	;abs 0x30a0
    2fc6:	45 32       	jn	$-884    	;abs 0x2c52
    2fc8:	34 41       	pop	r4		;
    2fca:	41 30       	jn	$+132    	;abs 0x304e
    2fcc:	32 35       	jge	$+614    	;abs 0x3232
    2fce:	45 34       	jge	$+140    	;abs 0x305a
    2fd0:	38 54       	add	@r4+,	r8	;
    2fd2:	20 3d       	jmp	$+578    	;abs 0x3214
    2fd4:	20 00 45 6e 	bra	&28229		;0x06e45
    2fd8:	74 65       	addc.b	@r5+,	r4	;
    2fda:	72 20       	jnz	$+230    	;abs 0x30c0
    2fdc:	68 65       	addc.b	@r5,	r8	;
    2fde:	78 61       	addc.b	@r1+,	r8	;
    2fe0:	64 65       	addc.b	@r5,	r4	;
    2fe2:	63 69       	.word	0x6963;	????
    2fe4:	6d 61       	addc.b	@r1,	r13	;
    2fe6:	6c 20       	jnz	$+218    	;abs 0x30c0
    2fe8:	64 61       	addc.b	@r1,	r4	;
    2fea:	74 61       	addc.b	@r1+,	r4	;
    2fec:	20 74       	subc	@r4,	r0	;
    2fee:	6f 20       	jnz	$+224    	;abs 0x30ce
    2ff0:	77 72       	subc.b	#8,	r7	;r2 As==11
    2ff2:	69 74       	subc.b	@r4,	r9	;
    2ff4:	65 20       	jnz	$+204    	;abs 0x30c0
    2ff6:	74 6f       	addc.b	@r15+,	r4	;
    2ff8:	20 50       	add	@r0,	r0	;
    2ffa:	52 4f 4d 3a 	mov.b	14925(r15),r2	;0x03a4d
    2ffe:	20 30       	jn	$+66     	;abs 0x3040
    3000:	78 00 0a 44 	mova	r0,	17418(r8); 0x0440a
    3004:	61 74       	subc.b	@r4,	r1	;
    3006:	61 20       	jnz	$+196    	;abs 0x30ca
    3008:	66 72       	subc.b	#4,	r6	;r2 As==10
    300a:	6f 6d       	addc.b	@r13,	r15	;
    300c:	20 50       	add	@r0,	r0	;
    300e:	52 4f 4d 20 	mov.b	8269(r15),r2	;0x0204d
    3012:	3d 20       	jnz	$+124    	;abs 0x308e
    3014:	00 0a       	bra	@r10		;
    3016:	49 50       	add.b	r0,	r9	;
    3018:	20 41       	br	@r1		;
    301a:	64 64       	addc.b	@r4,	r4	;
    301c:	72 65       	addc.b	@r5+,	r2	;
    301e:	73 73       	.word	0x7373;	????
    3020:	20 3d       	jmp	$+578    	;abs 0x3262
    3022:	20 31       	jn	$+578    	;abs 0x3264
    3024:	39 32       	jn	$-908    	;abs 0x2c98
    3026:	2e 31       	jn	$+606    	;abs 0x3284
    3028:	36 38       	jl	$+110    	;abs 0x3096
    302a:	2e 00 2e 00 	mova	&46,	r14	;0x0002e
    302e:	20 00 0a 49 	bra	&18698		;0x0490a
    3032:	50 42 75 73 	br	&0x7375		;
    3036:	20 77       	subc	@r7,	r0	;
    3038:	72 69       	addc.b	@r9+,	r2	;
    303a:	74 65       	addc.b	@r5+,	r4	;
    303c:	00 0a       	bra	@r10		;
    303e:	20 45       	br	@r5		;
    3040:	6e 74       	subc.b	@r4,	r14	;
    3042:	65 72       	subc.b	#4,	r5	;r2 As==10
    3044:	20 68       	addc	@r8,	r0	;
    3046:	65 78       	subc.b	@r8,	r5	;
    3048:	61 64       	addc.b	@r4,	r1	;
    304a:	65 63       	addc.b	#2,	r5	;r3 As==10
    304c:	69 6d       	addc.b	@r13,	r9	;
    304e:	61 6c       	addc.b	@r12,	r1	;
    3050:	20 64       	addc	@r4,	r0	;
    3052:	61 74       	subc.b	@r4,	r1	;
    3054:	61 20       	jnz	$+196    	;abs 0x3118
    3056:	61 64       	addc.b	@r4,	r1	;
    3058:	64 72       	subc.b	#4,	r4	;r2 As==10
    305a:	65 73       	subc.b	#2,	r5	;r3 As==10
    305c:	73 20       	jnz	$+232    	;abs 0x3144
    305e:	6f 6e       	addc.b	@r14,	r15	;
    3060:	20 41       	br	@r1		;
    3062:	33 32       	jn	$-920    	;abs 0x2cca
    3064:	3a 20       	jnz	$+118    	;abs 0x30da
    3066:	30 78       	subc	@r8+,	r0	;
    3068:	00 0a       	bra	@r10		;
    306a:	20 49       	br	@r9		;
    306c:	6e 63       	addc.b	#2,	r14	;r3 As==10
    306e:	72 65       	addc.b	@r5+,	r2	;
    3070:	6d 65       	addc.b	@r5,	r13	;
    3072:	6e 74       	subc.b	@r4,	r14	;
    3074:	69 6e       	addc.b	@r14,	r9	;
    3076:	67 20       	jnz	$+208    	;abs 0x3146
    3078:	3f 20       	jnz	$+128    	;abs 0x30f8
    307a:	28 59       	add	@r9,	r8	;
    307c:	2f 4e       	mov	@r14,	r15	;
    307e:	29 00 59 00 	mova	&89,	r9	;0x00059
    3082:	0a 20       	jnz	$+22     	;abs 0x3098
    3084:	55 73       	subc.b	#1,	r5	;r3 As==01
    3086:	65 20       	jnz	$+204    	;abs 0x3152
    3088:	43 6f       	.word	0x6f43;	????
    308a:	6e 66       	addc.b	@r6,	r14	;
    308c:	69 67       	addc.b	@r7,	r9	;
    308e:	75 72       	subc.b	#8,	r5	;r2 As==11
    3090:	61 74       	subc.b	@r4,	r1	;
    3092:	69 6f       	addc.b	@r15,	r9	;
    3094:	6e 20       	jnz	$+222    	;abs 0x3172
    3096:	53 70       	.word	0x7053;	????
    3098:	61 63       	addc.b	#2,	r1	;r3 As==10
    309a:	65 20       	jnz	$+204    	;abs 0x3166
    309c:	3f 20       	jnz	$+128    	;abs 0x311c
    309e:	28 59       	add	@r9,	r8	;
    30a0:	2f 4e       	mov	@r14,	r15	;
    30a2:	29 00 43 61 	mova	&24899,	r9	;0x06143
    30a6:	6e 6e       	addc.b	@r14,	r14	;
    30a8:	6f 74       	subc.b	@r4,	r15	;
    30aa:	20 75       	subc	@r5,	r0	;
    30ac:	73 65       	.word	0x6573;	????
    30ae:	20 4e       	br	@r14		;
    30b0:	6f 6e       	addc.b	@r14,	r15	;
    30b2:	2d 49       	mov	@r9,	r13	;
    30b4:	6e 63       	addc.b	#2,	r14	;r3 As==10
    30b6:	72 65       	addc.b	@r5+,	r2	;
    30b8:	6d 65       	addc.b	@r5,	r13	;
    30ba:	6e 74       	subc.b	@r4,	r14	;
    30bc:	69 6e       	addc.b	@r14,	r9	;
    30be:	67 20       	jnz	$+208    	;abs 0x318e
    30c0:	54 72 61 6e 	subc.b	&0x6e61,r4	;0x6e61
    30c4:	73 61       	.word	0x6173;	????
    30c6:	63 74       	.word	0x7463;	????
    30c8:	69 6f       	addc.b	@r15,	r9	;
    30ca:	6e 73       	subc.b	#2,	r14	;r3 As==10
    30cc:	20 69       	addc	@r9,	r0	;
    30ce:	6e 20       	jnz	$+222    	;abs 0x31ac
    30d0:	43 6f       	.word	0x6f43;	????
    30d2:	6e 66       	addc.b	@r6,	r14	;
    30d4:	69 67       	addc.b	@r7,	r9	;
    30d6:	75 72       	subc.b	#8,	r5	;r2 As==11
    30d8:	61 74       	subc.b	@r4,	r1	;
    30da:	69 6f       	addc.b	@r15,	r9	;
    30dc:	6e 20       	jnz	$+222    	;abs 0x31ba
    30de:	53 70       	.word	0x7053;	????
    30e0:	61 63       	addc.b	#2,	r1	;r3 As==10
    30e2:	65 00 49 50 	mova	r0,	&348233	; 0x55049
    30e6:	62 75       	subc.b	@r5,	r2	;
    30e8:	73 20       	jnz	$+232    	;abs 0x31d0
    30ea:	52 65 70 6c 	addc.b	27760(r5),r2	;0x06c70
    30ee:	79 20       	jnz	$+244    	;abs 0x31e2
    30f0:	48 65       	addc.b	r5,	r8	;
    30f2:	61 64       	addc.b	@r4,	r1	;
    30f4:	65 72       	subc.b	#4,	r5	;r2 As==10
    30f6:	20 4d       	br	@r13		;
    30f8:	69 73       	subc.b	#2,	r9	;r3 As==10
    30fa:	6d 61       	addc.b	@r1,	r13	;
    30fc:	74 63       	addc.b	#-1,	r4	;r3 As==11
    30fe:	68 2e       	jc	$-814    	;abs 0x2dd0
    3100:	20 53       	incd	r0		;
    3102:	65 6e       	addc.b	@r14,	r5	;
    3104:	74 20       	jnz	$+234    	;abs 0x31ee
    3106:	30 78       	subc	@r8+,	r0	;
    3108:	25 30       	jn	$+76     	;abs 0x3154
    310a:	38 6c       	addc	@r12+,	r8	;
    310c:	58 20       	jnz	$+178    	;abs 0x31be
    310e:	2c 20       	jnz	$+90     	;abs 0x3168
    3110:	47 6f       	addc.b	r15,	r7	;
    3112:	74 20       	jnz	$+234    	;abs 0x31fc
    3114:	30 78       	subc	@r8+,	r0	;
    3116:	25 30       	jn	$+76     	;abs 0x3162
    3118:	38 6c       	addc	@r12+,	r8	;
    311a:	58 20       	jnz	$+178    	;abs 0x31cc
    311c:	2c 20       	jnz	$+90     	;abs 0x3176
    311e:	45 78       	subc.b	r8,	r5	;
    3120:	70 65       	addc.b	@r5+,	r0	;
    3122:	63 74       	.word	0x7463;	????
    3124:	65 64       	addc.b	@r4,	r5	;
    3126:	20 30       	jn	$+66     	;abs 0x3168
    3128:	78 25       	jz	$+754    	;abs 0x341a
    312a:	30 38       	jl	$+98     	;abs 0x318c
    312c:	6c 58       	add.b	@r8,	r12	;
    312e:	20 0a 00 49 	bra	&674048	;0xa4900
    3132:	6e 76       	subc.b	@r6,	r14	;
    3134:	61 6c       	addc.b	@r12,	r1	;
    3136:	69 64       	addc.b	@r4,	r9	;
    3138:	20 63       	addc	#2,	r0	;r3 As==10
    313a:	6f 6d       	addc.b	@r13,	r15	;
    313c:	6d 61       	addc.b	@r1,	r13	;
    313e:	6e 64       	addc.b	@r4,	r14	;
    3140:	2e 20       	jnz	$+94     	;abs 0x319e
    3142:	54 79 70 65 	subc.b	25968(r9),r4	;0x06570
    3146:	20 27       	jz	$-446    	;abs 0x2f88
    3148:	68 65       	addc.b	@r5,	r8	;
    314a:	6c 70       	subc.b	@r0,	r12	;
    314c:	27 20       	jnz	$+80     	;abs 0x319c
    314e:	74 6f       	addc.b	@r15+,	r4	;
    3150:	20 73       	subc	#2,	r0	;r3 As==10
    3152:	65 65       	addc.b	@r5,	r5	;
    3154:	20 61       	addc	@r1,	r0	;
    3156:	6c 6c       	addc.b	@r12,	r12	;
    3158:	20 63       	addc	#2,	r0	;r3 As==10
    315a:	6f 6d       	addc.b	@r13,	r15	;
    315c:	6d 61       	addc.b	@r1,	r13	;
    315e:	6e 64       	addc.b	@r4,	r14	;
    3160:	73 2e       	jc	$-792    	;abs 0x2e48
    3162:	0a 00       	mova	@r0,	r10	;
    3164:	0a 00       	mova	@r0,	r10	;

00003166 <__sf_fake_stderr>:
    3166:	00 00       	beq			
    3168:	00 00       	beq			
    316a:	00 00       	beq			
    316c:	00 00       	beq			
    316e:	00 00       	beq			
    3170:	00 00       	beq			
    3172:	00 00       	beq			
    3174:	00 00       	beq			
    3176:	00 00       	beq			

00003178 <__sf_fake_stdout>:
    3178:	00 00       	beq			
    317a:	00 00       	beq			
    317c:	00 00       	beq			
    317e:	00 00       	beq			
    3180:	00 00       	beq			
    3182:	00 00       	beq			
    3184:	00 00       	beq			
    3186:	00 00       	beq			
    3188:	00 00       	beq			

0000318a <__sf_fake_stdin>:
    318a:	00 00       	beq			
    318c:	00 00       	beq			
    318e:	00 00       	beq			
    3190:	00 00       	beq			
    3192:	00 00       	beq			
    3194:	00 00       	beq			
    3196:	00 00       	beq			
    3198:	00 00       	beq			
    319a:	00 00       	beq			

0000319c <_global_impure_ptr>:
    319c:	0a 80       	sub	r0,	r10	;
    319e:	43 00       	rrcm.a	#1,	r3	;
    31a0:	23 2d       	jc	$+584    	;abs 0x33e8
    31a2:	30 2b       	jnc	$-414    	;abs 0x3004
    31a4:	20 00 68 6c 	bra	&27752		;0x06c68
    31a8:	4c 00       	rrcm.a	#1,	r12	;
    31aa:	65 66       	addc.b	@r6,	r5	;
    31ac:	67 45       	mov.b	@r5,	r7	;
    31ae:	46 47       	mov.b	r7,	r6	;
    31b0:	00 30       	jn	$+2      	;abs 0x31b2
    31b2:	31 32       	jn	$-924    	;abs 0x2e16
    31b4:	33 34       	jge	$+104    	;abs 0x321c
    31b6:	35 36       	jge	$-916    	;abs 0x2e22
    31b8:	37 38       	jl	$+112    	;abs 0x3228
    31ba:	39 41       	pop	r9		;
    31bc:	42 43       	clr.b	r2		;
    31be:	44 45       	mov.b	r5,	r4	;
    31c0:	46 00       	rrcm.a	#1,	r6	;
    31c2:	30 31       	jn	$+610    	;abs 0x3424
    31c4:	32 33       	jn	$-410    	;abs 0x302a
    31c6:	34 35       	jge	$+618    	;abs 0x3430
    31c8:	36 37       	jge	$-402    	;abs 0x3036
    31ca:	38 39       	jl	$+626    	;abs 0x343c
    31cc:	61 62       	addc.b	#4,	r1	;r2 As==10
    31ce:	63 64       	.word	0x6463;	????
    31d0:	65 66       	addc.b	@r6,	r5	;
    31d2:	00 48       	br	r8		;
    31d4:	65 61       	addc.b	@r1,	r5	;
    31d6:	70 20       	jnz	$+226    	;abs 0x32b8
    31d8:	61 6e       	addc.b	@r14,	r1	;
    31da:	64 20       	jnz	$+202    	;abs 0x32a4
    31dc:	73 74       	.word	0x7473;	????
    31de:	61 63       	addc.b	#2,	r1	;r3 As==10
    31e0:	6b 20       	jnz	$+216    	;abs 0x32b8
    31e2:	63 6f       	.word	0x6f63;	????
    31e4:	6c 6c       	addc.b	@r12,	r12	;
    31e6:	69 73       	subc.b	#2,	r9	;r3 As==10
    31e8:	69 6f       	addc.b	@r15,	r9	;
    31ea:	6e 0a 00 00 	mova	r10,	&917504	; 0xe0000

Disassembly of section .data:

00008008 <__data_start>:
    8008:	0a 80       	sub	r0,	r10	;

0000800a <impure_data>:
    800a:	00 00       	beq			
    800c:	8a 31       	jn	$+790    	;abs 0x8322
    800e:	78 31       	jn	$+754    	;abs 0x8300
    8010:	66 31       	jn	$+718    	;abs 0x82de
    8012:	00 00       	beq			
    8014:	00 00       	beq			
    8016:	00 00       	beq			
    8018:	00 00       	beq			
    801a:	9e 31       	jn	$+830    	;abs 0x8358
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
    80a4:	58 29       	jnc	$+690    	;abs 0x8356

000080a6 <heap.1381>:
    80a6:	1c 81 00 00 	sub	0(r1),	r12	;

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

000080f5 <ConfigurationSpace>:
    80f5:	00 00       	beq			

000080f6 <command>:
    80f6:	00 00       	beq			
    80f8:	00 00       	beq			
    80fa:	00 00       	beq			
    80fc:	00 00       	beq			
    80fe:	00 00       	beq			
    8100:	00 00       	beq			
    8102:	00 00       	beq			
    8104:	00 00       	beq			

00008106 <buffer>:
    8106:	00 00       	beq			
    8108:	00 00       	beq			
    810a:	00 00       	beq			
    810c:	00 00       	beq			
    810e:	00 00       	beq			
    8110:	00 00       	beq			
    8112:	00 00       	beq			
    8114:	00 00       	beq			

00008116 <__malloc_sbrk_start>:
    8116:	00 00       	beq			

00008118 <__malloc_free_list>:
    8118:	00 00       	beq			

0000811a <errno>:
    811a:	00 00       	beq			

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
 57a:	01 42       	Address 0x0000057a is out of bounds.
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
  48:	00 14       	Address 0x00000048 is out of bounds.
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
