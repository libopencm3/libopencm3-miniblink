CC=arm-none-eabi-gcc

STM32L1_BOARDS=stm32l-discovery nucleo-l152re
STM32F4_BOARDS=stm32f4discovery
BOARDS_L1=$(STM32L1_BOARDS:=.all)
BOARDS_F4=$(STM32F4_BOARDS:=.all)

SFLAGS= --static -nostartfiles -std=c11 -g3 -Os
SFLAGS+= -fno-common -ffunction-sections -fdata-sections
SFLAGS+= -I./libopencm3/include -L./libopencm3/lib
LFLAGS+=-Wl,--start-group -lc -lgcc -lnosys -Wl,--end-group
LFLAGS+= template_stm32.c -T ld.stm32.basic

M3_FLAGS= $(SFLAGS) -mcpu=cortex-m3 -mthumb -msoft-float
M4FH_FLAGS= $(SFLAGS) -mcpu=cortex-m4 -mthumb -mfloat-abi=hard -mfpu=fpv4-sp-d16

# STM32L1 starts up with MSI at 4MHz
STM32L1_CFLAGS=$(M3_FLAGS) -DSTM32L1 -DLITTLE_BIT=100000 $(LFLAGS) -lopencm3_stm32l1
# STM32F4 starts up with HSI at 16MHz
STM32F4_CFLAGS=$(M4FH_FLAGS) -DSTM32F4 -DLITTLE_BIT=800000 $(LFLAGS) -lopencm3_stm32f4


all: $(BOARDS_L1) $(BOARDS_F4)

# New product code for original l1 discovery
32l152cdiscovery.all: stm32l-discovery.all
stm32l-discovery.all:
	$(CC) -DRCC_LED1=RCC_GPIOB -DPORT_LED1=GPIOB -DPIN_LED1=GPIO6 $(STM32L1_CFLAGS) -o $@.elf
nucleo-l152re.all:
	$(CC) -DRCC_LED1=RCC_GPIOA -DPORT_LED1=GPIOA -DPIN_LED1=GPIO5 $(STM32L1_CFLAGS) -o $@.elf

# New product code for original f4 discovery board.
stm32f407g-disc1.all: stm32f4discovery.all
stm32f4discovery.all:
	$(CC) -DRCC_LED1=RCC_GPIOD -DPORT_LED1=GPIOD -DPIN_LED1=GPIO12 $(STM32F4_CFLAGS) -o $@.elf

clean:
	# eh, I'm sure we can do this better, but this is ok for now.
	$(RM) *.elf

