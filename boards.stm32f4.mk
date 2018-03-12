# Instructions: 
# 1) add a rule for your board, following the style in place.

# STM32F4 starts up with HSI at 16MHz
STM32F4_CFLAGS=$(M4FH_FLAGS) -DSTM32F4 -DLITTLE_BIT=800000 $(LFLAGS) -lopencm3_stm32f4

# New product code for original f4 discovery board.
$(eval $(call MakeBoard,stm32f407g-disc1,GPIOD,GPIO12,$(STM32F4_CFLAGS)))
$(eval $(call MakeBoard,stm32f4discover,GPIOD,GPIO12,$(STM32F4_CFLAGS)))
$(eval $(call MakeBoard,nucleo-f411re,GPIOA,GPIO5,$(STM32F4_CFLAGS)))

