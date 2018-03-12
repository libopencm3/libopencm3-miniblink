# Instructions: 
# 1) add a rule for your board, following the style in place.

# STM32L1 starts up with MSI at 4MHz
STM32L1_CFLAGS=$(M3_FLAGS) -DSTM32L1 -DLITTLE_BIT=100000 $(LFLAGS) -lopencm3_stm32l1

define stm32l1board
	$(call MakeBoard,$(1),$(2),$(3),$(STM32L1_CFLAGS),stm32l1)
endef

# New product code for original l1 discovery
$(eval $(call stm32l1board,32l152cdiscovery,GPIOB,GPIO6))
$(eval $(call stm32l1board,stm32l-discovery,GPIOB,GPIO6))
$(eval $(call stm32l1board,nucleo-l152re,GPIOA,GPIO5))

