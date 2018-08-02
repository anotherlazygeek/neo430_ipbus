
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
  2e:	35 40 e8 0e 	mov	#3816,	r5	;#0x0ee8

00000032 <.Loc.77.1>:
    mov  #__data_end_rom, r6
  32:	36 40 e8 0e 	mov	#3816,	r6	;#0x0ee8

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
  58:	b0 12 3c 02 	call	#572		;#0x023c

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
  96:	30 40 14 09 	br	#0x0914		;

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

000000ae <hexstr_to_uint>:
  ae:	0a 12       	push	r10		;
  b0:	09 12       	push	r9		;
  b2:	08 12       	push	r8		;
  b4:	07 12       	push	r7		;
  b6:	06 12       	push	r6		;
  b8:	05 12       	push	r5		;
  ba:	4a 4d       	mov.b	r13,	r10	;
  bc:	05 4c       	mov	r12,	r5	;
  be:	48 43       	clr.b	r8		;
  c0:	49 43       	clr.b	r9		;
  c2:	06 48       	mov	r8,	r6	;
  c4:	07 49       	mov	r9,	r7	;

000000c6 <.L9>:
  c6:	4c 4a       	mov.b	r10,	r12	;
  c8:	7c 53       	add.b	#-1,	r12	;r3 As==11
  ca:	4a 4c       	mov.b	r12,	r10	;
  cc:	7c 93       	cmp.b	#-1,	r12	;r3 As==11
  ce:	04 20       	jnz	$+10     	;abs 0xd8
  d0:	0c 48       	mov	r8,	r12	;
  d2:	0d 49       	mov	r9,	r13	;
  d4:	30 40 10 09 	br	#0x0910		;

000000d8 <.L13>:
  d8:	6c 45       	mov.b	@r5,	r12	;
  da:	4d 4c       	mov.b	r12,	r13	;
  dc:	7d 50 d0 ff 	add.b	#65488,	r13	;#0xffd0
  e0:	7e 40 09 00 	mov.b	#9,	r14	;
  e4:	4e 9d       	cmp.b	r13,	r14	;
  e6:	10 28       	jnc	$+34     	;abs 0x108
  e8:	3c 50 d0 ff 	add	#65488,	r12	;#0xffd0

000000ec <.L15>:
  ec:	3c b0 00 80 	bit	#32768,	r12	;#0x8000
  f0:	0d 7d       	subc	r13,	r13	;
  f2:	3d e3       	inv	r13		;

000000f4 <.L11>:
  f4:	0e 4a       	mov	r10,	r14	;
  f6:	0e 5a       	add	r10,	r14	;
  f8:	0e 5e       	rla	r14		;
  fa:	b0 12 8c 09 	call	#2444		;#0x098c
  fe:	08 5c       	add	r12,	r8	;
 100:	09 6d       	addc	r13,	r9	;
 102:	15 53       	inc	r5		;
 104:	30 40 c6 00 	br	#0x00c6		;

00000108 <.L10>:
 108:	4d 4c       	mov.b	r12,	r13	;
 10a:	7d 50 9f ff 	add.b	#65439,	r13	;#0xff9f
 10e:	7e 40 05 00 	mov.b	#5,	r14	;
 112:	4e 9d       	cmp.b	r13,	r14	;
 114:	04 28       	jnc	$+10     	;abs 0x11e
 116:	3c 50 a9 ff 	add	#65449,	r12	;#0xffa9
 11a:	30 40 ec 00 	br	#0x00ec		;

0000011e <.L12>:
 11e:	4d 4c       	mov.b	r12,	r13	;
 120:	7d 50 bf ff 	add.b	#65471,	r13	;#0xffbf
 124:	7e 40 05 00 	mov.b	#5,	r14	;
 128:	4e 9d       	cmp.b	r13,	r14	;
 12a:	04 28       	jnc	$+10     	;abs 0x134
 12c:	3c 50 c9 ff 	add	#65481,	r12	;#0xffc9
 130:	30 40 ec 00 	br	#0x00ec		;

00000134 <.L14>:
 134:	0c 46       	mov	r6,	r12	;
 136:	0d 47       	mov	r7,	r13	;
 138:	30 40 f4 00 	br	#0x00f4		;

0000013c <uart_scan>:
 13c:	0a 12       	push	r10		;
 13e:	09 12       	push	r9		;
 140:	08 12       	push	r8		;
 142:	07 12       	push	r7		;
 144:	06 12       	push	r6		;
 146:	08 4c       	mov	r12,	r8	;
 148:	4a 43       	clr.b	r10		;
 14a:	06 4d       	mov	r13,	r6	;
 14c:	36 53       	add	#-1,	r6	;r3 As==11
 14e:	37 40 6a 00 	mov	#106,	r7	;#0x006a

00000152 <.L17>:
 152:	3c 40 a4 ff 	mov	#65444,	r12	;#0xffa4

00000156 <.L18>:
 156:	29 4c       	mov	@r12,	r9	;
 158:	09 93       	cmp	#0,	r9	;r3 As==00
 15a:	fd 37       	jge	$-4      	;abs 0x156
 15c:	39 f0 ff 00 	and	#255,	r9	;#0x00ff
 160:	79 92       	cmp.b	#8,	r9	;r2 As==11
 162:	10 20       	jnz	$+34     	;abs 0x184
 164:	0a 93       	cmp	#0,	r10	;r3 As==00
 166:	f5 27       	jz	$-20     	;abs 0x152
 168:	39 40 76 0a 	mov	#2678,	r9	;#0x0a76

0000016c <.L21>:
 16c:	19 53       	inc	r9		;
 16e:	5c 49 ff ff 	mov.b	-1(r9),	r12	;
 172:	0c 93       	cmp	#0,	r12	;r3 As==00
 174:	04 20       	jnz	$+10     	;abs 0x17e
 176:	38 53       	add	#-1,	r8	;r3 As==11
 178:	3a 53       	add	#-1,	r10	;r3 As==11
 17a:	30 40 52 01 	br	#0x0152		;

0000017e <.L22>:
 17e:	87 12       	call	r7		;
 180:	30 40 6c 01 	br	#0x016c		;

00000184 <.L19>:
 184:	79 90 0d 00 	cmp.b	#13,	r9	;#0x000d
 188:	11 24       	jz	$+36     	;abs 0x1ac
 18a:	4c 49       	mov.b	r9,	r12	;
 18c:	7c 50 e0 ff 	add.b	#65504,	r12	;#0xffe0
 190:	7d 40 5e 00 	mov.b	#94,	r13	;#0x005e
 194:	4d 9c       	cmp.b	r12,	r13	;
 196:	dd 2b       	jnc	$-68     	;abs 0x152
 198:	0a 96       	cmp	r6,	r10	;
 19a:	db 2f       	jc	$-72     	;abs 0x152
 19c:	4c 49       	mov.b	r9,	r12	;
 19e:	87 12       	call	r7		;
 1a0:	c8 49 00 00 	mov.b	r9,	0(r8)	;
 1a4:	1a 53       	inc	r10		;
 1a6:	18 53       	inc	r8		;
 1a8:	30 40 52 01 	br	#0x0152		;

000001ac <.L23>:
 1ac:	c8 43 00 00 	mov.b	#0,	0(r8)	;r3 As==00
 1b0:	0c 4a       	mov	r10,	r12	;
 1b2:	30 40 12 09 	br	#0x0912		;

000001b6 <uart_print_hex_byte>:
 1b6:	0a 12       	push	r10		;
 1b8:	09 12       	push	r9		;
 1ba:	4a 4c       	mov.b	r12,	r10	;
 1bc:	0c 4a       	mov	r10,	r12	;
 1be:	b0 12 be 09 	call	#2494		;#0x09be
 1c2:	3c f0 ff 00 	and	#255,	r12	;#0x00ff
 1c6:	7d 40 09 00 	mov.b	#9,	r13	;
 1ca:	4d 9c       	cmp.b	r12,	r13	;
 1cc:	15 28       	jnc	$+44     	;abs 0x1f8
 1ce:	7c 50 30 00 	add.b	#48,	r12	;#0x0030

000001d2 <.L33>:
 1d2:	3c f0 ff 00 	and	#255,	r12	;#0x00ff
 1d6:	39 40 6a 00 	mov	#106,	r9	;#0x006a
 1da:	89 12       	call	r9		;
 1dc:	4c 4a       	mov.b	r10,	r12	;
 1de:	7c f0 0f 00 	and.b	#15,	r12	;#0x000f
 1e2:	7d 40 09 00 	mov.b	#9,	r13	;
 1e6:	4d 9c       	cmp.b	r12,	r13	;
 1e8:	0b 28       	jnc	$+24     	;abs 0x200
 1ea:	7c 50 30 00 	add.b	#48,	r12	;#0x0030

000001ee <.L34>:
 1ee:	3c f0 ff 00 	and	#255,	r12	;#0x00ff
 1f2:	89 12       	call	r9		;
 1f4:	30 40 18 09 	br	#0x0918		;

000001f8 <.L29>:
 1f8:	7c 50 37 00 	add.b	#55,	r12	;#0x0037
 1fc:	30 40 d2 01 	br	#0x01d2		;

00000200 <.L31>:
 200:	7c 50 37 00 	add.b	#55,	r12	;#0x0037
 204:	30 40 ee 01 	br	#0x01ee		;

00000208 <uart_print_hex_word>:
 208:	0a 12       	push	r10		;
 20a:	09 12       	push	r9		;
 20c:	09 4c       	mov	r12,	r9	;
 20e:	b0 12 ae 09 	call	#2478		;#0x09ae
 212:	3a 40 b6 01 	mov	#438,	r10	;#0x01b6
 216:	8a 12       	call	r10		;
 218:	4c 49       	mov.b	r9,	r12	;
 21a:	8a 12       	call	r10		;
 21c:	30 40 18 09 	br	#0x0918		;

00000220 <uart_print_hex_dword>:
 220:	0a 12       	push	r10		;
 222:	09 12       	push	r9		;
 224:	09 4c       	mov	r12,	r9	;
 226:	7e 40 10 00 	mov.b	#16,	r14	;#0x0010
 22a:	b0 12 40 0a 	call	#2624		;#0x0a40
 22e:	3a 40 08 02 	mov	#520,	r10	;#0x0208
 232:	8a 12       	call	r10		;
 234:	0c 49       	mov	r9,	r12	;
 236:	8a 12       	call	r10		;
 238:	30 40 18 09 	br	#0x0918		;

0000023c <main>:
 23c:	0a 12       	push	r10		;
 23e:	09 12       	push	r9		;
 240:	08 12       	push	r8		;
 242:	07 12       	push	r7		;
 244:	06 12       	push	r6		;
 246:	05 12       	push	r5		;
 248:	04 12       	push	r4		;
 24a:	31 80 32 00 	sub	#50,	r1	;#0x0032
 24e:	1e 42 fc ff 	mov	&0xfffc,r14	;0xfffc
 252:	1f 42 fe ff 	mov	&0xfffe,r15	;0xfffe
 256:	4c 43       	clr.b	r12		;

00000258 <.L38>:
 258:	0a 4f       	mov	r15,	r10	;
 25a:	0f 93       	cmp	#0,	r15	;r3 As==00
 25c:	91 20       	jnz	$+292    	;abs 0x380
 25e:	3d 40 ff 95 	mov	#38399,	r13	;#0x95ff
 262:	0d 9e       	cmp	r14,	r13	;
 264:	8d 28       	jnc	$+284    	;abs 0x380

00000266 <.L41>:
 266:	7e 40 ff 00 	mov.b	#255,	r14	;#0x00ff
 26a:	0e 9c       	cmp	r12,	r14	;
 26c:	8f 28       	jnc	$+288    	;abs 0x38c
 26e:	0d 4a       	mov	r10,	r13	;
 270:	0d 5a       	add	r10,	r13	;
 272:	0d 5d       	rla	r13		;
 274:	0d 5d       	rla	r13		;
 276:	0d 5d       	rla	r13		;
 278:	0d 5d       	rla	r13		;
 27a:	0d 5d       	rla	r13		;
 27c:	0d 5d       	rla	r13		;
 27e:	0d 5d       	rla	r13		;
 280:	0d dc       	bis	r12,	r13	;
 282:	82 4d a6 ff 	mov	r13,	&0xffa6	;
 286:	92 43 a0 ff 	mov	#1,	&0xffa0	;r3 As==01
 28a:	3a 40 7e 00 	mov	#126,	r10	;#0x007e
 28e:	3c 40 7a 0a 	mov	#2682,	r12	;#0x0a7a
 292:	8a 12       	call	r10		;
 294:	a2 b3 f2 ff 	bit	#2,	&0xfff2	;r3 As==10
 298:	02 20       	jnz	$+6      	;abs 0x29e
 29a:	30 40 58 08 	br	#0x0858		;
 29e:	e2 42 08 80 	mov.b	#4,	&0x8008	;r2 As==10
 2a2:	82 43 90 ff 	mov	#0,	&0xff90	;r3 As==00
 2a6:	3c 40 1a 0b 	mov	#2842,	r12	;#0x0b1a

