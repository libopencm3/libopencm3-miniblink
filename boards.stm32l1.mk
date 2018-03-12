# Instructions: 
# 1) add a rule for your board, following the style in place.

# STM32L1 starts up with MSI at 4MHz
STM32L1_CFLAGS=$(M3_FLAGS) -DSTM32L1 -DLITTLE_BIT=100000 $(LFLAGS) -lopencm3_stm32l1

define STM32L1_Board
BOARDS_ALL+=$(1).all
BOARDS_CLEAN+=$(1).clean
$(1).all:
	$(call MakeBoard,RCC_$(2),$(2),$(3),$(STM32L1_CFLAGS),$(1).elf)
$(1).clean:
	$(call CleanBoard,$(1).elf)
endef

# New product code for original l1 discovery
$(eval $(call STM32L1_Board,32l152cdiscovery,GPIOB,GPIO6))
$(eval $(call STM32L1_Board,stm32l-discovery,GPIOB,GPIO6))
$(eval $(call STM32L1_Board,nucleo-l152re,GPIOA,GPIO5))

