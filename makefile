##
## @file - makefile
## @author - Harlan James <root@aboyandhisgnu.org>
## @description - Simple makefile for the project
##

PROJECT = blink

CC=arm-none-eabi-gcc
LD=arm-none-eabi-ld
AR=arm-none-eabi-ar
AS=arm-none-eabi-as
CP=arm-none-eabi-objcopy
OD=arm-none-eabi-objdump

CFLAGS  = -Wall -Wextra -std=c11
CFLAGS += -nostdlib -mcpu=cortex-m4 -mthumb -mthumb-interwork
CFLAGS += -I./include
CFLAGS += -T stm32f407vg.ld

SRC     = startup.S main.c

LINKER  = ./stm32f4.ld

ELF     = $(PROJECT).elf
BIN     = $(PROJECT).bin

default: $(BIN)
	st-flash write $(BIN) 0x8000000

$(BIN) : $(ELF)
	$(CP) -O binary $^ $@

$(ELF): $(SRC)
	$(CC) $(CFLAGS) $^ -o $@
