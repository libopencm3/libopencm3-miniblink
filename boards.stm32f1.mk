# Instructions: 
# 1) Add one entry for your board, using the most formal name you can
#    to the xxxx_BOARDS= list
# 2) add a rule for your board, following the style in place.


STM32F1_BOARDS  = stm32vldiscovery olimex-h103 olimex-h107 bluepill
STM32F1_BOARDS += nucleo-f103rb
BOARDS_STM32F1=$(STM32F1_BOARDS:=.all)

# STM32F1 starts up with HSI at 8Mhz
STM32F1_CFLAGS=$(M3_FLAGS) -DSTM32F1 -DLITTLE_BIT=200000 $(LFLAGS) -lopencm3_stm32f1

define STM32F1_MakeBoard
        $(call MakeBoard,RCC_$(1),$(1),$(2),$(STM32F1_CFLAGS),$(3).elf)
endef

stm32vldiscovery.all:
	$(call STM32F1_MakeBoard,GPIOC,GPIO8,$@)

olimex-h103.all:
	$(call STM32F1_MakeBoard,GPIOC,GPIO12,$@)

olimex-h107.all:
	$(call STM32F1_MakeBoard,GPIOC,GPIO6,$@)

bluepill.all:
	$(call STM32F1_MakeBoard,GPIOC,GPIO13,$@)

nucleo-f103rb.all:
	$(call STM32F1_MakeBoard,GPIOA,GPIO5,$@)
