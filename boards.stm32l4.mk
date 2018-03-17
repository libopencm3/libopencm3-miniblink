# Instructions: 
# 1) add a rule for your board, following the style in place.

# STM32L4 starts up with MSI at 4MHz
STM32L4_CFLAGS=$(M4FH_FLAGS) -DSTM32L4 -DLITTLE_BIT=100000 $(LFLAGS) -lopencm3_stm32l4

define stm32l4board
	$(call MakeBoard,$(1),$(2),$(3),$(STM32L4_CFLAGS),stm32l4)
endef

$(eval $(call stm32l4board,stm32l476g-disco,GPIOE,GPIO8))

