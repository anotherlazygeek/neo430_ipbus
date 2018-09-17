
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
  2e:	35 40 ce 0c 	mov	#3278,	r5	;#0x0cce

00000032 <.Loc.77.1>:
    mov  #__data_end_rom, r6
  32:	36 40 ce 0c 	mov	#3278,	r6	;#0x0cce

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
  58:	b0 12 58 03 	call	#856		;#0x0358

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
  96:	30 40 26 08 	br	#0x0826		;

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
  e8:	b0 12 54 08 	call	#2132		;#0x0854
  ec:	3d 40 90 ff 	mov	#65424,	r13	;#0xff90
  f0:	8d 4c 00 00 	mov	r12,	0(r13)	;
  f4:	ca 47 9a ff 	mov.b	r7,	-102(r10); 0xff9a
  f8:	82 48 96 ff 	mov	r8,	&0xff96	;
  fc:	82 49 98 ff 	mov	r9,	&0xff98	;

00000100 <.L13>:
 100:	2c 4d       	mov	@r13,	r12	;
 102:	0c 93       	cmp	#0,	r12	;r3 As==00
 104:	fd 3b       	jl	$-4      	;abs 0x100
 106:	30 40 26 08 	br	#0x0826		;

0000010a <uart_scan.constprop.7>:
 10a:	0a 12       	push	r10		;
 10c:	09 12       	push	r9		;
 10e:	08 12       	push	r8		;
 110:	07 12       	push	r7		;
 112:	06 12       	push	r6		;
 114:	4a 43       	clr.b	r10		;
 116:	38 40 08 80 	mov	#32776,	r8	;#0x8008
 11a:	06 4c       	mov	r12,	r6	;
 11c:	36 53       	add	#-1,	r6	;r3 As==11
 11e:	37 40 6a 00 	mov	#106,	r7	;#0x006a

00000122 <.L16>:
 122:	3c 40 a4 ff 	mov	#65444,	r12	;#0xffa4

00000126 <.L17>:
 126:	29 4c       	mov	@r12,	r9	;
 128:	09 93       	cmp	#0,	r9	;r3 As==00
 12a:	fd 37       	jge	$-4      	;abs 0x126
 12c:	39 f0 ff 00 	and	#255,	r9	;#0x00ff
 130:	79 92       	cmp.b	#8,	r9	;r2 As==11
 132:	10 20       	jnz	$+34     	;abs 0x154
 134:	0a 93       	cmp	#0,	r10	;r3 As==00
 136:	f5 27       	jz	$-20     	;abs 0x122
 138:	39 40 88 09 	mov	#2440,	r9	;#0x0988

0000013c <.L20>:
 13c:	19 53       	inc	r9		;
 13e:	5c 49 ff ff 	mov.b	-1(r9),	r12	;
 142:	0c 93       	cmp	#0,	r12	;r3 As==00
 144:	04 20       	jnz	$+10     	;abs 0x14e
 146:	38 53       	add	#-1,	r8	;r3 As==11
 148:	3a 53       	add	#-1,	r10	;r3 As==11
 14a:	30 40 22 01 	br	#0x0122		;

0000014e <.L21>:
 14e:	87 12       	call	r7		;
 150:	30 40 3c 01 	br	#0x013c		;

00000154 <.L18>:
 154:	79 90 0d 00 	cmp.b	#13,	r9	;#0x000d
 158:	11 24       	jz	$+36     	;abs 0x17c
 15a:	4c 49       	mov.b	r9,	r12	;
 15c:	7c 50 e0 ff 	add.b	#65504,	r12	;#0xffe0
 160:	7d 40 5e 00 	mov.b	#94,	r13	;#0x005e
 164:	4d 9c       	cmp.b	r12,	r13	;
 166:	dd 2b       	jnc	$-68     	;abs 0x122
 168:	0a 96       	cmp	r6,	r10	;
 16a:	db 2f       	jc	$-72     	;abs 0x122
 16c:	4c 49       	mov.b	r9,	r12	;
 16e:	87 12       	call	r7		;
 170:	c8 49 00 00 	mov.b	r9,	0(r8)	;
 174:	1a 53       	inc	r10		;
 176:	18 53       	inc	r8		;
 178:	30 40 22 01 	br	#0x0122		;

0000017c <.L22>:
 17c:	c8 43 00 00 	mov.b	#0,	0(r8)	;r3 As==00
 180:	0c 4a       	mov	r10,	r12	;
 182:	30 40 24 08 	br	#0x0824		;

00000186 <checkack.constprop.5>:
 186:	3d 40 90 ff 	mov	#65424,	r13	;#0xff90
 18a:	3e 40 9a ff 	mov	#65434,	r14	;#0xff9a

0000018e <.L28>:
 18e:	4c 43       	clr.b	r12		;

00000190 <.L29>:
 190:	03 43       	nop			
 192:	1c 53       	inc	r12		;
 194:	3c 90 00 02 	cmp	#512,	r12	;#0x0200
 198:	fb 23       	jnz	$-8      	;abs 0x190
 19a:	92 43 90 ff 	mov	#1,	&0xff90	;r3 As==01
 19e:	b2 40 10 00 	mov	#16,	&0xff92	;#0x0010
 1a2:	92 ff 
 1a4:	82 43 94 ff 	mov	#0,	&0xff94	;r3 As==00

000001a8 <.L30>:
 1a8:	2c 4d       	mov	@r13,	r12	;
 1aa:	0c 93       	cmp	#0,	r12	;r3 As==00
 1ac:	fd 3b       	jl	$-4      	;abs 0x1a8
 1ae:	6c 4e       	mov.b	@r14,	r12	;
 1b0:	2c b3       	bit	#2,	r12	;r3 As==10
 1b2:	ed 23       	jnz	$-36     	;abs 0x18e
 1b4:	7c e3       	xor.b	#-1,	r12	;r3 As==11
 1b6:	3c f0 ff 00 	and	#255,	r12	;#0x00ff
 1ba:	b0 12 c4 08 	call	#2244		;#0x08c4
 1be:	30 41       	ret			

000001c0 <read_i2c_address.constprop.4>:
 1c0:	0a 12       	push	r10		;
 1c2:	09 12       	push	r9		;
 1c4:	08 12       	push	r8		;
 1c6:	07 12       	push	r7		;
 1c8:	06 12       	push	r6		;
 1ca:	05 12       	push	r5		;
 1cc:	04 12       	push	r4		;
 1ce:	21 83       	decd	r1		;
 1d0:	4e 4c       	mov.b	r12,	r14	;
 1d2:	47 4d       	mov.b	r13,	r7	;
 1d4:	4e 5e       	rla.b	r14		;
 1d6:	38 40 d0 00 	mov	#208,	r8	;#0x00d0
 1da:	5e d3       	bis.b	#1,	r14	;r3 As==01
 1dc:	7c 40 0c 00 	mov.b	#12,	r12	;#0x000c
 1e0:	4d 43       	clr.b	r13		;
 1e2:	88 12       	call	r8		;
 1e4:	7e 40 90 ff 	mov.b	#65424,	r14	;#0xff90
 1e8:	7c 40 10 00 	mov.b	#16,	r12	;#0x0010
 1ec:	4d 43       	clr.b	r13		;
 1ee:	88 12       	call	r8		;
 1f0:	39 40 86 01 	mov	#390,	r9	;#0x0186
 1f4:	89 12       	call	r9		;
 1f6:	4a 4c       	mov.b	r12,	r10	;
 1f8:	06 48       	mov	r8,	r6	;
 1fa:	0a 93       	cmp	#0,	r10	;r3 As==00
 1fc:	24 24       	jz	$+74     	;abs 0x246
 1fe:	4a 43       	clr.b	r10		;
 200:	0c 47       	mov	r7,	r12	;
 202:	3c 53       	add	#-1,	r12	;r3 As==11
 204:	81 4c 00 00 	mov	r12,	0(r1)	;
 208:	74 40 10 00 	mov.b	#16,	r4	;#0x0010
 20c:	45 43       	clr.b	r5		;
 20e:	38 40 90 ff 	mov	#65424,	r8	;#0xff90

00000212 <.L36>:
 212:	0a 97       	cmp	r7,	r10	;
 214:	22 24       	jz	$+70     	;abs 0x25a
 216:	2a 91       	cmp	@r1,	r10	;
 218:	24 34       	jge	$+74     	;abs 0x262
 21a:	7e 40 20 00 	mov.b	#32,	r14	;#0x0020

0000021e <.L43>:
 21e:	0c 44       	mov	r4,	r12	;
 220:	0d 45       	mov	r5,	r13	;
 222:	86 12       	call	r6		;
 224:	89 12       	call	r9		;
 226:	92 43 90 ff 	mov	#1,	&0xff90	;r3 As==01
 22a:	b2 40 0c 00 	mov	#12,	&0xff92	;#0x000c
 22e:	92 ff 
 230:	82 43 94 ff 	mov	#0,	&0xff94	;r3 As==00

00000234 <.L40>:
 234:	2c 48       	mov	@r8,	r12	;
 236:	0c 93       	cmp	#0,	r12	;r3 As==00
 238:	fd 3b       	jl	$-4      	;abs 0x234
 23a:	da 42 9a ff 	mov.b	&0xff9a,-32744(r10);0xff9a, 0x8018
 23e:	18 80 
 240:	1a 53       	inc	r10		;
 242:	30 40 12 02 	br	#0x0212		;

00000246 <.L35>:
 246:	3c 40 8c 09 	mov	#2444,	r12	;#0x098c
 24a:	b0 12 7e 00 	call	#126		;#0x007e
 24e:	7e 40 40 00 	mov.b	#64,	r14	;#0x0040
 252:	7c 40 10 00 	mov.b	#16,	r12	;#0x0010
 256:	4d 43       	clr.b	r13		;
 258:	88 12       	call	r8		;

0000025a <.L44>:
 25a:	0c 4a       	mov	r10,	r12	;
 25c:	21 53       	incd	r1		;
 25e:	30 40 20 08 	br	#0x0820		;

00000262 <.L38>:
 262:	7e 40 68 00 	mov.b	#104,	r14	;#0x0068
 266:	30 40 1e 02 	br	#0x021e		;

