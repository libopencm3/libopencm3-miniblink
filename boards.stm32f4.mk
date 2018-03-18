# Instructions: 
# 1) add a rule for your board, following the style in place.

# STM32F4 starts up with HSI at 16MHz
STM32F4_CFLAGS=$(M4FH_FLAGS) -DSTM32F4 -DLITTLE_BIT=800000 $(LFLAGS) -lopencm3_stm32f4

define stm32f4board
	$(call MakeBoard,$(1),$(2),$(3),$(STM32F4_CFLAGS),stm32f4)
endef

# New product code for original f4 discovery board.
$(eval $(call stm32f4board,stm32f407g-disc1,GPIOD,GPIO12))
$(eval $(call stm32f4board,stm32f4discover,GPIOD,GPIO12))
$(eval $(call stm32f4board,nucleo-f411re,GPIOA,GPIO5))
$(eval $(call stm32f4board,nucleo-f401re,GPIOA,GPIO5))
$(eval $(call stm32f4board,stm32f429i-disc1,GPIOG,GPIO13))
$(eval $(call stm32f4board,nucleo-f410rb,GPIOA,GPIO5))
$(eval $(call stm32f4board,nucleo-f446re,GPIOA,GPIO5))
$(eval $(call stm32f4board,olimex-p405,GPIOC,GPIO12))
$(eval $(call stm32f4board,olimex-e407,GPIOC,GPIO13))
