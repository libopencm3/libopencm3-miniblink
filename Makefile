CC=arm-none-eabi-gcc
OBJCOPY=arm-none-eabi-objcopy
OD=bin

all: realall.really

SFLAGS= --static -nostartfiles -std=c11 -g3 -Os
SFLAGS+= -fno-common -ffunction-sections -fdata-sections
SFLAGS+= -I./libopencm3/include -L./libopencm3/lib
LFLAGS+=-Wl,--start-group -lc -lgcc -lnosys -Wl,--end-group
LFLAGS+= template_stm32.c -T ld.stm32.basic

M0_FLAGS= $(SFLAGS) -mcpu=cortex-m0 -mthumb -msoft-float
M0P_FLAGS= $(SFLAGS) -mcpu=cortex-m0plus -mthumb -msoft-float
M3_FLAGS= $(SFLAGS) -mcpu=cortex-m3 -mthumb -msoft-float
M4FH_FLAGS= $(SFLAGS) -mcpu=cortex-m4 -mthumb -mfloat-abi=hard -mfpu=fpv4-sp-d16

define RAWMakeBoard
	$(CC) -DRCC_LED1=$(1) -DPORT_LED1=$(2) -DPIN_LED1=$(3) $(4) -o $(OD)/$(5)
endef

define MakeBoard
BOARDS_ELF+=$(OD)/$(1).elf
BOARDS_BIN+=$(OD)/$(1).bin
BOARDS_HEX+=$(OD)/$(1).hex
$(OD)/$(1).elf: template_stm32.c libopencm3/lib/libopencm3_$(5).a
	@echo "  $(5) -> Creating $(OD)/$(1).elf"
	$(call RAWMakeBoard,RCC_$(2),$(2),$(3),$(4),$(1).elf)
endef

include boards.stm32f0.mk
include boards.stm32f1.mk
include boards.stm32f2.mk
include boards.stm32f3.mk
include boards.stm32f4.mk
include boards.stm32l0.mk
include boards.stm32l1.mk
include boards.stm32l4.mk

realall.really: outdir $(BOARDS_ELF) $(BOARDS_BIN) $(BOARDS_HEX)

libopencm3/Makefile:
	@echo "Initializing libopencm3 submodule"
	git submodule update --init

libopencm3/lib/libopencm3_%.a: libopencm3/Makefile
	$(MAKE) -C libopencm3

%.bin: %.elf
	@#printf "  OBJCOPY $(*).bin\n"
	$(OBJCOPY) -Obinary $(*).elf $(*).bin

%.hex: %.elf
	@#printf "  OBJCOPY $(*).hex\n"
	$(OBJCOPY) -Oihex $(*).elf $(*).hex

outdir:
	mkdir -p $(OD)

clean:
	$(RM) $(BOARDS_ELF) $(BOARDS_BIN) $(BOARDS_HEX)

.PHONY: realall.really outdir clean all
$(V).SILENT:
