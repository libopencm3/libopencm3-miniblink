# Instructions: 
# 1) add a rule for your board, following the style in place.

# STM32F1 starts up with HSI at 8Mhz
STM32F1_CFLAGS=$(M3_FLAGS) -DSTM32F1 -DLITTLE_BIT=200000 $(LFLAGS) -lopencm3_stm32f1

define STM32F1_Board
BOARDS_ALL+=$(1).all
BOARDS_CLEAN+=$(1).clean
$(1).all:
	$(call MakeBoard,RCC_$(2),$(2),$(3),$(STM32F1_CFLAGS),$(1).elf)
$(1).clean:
	$(call CleanBoard,$(1).elf)
endef

$(eval $(call STM32F1_Board,stm32vldiscovery,GPIOC,GPIO8))
$(eval $(call STM32F1_Board,olimex-h103,GPIOC,GPIO12))
$(eval $(call STM32F1_Board,olimex-h107,GPIOC,GPIO6))
$(eval $(call STM32F1_Board,bluepill,GPIOC,GPIO13))
$(eval $(call STM32F1_Board,nucleo-f103rb,GPIOA,GPIO5))
