# Instructions: 
# 1) add a rule for your board, following the style in place.

# STM32L1 starts up with MSI at 4MHz
STM32L1_CFLAGS=$(M3_FLAGS) -DSTM32L1 -DLITTLE_BIT=100000 $(LFLAGS) -lopencm3_stm32l1

# New product code for original l1 discovery
$(eval $(call MakeBoard,32l152cdiscovery,GPIOB,GPIO6,$(STM32L1_CFLAGS)))
$(eval $(call MakeBoard,stm32l-discovery,GPIOB,GPIO6,$(STM32L1_CFLAGS)))
$(eval $(call MakeBoard,nucleo-l152re,GPIOA,GPIO5,$(STM32L1_CFLAGS)))

