# Instructions: 
# 1) Add one entry for your board, using the most formal name you can
#    to the xxxx_BOARDS= list
# 2) add a rule for your board, following the style in place.


STM32L1_BOARDS  = stm32l-discovery nucleo-l152re
STM32L1_BOARDS += nucleo-f103rb
BOARDS_STM32L1=$(STM32L1_BOARDS:=.all)

# STM32L1 starts up with MSI at 4MHz
STM32L1_CFLAGS=$(M3_FLAGS) -DSTM32L1 -DLITTLE_BIT=100000 $(LFLAGS) -lopencm3_stm32l1

define STM32L1_MakeBoard
	$(call MakeBoard,RCC_$(1),$(1),$(2),$(STM32L1_CFLAGS),$(3).elf)
endef

# New product code for original l1 discovery
32l152cdiscovery.all: stm32l-discovery.all
stm32l-discovery.all:
	$(call STM32L1_MakeBoard,GPIOB,GPIO6,$@)
nucleo-l152re.all:
	$(call STM32L1_MakeBoard,GPIOA,GPIO5,$@)