000002aa <.L137>:
 2aa:	8a 12       	call	r10		;

000002ac <.L47>:
 2ac:	3c 40 dd 0b 	mov	#3037,	r12	;#0x0bdd
 2b0:	8a 12       	call	r10		;
 2b2:	7d 40 10 00 	mov.b	#16,	r13	;#0x0010
 2b6:	0c 41       	mov	r1,	r12	;
 2b8:	3c 50 22 00 	add	#34,	r12	;#0x0022
 2bc:	b0 12 3c 01 	call	#316		;#0x013c
 2c0:	09 4c       	mov	r12,	r9	;
 2c2:	3c 40 ec 0b 	mov	#3052,	r12	;#0x0bec
 2c6:	8a 12       	call	r10		;
 2c8:	09 93       	cmp	#0,	r9	;r3 As==00
 2ca:	f0 27       	jz	$-30     	;abs 0x2ac
 2cc:	39 40 46 0a 	mov	#2630,	r9	;#0x0a46
 2d0:	3d 40 ee 0b 	mov	#3054,	r13	;#0x0bee
 2d4:	0c 41       	mov	r1,	r12	;
 2d6:	3c 50 22 00 	add	#34,	r12	;#0x0022
 2da:	89 12       	call	r9		;
 2dc:	08 4c       	mov	r12,	r8	;
 2de:	3d 40 f3 0b 	mov	#3059,	r13	;#0x0bf3
 2e2:	0c 41       	mov	r1,	r12	;
 2e4:	3c 50 22 00 	add	#34,	r12	;#0x0022
 2e8:	89 12       	call	r9		;
 2ea:	0e 49       	mov	r9,	r14	;
 2ec:	0c 93       	cmp	#0,	r12	;r3 As==00
 2ee:	5d 24       	jz	$+188    	;abs 0x3aa
 2f0:	59 43       	mov.b	#1,	r9	;r3 As==01
 2f2:	08 93       	cmp	#0,	r8	;r3 As==00
 2f4:	01 24       	jz	$+4      	;abs 0x2f8
 2f6:	49 43       	clr.b	r9		;

000002f8 <.L49>:
 2f8:	3d 40 f9 0b 	mov	#3065,	r13	;#0x0bf9
 2fc:	0c 41       	mov	r1,	r12	;
 2fe:	3c 50 22 00 	add	#34,	r12	;#0x0022
 302:	8e 12       	call	r14		;
 304:	0c 93       	cmp	#0,	r12	;r3 As==00
 306:	02 20       	jnz	$+6      	;abs 0x30c
 308:	79 40 03 00 	mov.b	#3,	r9	;

0000030c <.L51>:
 30c:	38 40 46 0a 	mov	#2630,	r8	;#0x0a46
 310:	3d 40 fe 0b 	mov	#3070,	r13	;#0x0bfe
 314:	0c 41       	mov	r1,	r12	;
 316:	3c 50 22 00 	add	#34,	r12	;#0x0022
 31a:	88 12       	call	r8		;
 31c:	0c 93       	cmp	#0,	r12	;r3 As==00
 31e:	01 20       	jnz	$+4      	;abs 0x322
 320:	69 42       	mov.b	#4,	r9	;r2 As==10

00000322 <.L52>:
 322:	3d 40 04 0c 	mov	#3076,	r13	;#0x0c04
 326:	0c 41       	mov	r1,	r12	;
 328:	3c 50 22 00 	add	#34,	r12	;#0x0022
 32c:	88 12       	call	r8		;
 32e:	0c 93       	cmp	#0,	r12	;r3 As==00
 330:	02 20       	jnz	$+6      	;abs 0x336
 332:	79 40 05 00 	mov.b	#5,	r9	;

00000336 <.L53>:
 336:	38 40 46 0a 	mov	#2630,	r8	;#0x0a46
 33a:	3d 40 09 0c 	mov	#3081,	r13	;#0x0c09
 33e:	0c 41       	mov	r1,	r12	;
 340:	3c 50 22 00 	add	#34,	r12	;#0x0022
 344:	88 12       	call	r8		;
 346:	0c 93       	cmp	#0,	r12	;r3 As==00
 348:	02 20       	jnz	$+6      	;abs 0x34e
 34a:	79 40 06 00 	mov.b	#6,	r9	;

0000034e <.L54>:
 34e:	3d 40 0f 0c 	mov	#3087,	r13	;#0x0c0f
 352:	0c 41       	mov	r1,	r12	;
 354:	3c 50 22 00 	add	#34,	r12	;#0x0022
 358:	88 12       	call	r8		;
 35a:	0c 93       	cmp	#0,	r12	;r3 As==00
 35c:	02 20       	jnz	$+6      	;abs 0x362
 35e:	30 40 40 08 	br	#0x0840		;
 362:	39 90 03 00 	cmp	#3,	r9	;
 366:	6c 24       	jz	$+218    	;abs 0x440
 368:	7c 40 03 00 	mov.b	#3,	r12	;
 36c:	0c 99       	cmp	r9,	r12	;
 36e:	20 28       	jnc	$+66     	;abs 0x3b0
 370:	19 93       	cmp	#1,	r9	;r3 As==01
 372:	2f 24       	jz	$+96     	;abs 0x3d2
 374:	29 93       	cmp	#2,	r9	;r3 As==10
 376:	31 24       	jz	$+100    	;abs 0x3da

00000378 <.L56>:
 378:	3c 40 b5 0e 	mov	#3765,	r12	;#0x0eb5
 37c:	30 40 aa 02 	br	#0x02aa		;

00000380 <.L39>:
 380:	3e 50 00 6a 	add	#27136,	r14	;#0x6a00
 384:	3f 63       	addc	#-1,	r15	;r3 As==11
 386:	1c 53       	inc	r12		;
 388:	30 40 58 02 	br	#0x0258		;

0000038c <.L45>:
 38c:	6a 93       	cmp.b	#2,	r10	;r3 As==10
 38e:	02 24       	jz	$+6      	;abs 0x394
 390:	6a 92       	cmp.b	#4,	r10	;r2 As==10
 392:	07 20       	jnz	$+16     	;abs 0x3a2

00000394 <.L42>:
 394:	b0 12 c2 09 	call	#2498		;#0x09c2

00000398 <.L44>:
 398:	5a 53       	inc.b	r10		;
 39a:	3a f0 ff 00 	and	#255,	r10	;#0x00ff
 39e:	30 40 66 02 	br	#0x0266		;

000003a2 <.L43>:
 3a2:	b0 12 ca 09 	call	#2506		;#0x09ca
 3a6:	30 40 98 03 	br	#0x0398		;

000003aa <.L114>:
 3aa:	69 43       	mov.b	#2,	r9	;r3 As==10
 3ac:	30 40 f8 02 	br	#0x02f8		;

000003b0 <.L58>:
 3b0:	39 90 05 00 	cmp	#5,	r9	;
 3b4:	7d 25       	jz	$+764    	;abs 0x6b0
 3b6:	39 90 05 00 	cmp	#5,	r9	;
 3ba:	e0 28       	jnc	$+450    	;abs 0x57c
 3bc:	39 90 06 00 	cmp	#6,	r9	;
 3c0:	db 23       	jnz	$-72     	;abs 0x378
 3c2:	3c 40 a0 ff 	mov	#65440,	r12	;#0xffa0

000003c6 <.L123>:
 3c6:	bc b2 00 00 	bit	#8,	0(r12)	;r2 As==11
 3ca:	fd 23       	jnz	$-4      	;abs 0x3c6
 3cc:	00 43       	clr	r0		;
 3ce:	30 40 ac 02 	br	#0x02ac		;

000003d2 <.L59>:
 3d2:	3c 40 14 0c 	mov	#3092,	r12	;#0x0c14
 3d6:	30 40 aa 02 	br	#0x02aa		;

000003da <.L60>:
 3da:	3c 40 0c 0d 	mov	#3340,	r12	;#0x0d0c
 3de:	8a 12       	call	r10		;
 3e0:	0d 49       	mov	r9,	r13	;
 3e2:	0c 41       	mov	r1,	r12	;
 3e4:	3c 50 19 00 	add	#25,	r12	;#0x0019
 3e8:	b0 12 3c 01 	call	#316		;#0x013c
 3ec:	3d 40 34 0d 	mov	#3380,	r13	;#0x0d34
 3f0:	0c 41       	mov	r1,	r12	;
 3f2:	3c 50 19 00 	add	#25,	r12	;#0x0019
 3f6:	88 12       	call	r8		;
 3f8:	0c 93       	cmp	#0,	r12	;r3 As==00
 3fa:	06 20       	jnz	$+14     	;abs 0x408
 3fc:	d2 43 08 80 	mov.b	#1,	&0x8008	;r3 As==01

00000400 <.L65>:
 400:	3c 40 5d 0d 	mov	#3421,	r12	;#0x0d5d
 404:	30 40 aa 02 	br	#0x02aa		;

00000408 <.L64>:
 408:	3d 40 36 0d 	mov	#3382,	r13	;#0x0d36
 40c:	0c 41       	mov	r1,	r12	;
 40e:	3c 50 19 00 	add	#25,	r12	;#0x0019
 412:	88 12       	call	r8		;
 414:	0c 93       	cmp	#0,	r12	;r3 As==00
 416:	04 20       	jnz	$+10     	;abs 0x420
 418:	c2 49 08 80 	mov.b	r9,	&0x8008	;
 41c:	30 40 00 04 	br	#0x0400		;

00000420 <.L66>:
 420:	3d 40 38 0d 	mov	#3384,	r13	;#0x0d38
 424:	0c 41       	mov	r1,	r12	;
 426:	3c 50 19 00 	add	#25,	r12	;#0x0019
 42a:	88 12       	call	r8		;
 42c:	0c 93       	cmp	#0,	r12	;r3 As==00
 42e:	04 20       	jnz	$+10     	;abs 0x438
 430:	e2 42 08 80 	mov.b	#4,	&0x8008	;r2 As==10
 434:	30 40 00 04 	br	#0x0400		;

00000438 <.L67>:
 438:	3c 40 3a 0d 	mov	#3386,	r12	;#0x0d3a
 43c:	30 40 aa 02 	br	#0x02aa		;

00000440 <.L57>:
 440:	3c 40 6b 0d 	mov	#3435,	r12	;#0x0d6b
 444:	8a 12       	call	r10		;
 446:	7d 40 09 00 	mov.b	#9,	r13	;
 44a:	0c 41       	mov	r1,	r12	;
 44c:	3c 50 19 00 	add	#25,	r12	;#0x0019
 450:	b0 12 3c 01 	call	#316		;#0x013c
 454:	0c 41       	mov	r1,	r12	;
 456:	3c 50 19 00 	add	#25,	r12	;#0x0019
 45a:	b0 12 62 0a 	call	#2658		;#0x0a62
 45e:	4d 4c       	mov.b	r12,	r13	;
 460:	0c 41       	mov	r1,	r12	;
 462:	3c 50 19 00 	add	#25,	r12	;#0x0019
 466:	b0 12 ae 00 	call	#174		;#0x00ae
 46a:	06 4c       	mov	r12,	r6	;
 46c:	07 4d       	mov	r13,	r7	;
 46e:	3c 40 90 0d 	mov	#3472,	r12	;#0x0d90
 472:	8a 12       	call	r10		;
 474:	0c 46       	mov	r6,	r12	;
 476:	0d 47       	mov	r7,	r13	;
 478:	b0 12 20 02 	call	#544		;#0x0220
 47c:	3c 40 a2 0d 	mov	#3490,	r12	;#0x0da2
 480:	8a 12       	call	r10		;
 482:	3c 40 a8 0d 	mov	#3496,	r12	;#0x0da8
 486:	8a 12       	call	r10		;
 488:	58 42 08 80 	mov.b	&0x8008,r8	;0x8008
 48c:	58 93       	cmp.b	#1,	r8	;r3 As==01
 48e:	22 20       	jnz	$+70     	;abs 0x4d4
 490:	5c 43       	mov.b	#1,	r12	;r3 As==01
 492:	0d 46       	mov	r6,	r13	;
 494:	7d f0 03 00 	and.b	#3,	r13	;
 498:	b0 12 42 09 	call	#2370		;#0x0942
 49c:	82 4c 90 ff 	mov	r12,	&0xff90	;
 4a0:	82 46 92 ff 	mov	r6,	&0xff92	;
 4a4:	82 47 94 ff 	mov	r7,	&0xff94	;

000004a8 <.L69>:
 4a8:	79 40 65 00 	mov.b	#101,	r9	;#0x0065
 4ac:	35 40 90 ff 	mov	#65424,	r5	;#0xff90

