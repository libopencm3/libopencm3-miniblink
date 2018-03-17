# Instructions: 
# 1) add a rule for your board, following the style in place.

# STM32F0 starts up with HSI at 8Mhz
STM32F0_CFLAGS=$(M0_FLAGS) -DSTM32F0 -DLITTLE_BIT=100000 $(LFLAGS) -lopencm3_stm32f0

define stm32f0board
	$(call MakeBoard,$(1),$(2),$(3),$(STM32F0_CFLAGS),stm32f0)
endef

$(eval $(call stm32f0board,stm32f0-discovery,GPIOC,GPIO8))
