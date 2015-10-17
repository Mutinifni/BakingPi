.section .init
.globl _start
_start:

b main

.section .text

main:

mov sp,#0x8000

// SetGpioFunction function sets the function of GPIO port 16 (OK LED) to 001
pinNum .req r0
pinFunc .req r1
mov pinNum,#16
mov pinFunc,#1
bl SetGpioFunction
.unreq pinNum
.unreq pinFunc

// Set GPIO 16 to low, causing the LED to turn on.
loop$:
pinNum .req r0
pinVal .req r1
mov pinNum,#16
mov pinVal,#0
bl SetGpio
.unreq pinNum
.unreq pinVal

// Make the processor busy.
decr .req r0
mov decr,#0x3F0000
wait1$: 
	sub decr,#1
	teq decr,#0
	bne wait1$
.unreq decr


// Set GPIO 16 to high.
pinNum .req r0
pinVal .req r1
mov pinNum,#16
mov pinVal,#1
bl SetGpio
.unreq pinNum
.unreq pinVal

// Make the processor busy.
decr .req r0
mov decr,#0x3F0000
wait2$:
	sub decr,#1
	teq decr,#0
	bne wait2$
.unreq decr

b loop$