000004b0 <.L75>:
 4b0:	2c 45       	mov	@r5,	r12	;
 4b2:	0c 93       	cmp	#0,	r12	;r3 As==00
 4b4:	3e 34       	jge	$+126    	;abs 0x532
 4b6:	39 53       	add	#-1,	r9	;r3 As==11
 4b8:	09 93       	cmp	#0,	r9	;r3 As==00
 4ba:	fa 23       	jnz	$-10     	;abs 0x4b0
 4bc:	3c 40 b6 0d 	mov	#3510,	r12	;#0x0db6
 4c0:	8a 12       	call	r10		;
 4c2:	85 49 00 00 	mov	r9,	0(r5)	;
 4c6:	3d 40 a4 ff 	mov	#65444,	r13	;#0xffa4

000004ca <.L76>:
 4ca:	2c 4d       	mov	@r13,	r12	;
 4cc:	0c 93       	cmp	#0,	r12	;r3 As==00
 4ce:	fd 37       	jge	$-4      	;abs 0x4ca
 4d0:	30 40 ac 02 	br	#0x02ac		;

000004d4 <.L68>:
 4d4:	68 93       	cmp.b	#2,	r8	;r3 As==10
 4d6:	19 20       	jnz	$+52     	;abs 0x50a
 4d8:	0c 46       	mov	r6,	r12	;
 4da:	6c f3       	and.b	#2,	r12	;r3 As==10
 4dc:	0c 93       	cmp	#0,	r12	;r3 As==00
 4de:	11 24       	jz	$+36     	;abs 0x502
 4e0:	b2 40 0c 00 	mov	#12,	&0xff90	;#0x000c
 4e4:	90 ff 

000004e6 <.L73>:
 4e6:	0d 46       	mov	r6,	r13	;
 4e8:	1d c3       	bic	#1,	r13	;r3 As==01
 4ea:	81 4d 02 00 	mov	r13,	2(r1)	;
 4ee:	81 47 04 00 	mov	r7,	4(r1)	;
 4f2:	92 41 02 00 	mov	2(r1),	&0xff92	;
 4f6:	92 ff 
 4f8:	92 41 04 00 	mov	4(r1),	&0xff94	;
 4fc:	94 ff 
 4fe:	30 40 a8 04 	br	#0x04a8		;

00000502 <.L71>:
 502:	82 49 90 ff 	mov	r9,	&0xff90	;
 506:	30 40 e6 04 	br	#0x04e6		;

0000050a <.L70>:
 50a:	68 92       	cmp.b	#4,	r8	;r2 As==10
 50c:	cd 23       	jnz	$-100    	;abs 0x4a8
 50e:	b2 40 0f 00 	mov	#15,	&0xff90	;#0x000f
 512:	90 ff 
 514:	0e 46       	mov	r6,	r14	;
 516:	3e f0 fc ff 	and	#65532,	r14	;#0xfffc
 51a:	81 4e 06 00 	mov	r14,	6(r1)	;
 51e:	81 47 08 00 	mov	r7,	8(r1)	;
 522:	92 41 06 00 	mov	6(r1),	&0xff92	;
 526:	92 ff 
 528:	92 41 08 00 	mov	8(r1),	&0xff94	;
 52c:	94 ff 
 52e:	30 40 a8 04 	br	#0x04a8		;

00000532 <.L74>:
 532:	58 93       	cmp.b	#1,	r8	;r3 As==01
 534:	0a 20       	jnz	$+22     	;abs 0x54a
 536:	76 f0 03 00 	and.b	#3,	r6	;
 53a:	5c 46 9a ff 	mov.b	-102(r6),r12	;0xffffff9a
 53e:	b0 12 b6 01 	call	#438		;#0x01b6

00000542 <.L79>:
 542:	3c 40 ec 0b 	mov	#3052,	r12	;#0x0bec
 546:	30 40 aa 02 	br	#0x02aa		;

0000054a <.L78>:
 54a:	68 93       	cmp.b	#2,	r8	;r3 As==10
 54c:	0d 20       	jnz	$+28     	;abs 0x568
 54e:	66 f3       	and.b	#2,	r6	;r3 As==10
 550:	06 93       	cmp	#0,	r6	;r3 As==00
 552:	06 24       	jz	$+14     	;abs 0x560
 554:	1c 42 9c ff 	mov	&0xff9c,r12	;0xff9c

00000558 <.L83>:
 558:	b0 12 08 02 	call	#520		;#0x0208
 55c:	30 40 42 05 	br	#0x0542		;

00000560 <.L81>:
 560:	1c 42 9a ff 	mov	&0xff9a,r12	;0xff9a
 564:	30 40 58 05 	br	#0x0558		;

00000568 <.L80>:
 568:	68 92       	cmp.b	#4,	r8	;r2 As==10
 56a:	eb 23       	jnz	$-40     	;abs 0x542
 56c:	1c 42 9a ff 	mov	&0xff9a,r12	;0xff9a
 570:	1d 42 9c ff 	mov	&0xff9c,r13	;0xff9c
 574:	b0 12 20 02 	call	#544		;#0x0220
 578:	30 40 42 05 	br	#0x0542		;

0000057c <.L62>:
 57c:	3c 40 6b 0d 	mov	#3435,	r12	;#0x0d6b
 580:	8a 12       	call	r10		;
 582:	34 40 3c 01 	mov	#316,	r4	;#0x013c
 586:	7d 40 09 00 	mov.b	#9,	r13	;
 58a:	0c 41       	mov	r1,	r12	;
 58c:	3c 50 19 00 	add	#25,	r12	;#0x0019
 590:	84 12       	call	r4		;
 592:	36 40 62 0a 	mov	#2658,	r6	;#0x0a62
 596:	0c 41       	mov	r1,	r12	;
 598:	3c 50 19 00 	add	#25,	r12	;#0x0019
 59c:	86 12       	call	r6		;
 59e:	37 40 ae 00 	mov	#174,	r7	;#0x00ae
 5a2:	4d 4c       	mov.b	r12,	r13	;
 5a4:	0c 41       	mov	r1,	r12	;
 5a6:	3c 50 19 00 	add	#25,	r12	;#0x0019
 5aa:	87 12       	call	r7		;
 5ac:	08 4c       	mov	r12,	r8	;
 5ae:	09 4d       	mov	r13,	r9	;
 5b0:	3c 40 ec 0d 	mov	#3564,	r12	;#0x0dec
 5b4:	8a 12       	call	r10		;
 5b6:	55 42 08 80 	mov.b	&0x8008,r5	;0x8008
 5ba:	0d 45       	mov	r5,	r13	;
 5bc:	0d 55       	add	r5,	r13	;
 5be:	1d 53       	inc	r13		;
 5c0:	0c 41       	mov	r1,	r12	;
 5c2:	3c 50 19 00 	add	#25,	r12	;#0x0019
 5c6:	84 12       	call	r4		;
 5c8:	0c 41       	mov	r1,	r12	;
 5ca:	3c 50 19 00 	add	#25,	r12	;#0x0019
 5ce:	86 12       	call	r6		;
 5d0:	4d 4c       	mov.b	r12,	r13	;
 5d2:	0c 41       	mov	r1,	r12	;
 5d4:	3c 50 19 00 	add	#25,	r12	;#0x0019
 5d8:	87 12       	call	r7		;
 5da:	06 4c       	mov	r12,	r6	;
 5dc:	07 4d       	mov	r13,	r7	;
 5de:	3c 40 0e 0e 	mov	#3598,	r12	;#0x0e0e
 5e2:	8a 12       	call	r10		;
 5e4:	34 40 20 02 	mov	#544,	r4	;#0x0220
 5e8:	0c 46       	mov	r6,	r12	;
 5ea:	0d 47       	mov	r7,	r13	;
 5ec:	84 12       	call	r4		;
 5ee:	3c 40 1b 0e 	mov	#3611,	r12	;#0x0e1b
 5f2:	8a 12       	call	r10		;
 5f4:	0c 48       	mov	r8,	r12	;
 5f6:	0d 49       	mov	r9,	r13	;
 5f8:	84 12       	call	r4		;
 5fa:	3c 40 a2 0d 	mov	#3490,	r12	;#0x0da2
 5fe:	8a 12       	call	r10		;
 600:	55 93       	cmp.b	#1,	r5	;r3 As==01
 602:	27 20       	jnz	$+80     	;abs 0x652
 604:	36 f0 ff 00 	and	#255,	r6	;#0x00ff
 608:	07 48       	mov	r8,	r7	;
 60a:	77 f0 03 00 	and.b	#3,	r7	;
 60e:	5c 43       	mov.b	#1,	r12	;r3 As==01
 610:	0d 47       	mov	r7,	r13	;
 612:	b0 12 42 09 	call	#2370		;#0x0942
 616:	82 4c 90 ff 	mov	r12,	&0xff90	;
 61a:	c7 46 9a ff 	mov.b	r6,	-102(r7); 0xff9a
 61e:	82 48 96 ff 	mov	r8,	&0xff96	;
 622:	82 49 98 ff 	mov	r9,	&0xff98	;

00000626 <.L85>:
 626:	79 40 65 00 	mov.b	#101,	r9	;#0x0065
 62a:	38 40 90 ff 	mov	#65424,	r8	;#0xff90

0000062e <.L90>:
 62e:	2c 48       	mov	@r8,	r12	;
 630:	0c 93       	cmp	#0,	r12	;r3 As==00
 632:	3a 34       	jge	$+118    	;abs 0x6a8
 634:	39 53       	add	#-1,	r9	;r3 As==11
 636:	09 93       	cmp	#0,	r9	;r3 As==00
 638:	fa 23       	jnz	$-10     	;abs 0x62e
 63a:	3c 40 b6 0d 	mov	#3510,	r12	;#0x0db6
 63e:	8a 12       	call	r10		;
 640:	88 49 00 00 	mov	r9,	0(r8)	;
 644:	3d 40 a4 ff 	mov	#65444,	r13	;#0xffa4

00000648 <.L91>:
 648:	2c 4d       	mov	@r13,	r12	;
 64a:	0c 93       	cmp	#0,	r12	;r3 As==00
 64c:	fd 37       	jge	$-4      	;abs 0x648
 64e:	30 40 ac 02 	br	#0x02ac		;

00000652 <.L84>:
 652:	65 93       	cmp.b	#2,	r5	;r3 As==10
 654:	11 20       	jnz	$+36     	;abs 0x678
 656:	68 f3       	and.b	#2,	r8	;r3 As==10
 658:	08 93       	cmp	#0,	r8	;r3 As==00
 65a:	07 24       	jz	$+16     	;abs 0x66a
 65c:	b2 40 0c 00 	mov	#12,	&0xff90	;#0x000c
 660:	90 ff 
 662:	82 46 9c ff 	mov	r6,	&0xff9c	;
 666:	30 40 26 06 	br	#0x0626		;

0000066a <.L87>:
 66a:	b2 40 03 00 	mov	#3,	&0xff90	;
 66e:	90 ff 
 670:	82 46 9a ff 	mov	r6,	&0xff9a	;
 674:	30 40 26 06 	br	#0x0626		;

00000678 <.L86>:
 678:	65 92       	cmp.b	#4,	r5	;r2 As==10
 67a:	d5 23       	jnz	$-84     	;abs 0x626
 67c:	b2 40 0f 00 	mov	#15,	&0xff90	;#0x000f
 680:	90 ff 
 682:	82 46 9a ff 	mov	r6,	&0xff9a	;
 686:	82 47 9c ff 	mov	r7,	&0xff9c	;
 68a:	0c 48       	mov	r8,	r12	;
 68c:	3c f0 fc ff 	and	#65532,	r12	;#0xfffc
 690:	81 4c 0a 00 	mov	r12,	10(r1)	; 0x000a
 694:	81 49 0c 00 	mov	r9,	12(r1)	; 0x000c
 698:	92 41 0a 00 	mov	10(r1),	&0xff96	;0x0000a
 69c:	96 ff 
 69e:	92 41 0c 00 	mov	12(r1),	&0xff98	;0x0000c
 6a2:	98 ff 
 6a4:	30 40 26 06 	br	#0x0626		;

000006a8 <.L89>:
 6a8:	3c 40 24 0e 	mov	#3620,	r12	;#0x0e24
 6ac:	30 40 aa 02 	br	#0x02aa		;

000006b0 <.L61>:
 6b0:	3c 40 2b 0e 	mov	#3627,	r12	;#0x0e2b
 6b4:	8a 12       	call	r10		;
 6b6:	7d 40 09 00 	mov.b	#9,	r13	;
 6ba:	0c 41       	mov	r1,	r12	;
 6bc:	3c 50 19 00 	add	#25,	r12	;#0x0019
 6c0:	b0 12 3c 01 	call	#316		;#0x013c
 6c4:	0c 41       	mov	r1,	r12	;
 6c6:	3c 50 19 00 	add	#25,	r12	;#0x0019
 6ca:	b0 12 62 0a 	call	#2658		;#0x0a62
 6ce:	4d 4c       	mov.b	r12,	r13	;
 6d0:	0c 41       	mov	r1,	r12	;
 6d2:	3c 50 19 00 	add	#25,	r12	;#0x0019
 6d6:	b0 12 ae 00 	call	#174		;#0x00ae
 6da:	04 4c       	mov	r12,	r4	;
 6dc:	05 4d       	mov	r13,	r5	;
 6de:	3c 40 4f 0e 	mov	#3663,	r12	;#0x0e4f
 6e2:	8a 12       	call	r10		;
 6e4:	3d 40 a4 ff 	mov	#65444,	r13	;#0xffa4

