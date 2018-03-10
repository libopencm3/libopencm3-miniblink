CC=arm-none-eabi-gcc
OD=bin

all: realall.really

SFLAGS= --static -nostartfiles -std=c11 -g3 -Os
SFLAGS+= -fno-common -ffunction-sections -fdata-sections
SFLAGS+= -I./libopencm3/include -L./libopencm3/lib
LFLAGS+=-Wl,--start-group -lc -lgcc -lnosys -Wl,--end-group
LFLAGS+= template_stm32.c -T ld.stm32.basic

M3_FLAGS= $(SFLAGS) -mcpu=cortex-m3 -mthumb -msoft-float
M4FH_FLAGS= $(SFLAGS) -mcpu=cortex-m4 -mthumb -mfloat-abi=hard -mfpu=fpv4-sp-d16

include boards.stm32f1.mk
include boards.stm32f4.mk
include boards.stm32l1.mk

realall.really: outdir $(BOARDS_STM32F1) $(BOARDS_STM32F4) $(BOARDS_STM32L1)

outdir:
	mkdir -p $(OD)

clean:
	# eh, I'm sure we can do this better, but this is ok for now.
	$(RM) -rf $(OD)