0000026a <write_i2c_address.constprop.3>:
 26a:	0a 12       	push	r10		;
 26c:	09 12       	push	r9		;
 26e:	08 12       	push	r8		;
 270:	07 12       	push	r7		;
 272:	06 12       	push	r6		;
 274:	05 12       	push	r5		;
 276:	04 12       	push	r4		;
 278:	3c f0 ff 00 	and	#255,	r12	;#0x00ff
 27c:	47 4d       	mov.b	r13,	r7	;
 27e:	48 4e       	mov.b	r14,	r8	;
 280:	4c 5c       	rla.b	r12		;
 282:	3a 40 d0 00 	mov	#208,	r10	;#0x00d0
 286:	4e 4c       	mov.b	r12,	r14	;
 288:	7c 40 0c 00 	mov.b	#12,	r12	;#0x000c
 28c:	4d 43       	clr.b	r13		;
 28e:	8a 12       	call	r10		;
 290:	7e 40 90 ff 	mov.b	#65424,	r14	;#0xff90
 294:	7c 40 10 00 	mov.b	#16,	r12	;#0x0010
 298:	4d 43       	clr.b	r13		;
 29a:	8a 12       	call	r10		;
 29c:	39 40 86 01 	mov	#390,	r9	;#0x0186
 2a0:	89 12       	call	r9		;
 2a2:	06 4a       	mov	r10,	r6	;
 2a4:	4c 93       	cmp.b	#0,	r12	;r3 As==00
 2a6:	0a 24       	jz	$+22     	;abs 0x2bc
 2a8:	4a 43       	clr.b	r10		;
 2aa:	74 40 10 00 	mov.b	#16,	r4	;#0x0010
 2ae:	45 43       	clr.b	r5		;

000002b0 <.L47>:
 2b0:	0a 97       	cmp	r7,	r10	;
 2b2:	12 20       	jnz	$+38     	;abs 0x2d8
 2b4:	08 93       	cmp	#0,	r8	;r3 As==00
 2b6:	0d 24       	jz	$+28     	;abs 0x2d2
 2b8:	30 40 f4 02 	br	#0x02f4		;

000002bc <.L46>:
 2bc:	3c 40 cb 09 	mov	#2507,	r12	;#0x09cb
 2c0:	b0 12 7e 00 	call	#126		;#0x007e
 2c4:	7e 40 40 00 	mov.b	#64,	r14	;#0x0040
 2c8:	7c 40 10 00 	mov.b	#16,	r12	;#0x0010
 2cc:	4d 43       	clr.b	r13		;
 2ce:	8a 12       	call	r10		;
 2d0:	3a 43       	mov	#-1,	r10	;r3 As==11

000002d2 <.L45>:
 2d2:	0c 4a       	mov	r10,	r12	;
 2d4:	30 40 20 08 	br	#0x0820		;

000002d8 <.L50>:
 2d8:	5e 4a 18 80 	mov.b	-32744(r10),r14	;0xffff8018
 2dc:	7c 40 0c 00 	mov.b	#12,	r12	;#0x000c
 2e0:	4d 43       	clr.b	r13		;
 2e2:	86 12       	call	r6		;
 2e4:	7e 40 10 00 	mov.b	#16,	r14	;#0x0010
 2e8:	0c 44       	mov	r4,	r12	;
 2ea:	0d 45       	mov	r5,	r13	;
 2ec:	86 12       	call	r6		;
 2ee:	89 12       	call	r9		;
 2f0:	4c 93       	cmp.b	#0,	r12	;r3 As==00
 2f2:	08 20       	jnz	$+18     	;abs 0x304

000002f4 <.L54>:
 2f4:	7e 40 40 00 	mov.b	#64,	r14	;#0x0040
 2f8:	7c 40 10 00 	mov.b	#16,	r12	;#0x0010
 2fc:	4d 43       	clr.b	r13		;
 2fe:	86 12       	call	r6		;
 300:	30 40 d2 02 	br	#0x02d2		;

00000304 <.L49>:
 304:	1a 53       	inc	r10		;
 306:	30 40 b0 02 	br	#0x02b0		;

0000030a <uart_print_hex_word>:
 30a:	0a 12       	push	r10		;
 30c:	09 12       	push	r9		;
 30e:	08 12       	push	r8		;
 310:	09 4c       	mov	r12,	r9	;
 312:	b0 12 c0 08 	call	#2240		;#0x08c0
 316:	48 4c       	mov.b	r12,	r8	;
 318:	0c 48       	mov	r8,	r12	;
 31a:	b0 12 d0 08 	call	#2256		;#0x08d0
 31e:	3a 40 ae 00 	mov	#174,	r10	;#0x00ae
 322:	8a 12       	call	r10		;
 324:	4c 48       	mov.b	r8,	r12	;
 326:	8a 12       	call	r10		;
 328:	39 f0 ff 00 	and	#255,	r9	;#0x00ff
 32c:	0c 49       	mov	r9,	r12	;
 32e:	b0 12 d0 08 	call	#2256		;#0x08d0
 332:	8a 12       	call	r10		;
 334:	4c 49       	mov.b	r9,	r12	;
 336:	8a 12       	call	r10		;
 338:	30 40 28 08 	br	#0x0828		;

0000033c <uart_print_hex_dword>:
 33c:	0a 12       	push	r10		;
 33e:	09 12       	push	r9		;
 340:	09 4c       	mov	r12,	r9	;
 342:	7e 40 10 00 	mov.b	#16,	r14	;#0x0010
 346:	b0 12 52 09 	call	#2386		;#0x0952
 34a:	3a 40 0a 03 	mov	#778,	r10	;#0x030a
 34e:	8a 12       	call	r10		;
 350:	0c 49       	mov	r9,	r12	;
 352:	8a 12       	call	r10		;
 354:	30 40 2a 08 	br	#0x082a		;

00000358 <main>:
 358:	0a 12       	push	r10		;
 35a:	09 12       	push	r9		;
 35c:	08 12       	push	r8		;
 35e:	07 12       	push	r7		;
 360:	06 12       	push	r6		;
 362:	05 12       	push	r5		;
 364:	04 12       	push	r4		;
 366:	1e 42 fc ff 	mov	&0xfffc,r14	;0xfffc
 36a:	1f 42 fe ff 	mov	&0xfffe,r15	;0xfffe
 36e:	4c 43       	clr.b	r12		;

00000370 <.L58>:
 370:	0a 4f       	mov	r15,	r10	;
 372:	0f 93       	cmp	#0,	r15	;r3 As==00
 374:	8a 20       	jnz	$+278    	;abs 0x48a
 376:	3d 40 ff 95 	mov	#38399,	r13	;#0x95ff
 37a:	0d 9e       	cmp	r14,	r13	;
 37c:	86 28       	jnc	$+270    	;abs 0x48a

0000037e <.L61>:
 37e:	7e 40 ff 00 	mov.b	#255,	r14	;#0x00ff
 382:	0e 9c       	cmp	r12,	r14	;
 384:	88 28       	jnc	$+274    	;abs 0x496
 386:	0d 4a       	mov	r10,	r13	;
 388:	0d 5a       	add	r10,	r13	;
 38a:	0d 5d       	rla	r13		;
 38c:	0d 5d       	rla	r13		;
 38e:	0d 5d       	rla	r13		;
 390:	0d 5d       	rla	r13		;
 392:	0d 5d       	rla	r13		;
 394:	0d 5d       	rla	r13		;
 396:	0d 5d       	rla	r13		;
 398:	0d dc       	bis	r12,	r13	;
 39a:	82 4d a6 ff 	mov	r13,	&0xffa6	;
 39e:	92 43 a0 ff 	mov	#1,	&0xffa0	;r3 As==01
 3a2:	3a 40 7e 00 	mov	#126,	r10	;#0x007e
 3a6:	3c 40 1f 0a 	mov	#2591,	r12	;#0x0a1f
 3aa:	8a 12       	call	r10		;
 3ac:	09 4a       	mov	r10,	r9	;
 3ae:	a2 b3 f2 ff 	bit	#2,	&0xfff2	;r3 As==10
 3b2:	fb 25       	jz	$+1016   	;abs 0x7aa
 3b4:	3c 40 be 0a 	mov	#2750,	r12	;#0x0abe
 3b8:	8a 12       	call	r10		;
 3ba:	3a 40 d0 00 	mov	#208,	r10	;#0x00d0
 3be:	4e 43       	clr.b	r14		;
 3c0:	7c 42       	mov.b	#8,	r12	;r2 As==11
 3c2:	4d 43       	clr.b	r13		;
 3c4:	8a 12       	call	r10		;
 3c6:	4e 43       	clr.b	r14		;
 3c8:	4c 43       	clr.b	r12		;
 3ca:	4d 43       	clr.b	r13		;
 3cc:	8a 12       	call	r10		;
 3ce:	6e 42       	mov.b	#4,	r14	;r2 As==10
 3d0:	6c 42       	mov.b	#4,	r12	;r2 As==10
 3d2:	4d 43       	clr.b	r13		;
 3d4:	8a 12       	call	r10		;
 3d6:	7e 40 80 ff 	mov.b	#65408,	r14	;#0xff80
 3da:	7c 42       	mov.b	#8,	r12	;r2 As==11
 3dc:	4d 43       	clr.b	r13		;
 3de:	8a 12       	call	r10		;
 3e0:	4c 43       	clr.b	r12		;

000003e2 <.L67>:
 3e2:	03 43       	nop			
 3e4:	1c 53       	inc	r12		;
 3e6:	3c 90 e8 03 	cmp	#1000,	r12	;#0x03e8
 3ea:	fb 23       	jnz	$-8      	;abs 0x3e2
 3ec:	3c 40 d2 0a 	mov	#2770,	r12	;#0x0ad2
 3f0:	89 12       	call	r9		;
 3f2:	3a 40 7e 00 	mov	#126,	r10	;#0x007e

000003f6 <.L68>:
 3f6:	3c 40 e0 0a 	mov	#2784,	r12	;#0x0ae0
 3fa:	8a 12       	call	r10		;
 3fc:	35 40 0a 01 	mov	#266,	r5	;#0x010a
 400:	7c 40 10 00 	mov.b	#16,	r12	;#0x0010
 404:	85 12       	call	r5		;
 406:	07 4c       	mov	r12,	r7	;
 408:	3c 40 f4 0a 	mov	#2804,	r12	;#0x0af4
 40c:	8a 12       	call	r10		;
 40e:	07 93       	cmp	#0,	r7	;r3 As==00
 410:	f2 27       	jz	$-26     	;abs 0x3f6
 412:	36 40 58 09 	mov	#2392,	r6	;#0x0958
 416:	3d 40 f6 0a 	mov	#2806,	r13	;#0x0af6
 41a:	3c 40 08 80 	mov	#32776,	r12	;#0x8008
 41e:	86 12       	call	r6		;
 420:	04 4c       	mov	r12,	r4	;
 422:	3d 40 fb 0a 	mov	#2811,	r13	;#0x0afb
 426:	3c 40 08 80 	mov	#32776,	r12	;#0x8008
 42a:	86 12       	call	r6		;
 42c:	0c 93       	cmp	#0,	r12	;r3 As==00
 42e:	42 24       	jz	$+134    	;abs 0x4b4
 430:	57 43       	mov.b	#1,	r7	;r3 As==01
 432:	04 93       	cmp	#0,	r4	;r3 As==00
 434:	01 24       	jz	$+4      	;abs 0x438
 436:	47 43       	clr.b	r7		;