000006e8 <.L93>:
 6e8:	2c 4d       	mov	@r13,	r12	;
 6ea:	0c 93       	cmp	#0,	r12	;r3 As==00
 6ec:	fd 37       	jge	$-4      	;abs 0x6e8
 6ee:	39 40 90 ff 	mov	#65424,	r9	;#0xff90

000006f2 <.L112>:
 6f2:	3c 40 94 0e 	mov	#3732,	r12	;#0x0e94
 6f6:	8a 12       	call	r10		;
 6f8:	0c 44       	mov	r4,	r12	;
 6fa:	0d 45       	mov	r5,	r13	;
 6fc:	b0 12 20 02 	call	#544		;#0x0220
 700:	3c 40 97 0e 	mov	#3735,	r12	;#0x0e97
 704:	8a 12       	call	r10		;
 706:	57 42 08 80 	mov.b	&0x8008,r7	;0x8008
 70a:	0d 47       	mov	r7,	r13	;
 70c:	7c 40 10 00 	mov.b	#16,	r12	;#0x0010
 710:	b0 12 c2 08 	call	#2242		;#0x08c2
 714:	81 4c 16 00 	mov	r12,	22(r1)	; 0x0016
 718:	48 43       	clr.b	r8		;
 71a:	36 40 92 ff 	mov	#65426,	r6	;#0xff92

0000071e <.L94>:
 71e:	81 98 16 00 	cmp	r8,	22(r1)	; 0x0016
 722:	09 20       	jnz	$+20     	;abs 0x736
 724:	3c 40 ec 0b 	mov	#3052,	r12	;#0x0bec
 728:	8a 12       	call	r10		;
 72a:	1c 42 a4 ff 	mov	&0xffa4,r12	;0xffa4
 72e:	0c 93       	cmp	#0,	r12	;r3 As==00
 730:	e0 37       	jge	$-62     	;abs 0x6f2
 732:	30 40 ac 02 	br	#0x02ac		;

00000736 <.L110>:
 736:	57 93       	cmp.b	#1,	r7	;r3 As==01
 738:	23 20       	jnz	$+72     	;abs 0x780
 73a:	5c 43       	mov.b	#1,	r12	;r3 As==01
 73c:	0d 44       	mov	r4,	r13	;
 73e:	7d f0 03 00 	and.b	#3,	r13	;
 742:	b0 12 42 09 	call	#2370		;#0x0942
 746:	89 4c 00 00 	mov	r12,	0(r9)	;
 74a:	86 44 00 00 	mov	r4,	0(r6)	;
 74e:	86 45 02 00 	mov	r5,	2(r6)	;

00000752 <.L96>:
 752:	7d 40 65 00 	mov.b	#101,	r13	;#0x0065

00000756 <.L102>:
 756:	2c 49       	mov	@r9,	r12	;
 758:	0c 93       	cmp	#0,	r12	;r3 As==00
 75a:	42 34       	jge	$+134    	;abs 0x7e0
 75c:	3d 53       	add	#-1,	r13	;r3 As==11
 75e:	0d 93       	cmp	#0,	r13	;r3 As==00
 760:	fa 23       	jnz	$-10     	;abs 0x756
 762:	3c 40 b6 0d 	mov	#3510,	r12	;#0x0db6
 766:	81 4d 00 00 	mov	r13,	0(r1)	;
 76a:	8a 12       	call	r10		;
 76c:	2d 41       	mov	@r1,	r13	;
 76e:	89 4d 00 00 	mov	r13,	0(r9)	;
 772:	3d 40 a4 ff 	mov	#65444,	r13	;#0xffa4

00000776 <.L103>:
 776:	2c 4d       	mov	@r13,	r12	;
 778:	0c 93       	cmp	#0,	r12	;r3 As==00
 77a:	fd 37       	jge	$-4      	;abs 0x776
 77c:	30 40 ac 02 	br	#0x02ac		;

00000780 <.L95>:
 780:	67 93       	cmp.b	#2,	r7	;r3 As==10
 782:	1a 20       	jnz	$+54     	;abs 0x7b8
 784:	0c 44       	mov	r4,	r12	;
 786:	6c f3       	and.b	#2,	r12	;r3 As==10
 788:	0c 93       	cmp	#0,	r12	;r3 As==00
 78a:	11 24       	jz	$+36     	;abs 0x7ae
 78c:	b2 40 0c 00 	mov	#12,	&0xff90	;#0x000c
 790:	90 ff 

00000792 <.L100>:
 792:	0d 44       	mov	r4,	r13	;
 794:	1d c3       	bic	#1,	r13	;r3 As==01
 796:	81 4d 0e 00 	mov	r13,	14(r1)	; 0x000e
 79a:	81 45 10 00 	mov	r5,	16(r1)	; 0x0010
 79e:	96 41 0e 00 	mov	14(r1),	0(r6)	;0x0000e
 7a2:	00 00 
 7a4:	96 41 10 00 	mov	16(r1),	2(r6)	;0x00010
 7a8:	02 00 
 7aa:	30 40 52 07 	br	#0x0752		;

000007ae <.L98>:
 7ae:	b2 40 03 00 	mov	#3,	&0xff90	;
 7b2:	90 ff 
 7b4:	30 40 92 07 	br	#0x0792		;

000007b8 <.L97>:
 7b8:	67 92       	cmp.b	#4,	r7	;r2 As==10
 7ba:	cb 23       	jnz	$-104    	;abs 0x752
 7bc:	b2 40 0f 00 	mov	#15,	&0xff90	;#0x000f
 7c0:	90 ff 
 7c2:	0c 44       	mov	r4,	r12	;
 7c4:	3c f0 fc ff 	and	#65532,	r12	;#0xfffc
 7c8:	81 4c 12 00 	mov	r12,	18(r1)	; 0x0012
 7cc:	81 45 14 00 	mov	r5,	20(r1)	; 0x0014
 7d0:	96 41 12 00 	mov	18(r1),	0(r6)	;0x00012
 7d4:	00 00 
 7d6:	96 41 14 00 	mov	20(r1),	2(r6)	;0x00014
 7da:	02 00 
 7dc:	30 40 52 07 	br	#0x0752		;

000007e0 <.L101>:
 7e0:	57 93       	cmp.b	#1,	r7	;r3 As==01
 7e2:	10 20       	jnz	$+34     	;abs 0x804
 7e4:	0c 44       	mov	r4,	r12	;
 7e6:	7c f0 03 00 	and.b	#3,	r12	;
 7ea:	5c 4c 9a ff 	mov.b	-102(r12),r12	;0xffffff9a
 7ee:	b0 12 b6 01 	call	#438		;#0x01b6
 7f2:	14 53       	inc	r4		;

000007f4 <.L138>:
 7f4:	05 63       	adc	r5		;

000007f6 <.L105>:
 7f6:	7c 40 20 00 	mov.b	#32,	r12	;#0x0020
 7fa:	b0 12 6a 00 	call	#106		;#0x006a
 7fe:	18 53       	inc	r8		;
 800:	30 40 1e 07 	br	#0x071e		;

00000804 <.L104>:
 804:	67 93       	cmp.b	#2,	r7	;r3 As==10
 806:	10 20       	jnz	$+34     	;abs 0x828
 808:	0c 44       	mov	r4,	r12	;
 80a:	6c f3       	and.b	#2,	r12	;r3 As==10
 80c:	0c 93       	cmp	#0,	r12	;r3 As==00
 80e:	07 24       	jz	$+16     	;abs 0x81e
 810:	1c 42 9c ff 	mov	&0xff9c,r12	;0xff9c

00000814 <.L109>:
 814:	b0 12 08 02 	call	#520		;#0x0208
 818:	24 53       	incd	r4		;
 81a:	30 40 f4 07 	br	#0x07f4		;

0000081e <.L107>:
 81e:	3e 40 9a ff 	mov	#65434,	r14	;#0xff9a
 822:	2c 4e       	mov	@r14,	r12	;
 824:	30 40 14 08 	br	#0x0814		;

00000828 <.L106>:
 828:	67 92       	cmp.b	#4,	r7	;r2 As==10
 82a:	e5 23       	jnz	$-52     	;abs 0x7f6
 82c:	3e 40 9a ff 	mov	#65434,	r14	;#0xff9a
 830:	2c 4e       	mov	@r14,	r12	;
 832:	1d 4e 02 00 	mov	2(r14),	r13	;
 836:	b0 12 20 02 	call	#544		;#0x0220
 83a:	24 52       	add	#4,	r4	;r2 As==10
 83c:	30 40 f4 07 	br	#0x07f4		;

00000840 <.L55>:
 840:	b2 b0 80 00 	bit	#128,	&0xfff2	;#0x0080
 844:	f2 ff 
 846:	04 20       	jnz	$+10     	;abs 0x850
 848:	3c 40 9b 0e 	mov	#3739,	r12	;#0x0e9b
 84c:	30 40 aa 02 	br	#0x02aa		;

00000850 <.L113>:
 850:	30 40 00 f0 	br	#0xf000		;
 854:	30 40 ac 02 	br	#0x02ac		;

00000858 <.L136>:
 858:	3c 40 f2 0a 	mov	#2802,	r12	;#0x0af2
 85c:	8a 12       	call	r10		;
 85e:	5c 43       	mov.b	#1,	r12	;r3 As==01
 860:	31 50 32 00 	add	#50,	r1	;#0x0032
 864:	30 40 0e 09 	br	#0x090e		;

00000868 <udivmodhi4>:
 868:	0a 12       	push	r10		;

0000086a <.LCFI0>:
 86a:	09 12       	push	r9		;

0000086c <.LCFI1>:
 86c:	08 12       	push	r8		;

0000086e <.LCFI2>:
 86e:	07 12       	push	r7		;

00000870 <.LCFI3>:
 870:	06 12       	push	r6		;

00000872 <.LCFI4>:
 872:	07 4c       	mov	r12,	r7	;
 874:	09 4d       	mov	r13,	r9	;
 876:	06 4e       	mov	r14,	r6	;

00000878 <.LVL1>:
 878:	7a 40 11 00 	mov.b	#17,	r10	;#0x0011

0000087c <.Loc.35.1>:
 87c:	58 43       	mov.b	#1,	r8	;r3 As==01

0000087e <.L2>:
 87e:	09 97       	cmp	r7,	r9	;
 880:	09 28       	jnc	$+20     	;abs 0x894

00000882 <.L15>:
 882:	4a 43       	clr.b	r10		;

00000884 <.L4>:
 884:	08 93       	cmp	#0,	r8	;r3 As==00
 886:	0f 20       	jnz	$+32     	;abs 0x8a6

00000888 <.L5>:
 888:	06 93       	cmp	#0,	r6	;r3 As==00
 88a:	01 24       	jz	$+4      	;abs 0x88e
 88c:	0a 47       	mov	r7,	r10	;

0000088e <.L1>:
 88e:	0c 4a       	mov	r10,	r12	;
 890:	30 40 12 09 	br	#0x0912		;

00000894 <.L3>:
 894:	3a 53       	add	#-1,	r10	;r3 As==11

00000896 <.Loc.38.1>:
 896:	0a 93       	cmp	#0,	r10	;r3 As==00
 898:	f7 27       	jz	$-16     	;abs 0x888

0000089a <.Loc.38.1>:
 89a:	09 93       	cmp	#0,	r9	;r3 As==00
 89c:	f2 3b       	jl	$-26     	;abs 0x882

0000089e <.Loc.40.1>:
 89e:	09 59       	rla	r9		;

000008a0 <.Loc.41.1>:
 8a0:	08 58       	rla	r8		;
 8a2:	30 40 7e 08 	br	#0x087e		;

000008a6 <.L9>:
 8a6:	07 99       	cmp	r9,	r7	;
 8a8:	02 28       	jnc	$+6      	;abs 0x8ae

000008aa <.Loc.47.1>:
 8aa:	07 89       	sub	r9,	r7	;

000008ac <.Loc.48.1>:
 8ac:	0a d8       	bis	r8,	r10	;

000008ae <.L8>:
 8ae:	0c 48       	mov	r8,	r12	;
 8b0:	b0 12 ca 09 	call	#2506		;#0x09ca
 8b4:	08 4c       	mov	r12,	r8	;

