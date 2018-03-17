# Instructions: 
# 1) add a rule for your board, following the style in place.

# STM32F2 starts up with HSI at 16MHz
STM32F2_CFLAGS=$(M3_FLAGS) -DSTM32F2 -DLITTLE_BIT=400000 $(LFLAGS) -lopencm3_stm32f2

define stm32f2board
	$(call MakeBoard,$(1),$(2),$(3),$(STM32F2_CFLAGS),stm32f2)
endef

$(eval $(call stm32f2board,jobygps,GPIOC,GPIO3))