00000438 <.L70>:
 438:	3d 40 02 0b 	mov	#2818,	r13	;#0x0b02
 43c:	3c 40 08 80 	mov	#32776,	r12	;#0x8008
 440:	86 12       	call	r6		;
 442:	0c 93       	cmp	#0,	r12	;r3 As==00
 444:	02 20       	jnz	$+6      	;abs 0x44a
 446:	77 40 03 00 	mov.b	#3,	r7	;

0000044a <.L72>:
 44a:	3d 40 05 0b 	mov	#2821,	r13	;#0x0b05
 44e:	3c 40 08 80 	mov	#32776,	r12	;#0x8008
 452:	86 12       	call	r6		;
 454:	0c 93       	cmp	#0,	r12	;r3 As==00
 456:	01 20       	jnz	$+4      	;abs 0x45a
 458:	67 42       	mov.b	#4,	r7	;r2 As==10

0000045a <.L73>:
 45a:	3d 40 0b 0b 	mov	#2827,	r13	;#0x0b0b
 45e:	3c 40 08 80 	mov	#32776,	r12	;#0x8008
 462:	86 12       	call	r6		;
 464:	0c 93       	cmp	#0,	r12	;r3 As==00
 466:	02 20       	jnz	$+6      	;abs 0x46c
 468:	77 40 05 00 	mov.b	#5,	r7	;

0000046c <.L74>:
 46c:	3d 40 10 0b 	mov	#2832,	r13	;#0x0b10
 470:	3c 40 08 80 	mov	#32776,	r12	;#0x8008
 474:	86 12       	call	r6		;
 476:	0c 93       	cmp	#0,	r12	;r3 As==00
 478:	20 20       	jnz	$+66     	;abs 0x4ba
 47a:	3c 40 a0 ff 	mov	#65440,	r12	;#0xffa0

0000047e <.L75>:
 47e:	bc b2 00 00 	bit	#8,	0(r12)	;r2 As==11
 482:	fd 23       	jnz	$-4      	;abs 0x47e
 484:	00 43       	clr	r0		;
 486:	30 40 f6 03 	br	#0x03f6		;

0000048a <.L59>:
 48a:	3e 50 00 6a 	add	#27136,	r14	;#0x6a00
 48e:	3f 63       	addc	#-1,	r15	;r3 As==11
 490:	1c 53       	inc	r12		;
 492:	30 40 70 03 	br	#0x0370		;

00000496 <.L65>:
 496:	6a 93       	cmp.b	#2,	r10	;r3 As==10
 498:	02 24       	jz	$+6      	;abs 0x49e
 49a:	6a 92       	cmp.b	#4,	r10	;r2 As==10
 49c:	07 20       	jnz	$+16     	;abs 0x4ac

0000049e <.L62>:
 49e:	b0 12 d4 08 	call	#2260		;#0x08d4

000004a2 <.L64>:
 4a2:	5a 53       	inc.b	r10		;
 4a4:	3a f0 ff 00 	and	#255,	r10	;#0x00ff
 4a8:	30 40 7e 03 	br	#0x037e		;

000004ac <.L63>:
 4ac:	b0 12 dc 08 	call	#2268		;#0x08dc
 4b0:	30 40 a2 04 	br	#0x04a2		;

000004b4 <.L88>:
 4b4:	67 43       	mov.b	#2,	r7	;r3 As==10
 4b6:	30 40 38 04 	br	#0x0438		;

000004ba <.L104>:
 4ba:	37 90 03 00 	cmp	#3,	r7	;
 4be:	df 24       	jz	$+448    	;abs 0x67e
 4c0:	7c 40 03 00 	mov.b	#3,	r12	;
 4c4:	0c 97       	cmp	r7,	r12	;
 4c6:	08 28       	jnc	$+18     	;abs 0x4d8
 4c8:	17 93       	cmp	#1,	r7	;r3 As==01
 4ca:	ad 24       	jz	$+348    	;abs 0x626
 4cc:	27 93       	cmp	#2,	r7	;r3 As==10
 4ce:	b0 24       	jz	$+354    	;abs 0x630

000004d0 <.L76>:
 4d0:	3c 40 9a 0c 	mov	#3226,	r12	;#0x0c9a
 4d4:	30 40 2a 06 	br	#0x062a		;

000004d8 <.L78>:
 4d8:	27 92       	cmp	#4,	r7	;r2 As==10
 4da:	fa 24       	jz	$+502    	;abs 0x6d0
 4dc:	37 90 05 00 	cmp	#5,	r7	;
 4e0:	f7 23       	jnz	$-16     	;abs 0x4d0
 4e2:	37 40 18 80 	mov	#32792,	r7	;#0x8018
 4e6:	c2 43 18 80 	mov.b	#0,	&0x8018	;r3 As==00
 4ea:	4e 43       	clr.b	r14		;
 4ec:	5d 43       	mov.b	#1,	r13	;r3 As==01
 4ee:	7c 40 53 00 	mov.b	#83,	r12	;#0x0053
 4f2:	b0 12 6a 02 	call	#618		;#0x026a
 4f6:	6d 42       	mov.b	#4,	r13	;r2 As==10
 4f8:	7c 40 53 00 	mov.b	#83,	r12	;#0x0053
 4fc:	b0 12 c0 01 	call	#448		;#0x01c0
 500:	5c 47 02 00 	mov.b	2(r7),	r12	;
 504:	4d 43       	clr.b	r13		;
 506:	0c 5c       	rla	r12		;
 508:	0d 6d       	rlc	r13		;
 50a:	0c 5c       	rla	r12		;
 50c:	0d 6d       	rlc	r13		;
 50e:	0c 5c       	rla	r12		;
 510:	0d 6d       	rlc	r13		;
 512:	0c 5c       	rla	r12		;
 514:	0d 6d       	rlc	r13		;
 516:	0c 5c       	rla	r12		;
 518:	0d 6d       	rlc	r13		;
 51a:	0c 5c       	rla	r12		;
 51c:	0d 6d       	rlc	r13		;
 51e:	0c 5c       	rla	r12		;
 520:	0d 6d       	rlc	r13		;
 522:	04 4c       	mov	r12,	r4	;
 524:	04 5c       	add	r12,	r4	;
 526:	06 4d       	mov	r13,	r6	;
 528:	06 6d       	addc	r13,	r6	;
 52a:	45 43       	clr.b	r5		;
 52c:	5c 47 01 00 	mov.b	1(r7),	r12	;
 530:	0d 45       	mov	r5,	r13	;
 532:	7e 40 10 00 	mov.b	#16,	r14	;#0x0010
 536:	b0 12 9e 08 	call	#2206		;#0x089e
 53a:	0c 54       	add	r4,	r12	;
 53c:	06 6d       	addc	r13,	r6	;
 53e:	54 47 03 00 	mov.b	3(r7),	r4	;
 542:	04 5c       	add	r12,	r4	;
 544:	06 65       	addc	r5,	r6	;
 546:	6c 47       	mov.b	@r7,	r12	;
 548:	0d 45       	mov	r5,	r13	;
 54a:	7e 40 18 00 	mov.b	#24,	r14	;#0x0018
 54e:	b0 12 9e 08 	call	#2206		;#0x089e
 552:	07 44       	mov	r4,	r7	;
 554:	07 5c       	add	r12,	r7	;
 556:	06 6d       	addc	r13,	r6	;
 558:	3c 40 6e 0c 	mov	#3182,	r12	;#0x0c6e
 55c:	8a 12       	call	r10		;
 55e:	0c 47       	mov	r7,	r12	;
 560:	0d 46       	mov	r6,	r13	;
 562:	b0 12 3c 03 	call	#828		;#0x033c
 566:	3c 40 f4 0a 	mov	#2804,	r12	;#0x0af4
 56a:	8a 12       	call	r10		;
 56c:	3c 40 81 0c 	mov	#3201,	r12	;#0x0c81
 570:	8a 12       	call	r10		;
 572:	0c 47       	mov	r7,	r12	;
 574:	0d 46       	mov	r6,	r13	;
 576:	b0 12 18 09 	call	#2328		;#0x0918
 57a:	44 4c       	mov.b	r12,	r4	;
 57c:	36 40 10 08 	mov	#2064,	r6	;#0x0810
 580:	7d 40 64 00 	mov.b	#100,	r13	;#0x0064
 584:	0c 44       	mov	r4,	r12	;
 586:	86 12       	call	r6		;
 588:	48 4c       	mov.b	r12,	r8	;
 58a:	39 40 08 80 	mov	#32776,	r9	;#0x8008
 58e:	4c 48       	mov.b	r8,	r12	;
 590:	7c 50 30 00 	add.b	#48,	r12	;#0x0030
 594:	c9 4c 00 00 	mov.b	r12,	0(r9)	;
 598:	7d 40 0a 00 	mov.b	#10,	r13	;#0x000a
 59c:	0c 44       	mov	r4,	r12	;
 59e:	86 12       	call	r6		;
 5a0:	7c 50 30 00 	add.b	#48,	r12	;#0x0030
 5a4:	4d 48       	mov.b	r8,	r13	;
 5a6:	4d 58       	add.b	r8,	r13	;
 5a8:	4d 5d       	rla.b	r13		;
 5aa:	4d 58       	add.b	r8,	r13	;
 5ac:	4d 5d       	rla.b	r13		;
 5ae:	4c 8d       	sub.b	r13,	r12	;
 5b0:	c9 4c 01 00 	mov.b	r12,	1(r9)	;
 5b4:	38 40 18 08 	mov	#2072,	r8	;#0x0818
 5b8:	7d 40 0a 00 	mov.b	#10,	r13	;#0x000a
 5bc:	0c 44       	mov	r4,	r12	;
 5be:	88 12       	call	r8		;
 5c0:	7c 50 30 00 	add.b	#48,	r12	;#0x0030
 5c4:	c9 4c 02 00 	mov.b	r12,	2(r9)	;
 5c8:	c9 45 03 00 	mov.b	r5,	3(r9)	;
 5cc:	0c 49       	mov	r9,	r12	;
 5ce:	8a 12       	call	r10		;
 5d0:	3c 40 98 0c 	mov	#3224,	r12	;#0x0c98
 5d4:	8a 12       	call	r10		;
 5d6:	37 f0 ff 00 	and	#255,	r7	;#0x00ff
 5da:	7d 40 64 00 	mov.b	#100,	r13	;#0x0064
 5de:	0c 47       	mov	r7,	r12	;
 5e0:	86 12       	call	r6		;
 5e2:	44 4c       	mov.b	r12,	r4	;
 5e4:	4d 44       	mov.b	r4,	r13	;
 5e6:	7d 50 30 00 	add.b	#48,	r13	;#0x0030
 5ea:	c9 4d 00 00 	mov.b	r13,	0(r9)	;
 5ee:	7d 40 0a 00 	mov.b	#10,	r13	;#0x000a
 5f2:	0c 47       	mov	r7,	r12	;
 5f4:	86 12       	call	r6		;
 5f6:	7c 50 30 00 	add.b	#48,	r12	;#0x0030
 5fa:	4d 44       	mov.b	r4,	r13	;
 5fc:	4d 54       	add.b	r4,	r13	;
 5fe:	4d 5d       	rla.b	r13		;
 600:	4d 54       	add.b	r4,	r13	;
 602:	4d 5d       	rla.b	r13		;
 604:	4c 8d       	sub.b	r13,	r12	;
 606:	c9 4c 01 00 	mov.b	r12,	1(r9)	;
 60a:	7d 40 0a 00 	mov.b	#10,	r13	;#0x000a
 60e:	0c 47       	mov	r7,	r12	;
 610:	88 12       	call	r8		;
 612:	7c 50 30 00 	add.b	#48,	r12	;#0x0030
 616:	c9 4c 02 00 	mov.b	r12,	2(r9)	;
 61a:	c9 45 03 00 	mov.b	r5,	3(r9)	;
 61e:	0c 49       	mov	r9,	r12	;
 620:	8a 12       	call	r10		;
 622:	30 40 76 06 	br	#0x0676		;

