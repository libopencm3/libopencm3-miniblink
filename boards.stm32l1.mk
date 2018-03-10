# Instructions: 
# 1) Add one entry for your board, using the most formal name you can
#    to the xxxx_BOARDS= list
# 2) add a rule for your board, following the style in place.


STM32L1_BOARDS  = stm32l-discovery nucleo-l152re
STM32L1_BOARDS += nucleo-f103rb
BOARDS_STM32L1=$(STM32L1_BOARDS:=.all)

# STM32L1 starts up with MSI at 4MHz
STM32L1_CFLAGS=$(M3_FLAGS) -DSTM32L1 -DLITTLE_BIT=100000 $(LFLAGS) -lopencm3_stm32l1

# New product code for original l1 discovery
32l152cdiscovery.all: stm32l-discovery.all
stm32l-discovery.all:
	$(CC) -DRCC_LED1=RCC_GPIOB -DPORT_LED1=GPIOB -DPIN_LED1=GPIO6 $(STM32L1_CFLAGS) -o $(OD)/$@.elf
nucleo-l152re.all:
	$(CC) -DRCC_LED1=RCC_GPIOA -DPORT_LED1=GPIOA -DPIN_LED1=GPIO5 $(STM32L1_CFLAGS) -o $(OD)/$@.elf

