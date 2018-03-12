# Instructions: 
# 1) add a rule for your board, following the style in place.

# STM32F4 starts up with HSI at 16MHz
STM32F4_CFLAGS=$(M4FH_FLAGS) -DSTM32F4 -DLITTLE_BIT=800000 $(LFLAGS) -lopencm3_stm32f4

define STM32F4_Board
BOARDS_ALL+=$(1).all
BOARDS_CLEAN+=$(1).clean
$(1).all:
	$(call MakeBoard,RCC_$(2),$(2),$(3),$(STM32F4_CFLAGS),$(1).elf)
$(1).clean:
	$(call CleanBoard,$(1).elf)
endef

# New product code for original f4 discovery board.
$(eval $(call STM32F4_Board,stm32f407g-disc1,GPIOD,GPIO12))
$(eval $(call STM32F4_Board,stm32f4discover,GPIOD,GPIO12))
$(eval $(call STM32F4_Board,nucleo-f411re,GPIOA,GPIO5))