00000626 <.L79>:
 626:	3c 40 16 0b 	mov	#2838,	r12	;#0x0b16

0000062a <.L106>:
 62a:	8a 12       	call	r10		;
 62c:	30 40 f6 03 	br	#0x03f6		;

00000630 <.L80>:
 630:	3c 40 03 0c 	mov	#3075,	r12	;#0x0c03
 634:	8a 12       	call	r10		;
 636:	d2 43 18 80 	mov.b	#1,	&0x8018	;r3 As==01
 63a:	f2 40 7f 00 	mov.b	#127,	&0x8019	;#0x007f
 63e:	19 80 
 640:	36 40 6a 02 	mov	#618,	r6	;#0x026a
 644:	5e 43       	mov.b	#1,	r14	;r3 As==01
 646:	4d 47       	mov.b	r7,	r13	;
 648:	7c 40 21 00 	mov.b	#33,	r12	;#0x0021
 64c:	86 12       	call	r6		;
 64e:	d2 43 18 80 	mov.b	#1,	&0x8018	;r3 As==01
 652:	4e 43       	clr.b	r14		;
 654:	5d 43       	mov.b	#1,	r13	;r3 As==01
 656:	7c 40 21 00 	mov.b	#33,	r12	;#0x0021
 65a:	86 12       	call	r6		;
 65c:	5d 43       	mov.b	#1,	r13	;r3 As==01
 65e:	7c 40 21 00 	mov.b	#33,	r12	;#0x0021
 662:	b0 12 c0 01 	call	#448		;#0x01c0
 666:	3c 40 1a 0c 	mov	#3098,	r12	;#0x0c1a
 66a:	8a 12       	call	r10		;
 66c:	5c 42 18 80 	mov.b	&0x8018,r12	;0x8018
 670:	4d 43       	clr.b	r13		;

00000672 <.L109>:
 672:	b0 12 3c 03 	call	#828		;#0x033c

00000676 <.L108>:
 676:	3c 40 f4 0a 	mov	#2804,	r12	;#0x0af4
 67a:	30 40 2a 06 	br	#0x062a		;

0000067e <.L77>:
 67e:	37 40 18 80 	mov	#32792,	r7	;#0x8018
 682:	f2 40 fa ff 	mov.b	#65530,	&0x8018	;#0xfffa
 686:	18 80 
 688:	4e 43       	clr.b	r14		;
 68a:	5d 43       	mov.b	#1,	r13	;r3 As==01
 68c:	7c 40 53 00 	mov.b	#83,	r12	;#0x0053
 690:	b0 12 6a 02 	call	#618		;#0x026a
 694:	7d 40 06 00 	mov.b	#6,	r13	;
 698:	7c 40 53 00 	mov.b	#83,	r12	;#0x0053
 69c:	b0 12 c0 01 	call	#448		;#0x01c0
 6a0:	56 47 04 00 	mov.b	4(r7),	r6	;
 6a4:	06 56       	rla	r6		;
 6a6:	06 56       	rla	r6		;
 6a8:	06 56       	rla	r6		;
 6aa:	06 56       	rla	r6		;
 6ac:	06 56       	rla	r6		;
 6ae:	06 56       	rla	r6		;
 6b0:	06 56       	rla	r6		;
 6b2:	06 56       	rla	r6		;
 6b4:	57 47 05 00 	mov.b	5(r7),	r7	;
 6b8:	06 57       	add	r7,	r6	;
 6ba:	36 b0 00 80 	bit	#32768,	r6	;#0x8000
 6be:	07 77       	subc	r7,	r7	;
 6c0:	37 e3       	inv	r7		;
 6c2:	3c 40 28 0c 	mov	#3112,	r12	;#0x0c28
 6c6:	8a 12       	call	r10		;
 6c8:	0c 46       	mov	r6,	r12	;
 6ca:	0d 47       	mov	r7,	r13	;
 6cc:	30 40 72 06 	br	#0x0672		;

000006d0 <.L81>:
 6d0:	3c 40 42 0c 	mov	#3138,	r12	;#0x0c42
 6d4:	8a 12       	call	r10		;
 6d6:	7c 40 09 00 	mov.b	#9,	r12	;
 6da:	85 12       	call	r5		;
 6dc:	3c 40 08 80 	mov	#32776,	r12	;#0x8008
 6e0:	b0 12 74 09 	call	#2420		;#0x0974
 6e4:	09 4c       	mov	r12,	r9	;
 6e6:	05 4c       	mov	r12,	r5	;
 6e8:	35 50 ff 3f 	add	#16383,	r5	;#0x3fff
 6ec:	05 55       	rla	r5		;
 6ee:	05 55       	rla	r5		;
 6f0:	44 43       	clr.b	r4		;
 6f2:	46 43       	clr.b	r6		;
 6f4:	47 43       	clr.b	r7		;

000006f6 <.L83>:
 6f6:	09 94       	cmp	r4,	r9	;
 6f8:	25 20       	jnz	$+76     	;abs 0x744
 6fa:	35 40 18 80 	mov	#32792,	r5	;#0x8018
 6fe:	c2 43 18 80 	mov.b	#0,	&0x8018	;r3 As==00
 702:	c5 46 01 00 	mov.b	r6,	1(r5)	;
 706:	0c 46       	mov	r6,	r12	;
 708:	0d 47       	mov	r7,	r13	;
 70a:	b0 12 18 09 	call	#2328		;#0x0918
 70e:	c5 4c 02 00 	mov.b	r12,	2(r5)	;
 712:	0c 46       	mov	r6,	r12	;
 714:	0d 47       	mov	r7,	r13	;
 716:	7e 40 10 00 	mov.b	#16,	r14	;#0x0010
 71a:	b0 12 52 09 	call	#2386		;#0x0952
 71e:	c5 4c 03 00 	mov.b	r12,	3(r5)	;
 722:	0c 46       	mov	r6,	r12	;
 724:	0d 47       	mov	r7,	r13	;
 726:	7e 40 18 00 	mov.b	#24,	r14	;#0x0018
 72a:	b0 12 52 09 	call	#2386		;#0x0952
 72e:	c5 4c 04 00 	mov.b	r12,	4(r5)	;
 732:	5e 43       	mov.b	#1,	r14	;r3 As==01
 734:	7d 40 05 00 	mov.b	#5,	r13	;
 738:	7c 40 53 00 	mov.b	#83,	r12	;#0x0053
 73c:	b0 12 6a 02 	call	#618		;#0x026a
 740:	30 40 f6 03 	br	#0x03f6		;

00000744 <.L87>:
 744:	5c 44 08 80 	mov.b	-32760(r4),r12	;0xffff8008
 748:	4d 4c       	mov.b	r12,	r13	;
 74a:	7d 50 d0 ff 	add.b	#65488,	r13	;#0xffd0
 74e:	7e 40 09 00 	mov.b	#9,	r14	;
 752:	4e 9d       	cmp.b	r13,	r14	;
 754:	10 28       	jnc	$+34     	;abs 0x776
 756:	3c 50 d0 ff 	add	#65488,	r12	;#0xffd0

0000075a <.L107>:
 75a:	3c b0 00 80 	bit	#32768,	r12	;#0x8000
 75e:	0d 7d       	subc	r13,	r13	;
 760:	3d e3       	inv	r13		;

00000762 <.L85>:
 762:	0e 45       	mov	r5,	r14	;
 764:	b0 12 9e 08 	call	#2206		;#0x089e
 768:	06 5c       	add	r12,	r6	;
 76a:	07 6d       	addc	r13,	r7	;
 76c:	14 53       	inc	r4		;
 76e:	35 50 fc ff 	add	#65532,	r5	;#0xfffc
 772:	30 40 f6 06 	br	#0x06f6		;

00000776 <.L84>:
 776:	4d 4c       	mov.b	r12,	r13	;
 778:	7d 50 9f ff 	add.b	#65439,	r13	;#0xff9f
 77c:	7e 40 05 00 	mov.b	#5,	r14	;
 780:	4e 9d       	cmp.b	r13,	r14	;
 782:	04 28       	jnc	$+10     	;abs 0x78c
 784:	3c 50 a9 ff 	add	#65449,	r12	;#0xffa9
 788:	30 40 5a 07 	br	#0x075a		;

0000078c <.L86>:
 78c:	4d 4c       	mov.b	r12,	r13	;
 78e:	7d 50 bf ff 	add.b	#65471,	r13	;#0xffbf
 792:	7e 40 05 00 	mov.b	#5,	r14	;
 796:	4e 9d       	cmp.b	r13,	r14	;
 798:	04 28       	jnc	$+10     	;abs 0x7a2
 79a:	3c 50 c9 ff 	add	#65481,	r12	;#0xffc9
 79e:	30 40 5a 07 	br	#0x075a		;

000007a2 <.L89>:
 7a2:	4c 43       	clr.b	r12		;
 7a4:	4d 43       	clr.b	r13		;
 7a6:	30 40 62 07 	br	#0x0762		;

000007aa <.L105>:
 7aa:	3c 40 96 0a 	mov	#2710,	r12	;#0x0a96
 7ae:	8a 12       	call	r10		;
 7b0:	5c 43       	mov.b	#1,	r12	;r3 As==01
 7b2:	30 40 20 08 	br	#0x0820		;

000007b6 <udivmodhi4>:
 7b6:	0a 12       	push	r10		;

000007b8 <.LCFI0>:
 7b8:	09 12       	push	r9		;

000007ba <.LCFI1>:
 7ba:	08 12       	push	r8		;

