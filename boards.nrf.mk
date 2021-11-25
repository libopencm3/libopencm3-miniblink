# Instructions: 
# 1) add a rule for your board to the bottom of this file
# 2) profit!

LFLAGS_NRF52=$(LFLAGS) template_nrf52.c -T ld.nrf52.basic

# NRF52 starts up with HFINT at 64Mhz
NRF52_CFLAGS=$(M4FH_FLAGS) -DNRF52 -DLITTLE_BIT=3200000 $(LFLAGS_NRF52) -lopencm3_nrf52

define RAWMakeBoard
	$(CC) -DPORT_LED1=GPIO -DPIN_LED1=$(1) \
		$(if $(3),-DPORT_LED2=GPIO -DPIN_LED2=$(3),) \
		$(4) -o $(OD)/nrf52/$(2)
endef


define MakeBoard
	# 1 = board, 2 = pin, 3 = pin, 4 = cflags, 5 = lib
BOARDS_ELF+=$(OD)/nrf52/$(1).elf
BOARDS_BIN+=$(OD)/nrf52/$(1).bin
BOARDS_HEX+=$(OD)/nrf52/$(1).hex
$(OD)/nrf52/$(1).elf: template_nrf52.c libopencm3/lib/libopencm3_$(5).a
	@echo "  $(5) -> Creating $(OD)/nrf52/$(1).elf"
	$(call RAWMakeBoard,$(2),$(1).elf,$(3),$(4))
endef

define nrf52board
	# 1 = board, 2 = pin, 3=pin
	$(call MakeBoard,$(1),$(2),$(3),$(NRF52_CFLAGS),nrf52)
endef

# NRF52 boards
$(eval $(call nrf52board,nrf52833-dk,GPIO13,GPIO14))
$(eval $(call nrf52board,pinetime,GPIO13,GPIO14))
