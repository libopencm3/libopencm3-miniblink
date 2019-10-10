# Instructions: 
# 1) add a rule for your board, following the style in place.
# This file should cover all the TI boards, lm3s, lm4f, tiva, msp432

LFLAGS_TI=$(LFLAGS) template_ti.c -T ld.ti.basic

# FIXME what are default clock speeds?
LM3S_CFLAGS=$(M3_FLAGS) -DLM3S -DLITTLE_BIT=800000 $(LFLAGS_TI) -lopencm3_lm3s
LM4F_CFLAGS=$(M4FH_FLAGS) -DLM4F -DLITTLE_BIT=800000 $(LFLAGS_TI) -lopencm3_lm4f

define RAWMakeBoard
	$(CC) -DRCC_LED1=RCC_$(1) -DPORT_LED1=$(1) -DPIN_LED1=$(2) \
		$(if $(5),-DRCC_LED2=RCC_$(5) -DPORT_LED2=$(5) -DPIN_LED2=$(6),) \
		$(3) -o $(OD)/ti/$(4)
endef

define MakeBoard
BOARDS_ELF+=$(OD)/ti/$(1).elf
BOARDS_BIN+=$(OD)/ti/$(1).bin
BOARDS_HEX+=$(OD)/ti/$(1).hex
$(OD)/ti/$(1).elf: template_ti.c libopencm3/lib/libopencm3_$(5).a
	@echo "  $(5) -> Creating $(OD)/ti/$(1).elf"
	$(call RAWMakeBoard,$(2),$(3),$(4),$(1).elf,$(6),$(7))
endef

define lm3sboard
	$(call MakeBoard,$(1),$(2),$(3),$(LM3S_CFLAGS),lm3s)
endef
define lm4fboard
	$(call MakeBoard,$(1),$(2),$(3),$(LM4F_CFLAGS),lm4f)
endef

# If anyone actually has real lm3s hardware, they can file a bug.
#$(eval $(call lm3sboard,lm3s811-evb,GPIOC,GPIO5))
$(eval $(call lm4fboard,ek-lm4f120xl,GPIOF,GPIO1,GPIOF,GPIO2))
# PN1, PN0, PF4, PF0
$(eval $(call lm4fboard,ek-tm4c1294xl,GPION,GPIO0,GPIOF,GPIO4))