000007bc <.LCFI2>:
 7bc:	07 12       	push	r7		;

000007be <.LCFI3>:
 7be:	06 12       	push	r6		;

000007c0 <.LCFI4>:
 7c0:	07 4c       	mov	r12,	r7	;
 7c2:	09 4d       	mov	r13,	r9	;
 7c4:	06 4e       	mov	r14,	r6	;

000007c6 <.LVL1>:
 7c6:	7a 40 11 00 	mov.b	#17,	r10	;#0x0011

000007ca <.Loc.35.1>:
 7ca:	58 43       	mov.b	#1,	r8	;r3 As==01

000007cc <.L2>:
 7cc:	09 97       	cmp	r7,	r9	;
 7ce:	09 28       	jnc	$+20     	;abs 0x7e2

000007d0 <.L15>:
 7d0:	4a 43       	clr.b	r10		;

000007d2 <.L4>:
 7d2:	08 93       	cmp	#0,	r8	;r3 As==00
 7d4:	0f 20       	jnz	$+32     	;abs 0x7f4

000007d6 <.L5>:
 7d6:	06 93       	cmp	#0,	r6	;r3 As==00
 7d8:	01 24       	jz	$+4      	;abs 0x7dc
 7da:	0a 47       	mov	r7,	r10	;

000007dc <.L1>:
 7dc:	0c 4a       	mov	r10,	r12	;
 7de:	30 40 24 08 	br	#0x0824		;

000007e2 <.L3>:
 7e2:	3a 53       	add	#-1,	r10	;r3 As==11

000007e4 <.Loc.38.1>:
 7e4:	0a 93       	cmp	#0,	r10	;r3 As==00
 7e6:	f7 27       	jz	$-16     	;abs 0x7d6

000007e8 <.Loc.38.1>:
 7e8:	09 93       	cmp	#0,	r9	;r3 As==00
 7ea:	f2 3b       	jl	$-26     	;abs 0x7d0

000007ec <.Loc.40.1>:
 7ec:	09 59       	rla	r9		;

000007ee <.Loc.41.1>:
 7ee:	08 58       	rla	r8		;
 7f0:	30 40 cc 07 	br	#0x07cc		;

000007f4 <.L9>:
 7f4:	07 99       	cmp	r9,	r7	;
 7f6:	02 28       	jnc	$+6      	;abs 0x7fc

000007f8 <.Loc.47.1>:
 7f8:	07 89       	sub	r9,	r7	;

000007fa <.Loc.48.1>:
 7fa:	0a d8       	bis	r8,	r10	;

000007fc <.L8>:
 7fc:	0c 48       	mov	r8,	r12	;
 7fe:	b0 12 dc 08 	call	#2268		;#0x08dc
 802:	08 4c       	mov	r12,	r8	;

00000804 <.Loc.51.1>:
 804:	0c 49       	mov	r9,	r12	;
 806:	b0 12 dc 08 	call	#2268		;#0x08dc
 80a:	09 4c       	mov	r12,	r9	;
 80c:	30 40 d2 07 	br	#0x07d2		;

00000810 <__mspabi_divu>:
 810:	4e 43       	clr.b	r14		;
 812:	b0 12 b6 07 	call	#1974		;#0x07b6

00000816 <.LVL41>:
 816:	30 41       	ret			

00000818 <__mspabi_remu>:
 818:	5e 43       	mov.b	#1,	r14	;r3 As==01
 81a:	b0 12 b6 07 	call	#1974		;#0x07b6

0000081e <.LVL43>:
 81e:	30 41       	ret			

00000820 <__mspabi_func_epilog_7>:
 820:	34 41       	pop	r4		;

00000822 <__mspabi_func_epilog_6>:
 822:	35 41       	pop	r5		;

00000824 <__mspabi_func_epilog_5>:
 824:	36 41       	pop	r6		;

00000826 <__mspabi_func_epilog_4>:
 826:	37 41       	pop	r7		;

00000828 <__mspabi_func_epilog_3>:
 828:	38 41       	pop	r8		;

0000082a <__mspabi_func_epilog_2>:
 82a:	39 41       	pop	r9		;

0000082c <__mspabi_func_epilog_1>:
 82c:	3a 41       	pop	r10		;
 82e:	30 41       	ret			

00000830 <__mspabi_slli_15>:
 830:	0c 5c       	rla	r12		;

00000832 <__mspabi_slli_14>:
 832:	0c 5c       	rla	r12		;

00000834 <__mspabi_slli_13>:
 834:	0c 5c       	rla	r12		;

00000836 <__mspabi_slli_12>:
 836:	0c 5c       	rla	r12		;

00000838 <__mspabi_slli_11>:
 838:	0c 5c       	rla	r12		;

0000083a <__mspabi_slli_10>:
 83a:	0c 5c       	rla	r12		;

0000083c <__mspabi_slli_9>:
 83c:	0c 5c       	rla	r12		;

0000083e <__mspabi_slli_8>:
 83e:	0c 5c       	rla	r12		;

00000840 <__mspabi_slli_7>:
 840:	0c 5c       	rla	r12		;

00000842 <__mspabi_slli_6>:
 842:	0c 5c       	rla	r12		;

00000844 <__mspabi_slli_5>:
 844:	0c 5c       	rla	r12		;

00000846 <__mspabi_slli_4>:
 846:	0c 5c       	rla	r12		;

00000848 <__mspabi_slli_3>:
 848:	0c 5c       	rla	r12		;

0000084a <__mspabi_slli_2>:
 84a:	0c 5c       	rla	r12		;

0000084c <__mspabi_slli_1>:
 84c:	0c 5c       	rla	r12		;
 84e:	30 41       	ret			

00000850 <.L11>:
 850:	3d 53       	add	#-1,	r13	;r3 As==11
 852:	0c 5c       	rla	r12		;

00000854 <__mspabi_slli>:
 854:	0d 93       	cmp	#0,	r13	;r3 As==00
 856:	fc 23       	jnz	$-6      	;abs 0x850
 858:	30 41       	ret			

0000085a <__mspabi_slll_15>:
 85a:	0c 5c       	rla	r12		;
 85c:	0d 6d       	rlc	r13		;

0000085e <__mspabi_slll_14>:
 85e:	0c 5c       	rla	r12		;
 860:	0d 6d       	rlc	r13		;

00000862 <__mspabi_slll_13>:
 862:	0c 5c       	rla	r12		;
 864:	0d 6d       	rlc	r13		;

00000866 <__mspabi_slll_12>:
 866:	0c 5c       	rla	r12		;
 868:	0d 6d       	rlc	r13		;

0000086a <__mspabi_slll_11>:
 86a:	0c 5c       	rla	r12		;
 86c:	0d 6d       	rlc	r13		;

0000086e <__mspabi_slll_10>:
 86e:	0c 5c       	rla	r12		;
 870:	0d 6d       	rlc	r13		;

00000872 <__mspabi_slll_9>:
 872:	0c 5c       	rla	r12		;
 874:	0d 6d       	rlc	r13		;

00000876 <__mspabi_slll_8>:
 876:	0c 5c       	rla	r12		;
 878:	0d 6d       	rlc	r13		;

0000087a <__mspabi_slll_7>:
 87a:	0c 5c       	rla	r12		;
 87c:	0d 6d       	rlc	r13		;

0000087e <__mspabi_slll_6>:
 87e:	0c 5c       	rla	r12		;
 880:	0d 6d       	rlc	r13		;

00000882 <__mspabi_slll_5>:
 882:	0c 5c       	rla	r12		;
 884:	0d 6d       	rlc	r13		;

00000886 <__mspabi_slll_4>:
 886:	0c 5c       	rla	r12		;
 888:	0d 6d       	rlc	r13		;

0000088a <__mspabi_slll_3>:
 88a:	0c 5c       	rla	r12		;
 88c:	0d 6d       	rlc	r13		;

0000088e <__mspabi_slll_2>:
 88e:	0c 5c       	rla	r12		;
 890:	0d 6d       	rlc	r13		;

00000892 <__mspabi_slll_1>:
 892:	0c 5c       	rla	r12		;
 894:	0d 6d       	rlc	r13		;
 896:	30 41       	ret			

00000898 <.L12>:
 898:	3e 53       	add	#-1,	r14	;r3 As==11
 89a:	0c 5c       	rla	r12		;
 89c:	0d 6d       	rlc	r13		;

0000089e <__mspabi_slll>:
 89e:	0e 93       	cmp	#0,	r14	;r3 As==00
 8a0:	fb 23       	jnz	$-8      	;abs 0x898
 8a2:	30 41       	ret			

000008a4 <__mspabi_srli_15>:
 8a4:	12 c3       	clrc			
 8a6:	0c 10       	rrc	r12		;

000008a8 <__mspabi_srli_14>:
 8a8:	12 c3       	clrc			
 8aa:	0c 10       	rrc	r12		;

000008ac <__mspabi_srli_13>:
 8ac:	12 c3       	clrc			
 8ae:	0c 10       	rrc	r12		;

000008b0 <__mspabi_srli_12>:
 8b0:	12 c3       	clrc			
 8b2:	0c 10       	rrc	r12		;

000008b4 <__mspabi_srli_11>:
 8b4:	12 c3       	clrc			
 8b6:	0c 10       	rrc	r12		;

000008b8 <__mspabi_srli_10>:
 8b8:	12 c3       	clrc			
 8ba:	0c 10       	rrc	r12		;

000008bc <__mspabi_srli_9>:
 8bc:	12 c3       	clrc			
 8be:	0c 10       	rrc	r12		;

000008c0 <__mspabi_srli_8>:
 8c0:	12 c3       	clrc			
 8c2:	0c 10       	rrc	r12		;

000008c4 <__mspabi_srli_7>:
 8c4:	12 c3       	clrc			
 8c6:	0c 10       	rrc	r12		;

000008c8 <__mspabi_srli_6>:
 8c8:	12 c3       	clrc			
 8ca:	0c 10       	rrc	r12		;

000008cc <__mspabi_srli_5>:
 8cc:	12 c3       	clrc			
 8ce:	0c 10       	rrc	r12		;

000008d0 <__mspabi_srli_4>:
 8d0:	12 c3       	clrc			
 8d2:	0c 10       	rrc	r12		;

000008d4 <__mspabi_srli_3>:
 8d4:	12 c3       	clrc			
 8d6:	0c 10       	rrc	r12		;

000008d8 <__mspabi_srli_2>:
 8d8:	12 c3       	clrc			
 8da:	0c 10       	rrc	r12		;

000008dc <__mspabi_srli_1>:
 8dc:	12 c3       	clrc			
 8de:	0c 10       	rrc	r12		;
 8e0:	30 41       	ret			

