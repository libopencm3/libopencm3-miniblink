# Instructions: 
# 1) add a rule for your board, following the style in place.

# STM32F1 starts up with HSI at 8Mhz
STM32F1_CFLAGS=$(M3_FLAGS) -DSTM32F1 -DLITTLE_BIT=200000 $(LFLAGS) -lopencm3_stm32f1

define stm32f1board
	$(call MakeBoard,$(1),$(2),$(3),$(STM32F1_CFLAGS),stm32f1)
endef

$(eval $(call stm32f1board,stm32vldiscovery,GPIOC,GPIO8))
$(eval $(call stm32f1board,olimex-h103,GPIOC,GPIO12))
$(eval $(call stm32f1board,olimex-h107,GPIOC,GPIO6))
$(eval $(call stm32f1board,bluepill,GPIOC,GPIO13))
$(eval $(call stm32f1board,nucleo-f103rb,GPIOA,GPIO5))
$(eval $(call stm32f1board,lisa-m-1,GPIOC,GPIO13))
$(eval $(call stm32f1board,lisa-m-2,GPIOA,GPIO8))
$(eval $(call stm32f1board,st-mb525,GPIOC,GPIO6))
$(eval $(call stm32f1board,obldc,GPIOA,GPIO6))
$(eval $(call stm32f1board,obldc-strip,GPIOB,GPIO4))
$(eval $(call stm32f1board,leaflabs-maple,GPIOA,GPIO5))
$(eval $(call stm32f1board,waveshare-open103r,GPIOC,GPIO9))
$(eval $(call stm32f1board,olimex-p103,GPIOC,GPIO12))
