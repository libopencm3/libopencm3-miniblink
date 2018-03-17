# Instructions: 
# 1) add a rule for your board, following the style in place.

# STM32L0 starts up with MSI at 2.1Mhz
STM32L0_CFLAGS=$(M0P_FLAGS) -DSTM32L0 -DLITTLE_BIT=10000 $(LFLAGS) -lopencm3_stm32l0

define stm32l0board
	$(call MakeBoard,$(1),$(2),$(3),$(STM32L0_CFLAGS),stm32l0)
endef

$(eval $(call stm32l0board,stm32l0538-disco,GPIOB,GPIO4))