000008b6 <.Loc.51.1>:
 8b6:	0c 49       	mov	r9,	r12	;
 8b8:	b0 12 ca 09 	call	#2506		;#0x09ca
 8bc:	09 4c       	mov	r12,	r9	;
 8be:	30 40 84 08 	br	#0x0884		;

000008c2 <__mspabi_divi>:
 8c2:	0a 12       	push	r10		;

000008c4 <.LCFI5>:
 8c4:	0f 4c       	mov	r12,	r15	;
 8c6:	0e 4d       	mov	r13,	r14	;

000008c8 <.LVL16>:
 8c8:	3b 40 68 08 	mov	#2152,	r11	;#0x0868

000008cc <.Loc.64.1>:
 8cc:	0c 93       	cmp	#0,	r12	;r3 As==00
 8ce:	1a 34       	jge	$+54     	;abs 0x904

000008d0 <.Loc.66.1>:
 8d0:	4c 43       	clr.b	r12		;

000008d2 <.LVL17>:
 8d2:	0c 8f       	sub	r15,	r12	;
 8d4:	0f 4c       	mov	r12,	r15	;

000008d6 <.LVL18>:
 8d6:	0d 93       	cmp	#0,	r13	;r3 As==00
 8d8:	0d 34       	jge	$+28     	;abs 0x8f4

000008da <.Loc.67.1>:
 8da:	5a 43       	mov.b	#1,	r10	;r3 As==01

000008dc <.L21>:
 8dc:	0d 43       	clr	r13		;
 8de:	0d 8e       	sub	r14,	r13	;

000008e0 <.LVL20>:
 8e0:	4e 43       	clr.b	r14		;

000008e2 <.LVL21>:
 8e2:	0c 4f       	mov	r15,	r12	;

000008e4 <.LVL22>:
 8e4:	8b 12       	call	r11		;

000008e6 <.LVL23>:
 8e6:	1a 93       	cmp	#1,	r10	;r3 As==01
 8e8:	03 24       	jz	$+8      	;abs 0x8f0

000008ea <.L20>:
 8ea:	4d 43       	clr.b	r13		;
 8ec:	0d 8c       	sub	r12,	r13	;
 8ee:	0c 4d       	mov	r13,	r12	;

000008f0 <.L16>:
 8f0:	3a 41       	pop	r10		;
 8f2:	30 41       	ret			

000008f4 <.L18>:
 8f4:	4e 43       	clr.b	r14		;
 8f6:	8b 12       	call	r11		;

000008f8 <.LVL27>:
 8f8:	30 40 ea 08 	br	#0x08ea		;

000008fc <.L27>:
 8fc:	4e 43       	clr.b	r14		;
 8fe:	8b 12       	call	r11		;

00000900 <.LVL29>:
 900:	30 40 f0 08 	br	#0x08f0		;

00000904 <.L17>:
 904:	0d 93       	cmp	#0,	r13	;r3 As==00
 906:	fa 37       	jge	$-10     	;abs 0x8fc

00000908 <.Loc.61.1>:
 908:	4a 43       	clr.b	r10		;
 90a:	30 40 dc 08 	br	#0x08dc		;

0000090e <__mspabi_func_epilog_7>:
 90e:	34 41       	pop	r4		;

00000910 <__mspabi_func_epilog_6>:
 910:	35 41       	pop	r5		;

00000912 <__mspabi_func_epilog_5>:
 912:	36 41       	pop	r6		;

00000914 <__mspabi_func_epilog_4>:
 914:	37 41       	pop	r7		;

00000916 <__mspabi_func_epilog_3>:
 916:	38 41       	pop	r8		;

00000918 <__mspabi_func_epilog_2>:
 918:	39 41       	pop	r9		;

0000091a <__mspabi_func_epilog_1>:
 91a:	3a 41       	pop	r10		;
 91c:	30 41       	ret			

0000091e <__mspabi_slli_15>:
 91e:	0c 5c       	rla	r12		;

00000920 <__mspabi_slli_14>:
 920:	0c 5c       	rla	r12		;

00000922 <__mspabi_slli_13>:
 922:	0c 5c       	rla	r12		;

00000924 <__mspabi_slli_12>:
 924:	0c 5c       	rla	r12		;

00000926 <__mspabi_slli_11>:
 926:	0c 5c       	rla	r12		;

00000928 <__mspabi_slli_10>:
 928:	0c 5c       	rla	r12		;

0000092a <__mspabi_slli_9>:
 92a:	0c 5c       	rla	r12		;

0000092c <__mspabi_slli_8>:
 92c:	0c 5c       	rla	r12		;

0000092e <__mspabi_slli_7>:
 92e:	0c 5c       	rla	r12		;

00000930 <__mspabi_slli_6>:
 930:	0c 5c       	rla	r12		;

00000932 <__mspabi_slli_5>:
 932:	0c 5c       	rla	r12		;

00000934 <__mspabi_slli_4>:
 934:	0c 5c       	rla	r12		;

00000936 <__mspabi_slli_3>:
 936:	0c 5c       	rla	r12		;

00000938 <__mspabi_slli_2>:
 938:	0c 5c       	rla	r12		;

0000093a <__mspabi_slli_1>:
 93a:	0c 5c       	rla	r12		;
 93c:	30 41       	ret			

0000093e <.L11>:
 93e:	3d 53       	add	#-1,	r13	;r3 As==11
 940:	0c 5c       	rla	r12		;

00000942 <__mspabi_slli>:
 942:	0d 93       	cmp	#0,	r13	;r3 As==00
 944:	fc 23       	jnz	$-6      	;abs 0x93e
 946:	30 41       	ret			

00000948 <__mspabi_slll_15>:
 948:	0c 5c       	rla	r12		;
 94a:	0d 6d       	rlc	r13		;

0000094c <__mspabi_slll_14>:
 94c:	0c 5c       	rla	r12		;
 94e:	0d 6d       	rlc	r13		;

00000950 <__mspabi_slll_13>:
 950:	0c 5c       	rla	r12		;
 952:	0d 6d       	rlc	r13		;

00000954 <__mspabi_slll_12>:
 954:	0c 5c       	rla	r12		;
 956:	0d 6d       	rlc	r13		;

00000958 <__mspabi_slll_11>:
 958:	0c 5c       	rla	r12		;
 95a:	0d 6d       	rlc	r13		;

0000095c <__mspabi_slll_10>:
 95c:	0c 5c       	rla	r12		;
 95e:	0d 6d       	rlc	r13		;

00000960 <__mspabi_slll_9>:
 960:	0c 5c       	rla	r12		;
 962:	0d 6d       	rlc	r13		;

00000964 <__mspabi_slll_8>:
 964:	0c 5c       	rla	r12		;
 966:	0d 6d       	rlc	r13		;

00000968 <__mspabi_slll_7>:
 968:	0c 5c       	rla	r12		;
 96a:	0d 6d       	rlc	r13		;

0000096c <__mspabi_slll_6>:
 96c:	0c 5c       	rla	r12		;
 96e:	0d 6d       	rlc	r13		;

00000970 <__mspabi_slll_5>:
 970:	0c 5c       	rla	r12		;
 972:	0d 6d       	rlc	r13		;

00000974 <__mspabi_slll_4>:
 974:	0c 5c       	rla	r12		;
 976:	0d 6d       	rlc	r13		;

00000978 <__mspabi_slll_3>:
 978:	0c 5c       	rla	r12		;
 97a:	0d 6d       	rlc	r13		;

0000097c <__mspabi_slll_2>:
 97c:	0c 5c       	rla	r12		;
 97e:	0d 6d       	rlc	r13		;

00000980 <__mspabi_slll_1>:
 980:	0c 5c       	rla	r12		;
 982:	0d 6d       	rlc	r13		;
 984:	30 41       	ret			

00000986 <.L12>:
 986:	3e 53       	add	#-1,	r14	;r3 As==11
 988:	0c 5c       	rla	r12		;
 98a:	0d 6d       	rlc	r13		;

0000098c <__mspabi_slll>:
 98c:	0e 93       	cmp	#0,	r14	;r3 As==00
 98e:	fb 23       	jnz	$-8      	;abs 0x986
 990:	30 41       	ret			

00000992 <__mspabi_srli_15>:
 992:	12 c3       	clrc			
 994:	0c 10       	rrc	r12		;

00000996 <__mspabi_srli_14>:
 996:	12 c3       	clrc			
 998:	0c 10       	rrc	r12		;

0000099a <__mspabi_srli_13>:
 99a:	12 c3       	clrc			
 99c:	0c 10       	rrc	r12		;

0000099e <__mspabi_srli_12>:
 99e:	12 c3       	clrc			
 9a0:	0c 10       	rrc	r12		;

000009a2 <__mspabi_srli_11>:
 9a2:	12 c3       	clrc			
 9a4:	0c 10       	rrc	r12		;

000009a6 <__mspabi_srli_10>:
 9a6:	12 c3       	clrc			
 9a8:	0c 10       	rrc	r12		;

000009aa <__mspabi_srli_9>:
 9aa:	12 c3       	clrc			
 9ac:	0c 10       	rrc	r12		;

000009ae <__mspabi_srli_8>:
 9ae:	12 c3       	clrc			
 9b0:	0c 10       	rrc	r12		;

000009b2 <__mspabi_srli_7>:
 9b2:	12 c3       	clrc			
 9b4:	0c 10       	rrc	r12		;

000009b6 <__mspabi_srli_6>:
 9b6:	12 c3       	clrc			
 9b8:	0c 10       	rrc	r12		;

000009ba <__mspabi_srli_5>:
 9ba:	12 c3       	clrc			
 9bc:	0c 10       	rrc	r12		;

000009be <__mspabi_srli_4>:
 9be:	12 c3       	clrc			
 9c0:	0c 10       	rrc	r12		;

000009c2 <__mspabi_srli_3>:
 9c2:	12 c3       	clrc			
 9c4:	0c 10       	rrc	r12		;

000009c6 <__mspabi_srli_2>:
 9c6:	12 c3       	clrc			
 9c8:	0c 10       	rrc	r12		;

000009ca <__mspabi_srli_1>:
 9ca:	12 c3       	clrc			
 9cc:	0c 10       	rrc	r12		;
 9ce:	30 41       	ret			

000009d0 <.L11>:
 9d0:	3d 53       	add	#-1,	r13	;r3 As==11
 9d2:	12 c3       	clrc			
 9d4:	0c 10       	rrc	r12		;

000009d6 <__mspabi_srli>:
 9d6:	0d 93       	cmp	#0,	r13	;r3 As==00
 9d8:	fb 23       	jnz	$-8      	;abs 0x9d0
 9da:	30 41       	ret			

000009dc <__mspabi_srll_15>:
 9dc:	12 c3       	clrc			
 9de:	0d 10       	rrc	r13		;
 9e0:	0c 10       	rrc	r12		;

000009e2 <__mspabi_srll_14>:
 9e2:	12 c3       	clrc			
 9e4:	0d 10       	rrc	r13		;
 9e6:	0c 10       	rrc	r12		;

000009e8 <__mspabi_srll_13>:
 9e8:	12 c3       	clrc			
 9ea:	0d 10       	rrc	r13		;
 9ec:	0c 10       	rrc	r12		;

000009ee <__mspabi_srll_12>:
 9ee:	12 c3       	clrc			
 9f0:	0d 10       	rrc	r13		;
 9f2:	0c 10       	rrc	r12		;

000009f4 <__mspabi_srll_11>:
 9f4:	12 c3       	clrc			
 9f6:	0d 10       	rrc	r13		;
 9f8:	0c 10       	rrc	r12		;

000009fa <__mspabi_srll_10>:
 9fa:	12 c3       	clrc			
 9fc:	0d 10       	rrc	r13		;
 9fe:	0c 10       	rrc	r12		;

00000a00 <__mspabi_srll_9>:
 a00:	12 c3       	clrc			
 a02:	0d 10       	rrc	r13		;
 a04:	0c 10       	rrc	r12		;

00000a06 <__mspabi_srll_8>:
 a06:	12 c3       	clrc			
 a08:	0d 10       	rrc	r13		;
 a0a:	0c 10       	rrc	r12		;

00000a0c <__mspabi_srll_7>:
 a0c:	12 c3       	clrc			
 a0e:	0d 10       	rrc	r13		;
 a10:	0c 10       	rrc	r12		;

00000a12 <__mspabi_srll_6>:
 a12:	12 c3       	clrc			
 a14:	0d 10       	rrc	r13		;
 a16:	0c 10       	rrc	r12		;

00000a18 <__mspabi_srll_5>:
 a18:	12 c3       	clrc			
 a1a:	0d 10       	rrc	r13		;
 a1c:	0c 10       	rrc	r12		;

00000a1e <__mspabi_srll_4>:
 a1e:	12 c3       	clrc			
 a20:	0d 10       	rrc	r13		;
 a22:	0c 10       	rrc	r12		;

00000a24 <__mspabi_srll_3>:
 a24:	12 c3       	clrc			
 a26:	0d 10       	rrc	r13		;
 a28:	0c 10       	rrc	r12		;

