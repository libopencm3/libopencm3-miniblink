# Instructions: 
# 1) add a rule for your board, following the style in place.
# This file should cover all the Atmel/Microchip Cortex-M parts

LFLAGS_SAM=$(LFLAGS) template_sam.c -T ld.sam.basic

# FIXME what are default clock speeds?
SAMD_CFLAGS=$(M0P_FLAGS) -DSAMD -DLITTLE_BIT=100000 $(LFLAGS_SAM) -lopencm3_samd

# FIXME - support led2
define RAWMakeBoard
        $(CC) -DPORT_LED1=$(1) -DPIN_LED1=$(2) $(3) -o $(OD)/sam/$(4)
endef

define MakeBoard
BOARDS_ELF+=$(OD)/sam/$(1).elf
BOARDS_BIN+=$(OD)/sam/$(1).bin
BOARDS_HEX+=$(OD)/sam/$(1).hex
$(OD)/sam/$(1).elf: template_sam.c libopencm3/lib/libopencm3_$(5).a
	@echo "  $(5) -> Creating $(OD)/sam/$(1).elf"
	$(call RAWMakeBoard,$(2),$(3),$(4),$(1).elf)
endef

define samdboard
	$(call MakeBoard,$(1),$(2),$(3),$(SAMD_CFLAGS),samd)
endef

$(eval $(call samdboard,samd10-xplained-mini,PORTA,9))
