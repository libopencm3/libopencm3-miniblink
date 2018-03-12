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

define RAWMakeBoard
	$(CC) -DRCC_LED1=$(1) -DPORT_LED1=$(2) -DPIN_LED1=$(3) $(4) -o $(OD)/$(5)
endef

define MakeBoard
BOARDS_ALL+=$(OD)/$(1).elf
$(OD)/$(1).elf: template_stm32.c libopencm3/lib/libopencm3_$(5).a
	$(call RAWMakeBoard,RCC_$(2),$(2),$(3),$(4),$(1).elf)
endef

include boards.stm32f1.mk
include boards.stm32f4.mk
include boards.stm32l1.mk

realall.really: outdir $(BOARDS_ALL)

libopencm3/lib/libopencm3_%.a:
	$(MAKE) -C libopencm3

outdir:
	mkdir -p $(OD)

clean:
	$(RM) $(BOARDS_ALL)

.PHONY: realall.really outdir clean all
