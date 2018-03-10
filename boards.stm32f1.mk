# Instructions: 
# 1) Add one entry for your board, using the most formal name you can
#    to the xxxx_BOARDS= list
# 2) add a rule for your board, following the style in place.


STM32F1_BOARDS  = stm32vldiscovery olimex-h103 olimex-h107 bluepill
STM32F1_BOARDS += nucleo-f103rb
BOARDS_STM32F1=$(STM32F1_BOARDS:=.all)

# STM32F1 starts up with HSI at 8Mhz
STM32F1_CFLAGS=$(M3_FLAGS) -DSTM32F1 -DLITTLE_BIT=200000 $(LFLAGS) -lopencm3_stm32f1

stm32vldiscovery.all:
	$(CC) -DRCC_LED1=RCC_GPIOC -DPORT_LED1=GPIOC -DPIN_LED1=GPIO8 $(STM32F1_CFLAGS) -o $(OD)/$@.elf

olimex-h103.all:
	$(CC) -DRCC_LED1=RCC_GPIOC -DPORT_LED1=GPIOC -DPIN_LED1=GPIO12 $(STM32F1_CFLAGS) -o $(OD)/$@.elf

olimex-h107.all:
	$(CC) -DRCC_LED1=RCC_GPIOC -DPORT_LED1=GPIOC -DPIN_LED1=GPIO6 $(STM32F1_CFLAGS) -o $(OD)/$@.elf

bluepill.all:
	$(CC) -DRCC_LED1=RCC_GPIOC -DPORT_LED1=GPIOC -DPIN_LED1=GPIO13 $(STM32F1_CFLAGS) -o $(OD)/$@.elf

nucleo-f103rb.all:
	$(CC) -DRCC_LED1=RCC_GPIOA -DPORT_LED1=GPIOA -DPIN_LED1=GPIO5 $(STM32F1_CFLAGS) -o $(OD)/$@.elf