00000a2a <__mspabi_srll_2>:
 a2a:	12 c3       	clrc			
 a2c:	0d 10       	rrc	r13		;
 a2e:	0c 10       	rrc	r12		;

00000a30 <__mspabi_srll_1>:
 a30:	12 c3       	clrc			
 a32:	0d 10       	rrc	r13		;
 a34:	0c 10       	rrc	r12		;
 a36:	30 41       	ret			

00000a38 <.L12>:
 a38:	3e 53       	add	#-1,	r14	;r3 As==11
 a3a:	12 c3       	clrc			
 a3c:	0d 10       	rrc	r13		;
 a3e:	0c 10       	rrc	r12		;

00000a40 <__mspabi_srll>:
 a40:	0e 93       	cmp	#0,	r14	;r3 As==00
 a42:	fa 23       	jnz	$-10     	;abs 0xa38
 a44:	30 41       	ret			

00000a46 <strcmp>:
 a46:	6e 4c       	mov.b	@r12,	r14	;
 a48:	0e 93       	cmp	#0,	r14	;r3 As==00
 a4a:	03 24       	jz	$+8      	;abs 0xa52

00000a4c <.Loc.66.1>:
 a4c:	cd 9e 00 00 	cmp.b	r14,	0(r13)	;
 a50:	04 24       	jz	$+10     	;abs 0xa5a

00000a52 <.L3>:
 a52:	0c 4e       	mov	r14,	r12	;

00000a54 <.LVL1>:
 a54:	6d 4d       	mov.b	@r13,	r13	;

00000a56 <.LVL2>:
 a56:	0c 8d       	sub	r13,	r12	;
 a58:	30 41       	ret			

00000a5a <.L4>:
 a5a:	1c 53       	inc	r12		;

00000a5c <.Loc.69.1>:
 a5c:	1d 53       	inc	r13		;
 a5e:	30 40 46 0a 	br	#0x0a46		;

00000a62 <strlen>:
 a62:	0d 4c       	mov	r12,	r13	;

00000a64 <.L2>:
 a64:	cd 93 00 00 	cmp.b	#0,	0(r13)	;r3 As==00
 a68:	03 20       	jnz	$+8      	;abs 0xa70

00000a6a <.Loc.88.1>:
 a6a:	0d 8c       	sub	r12,	r13	;

00000a6c <.LVL3>:
 a6c:	0c 4d       	mov	r13,	r12	;

00000a6e <.LVL4>:
 a6e:	30 41       	ret			

00000a70 <.L3>:
 a70:	1d 53       	inc	r13		;
 a72:	30 40 64 0a 	br	#0x0a64		;

Disassembly of section .rodata:

