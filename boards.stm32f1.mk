# Instructions: 
# 1) add a rule for your board, following the style in place.

# STM32F1 starts up with HSI at 8Mhz
STM32F1_CFLAGS=$(M3_FLAGS) -DSTM32F1 -DLITTLE_BIT=200000 $(LFLAGS) -lopencm3_stm32f1

$(eval $(call MakeBoard,stm32vldiscovery,GPIOC,GPIO8,$(STM32F1_CFLAGS)))
$(eval $(call MakeBoard,olimex-h103,GPIOC,GPIO12,$(STM32F1_CFLAGS)))
$(eval $(call MakeBoard,olimex-h107,GPIOC,GPIO6,$(STM32F1_CFLAGS)))
$(eval $(call MakeBoard,bluepill,GPIOC,GPIO13,$(STM32F1_CFLAGS)))
$(eval $(call MakeBoard,nucleo-f103rb,GPIOA,GPIO5,$(STM32F1_CFLAGS)))
