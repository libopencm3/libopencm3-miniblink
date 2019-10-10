# Instructions: 
# 1) add a rule for your board to the bottom of this file
# 2) profit!

LFLAGS_EFM32=$(LFLAGS) template_efm32.c -T ld.efm32.basic

# EFM32HG starts up with HFRCO at 14Mhz
EFM32HG_CFLAGS=$(M0P_FLAGS) -DEFM32HG -DLITTLE_BIT=800000 $(LFLAGS_EFM32) -lopencm3_efm32hg

define RAWMakeBoard
	$(CC) -DPORT_LED1=$(1) -DPIN_LED1=$(2) \
		$(if $(5),-DPORT_LED2=$(5) -DPIN_LED2=$(6),) \
		$(3) -o $(OD)/efm32/$(4)
endef


define MakeBoard
BOARDS_ELF+=$(OD)/efm32/$(1).elf
BOARDS_BIN+=$(OD)/efm32/$(1).bin
BOARDS_HEX+=$(OD)/efm32/$(1).hex
$(OD)/efm32/$(1).elf: template_efm32.c libopencm3/lib/libopencm3_$(5).a
	@echo "  $(5) -> Creating $(OD)/efm32/$(1).elf"
	$(call RAWMakeBoard,$(2),$(3),$(4),$(1).elf,$(6),$(7))
endef

define efm32hgboard
	$(call MakeBoard,$(1),$(2),$(3),$(EFM32HG_CFLAGS),efm32hg,$(4),$(5))
endef

# EFM32HG boards
$(eval $(call efm32hgboard,efm32hg-slstk3400a,GPIOF,GPIO4,GPIOF,GPIO5))