00000a76 <_etext-0x472>:
 a76:	08 20       	jnz	$+18     	;abs 0xa88
 a78:	08 00       	mova	@r0,	r8	;
 a7a:	0a 2d       	jc	$+534    	;abs 0xc90
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
 a92:	2d 2d       	jc	$+604    	;abs 0xcee
 a94:	2d 2d       	jc	$+604    	;abs 0xcf0
 a96:	2d 2d       	jc	$+604    	;abs 0xcf2
 a98:	2d 2d       	jc	$+604    	;abs 0xcf4
 a9a:	2d 2d       	jc	$+604    	;abs 0xcf6
 a9c:	2d 2d       	jc	$+604    	;abs 0xcf8
 a9e:	2d 2d       	jc	$+604    	;abs 0xcfa
 aa0:	2d 0a 2d 2d 	mova	&666925,r13	;0xa2d2d
 aa4:	2d 20       	jnz	$+92     	;abs 0xb00
 aa6:	57 69 73 68 	addc.b	26739(r9),r7	;0x06873
 aaa:	62 6f       	addc.b	@r15,	r2	;
 aac:	6e 65       	addc.b	@r5,	r14	;
 aae:	20 42       	br	#4		;r2 As==10
 ab0:	75 73       	subc.b	#-1,	r5	;r3 As==11
 ab2:	20 45       	br	@r5		;
 ab4:	78 70 6c 6f 	subc.b	#28524,	r8	;#0x6f6c
 ab8:	72 65       	addc.b	@r5+,	r2	;
 aba:	72 20       	jnz	$+230    	;abs 0xba0
 abc:	54 65 72 6d 	addc.b	28018(r5),r4	;0x06d72
 ac0:	69 6e       	addc.b	@r14,	r9	;
 ac2:	61 6c       	addc.b	@r12,	r1	;
 ac4:	20 2d       	jc	$+578    	;abs 0xd06
 ac6:	2d 2d       	jc	$+604    	;abs 0xd22
 ac8:	0a 2d       	jc	$+534    	;abs 0xcde
 aca:	2d 2d       	jc	$+604    	;abs 0xd26
 acc:	2d 2d       	jc	$+604    	;abs 0xd28
 ace:	2d 2d       	jc	$+604    	;abs 0xd2a
 ad0:	2d 2d       	jc	$+604    	;abs 0xd2c
 ad2:	2d 2d       	jc	$+604    	;abs 0xd2e
 ad4:	2d 2d       	jc	$+604    	;abs 0xd30
 ad6:	2d 2d       	jc	$+604    	;abs 0xd32
 ad8:	2d 2d       	jc	$+604    	;abs 0xd34
 ada:	2d 2d       	jc	$+604    	;abs 0xd36
 adc:	2d 2d       	jc	$+604    	;abs 0xd38
 ade:	2d 2d       	jc	$+604    	;abs 0xd3a
 ae0:	2d 2d       	jc	$+604    	;abs 0xd3c
 ae2:	2d 2d       	jc	$+604    	;abs 0xd3e
 ae4:	2d 2d       	jc	$+604    	;abs 0xd40
 ae6:	2d 2d       	jc	$+604    	;abs 0xd42
 ae8:	2d 2d       	jc	$+604    	;abs 0xd44
 aea:	2d 2d       	jc	$+604    	;abs 0xd46
 aec:	2d 2d       	jc	$+604    	;abs 0xd48
 aee:	2d 0a 0a 00 	mova	&655370,r13	;0xa000a
 af2:	45 72       	subc.b	r2,	r5	;
 af4:	72 6f       	addc.b	@r15+,	r2	;
 af6:	72 21       	jnz	$+742    	;abs 0xddc
 af8:	20 4e       	br	@r14		;
 afa:	6f 20       	jnz	$+224    	;abs 0xbda
 afc:	57 69 73 68 	addc.b	26739(r9),r7	;0x06873
 b00:	62 6f       	addc.b	@r15,	r2	;
 b02:	6e 65       	addc.b	@r5,	r14	;
 b04:	20 61       	addc	@r1,	r0	;
 b06:	64 61       	addc.b	@r1,	r4	;
 b08:	70 74       	subc.b	@r4+,	r0	;
 b0a:	65 72       	subc.b	#4,	r5	;r2 As==10
 b0c:	20 73       	subc	#2,	r0	;r3 As==10
 b0e:	79 6e       	addc.b	@r14+,	r9	;
 b10:	74 68       	addc.b	@r8+,	r4	;
 b12:	65 73       	subc.b	#2,	r5	;r3 As==10
 b14:	69 7a       	subc.b	@r10,	r9	;
 b16:	65 64       	addc.b	@r4,	r5	;
 b18:	21 00 43 6f 	mova	&28483,	r1	;0x06f43
 b1c:	6e 66       	addc.b	@r6,	r14	;
 b1e:	69 67       	addc.b	@r7,	r9	;
 b20:	75 72       	subc.b	#8,	r5	;r2 As==11
 b22:	65 20       	jnz	$+204    	;abs 0xbee
 b24:	74 68       	addc.b	@r8+,	r4	;
 b26:	65 20       	jnz	$+204    	;abs 0xbf2
 b28:	61 63       	addc.b	#2,	r1	;r3 As==10
 b2a:	74 75       	subc.b	@r5+,	r4	;
 b2c:	61 6c       	addc.b	@r12,	r1	;
 b2e:	20 64       	addc	@r4,	r0	;
 b30:	61 74       	subc.b	@r4,	r1	;
 b32:	61 20       	jnz	$+196    	;abs 0xbf6
 b34:	74 72       	subc.b	#8,	r4	;r2 As==11
 b36:	61 6e       	addc.b	@r14,	r1	;
 b38:	73 66       	.word	0x6673;	????
 b3a:	65 72       	subc.b	#4,	r5	;r2 As==10
 b3c:	20 73       	subc	#2,	r0	;r3 As==10
 b3e:	69 7a       	subc.b	@r10,	r9	;
 b40:	65 20       	jnz	$+204    	;abs 0xc0c
 b42:	28 31       	jn	$+594    	;abs 0xd94
 b44:	2c 20       	jnz	$+90     	;abs 0xb9e
 b46:	32 20       	jnz	$+102    	;abs 0xbac
 b48:	6f 72       	subc.b	#4,	r15	;r2 As==10
 b4a:	20 34       	jge	$+66     	;abs 0xb8c
 b4c:	20 62       	addc	#4,	r0	;r2 As==10
 b4e:	79 74       	subc.b	@r4+,	r9	;
 b50:	65 73       	subc.b	#2,	r5	;r3 As==10
 b52:	29 0a 75 73 	mova	&684917,r9	;0xa7375
 b56:	69 6e       	addc.b	@r14,	r9	;
 b58:	67 20       	jnz	$+208    	;abs 0xc28
 b5a:	27 73       	subc	#2,	r7	;r3 As==10
 b5c:	65 74       	subc.b	@r4,	r5	;
 b5e:	75 70 27 2e 	subc.b	#11815,	r5	;#0x2e27
 b62:	20 41       	br	@r1		;
 b64:	64 64       	addc.b	@r4,	r4	;
 b66:	72 65       	addc.b	@r5+,	r2	;
 b68:	73 73       	.word	0x7373;	????
 b6a:	65 73       	subc.b	#2,	r5	;r3 As==10
 b6c:	20 61       	addc	@r1,	r0	;
 b6e:	72 65       	addc.b	@r5+,	r2	;
 b70:	20 61       	addc	@r1,	r0	;
 b72:	6c 77       	subc.b	@r7,	r12	;
 b74:	61 79       	subc.b	@r9,	r1	;
 b76:	73 20       	jnz	$+232    	;abs 0xc5e
 b78:	33 32       	jn	$-920    	;abs 0x7e0
 b7a:	2d 62       	addc	#4,	r13	;r2 As==10
 b7c:	69 74       	subc.b	@r4,	r9	;
 b7e:	20 77       	subc	@r7,	r0	;
 b80:	69 64       	addc.b	@r4,	r9	;
 b82:	65 2e       	jc	$-820    	;abs 0x84e
 b84:	0a 54       	add	r4,	r10	;
 b86:	68 69       	addc.b	@r9,	r8	;
 b88:	73 20       	jnz	$+232    	;abs 0xc70
 b8a:	74 6f       	addc.b	@r15+,	r4	;
 b8c:	6f 6c       	addc.b	@r12,	r15	;
 b8e:	20 75       	subc	@r5,	r0	;
 b90:	73 65       	.word	0x6573;	????
 b92:	73 20       	jnz	$+232    	;abs 0xc7a
 b94:	6e 6f       	addc.b	@r15,	r14	;
 b96:	6e 2d       	jc	$+734    	;abs 0xe74
 b98:	62 6c       	addc.b	@r12,	r2	;
 b9a:	6f 63       	addc.b	#2,	r15	;r3 As==10
 b9c:	6b 69       	addc.b	@r9,	r11	;
 b9e:	6e 67       	addc.b	@r7,	r14	;
 ba0:	20 57       	add	@r7,	r0	;
 ba2:	69 73       	subc.b	#2,	r9	;r3 As==10
 ba4:	68 62       	addc.b	#4,	r8	;r2 As==10
 ba6:	6f 6e       	addc.b	@r14,	r15	;
 ba8:	65 20       	jnz	$+204    	;abs 0xc74
 baa:	74 72       	subc.b	#8,	r4	;r2 As==11
 bac:	61 6e       	addc.b	@r14,	r1	;
 bae:	73 61       	.word	0x6173;	????
 bb0:	63 74       	.word	0x7463;	????
 bb2:	69 6f       	addc.b	@r15,	r9	;
 bb4:	6e 73       	subc.b	#2,	r14	;r3 As==10
 bb6:	2e 0a 0a 54 	mova	&676874,r14	;0xa540a
 bba:	79 70 65 20 	subc.b	#8293,	r9	;#0x2065
 bbe:	27 68       	addc	@r8,	r7	;
 bc0:	65 6c       	addc.b	@r12,	r5	;
 bc2:	70 27       	jz	$-286    	;abs 0xaa4
 bc4:	20 74       	subc	@r4,	r0	;
 bc6:	6f 20       	jnz	$+224    	;abs 0xca6
 bc8:	73 65       	.word	0x6573;	????
 bca:	65 20       	jnz	$+204    	;abs 0xc96
 bcc:	74 68       	addc.b	@r8+,	r4	;
 bce:	65 20       	jnz	$+204    	;abs 0xc9a
 bd0:	68 65       	addc.b	@r5,	r8	;
 bd2:	6c 70       	subc.b	@r0,	r12	;
 bd4:	20 6d       	addc	@r13,	r0	;
 bd6:	65 6e       	addc.b	@r14,	r5	;
 bd8:	75 2e       	jc	$-788    	;abs 0x8c4
 bda:	0a 0a       	mova	@r10,	r10	;
 bdc:	00 57       	add	r7,	r0	;
 bde:	42 5f       	add.b	r15,	r2	;
 be0:	45 58       	add.b	r8,	r5	;
 be2:	50 4c 4f 52 	br	21071(r12)		;
 be6:	45 52       	add.b	r2,	r5	;
 be8:	3a 3e       	jmp	$-906    	;abs 0x85e
 bea:	20 00 0a 00 	bra	&10		;0x0000a
 bee:	68 65       	addc.b	@r5,	r8	;
 bf0:	6c 70       	subc.b	@r0,	r12	;
 bf2:	00 73       	sbc	r0		;
 bf4:	65 74       	subc.b	@r4,	r5	;
 bf6:	75 70 00 72 	subc.b	#29184,	r5	;#0x7200
 bfa:	65 61       	addc.b	@r1,	r5	;
 bfc:	64 00 77 72 	mova	r0,	&291447	; 0x47277
 c00:	69 74       	subc.b	@r4,	r9	;
 c02:	65 00 64 75 	mova	r0,	&357732	; 0x57564
 c06:	6d 70       	subc.b	@r0,	r13	;
 c08:	00 72       	subc	r2,	r0	;
 c0a:	65 73       	subc.b	#2,	r5	;r3 As==10
 c0c:	65 74       	subc.b	@r4,	r5	;
 c0e:	00 65       	addc	r5,	r0	;
 c10:	78 69       	addc.b	@r9+,	r8	;
 c12:	74 00 41 76 	mova	r0,	30273(r4); 0x07641
 c16:	61 69       	addc.b	@r9,	r1	;
 c18:	6c 61       	addc.b	@r1,	r12	;
 c1a:	62 6c       	addc.b	@r12,	r2	;
 c1c:	65 20       	jnz	$+204    	;abs 0xce8
 c1e:	63 6f       	.word	0x6f63;	????
 c20:	6d 6d       	addc.b	@r13,	r13	;
 c22:	61 6e       	addc.b	@r14,	r1	;
 c24:	64 73       	subc.b	#2,	r4	;r3 As==10
 c26:	3a 0a 20 68 	mova	26656(r10),r10	;0x06820
 c2a:	65 6c       	addc.b	@r12,	r5	;
 c2c:	70 20       	jnz	$+226    	;abs 0xd0e
 c2e:	20 2d       	jc	$+578    	;abs 0xe70
 c30:	20 73       	subc	#2,	r0	;r3 As==10
 c32:	68 6f       	addc.b	@r15,	r8	;
 c34:	77 20       	jnz	$+240    	;abs 0xd24
 c36:	74 68       	addc.b	@r8+,	r4	;
 c38:	69 73       	subc.b	#2,	r9	;r3 As==10
 c3a:	20 74       	subc	@r4,	r0	;
 c3c:	65 78       	subc.b	@r8,	r5	;
 c3e:	74 0a 20 73 	mova	r10,	29472(r4); 0x07320
 c42:	65 74       	subc.b	@r4,	r5	;
 c44:	75 70 20 2d 	subc.b	#11552,	r5	;#0x2d20
 c48:	20 63       	addc	#2,	r0	;r3 As==10
 c4a:	6f 6e       	addc.b	@r14,	r15	;
 c4c:	66 69       	addc.b	@r9,	r6	;
 c4e:	67 75       	subc.b	@r5,	r7	;
 c50:	72 65       	addc.b	@r5+,	r2	;
 c52:	20 57       	add	@r7,	r0	;
 c54:	42 20       	jnz	$+134    	;abs 0xcda
 c56:	69 6e       	addc.b	@r14,	r9	;
 c58:	74 65       	addc.b	@r5+,	r4	;
 c5a:	72 66       	addc.b	@r6+,	r2	;
 c5c:	61 63       	addc.b	#2,	r1	;r3 As==10
 c5e:	65 0a 20 72 	mova	r10,	&356896	; 0x57220
 c62:	65 61       	addc.b	@r1,	r5	;
 c64:	64 20       	jnz	$+202    	;abs 0xd2e
 c66:	20 2d       	jc	$+578    	;abs 0xea8
 c68:	20 72       	subc	#4,	r0	;r2 As==10
 c6a:	65 61       	addc.b	@r1,	r5	;
 c6c:	64 20       	jnz	$+202    	;abs 0xd36
 c6e:	66 72       	subc.b	#4,	r6	;r2 As==10
 c70:	6f 6d       	addc.b	@r13,	r15	;
 c72:	20 57       	add	@r7,	r0	;
 c74:	42 20       	jnz	$+134    	;abs 0xcfa
 c76:	61 64       	addc.b	@r4,	r1	;
 c78:	64 72       	subc.b	#4,	r4	;r2 As==10
 c7a:	65 73       	subc.b	#2,	r5	;r3 As==10
 c7c:	73 0a 20 77 	mova	r10,	30496(r3); 0x07720
 c80:	72 69       	addc.b	@r9+,	r2	;
 c82:	74 65       	addc.b	@r5+,	r4	;
 c84:	20 2d       	jc	$+578    	;abs 0xec6
 c86:	20 77       	subc	@r7,	r0	;
 c88:	72 69       	addc.b	@r9+,	r2	;
 c8a:	74 65       	addc.b	@r5+,	r4	;
 c8c:	20 74       	subc	@r4,	r0	;
 c8e:	6f 20       	jnz	$+224    	;abs 0xd6e
 c90:	57 42 20 61 	mov.b	&0x6120,r7	;0x6120
 c94:	64 64       	addc.b	@r4,	r4	;
 c96:	72 65       	addc.b	@r5+,	r2	;
 c98:	73 73       	.word	0x7373;	????
 c9a:	0a 20       	jnz	$+22     	;abs 0xcb0
 c9c:	64 75       	subc.b	@r5,	r4	;
 c9e:	6d 70       	subc.b	@r0,	r13	;
 ca0:	20 20       	jnz	$+66     	;abs 0xce2
 ca2:	2d 20       	jnz	$+92     	;abs 0xcfe
 ca4:	64 75       	subc.b	@r5,	r4	;
 ca6:	6d 70       	subc.b	@r0,	r13	;
 ca8:	20 64       	addc	@r4,	r0	;
 caa:	61 74       	subc.b	@r4,	r1	;
 cac:	61 20       	jnz	$+196    	;abs 0xd70
 cae:	66 72       	subc.b	#4,	r6	;r2 As==10
 cb0:	6f 6d       	addc.b	@r13,	r15	;
 cb2:	20 57       	add	@r7,	r0	;
 cb4:	42 20       	jnz	$+134    	;abs 0xd3a
 cb6:	61 64       	addc.b	@r4,	r1	;
 cb8:	64 72       	subc.b	#4,	r4	;r2 As==10
 cba:	65 73       	subc.b	#2,	r5	;r3 As==10
 cbc:	73 65       	.word	0x6573;	????
 cbe:	73 0a 20 72 	mova	r10,	29216(r3); 0x07220
 cc2:	65 73       	subc.b	#2,	r5	;r3 As==10
 cc4:	65 74       	subc.b	@r4,	r5	;
 cc6:	20 2d       	jc	$+578    	;abs 0xf08
 cc8:	20 70       	subc	@r0,	r0	;
 cca:	65 72       	subc.b	#4,	r5	;r2 As==10
 ccc:	66 6f       	addc.b	@r15,	r6	;
 cce:	72 6d       	addc.b	@r13+,	r2	;
 cd0:	20 73       	subc	#2,	r0	;r3 As==10
 cd2:	6f 66       	addc.b	@r6,	r15	;
 cd4:	74 2d       	jc	$+746    	;abs 0xfbe
 cd6:	72 65       	addc.b	@r5+,	r2	;
 cd8:	73 65       	.word	0x6573;	????
 cda:	74 0a 20 65 	mova	r10,	25888(r4); 0x06520
 cde:	78 69       	addc.b	@r9+,	r8	;
 ce0:	74 20       	jnz	$+234    	;abs 0xdca
 ce2:	20 2d       	jc	$+578    	;abs 0xf24
 ce4:	20 65       	addc	@r5,	r0	;
 ce6:	78 69       	addc.b	@r9+,	r8	;
 ce8:	74 20       	jnz	$+234    	;abs 0xdd2
 cea:	70 72       	subc.b	#8,	r0	;r2 As==11
 cec:	6f 67       	addc.b	@r7,	r15	;
 cee:	72 61       	addc.b	@r1+,	r2	;
 cf0:	6d 20       	jnz	$+220    	;abs 0xdcc
 cf2:	61 6e       	addc.b	@r14,	r1	;
 cf4:	64 20       	jnz	$+202    	;abs 0xdbe
 cf6:	72 65       	addc.b	@r5+,	r2	;
 cf8:	74 75       	subc.b	@r5+,	r4	;
 cfa:	72 6e       	addc.b	@r14+,	r2	;
 cfc:	20 74       	subc	@r4,	r0	;
 cfe:	6f 20       	jnz	$+224    	;abs 0xdde
 d00:	62 6f       	addc.b	@r15,	r2	;
 d02:	6f 74       	subc.b	@r4,	r15	;
 d04:	6c 6f       	addc.b	@r15,	r12	;
 d06:	61 64       	addc.b	@r4,	r1	;
 d08:	65 72       	subc.b	#4,	r5	;r2 As==10
 d0a:	0a 00       	mova	@r0,	r10	;
 d0c:	53 65       	.word	0x6553;	????
 d0e:	6c 65       	addc.b	@r5,	r12	;
 d10:	63 74       	.word	0x7463;	????
 d12:	20 74       	subc	@r4,	r0	;
 d14:	72 61       	addc.b	@r1+,	r2	;
 d16:	6e 73       	subc.b	#2,	r14	;r3 As==10
 d18:	66 65       	addc.b	@r5,	r6	;
 d1a:	72 20       	jnz	$+230    	;abs 0xe00
 d1c:	73 69       	.word	0x6973;	????
 d1e:	7a 65       	addc.b	@r5+,	r10	;
 d20:	20 69       	addc	@r9,	r0	;
 d22:	6e 20       	jnz	$+222    	;abs 0xe00
 d24:	62 79       	subc.b	@r9,	r2	;
 d26:	74 65       	addc.b	@r5+,	r4	;
 d28:	73 20       	jnz	$+232    	;abs 0xe10
 d2a:	28 31       	jn	$+594    	;abs 0xf7c
 d2c:	2c 32       	jn	$-934    	;abs 0x986
 d2e:	2c 34       	jge	$+90     	;abs 0xd88
 d30:	29 3a       	jl	$-940    	;abs 0x984
 d32:	20 00 31 00 	bra	&49		;0x00031
 d36:	32 00 34 00 	mova	52(r0),	r2	;PC rel. 0x00d6c
 d3a:	0a 49       	mov	r9,	r10	;
 d3c:	6e 76       	subc.b	@r6,	r14	;
 d3e:	61 6c       	addc.b	@r12,	r1	;
 d40:	69 64       	addc.b	@r4,	r9	;
 d42:	20 69       	addc	@r9,	r0	;
 d44:	6e 70       	subc.b	@r0,	r14	;
 d46:	75 74       	subc.b	@r4+,	r5	;
 d48:	2e 20       	jnz	$+94     	;abs 0xda6
 d4a:	43 61       	.word	0x6143;	????
 d4c:	6e 63       	addc.b	#2,	r14	;r3 As==10
 d4e:	65 6c       	addc.b	@r12,	r5	;
 d50:	6c 69       	addc.b	@r9,	r12	;
 d52:	6e 67       	addc.b	@r7,	r14	;
 d54:	20 73       	subc	#2,	r0	;r3 As==10
 d56:	65 74       	subc.b	@r4,	r5	;
 d58:	75 70 2e 0a 	subc.b	#2606,	r5	;#0x0a2e
 d5c:	00 0a       	bra	@r10		;
 d5e:	53 65       	.word	0x6553;	????
 d60:	74 75       	subc.b	@r5+,	r4	;
 d62:	70 20       	jnz	$+226    	;abs 0xe44
 d64:	64 6f       	addc.b	@r15,	r4	;
 d66:	6e 65       	addc.b	@r5,	r14	;
 d68:	2e 0a 00 45 	mova	&673024,r14	;0xa4500
 d6c:	6e 74       	subc.b	@r4,	r14	;
 d6e:	65 72       	subc.b	#4,	r5	;r2 As==10
 d70:	20 68       	addc	@r8,	r0	;
 d72:	65 78       	subc.b	@r8,	r5	;
 d74:	61 64       	addc.b	@r4,	r1	;
 d76:	65 63       	addc.b	#2,	r5	;r3 As==10
 d78:	69 6d       	addc.b	@r13,	r9	;
 d7a:	61 6c       	addc.b	@r12,	r1	;
 d7c:	20 74       	subc	@r4,	r0	;
 d7e:	61 72       	subc.b	#4,	r1	;r2 As==10
 d80:	67 65       	addc.b	@r5,	r7	;
 d82:	74 20       	jnz	$+234    	;abs 0xe6c
 d84:	61 64       	addc.b	@r4,	r1	;
 d86:	64 72       	subc.b	#4,	r4	;r2 As==10
 d88:	65 73       	subc.b	#2,	r5	;r3 As==10
 d8a:	73 3a       	jl	$-792    	;abs 0xa72
 d8c:	20 30       	jn	$+66     	;abs 0xdce
 d8e:	78 00 0a 52 	mova	r0,	21002(r8); 0x0520a
 d92:	65 61       	addc.b	@r1,	r5	;
 d94:	64 69       	addc.b	@r9,	r4	;
 d96:	6e 67       	addc.b	@r7,	r14	;
 d98:	20 66       	addc	@r6,	r0	;
 d9a:	72 6f       	addc.b	@r15+,	r2	;
 d9c:	6d 20       	jnz	$+220    	;abs 0xe78
 d9e:	5b 30       	jn	$+184    	;abs 0xe56
 da0:	78 00 5d 2e 	mova	r0,	11869(r8); 0x02e5d
 da4:	2e 2e       	jc	$-930    	;abs 0xa02
 da6:	20 00 52 65 	bra	&25938		;0x06552
 daa:	61 64       	addc.b	@r4,	r1	;
 dac:	20 64       	addc	@r4,	r0	;
 dae:	61 74       	subc.b	@r4,	r1	;
 db0:	61 3a       	jl	$-828    	;abs 0xa74
 db2:	20 30       	jn	$+66     	;abs 0xdf4
 db4:	78 00 0a 45 	mova	r0,	17674(r8); 0x0450a
 db8:	72 72       	subc.b	#8,	r2	;r2 As==11
 dba:	6f 72       	subc.b	#4,	r15	;r2 As==10
 dbc:	21 20       	jnz	$+68     	;abs 0xe00
 dbe:	44 65       	addc.b	r5,	r4	;
 dc0:	76 69       	addc.b	@r9+,	r6	;
 dc2:	63 65       	.word	0x6563;	????
 dc4:	20 6e       	addc	@r14,	r0	;
 dc6:	6f 74       	subc.b	@r4,	r15	;
 dc8:	20 72       	subc	#4,	r0	;r2 As==10
 dca:	65 73       	subc.b	#2,	r5	;r3 As==10
 dcc:	70 6f       	addc.b	@r15+,	r0	;
 dce:	6e 64       	addc.b	@r4,	r14	;
 dd0:	69 6e       	addc.b	@r14,	r9	;
 dd2:	67 21       	jnz	$+720    	;abs 0x10a2
 dd4:	20 50       	add	@r0,	r0	;
 dd6:	72 65       	addc.b	@r5+,	r2	;
 dd8:	73 73       	.word	0x7373;	????
 dda:	20 6b       	addc	@r11,	r0	;
 ddc:	65 79       	subc.b	@r9,	r5	;
 dde:	20 74       	subc	@r4,	r0	;
 de0:	6f 20       	jnz	$+224    	;abs 0xec0
 de2:	70 72       	subc.b	#8,	r0	;r2 As==11
 de4:	6f 63       	addc.b	#2,	r15	;r3 As==10
 de6:	65 65       	addc.b	@r5,	r5	;
 de8:	64 2e       	jc	$-822    	;abs 0xab2
 dea:	0a 00       	mova	@r0,	r10	;
 dec:	0a 45       	mov	r5,	r10	;
 dee:	6e 74       	subc.b	@r4,	r14	;
 df0:	65 72       	subc.b	#4,	r5	;r2 As==10
 df2:	20 68       	addc	@r8,	r0	;
 df4:	65 78       	subc.b	@r8,	r5	;
 df6:	61 64       	addc.b	@r4,	r1	;
 df8:	65 63       	addc.b	#2,	r5	;r3 As==10
 dfa:	69 6d       	addc.b	@r13,	r9	;
 dfc:	61 6c       	addc.b	@r12,	r1	;
 dfe:	20 77       	subc	@r7,	r0	;
 e00:	72 69       	addc.b	@r9+,	r2	;
 e02:	74 65       	addc.b	@r5+,	r4	;
 e04:	20 64       	addc	@r4,	r0	;
 e06:	61 74       	subc.b	@r4,	r1	;
 e08:	61 3a       	jl	$-828    	;abs 0xacc
 e0a:	20 30       	jn	$+66     	;abs 0xe4c
 e0c:	78 00 0a 57 	mova	r0,	22282(r8); 0x0570a
 e10:	72 69       	addc.b	@r9+,	r2	;
 e12:	74 69       	addc.b	@r9+,	r4	;
 e14:	6e 67       	addc.b	@r7,	r14	;
 e16:	20 27       	jz	$-446    	;abs 0xc58
 e18:	30 78       	subc	@r8+,	r0	;
 e1a:	00 27       	jz	$-510    	;abs 0xc1c
 e1c:	20 74       	subc	@r4,	r0	;
 e1e:	6f 20       	jnz	$+224    	;abs 0xefe
 e20:	5b 30       	jn	$+184    	;abs 0xed8
 e22:	78 00 44 6f 	mova	r0,	28484(r8); 0x06f44
 e26:	6e 65       	addc.b	@r5,	r14	;
 e28:	2e 0a 00 45 	mova	&673024,r14	;0xa4500
 e2c:	6e 74       	subc.b	@r4,	r14	;
 e2e:	65 72       	subc.b	#4,	r5	;r2 As==10
 e30:	20 68       	addc	@r8,	r0	;
 e32:	65 78       	subc.b	@r8,	r5	;
 e34:	61 64       	addc.b	@r4,	r1	;
 e36:	65 63       	addc.b	#2,	r5	;r3 As==10
 e38:	69 6d       	addc.b	@r13,	r9	;
 e3a:	61 6c       	addc.b	@r12,	r1	;
 e3c:	20 73       	subc	#2,	r0	;r3 As==10
 e3e:	74 61       	addc.b	@r1+,	r4	;
 e40:	72 74       	subc.b	@r4+,	r2	;
 e42:	20 61       	addc	@r1,	r0	;
 e44:	64 64       	addc.b	@r4,	r4	;
 e46:	72 65       	addc.b	@r5+,	r2	;
 e48:	73 73       	.word	0x7373;	????
 e4a:	3a 20       	jnz	$+118    	;abs 0xec0
 e4c:	30 78       	subc	@r8+,	r0	;
 e4e:	00 0a       	bra	@r10		;
 e50:	50 72 65 73 	subc.b	&0x7365,r0	;0x7365
 e54:	73 20       	jnz	$+232    	;abs 0xf3c
 e56:	61 6e       	addc.b	@r14,	r1	;
 e58:	79 20       	jnz	$+244    	;abs 0xf4c
 e5a:	6b 65       	addc.b	@r5,	r11	;
 e5c:	79 20       	jnz	$+244    	;abs 0xf50
 e5e:	74 6f       	addc.b	@r15+,	r4	;
 e60:	20 73       	subc	#2,	r0	;r3 As==10
 e62:	74 61       	addc.b	@r1+,	r4	;
 e64:	72 74       	subc.b	@r4+,	r2	;
 e66:	2e 0a 59 6f 	mova	&683865,r14	;0xa6f59
 e6a:	75 20       	jnz	$+236    	;abs 0xf56
 e6c:	63 61       	.word	0x6163;	????
 e6e:	6e 20       	jnz	$+222    	;abs 0xf4c
 e70:	61 62       	addc.b	#4,	r1	;r2 As==10
 e72:	6f 72       	subc.b	#4,	r15	;r2 As==10
 e74:	74 20       	jnz	$+234    	;abs 0xf5e
 e76:	64 75       	subc.b	@r5,	r4	;
 e78:	6d 70       	subc.b	@r0,	r13	;
 e7a:	69 6e       	addc.b	@r14,	r9	;
 e7c:	67 20       	jnz	$+208    	;abs 0xf4c
 e7e:	62 79       	subc.b	@r9,	r2	;
 e80:	20 70       	subc	@r0,	r0	;
 e82:	72 65       	addc.b	@r5+,	r2	;
 e84:	73 73       	.word	0x7373;	????
 e86:	69 6e       	addc.b	@r14,	r9	;
 e88:	67 20       	jnz	$+208    	;abs 0xf58
 e8a:	61 6e       	addc.b	@r14,	r1	;
 e8c:	79 20       	jnz	$+244    	;abs 0xf80
 e8e:	6b 65       	addc.b	@r5,	r11	;
 e90:	79 2e       	jc	$-780    	;abs 0xb84
 e92:	0a 00       	mova	@r0,	r10	;
 e94:	30 78       	subc	@r8+,	r0	;
 e96:	00 3a       	.word	0x3a00;	????
 e98:	20 20       	jnz	$+66     	;abs 0xeda
 e9a:	00 4e       	br	r14		;
 e9c:	6f 20       	jnz	$+224    	;abs 0xf7c
 e9e:	62 6f       	addc.b	@r15,	r2	;
 ea0:	6f 74       	subc.b	@r4,	r15	;
 ea2:	6c 6f       	addc.b	@r15,	r12	;
 ea4:	61 64       	addc.b	@r4,	r1	;
 ea6:	65 72       	subc.b	#4,	r5	;r2 As==10
 ea8:	20 69       	addc	@r9,	r0	;
 eaa:	6e 73       	subc.b	#2,	r14	;r3 As==10
 eac:	74 61       	addc.b	@r1+,	r4	;
 eae:	6c 6c       	addc.b	@r12,	r12	;
 eb0:	65 64       	addc.b	@r4,	r5	;
 eb2:	21 0a 00 49 	mova	&674048,r1	;0xa4900
 eb6:	6e 76       	subc.b	@r6,	r14	;
 eb8:	61 6c       	addc.b	@r12,	r1	;
 eba:	69 64       	addc.b	@r4,	r9	;
 ebc:	20 63       	addc	#2,	r0	;r3 As==10
 ebe:	6f 6d       	addc.b	@r13,	r15	;
 ec0:	6d 61       	addc.b	@r1,	r13	;
 ec2:	6e 64       	addc.b	@r4,	r14	;
 ec4:	2e 20       	jnz	$+94     	;abs 0xf22
 ec6:	54 79 70 65 	subc.b	25968(r9),r4	;0x06570
 eca:	20 27       	jz	$-446    	;abs 0xd0c
 ecc:	68 65       	addc.b	@r5,	r8	;
 ece:	6c 70       	subc.b	@r0,	r12	;
 ed0:	27 20       	jnz	$+80     	;abs 0xf20
 ed2:	74 6f       	addc.b	@r15+,	r4	;
 ed4:	20 73       	subc	#2,	r0	;r3 As==10
 ed6:	65 65       	addc.b	@r5,	r5	;
 ed8:	20 61       	addc	@r1,	r0	;
 eda:	6c 6c       	addc.b	@r12,	r12	;
 edc:	20 63       	addc	#2,	r0	;r3 As==10
 ede:	6f 6d       	addc.b	@r13,	r15	;
 ee0:	6d 61       	addc.b	@r1,	r13	;
 ee2:	6e 64       	addc.b	@r4,	r14	;
 ee4:	73 2e       	jc	$-792    	;abs 0xbcc
 ee6:	0a 00       	mova	@r0,	r10	;

Disassembly of section .bss:

00008008 <__bssstart>:
    8008:	00 00       	beq			

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
   0:	83 00 00 00 	mova	#0,	r3	;
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
  6e:	2f 73       	subc	#2,	r15	;r3 As==10
  70:	77 2f       	jc	$-272    	;abs 0xffffff60
  72:	63 6f       	.word	0x6f63;	????
  74:	6d 6d       	addc.b	@r13,	r13	;
  76:	6f 6e       	addc.b	@r14,	r15	;
  78:	00 47       	br	r7		;
  7a:	4e 55       	add.b	r5,	r14	;
  7c:	20 41       	br	@r1		;
  7e:	53 20       	jnz	$+168    	;abs 0x126
  80:	32 2e       	jc	$-922    	;abs 0xfffffce6
  82:	32 36       	jge	$-922    	;abs 0xfffffce8
  84:	00 01       	bra	@r1		;
  86:	80 f7       	Address 0x00000086 is out of bounds.
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
 11a:	01 61       	Address 0x0000011a is out of bounds.
.word	0xffff;	????
