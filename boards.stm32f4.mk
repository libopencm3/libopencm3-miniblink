# Instructions: 
# 1) Add one entry for your board, using the most formal name you can
#    to the xxxx_BOARDS= list
# 2) add a rule for your board, following the style in place.


STM32F4_BOARDS  = stm32f4discovery nucleo-f411re
BOARDS_STM32F4=$(STM32F4_BOARDS:=.all)

# STM32F4 starts up with HSI at 16MHz
STM32F4_CFLAGS=$(M4FH_FLAGS) -DSTM32F4 -DLITTLE_BIT=800000 $(LFLAGS) -lopencm3_stm32f4

# New product code for original f4 discovery board.
stm32f407g-disc1.all: stm32f4discovery.all
stm32f4discovery.all:
	$(CC) -DRCC_LED1=RCC_GPIOD -DPORT_LED1=GPIOD -DPIN_LED1=GPIO12 $(STM32F4_CFLAGS) -o $(OD)/$@.elf

nucleo-f411re.all:
	$(CC) -DRCC_LED1=RCC_GPIOA -DPORT_LED1=GPIOA -DPIN_LED1=GPIO5 $(STM32F4_CFLAGS) -o $(OD)/$@.elf