000008e2 <.L11>:
 8e2:	3d 53       	add	#-1,	r13	;r3 As==11
 8e4:	12 c3       	clrc			
 8e6:	0c 10       	rrc	r12		;

000008e8 <__mspabi_srli>:
 8e8:	0d 93       	cmp	#0,	r13	;r3 As==00
 8ea:	fb 23       	jnz	$-8      	;abs 0x8e2
 8ec:	30 41       	ret			

000008ee <__mspabi_srll_15>:
 8ee:	12 c3       	clrc			
 8f0:	0d 10       	rrc	r13		;
 8f2:	0c 10       	rrc	r12		;

000008f4 <__mspabi_srll_14>:
 8f4:	12 c3       	clrc			
 8f6:	0d 10       	rrc	r13		;
 8f8:	0c 10       	rrc	r12		;

000008fa <__mspabi_srll_13>:
 8fa:	12 c3       	clrc			
 8fc:	0d 10       	rrc	r13		;
 8fe:	0c 10       	rrc	r12		;

00000900 <__mspabi_srll_12>:
 900:	12 c3       	clrc			
 902:	0d 10       	rrc	r13		;
 904:	0c 10       	rrc	r12		;

00000906 <__mspabi_srll_11>:
 906:	12 c3       	clrc			
 908:	0d 10       	rrc	r13		;
 90a:	0c 10       	rrc	r12		;

0000090c <__mspabi_srll_10>:
 90c:	12 c3       	clrc			
 90e:	0d 10       	rrc	r13		;
 910:	0c 10       	rrc	r12		;

00000912 <__mspabi_srll_9>:
 912:	12 c3       	clrc			
 914:	0d 10       	rrc	r13		;
 916:	0c 10       	rrc	r12		;

00000918 <__mspabi_srll_8>:
 918:	12 c3       	clrc			
 91a:	0d 10       	rrc	r13		;
 91c:	0c 10       	rrc	r12		;

0000091e <__mspabi_srll_7>:
 91e:	12 c3       	clrc			
 920:	0d 10       	rrc	r13		;
 922:	0c 10       	rrc	r12		;

00000924 <__mspabi_srll_6>:
 924:	12 c3       	clrc			
 926:	0d 10       	rrc	r13		;
 928:	0c 10       	rrc	r12		;

0000092a <__mspabi_srll_5>:
 92a:	12 c3       	clrc			
 92c:	0d 10       	rrc	r13		;
 92e:	0c 10       	rrc	r12		;

00000930 <__mspabi_srll_4>:
 930:	12 c3       	clrc			
 932:	0d 10       	rrc	r13		;
 934:	0c 10       	rrc	r12		;

00000936 <__mspabi_srll_3>:
 936:	12 c3       	clrc			
 938:	0d 10       	rrc	r13		;
 93a:	0c 10       	rrc	r12		;

0000093c <__mspabi_srll_2>:
 93c:	12 c3       	clrc			
 93e:	0d 10       	rrc	r13		;
 940:	0c 10       	rrc	r12		;

00000942 <__mspabi_srll_1>:
 942:	12 c3       	clrc			
 944:	0d 10       	rrc	r13		;
 946:	0c 10       	rrc	r12		;
 948:	30 41       	ret			

0000094a <.L12>:
 94a:	3e 53       	add	#-1,	r14	;r3 As==11
 94c:	12 c3       	clrc			
 94e:	0d 10       	rrc	r13		;
 950:	0c 10       	rrc	r12		;

00000952 <__mspabi_srll>:
 952:	0e 93       	cmp	#0,	r14	;r3 As==00
 954:	fa 23       	jnz	$-10     	;abs 0x94a
 956:	30 41       	ret			

00000958 <strcmp>:
 958:	6e 4c       	mov.b	@r12,	r14	;
 95a:	0e 93       	cmp	#0,	r14	;r3 As==00
 95c:	03 24       	jz	$+8      	;abs 0x964

0000095e <.Loc.66.1>:
 95e:	cd 9e 00 00 	cmp.b	r14,	0(r13)	;
 962:	04 24       	jz	$+10     	;abs 0x96c

00000964 <.L3>:
 964:	0c 4e       	mov	r14,	r12	;

00000966 <.LVL1>:
 966:	6d 4d       	mov.b	@r13,	r13	;

00000968 <.LVL2>:
 968:	0c 8d       	sub	r13,	r12	;
 96a:	30 41       	ret			

0000096c <.L4>:
 96c:	1c 53       	inc	r12		;

0000096e <.Loc.69.1>:
 96e:	1d 53       	inc	r13		;
 970:	30 40 58 09 	br	#0x0958		;

00000974 <strlen>:
 974:	0d 4c       	mov	r12,	r13	;

00000976 <.L2>:
 976:	cd 93 00 00 	cmp.b	#0,	0(r13)	;r3 As==00
 97a:	03 20       	jnz	$+8      	;abs 0x982

0000097c <.Loc.88.1>:
 97c:	0d 8c       	sub	r12,	r13	;

0000097e <.LVL3>:
 97e:	0c 4d       	mov	r13,	r12	;

00000980 <.LVL4>:
 980:	30 41       	ret			

00000982 <.L3>:
 982:	1d 53       	inc	r13		;
 984:	30 40 76 09 	br	#0x0976		;

Disassembly of section .rodata:

