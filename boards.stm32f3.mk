# Instructions: 
# 1) add a rule for your board, following the style in place.

# STM32F3 starts up with HSI at 8MHz
STM32F3_CFLAGS=$(M4FH_FLAGS) -DSTM32F3 -DLITTLE_BIT=400000 $(LFLAGS) -lopencm3_stm32f3

define stm32f3board
	$(call MakeBoard,$(1),$(2),$(3),$(STM32F3_CFLAGS),stm32f3)
endef

$(eval $(call stm32f3board,stm32f3-discovery,GPIOE,GPIO8))