00000988 <_etext-0x346>:
 988:	08 20       	jnz	$+18     	;abs 0x99a
 98a:	08 00       	mova	@r0,	r8	;
 98c:	0a 72       	subc	r2,	r10	;
 98e:	65 61       	addc.b	@r1,	r5	;
 990:	64 5f       	add.b	@r15,	r4	;
 992:	69 32       	jn	$-812    	;abs 0x666
 994:	63 5f       	.word	0x5f63;	????
 996:	61 64       	addc.b	@r4,	r1	;
 998:	64 72       	subc.b	#4,	r4	;r2 As==10
 99a:	65 73       	subc.b	#2,	r5	;r3 As==10
 99c:	73 3a       	jl	$-792    	;abs 0x684
 99e:	20 4e       	br	@r14		;
 9a0:	6f 20       	jnz	$+224    	;abs 0xa80
 9a2:	41 43       	clr.b	r1		;
 9a4:	4b 2e       	jc	$-872    	;abs 0x63c
 9a6:	20 53       	incd	r0		;
 9a8:	65 6e       	addc.b	@r14,	r5	;
 9aa:	64 69       	addc.b	@r9,	r4	;
 9ac:	6e 67       	addc.b	@r7,	r14	;
 9ae:	20 53       	incd	r0		;
 9b0:	54 4f 50 20 	mov.b	8272(r15),r4	;0x02050
 9b4:	61 6e       	addc.b	@r14,	r1	;
 9b6:	64 20       	jnz	$+202    	;abs 0xa80
 9b8:	74 65       	addc.b	@r5+,	r4	;
 9ba:	72 6d       	addc.b	@r13+,	r2	;
 9bc:	69 6e       	addc.b	@r14,	r9	;
 9be:	61 74       	subc.b	@r4,	r1	;
 9c0:	69 6e       	addc.b	@r14,	r9	;
 9c2:	67 20       	jnz	$+208    	;abs 0xa92
 9c4:	72 65       	addc.b	@r5+,	r2	;
 9c6:	61 64       	addc.b	@r4,	r1	;
 9c8:	2e 0a 00 0a 	mova	&657920,r14	;0xa0a00
 9cc:	77 72       	subc.b	#8,	r7	;r2 As==11
 9ce:	69 74       	subc.b	@r4,	r9	;
 9d0:	65 5f       	add.b	@r15,	r5	;
 9d2:	69 32       	jn	$-812    	;abs 0x6a6
 9d4:	63 5f       	.word	0x5f63;	????
 9d6:	61 64       	addc.b	@r4,	r1	;
 9d8:	64 72       	subc.b	#4,	r4	;r2 As==10
 9da:	65 73       	subc.b	#2,	r5	;r3 As==10
 9dc:	73 3a       	jl	$-792    	;abs 0x6c4
 9de:	20 4e       	br	@r14		;
 9e0:	6f 20       	jnz	$+224    	;abs 0xac0
 9e2:	41 43       	clr.b	r1		;
 9e4:	4b 20       	jnz	$+152    	;abs 0xa7c
 9e6:	69 6e       	addc.b	@r14,	r9	;
 9e8:	20 72       	subc	#4,	r0	;r2 As==10
 9ea:	65 73       	subc.b	#2,	r5	;r3 As==10
 9ec:	70 6f       	addc.b	@r15+,	r0	;
 9ee:	6e 73       	subc.b	#2,	r14	;r3 As==10
 9f0:	65 20       	jnz	$+204    	;abs 0xabc
 9f2:	74 6f       	addc.b	@r15+,	r4	;
 9f4:	20 64       	addc	@r4,	r0	;
 9f6:	65 76       	subc.b	@r6,	r5	;
 9f8:	69 63       	addc.b	#2,	r9	;r3 As==10
 9fa:	65 2d       	jc	$+716    	;abs 0xcc6
 9fc:	49 44       	mov.b	r4,	r9	;
 9fe:	2e 20       	jnz	$+94     	;abs 0xa5c
 a00:	53 65       	.word	0x6553;	????
 a02:	6e 64       	addc.b	@r4,	r14	;
 a04:	69 6e       	addc.b	@r14,	r9	;
 a06:	67 20       	jnz	$+208    	;abs 0xad6
 a08:	53 54       	.word	0x5453;	????
 a0a:	4f 50       	add.b	r0,	r15	;
 a0c:	20 61       	addc	@r1,	r0	;
 a0e:	6e 64       	addc.b	@r4,	r14	;
 a10:	20 74       	subc	@r4,	r0	;
 a12:	65 72       	subc.b	#4,	r5	;r2 As==10
 a14:	6d 69       	addc.b	@r9,	r13	;
 a16:	6e 61       	addc.b	@r1,	r14	;
 a18:	74 69       	addc.b	@r9+,	r4	;
 a1a:	6e 67       	addc.b	@r7,	r14	;
 a1c:	2e 0a 00 0a 	mova	&657920,r14	;0xa0a00
 a20:	2d 2d       	jc	$+604    	;abs 0xc7c
 a22:	2d 2d       	jc	$+604    	;abs 0xc7e
 a24:	2d 2d       	jc	$+604    	;abs 0xc80
 a26:	2d 2d       	jc	$+604    	;abs 0xc82
 a28:	2d 2d       	jc	$+604    	;abs 0xc84
 a2a:	2d 2d       	jc	$+604    	;abs 0xc86
 a2c:	2d 2d       	jc	$+604    	;abs 0xc88
 a2e:	2d 2d       	jc	$+604    	;abs 0xc8a
 a30:	2d 2d       	jc	$+604    	;abs 0xc8c
 a32:	2d 2d       	jc	$+604    	;abs 0xc8e
 a34:	2d 2d       	jc	$+604    	;abs 0xc90
 a36:	2d 2d       	jc	$+604    	;abs 0xc92
 a38:	2d 2d       	jc	$+604    	;abs 0xc94
 a3a:	2d 2d       	jc	$+604    	;abs 0xc96
 a3c:	2d 2d       	jc	$+604    	;abs 0xc98
 a3e:	2d 2d       	jc	$+604    	;abs 0xc9a
 a40:	2d 2d       	jc	$+604    	;abs 0xc9c
 a42:	2d 2d       	jc	$+604    	;abs 0xc9e
 a44:	2d 2d       	jc	$+604    	;abs 0xca0
 a46:	0a 2d       	jc	$+534    	;abs 0xc5c
 a48:	2d 2d       	jc	$+604    	;abs 0xca4
 a4a:	20 49       	br	@r9		;
 a4c:	32 43       	mov	#-1,	r2	;r3 As==11
 a4e:	20 57       	add	@r7,	r0	;
 a50:	69 73       	subc.b	#2,	r9	;r3 As==10
 a52:	68 62       	addc.b	#4,	r8	;r2 As==10
 a54:	6f 6e       	addc.b	@r14,	r15	;
 a56:	65 20       	jnz	$+204    	;abs 0xb22
 a58:	45 78       	subc.b	r8,	r5	;
 a5a:	70 6c       	addc.b	@r12+,	r0	;
 a5c:	6f 72       	subc.b	#4,	r15	;r2 As==10
 a5e:	65 72       	subc.b	#4,	r5	;r2 As==10
 a60:	20 54       	add	@r4,	r0	;
 a62:	65 72       	subc.b	#4,	r5	;r2 As==10
 a64:	6d 69       	addc.b	@r9,	r13	;
 a66:	6e 61       	addc.b	@r1,	r14	;
 a68:	6c 20       	jnz	$+218    	;abs 0xb42
 a6a:	2d 2d       	jc	$+604    	;abs 0xcc6
 a6c:	0a 2d       	jc	$+534    	;abs 0xc82
 a6e:	2d 2d       	jc	$+604    	;abs 0xcca
 a70:	2d 2d       	jc	$+604    	;abs 0xccc
 a72:	2d 2d       	jc	$+604    	;abs 0xcce
 a74:	2d 2d       	jc	$+604    	;abs 0xcd0
 a76:	2d 2d       	jc	$+604    	;abs 0xcd2
 a78:	2d 2d       	jc	$+604    	;abs 0xcd4
 a7a:	2d 2d       	jc	$+604    	;abs 0xcd6
 a7c:	2d 2d       	jc	$+604    	;abs 0xcd8
 a7e:	2d 2d       	jc	$+604    	;abs 0xcda
 a80:	2d 2d       	jc	$+604    	;abs 0xcdc
 a82:	2d 2d       	jc	$+604    	;abs 0xcde
 a84:	2d 2d       	jc	$+604    	;abs 0xce0
 a86:	2d 2d       	jc	$+604    	;abs 0xce2
 a88:	2d 2d       	jc	$+604    	;abs 0xce4
 a8a:	2d 2d       	jc	$+604    	;abs 0xce6
 a8c:	2d 2d       	jc	$+604    	;abs 0xce8
 a8e:	2d 2d       	jc	$+604    	;abs 0xcea
 a90:	2d 2d       	jc	$+604    	;abs 0xcec
 a92:	2d 0a 0a 00 	mova	&655370,r13	;0xa000a
 a96:	45 72       	subc.b	r2,	r5	;
 a98:	72 6f       	addc.b	@r15+,	r2	;
 a9a:	72 21       	jnz	$+742    	;abs 0xd80
 a9c:	20 4e       	br	@r14		;
 a9e:	6f 20       	jnz	$+224    	;abs 0xb7e
 aa0:	57 69 73 68 	addc.b	26739(r9),r7	;0x06873
 aa4:	62 6f       	addc.b	@r15,	r2	;
 aa6:	6e 65       	addc.b	@r5,	r14	;
 aa8:	20 61       	addc	@r1,	r0	;
 aaa:	64 61       	addc.b	@r1,	r4	;
 aac:	70 74       	subc.b	@r4+,	r0	;
 aae:	65 72       	subc.b	#4,	r5	;r2 As==10
 ab0:	20 73       	subc	#2,	r0	;r3 As==10
 ab2:	79 6e       	addc.b	@r14+,	r9	;
 ab4:	74 68       	addc.b	@r8+,	r4	;
 ab6:	65 73       	subc.b	#2,	r5	;r3 As==10
 ab8:	69 7a       	subc.b	@r10,	r9	;
 aba:	65 64       	addc.b	@r4,	r5	;
 abc:	21 00 53 65 	mova	&25939,	r1	;0x06553
 ac0:	74 74       	subc.b	@r4+,	r4	;
 ac2:	69 6e       	addc.b	@r14,	r9	;
 ac4:	67 20       	jnz	$+208    	;abs 0xb94
 ac6:	75 70 20 49 	subc.b	#18720,	r5	;#0x4920
 aca:	32 43       	mov	#-1,	r2	;r3 As==11
 acc:	20 63       	addc	#2,	r0	;r3 As==10
 ace:	6f 72       	subc.b	#4,	r15	;r2 As==10
 ad0:	65 00 0a 53 	mova	r0,	&348938	; 0x5530a
 ad4:	65 74       	subc.b	@r4,	r5	;
 ad6:	75 70 20 64 	subc.b	#25632,	r5	;#0x6420
 ada:	6f 6e       	addc.b	@r14,	r15	;
 adc:	65 2e       	jc	$-820    	;abs 0x7a8
 ade:	0a 00       	mova	@r0,	r10	;
 ae0:	0a 45       	mov	r5,	r10	;
 ae2:	6e 74       	subc.b	@r4,	r14	;
 ae4:	65 72       	subc.b	#4,	r5	;r2 As==10
 ae6:	20 61       	addc	@r1,	r0	;
 ae8:	20 63       	addc	#2,	r0	;r3 As==10
 aea:	6f 6d       	addc.b	@r13,	r15	;
 aec:	6d 61       	addc.b	@r1,	r13	;
 aee:	6e 64       	addc.b	@r4,	r14	;
 af0:	3a 3e       	jmp	$-906    	;abs 0x766
 af2:	20 00 0a 00 	bra	&10		;0x0000a
 af6:	68 65       	addc.b	@r5,	r8	;
 af8:	6c 70       	subc.b	@r0,	r12	;
 afa:	00 65       	addc	r5,	r0	;
 afc:	6e 61       	addc.b	@r1,	r14	;
 afe:	62 6c       	addc.b	@r12,	r2	;
 b00:	65 00 69 64 	mova	r0,	&353385	; 0x56469
 b04:	00 77       	subc	r7,	r0	;
 b06:	72 69       	addc.b	@r9+,	r2	;
 b08:	74 65       	addc.b	@r5+,	r4	;
 b0a:	00 72       	subc	r2,	r0	;
 b0c:	65 61       	addc.b	@r1,	r5	;
 b0e:	64 00 72 65 	mova	r0,	&288114	; 0x46572
 b12:	73 65       	.word	0x6573;	????
 b14:	74 00 41 76 	mova	r0,	30273(r4); 0x07641
 b18:	61 69       	addc.b	@r9,	r1	;
 b1a:	6c 61       	addc.b	@r1,	r12	;
 b1c:	62 6c       	addc.b	@r12,	r2	;
 b1e:	65 20       	jnz	$+204    	;abs 0xbea
 b20:	63 6f       	.word	0x6f63;	????
 b22:	6d 6d       	addc.b	@r13,	r13	;
 b24:	61 6e       	addc.b	@r14,	r1	;
 b26:	64 73       	subc.b	#2,	r4	;r3 As==10
 b28:	3a 0a 20 68 	mova	26656(r10),r10	;0x06820
 b2c:	65 6c       	addc.b	@r12,	r5	;
 b2e:	70 20       	jnz	$+226    	;abs 0xc10
 b30:	20 20       	jnz	$+66     	;abs 0xb72
 b32:	2d 20       	jnz	$+92     	;abs 0xb8e
 b34:	73 68       	.word	0x6873;	????
 b36:	6f 77       	subc.b	@r7,	r15	;
 b38:	20 74       	subc	@r4,	r0	;
 b3a:	68 69       	addc.b	@r9,	r8	;
 b3c:	73 20       	jnz	$+232    	;abs 0xc24
 b3e:	74 65       	addc.b	@r5+,	r4	;
 b40:	78 74       	subc.b	@r4+,	r8	;
 b42:	0a 20       	jnz	$+22     	;abs 0xb58
 b44:	65 6e       	addc.b	@r14,	r5	;
 b46:	61 62       	addc.b	#4,	r1	;r2 As==10
 b48:	6c 65       	addc.b	@r5,	r12	;
 b4a:	20 2d       	jc	$+578    	;abs 0xd8c
 b4c:	20 65       	addc	@r5,	r0	;
 b4e:	6e 61       	addc.b	@r1,	r14	;
 b50:	62 6c       	addc.b	@r12,	r2	;
 b52:	65 20       	jnz	$+204    	;abs 0xc1e
 b54:	49 32       	jn	$-876    	;abs 0x7e8
 b56:	43 20       	jnz	$+136    	;abs 0xbde
 b58:	62 72       	subc.b	#4,	r2	;r2 As==10
 b5a:	69 64       	addc.b	@r4,	r9	;
 b5c:	67 65       	addc.b	@r5,	r7	;
 b5e:	20 6f       	addc	@r15,	r0	;
 b60:	6e 20       	jnz	$+222    	;abs 0xc3e
 b62:	45 6e       	addc.b	r14,	r5	;
 b64:	63 6c       	.word	0x6c63;	????
 b66:	75 73       	subc.b	#-1,	r5	;r3 As==11
 b68:	74 72       	subc.b	#8,	r4	;r2 As==11
 b6a:	61 0a 20 69 	mova	r10,	&92448	; 0x16920
 b6e:	64 20       	jnz	$+202    	;abs 0xc38
 b70:	20 20       	jnz	$+66     	;abs 0xbb2
 b72:	20 20       	jnz	$+66     	;abs 0xbb4
 b74:	2d 20       	jnz	$+92     	;abs 0xbd0
 b76:	52 65 61 64 	addc.b	25697(r5),r2	;0x06461
 b7a:	20 66       	addc	@r6,	r0	;
 b7c:	72 6f       	addc.b	@r15+,	r2	;
 b7e:	6d 20       	jnz	$+220    	;abs 0xc5a
 b80:	45 32       	jn	$-884    	;abs 0x80c
 b82:	34 41       	pop	r4		;
 b84:	41 30       	jn	$+132    	;abs 0xc08
 b86:	32 35       	jge	$+614    	;abs 0xdec
 b88:	45 34       	jge	$+140    	;abs 0xc14
 b8a:	38 54       	add	@r4+,	r8	;
 b8c:	20 55       	add	@r5,	r0	;
 b8e:	6e 69       	addc.b	@r9,	r14	;
 b90:	71 75       	subc.b	@r5+,	r1	;
 b92:	65 20       	jnz	$+204    	;abs 0xc5e
 b94:	49 44       	mov.b	r4,	r9	;
 b96:	0a 20       	jnz	$+22     	;abs 0xbac
 b98:	77 72       	subc.b	#8,	r7	;r2 As==11
 b9a:	69 74       	subc.b	@r4,	r9	;
 b9c:	65 20       	jnz	$+204    	;abs 0xc68
 b9e:	20 2d       	jc	$+578    	;abs 0xde0
 ba0:	20 77       	subc	@r7,	r0	;
 ba2:	72 69       	addc.b	@r9+,	r2	;
 ba4:	74 65       	addc.b	@r5+,	r4	;
 ba6:	20 74       	subc	@r4,	r0	;
 ba8:	6f 20       	jnz	$+224    	;abs 0xc88
 baa:	45 32       	jn	$-884    	;abs 0x836
 bac:	34 41       	pop	r4		;
 bae:	41 30       	jn	$+132    	;abs 0xc32
 bb0:	32 35       	jge	$+614    	;abs 0xe16
 bb2:	45 34       	jge	$+140    	;abs 0xc3e
 bb4:	38 54       	add	@r4+,	r8	;
 bb6:	20 50       	add	@r0,	r0	;
 bb8:	52 4f 4d 20 	mov.b	8269(r15),r2	;0x0204d
 bbc:	61 72       	subc.b	#4,	r1	;r2 As==10
 bbe:	65 61       	addc.b	@r1,	r5	;
 bc0:	20 0a 20 72 	bra	&684576	;0xa7220
 bc4:	65 61       	addc.b	@r1,	r5	;
 bc6:	64 20       	jnz	$+202    	;abs 0xc90
 bc8:	20 20       	jnz	$+66     	;abs 0xc0a
 bca:	2d 20       	jnz	$+92     	;abs 0xc26
 bcc:	72 65       	addc.b	@r5+,	r2	;
 bce:	61 64       	addc.b	@r4,	r1	;
 bd0:	20 66       	addc	@r6,	r0	;
 bd2:	72 6f       	addc.b	@r15+,	r2	;
 bd4:	6d 20       	jnz	$+220    	;abs 0xcb0
 bd6:	45 32       	jn	$-884    	;abs 0x862
 bd8:	34 41       	pop	r4		;
 bda:	41 30       	jn	$+132    	;abs 0xc5e
 bdc:	32 35       	jge	$+614    	;abs 0xe42
 bde:	45 34       	jge	$+140    	;abs 0xc6a
 be0:	38 54       	add	@r4+,	r8	;
 be2:	20 50       	add	@r0,	r0	;
 be4:	52 4f 4d 20 	mov.b	8269(r15),r2	;0x0204d
 be8:	61 72       	subc.b	#4,	r1	;r2 As==10
 bea:	65 61       	addc.b	@r1,	r5	;
 bec:	20 0a 20 72 	bra	&684576	;0xa7220
 bf0:	65 73       	subc.b	#2,	r5	;r3 As==10
 bf2:	65 74       	subc.b	@r4,	r5	;
 bf4:	20 20       	jnz	$+66     	;abs 0xc36
 bf6:	2d 20       	jnz	$+92     	;abs 0xc52
 bf8:	72 65       	addc.b	@r5+,	r2	;
 bfa:	73 65       	.word	0x6573;	????
 bfc:	74 20       	jnz	$+234    	;abs 0xce6
 bfe:	43 50       	.word	0x5043;	????
 c00:	55 0a       	rlam	#3,	r5	;
 c02:	00 0a       	bra	@r10		;
 c04:	45 6e       	addc.b	r14,	r5	;
 c06:	61 62       	addc.b	#4,	r1	;r2 As==10
 c08:	6c 69       	addc.b	@r9,	r12	;
 c0a:	6e 67       	addc.b	@r7,	r14	;
 c0c:	20 49       	br	@r9		;
 c0e:	32 43       	mov	#-1,	r2	;r3 As==11
 c10:	20 62       	addc	#4,	r0	;r2 As==10
 c12:	72 69       	addc.b	@r9+,	r2	;
 c14:	64 67       	addc.b	@r7,	r4	;
 c16:	65 3a       	jl	$-820    	;abs 0x8e2
 c18:	0a 00       	mova	@r0,	r10	;
 c1a:	50 6f 73 74 	addc.b	29811(r15),r0	;0x07473
 c1e:	20 52       	add	#4,	r0	;r2 As==10
 c20:	65 67       	addc.b	@r7,	r5	;
 c22:	44 69       	addc.b	r9,	r4	;
 c24:	72 3a       	jl	$-794    	;abs 0x90a
 c26:	20 00 0a 55 	bra	&21770		;0x0550a
 c2a:	49 44       	mov.b	r4,	r9	;
 c2c:	20 66       	addc	@r6,	r0	;
 c2e:	72 6f       	addc.b	@r15+,	r2	;
 c30:	6d 20       	jnz	$+220    	;abs 0xd0c
 c32:	45 32       	jn	$-884    	;abs 0x8be
 c34:	34 41       	pop	r4		;
 c36:	41 30       	jn	$+132    	;abs 0xcba
 c38:	32 35       	jge	$+614    	;abs 0xe9e
 c3a:	45 34       	jge	$+140    	;abs 0xcc6
 c3c:	38 54       	add	@r4+,	r8	;
 c3e:	20 3d       	jmp	$+578    	;abs 0xe80
 c40:	20 00 45 6e 	bra	&28229		;0x06e45
 c44:	74 65       	addc.b	@r5+,	r4	;
 c46:	72 20       	jnz	$+230    	;abs 0xd2c
 c48:	68 65       	addc.b	@r5,	r8	;
 c4a:	78 61       	addc.b	@r1+,	r8	;
 c4c:	64 65       	addc.b	@r5,	r4	;
 c4e:	63 69       	.word	0x6963;	????
 c50:	6d 61       	addc.b	@r1,	r13	;
 c52:	6c 20       	jnz	$+218    	;abs 0xd2c
 c54:	64 61       	addc.b	@r1,	r4	;
 c56:	74 61       	addc.b	@r1+,	r4	;
 c58:	20 74       	subc	@r4,	r0	;
 c5a:	6f 20       	jnz	$+224    	;abs 0xd3a
 c5c:	77 72       	subc.b	#8,	r7	;r2 As==11
 c5e:	69 74       	subc.b	@r4,	r9	;
 c60:	65 20       	jnz	$+204    	;abs 0xd2c
 c62:	74 6f       	addc.b	@r15+,	r4	;
 c64:	20 50       	add	@r0,	r0	;
 c66:	52 4f 4d 3a 	mov.b	14925(r15),r2	;0x03a4d
 c6a:	20 30       	jn	$+66     	;abs 0xcac
 c6c:	78 00 0a 44 	mova	r0,	17418(r8); 0x0440a
 c70:	61 74       	subc.b	@r4,	r1	;
 c72:	61 20       	jnz	$+196    	;abs 0xd36
 c74:	66 72       	subc.b	#4,	r6	;r2 As==10
 c76:	6f 6d       	addc.b	@r13,	r15	;
 c78:	20 50       	add	@r0,	r0	;
 c7a:	52 4f 4d 20 	mov.b	8269(r15),r2	;0x0204d
 c7e:	3d 20       	jnz	$+124    	;abs 0xcfa
 c80:	00 0a       	bra	@r10		;
 c82:	49 50       	add.b	r0,	r9	;
 c84:	20 41       	br	@r1		;
 c86:	64 64       	addc.b	@r4,	r4	;
 c88:	72 65       	addc.b	@r5+,	r2	;
 c8a:	73 73       	.word	0x7373;	????
 c8c:	20 3d       	jmp	$+578    	;abs 0xece
 c8e:	20 31       	jn	$+578    	;abs 0xed0
 c90:	39 32       	jn	$-908    	;abs 0x904
 c92:	2e 31       	jn	$+606    	;abs 0xef0
 c94:	36 38       	jl	$+110    	;abs 0xd02
 c96:	2e 00 2e 00 	mova	&46,	r14	;0x0002e
 c9a:	49 6e       	addc.b	r14,	r9	;
 c9c:	76 61       	addc.b	@r1+,	r6	;
 c9e:	6c 69       	addc.b	@r9,	r12	;
 ca0:	64 20       	jnz	$+202    	;abs 0xd6a
 ca2:	63 6f       	.word	0x6f63;	????
 ca4:	6d 6d       	addc.b	@r13,	r13	;
 ca6:	61 6e       	addc.b	@r14,	r1	;
 ca8:	64 2e       	jc	$-822    	;abs 0x972
 caa:	20 54       	add	@r4,	r0	;
 cac:	79 70 65 20 	subc.b	#8293,	r9	;#0x2065
 cb0:	27 68       	addc	@r8,	r7	;
 cb2:	65 6c       	addc.b	@r12,	r5	;
 cb4:	70 27       	jz	$-286    	;abs 0xb96
 cb6:	20 74       	subc	@r4,	r0	;
 cb8:	6f 20       	jnz	$+224    	;abs 0xd98
 cba:	73 65       	.word	0x6573;	????
 cbc:	65 20       	jnz	$+204    	;abs 0xd88
 cbe:	61 6c       	addc.b	@r12,	r1	;
 cc0:	6c 20       	jnz	$+218    	;abs 0xd9a
 cc2:	63 6f       	.word	0x6f63;	????
 cc4:	6d 6d       	addc.b	@r13,	r13	;
 cc6:	61 6e       	addc.b	@r14,	r1	;
 cc8:	64 73       	subc.b	#2,	r4	;r3 As==10
 cca:	2e 0a 00 00 	mova	&655360,r14	;0xa0000

Disassembly of section .bss:

00008008 <__bssstart>:
    8008:	00 00       	beq			
    800a:	00 00       	beq			
    800c:	00 00       	beq			
    800e:	00 00       	beq			
    8010:	00 00       	beq			
    8012:	00 00       	beq			
    8014:	00 00       	beq			
    8016:	00 00       	beq			

00008018 <buffer>:
    8018:	00 00       	beq			
    801a:	00 00       	beq			
    801c:	00 00       	beq			
    801e:	00 00       	beq			
    8020:	00 00       	beq			
    8022:	00 00       	beq			
    8024:	00 00       	beq			
    8026:	00 00       	beq			

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
  48:	00 08       	Address 0x00000048 is out of bounds.
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
  92:	80 62       	Address 0x00000092 is out of bounds.
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
