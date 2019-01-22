# Instructions: 
# 1) add a rule for your board to the bottom of this file
# 2) profit!

LFLAGS_STM32=$(LFLAGS) template_stm32.c -T ld.stm32.basic

# STM32F0 starts up with HSI at 8Mhz
STM32F0_CFLAGS=$(M0_FLAGS) -DSTM32F0 -DLITTLE_BIT=100000 $(LFLAGS_STM32) -lopencm3_stm32f0
# STM32F1 starts up with HSI at 8Mhz
STM32F1_CFLAGS=$(M3_FLAGS) -DSTM32F1 -DLITTLE_BIT=200000 $(LFLAGS_STM32) -lopencm3_stm32f1
# STM32F2 starts up with HSI at 16MHz
STM32F2_CFLAGS=$(M3_FLAGS) -DSTM32F2 -DLITTLE_BIT=400000 $(LFLAGS_STM32) -lopencm3_stm32f2
# STM32F3 starts up with HSI at 8MHz
STM32F3_CFLAGS=$(M4FH_FLAGS) -DSTM32F3 -DLITTLE_BIT=400000 $(LFLAGS_STM32) -lopencm3_stm32f3
# STM32F4 starts up with HSI at 16MHz
STM32F4_CFLAGS=$(M4FH_FLAGS) -DSTM32F4 -DLITTLE_BIT=800000 $(LFLAGS_STM32) -lopencm3_stm32f4
# STM32F7 starts up with HSI at 16MHz
STM32F7_CFLAGS=$(M7SP_FLAGS) -DSTM32F7 -DLITTLE_BIT=800000 $(LFLAGS_STM32) -lopencm3_stm32f7
# STM32L0 starts up with MSI at 2.1Mhz
STM32L0_CFLAGS=$(M0P_FLAGS) -DSTM32L0 -DLITTLE_BIT=50000 $(LFLAGS_STM32) -lopencm3_stm32l0
# STM32L1 starts up with MSI at 4MHz
STM32L1_CFLAGS=$(M3_FLAGS) -DSTM32L1 -DLITTLE_BIT=100000 $(LFLAGS_STM32) -lopencm3_stm32l1
# STM32L4 starts up with MSI at 4MHz
STM32L4_CFLAGS=$(M4FH_FLAGS) -DSTM32L4 -DLITTLE_BIT=100000 $(LFLAGS_STM32) -lopencm3_stm32l4
# STM32G0 starts up with HSI at 16MHz
STM32G0_CFLAGS=$(M0P_FLAGS) -DSTM32G0 -DLITTLE_BIT=400000 $(LFLAGS_STM32) -lopencm3_stm32g0

define RAWMakeBoard
	$(CC) -DRCC_LED1=$(1) -DPORT_LED1=$(2) -DPIN_LED1=$(3) $(4) -o $(OD)/stm32/$(5)
endef

define MakeBoard
BOARDS_ELF+=$(OD)/stm32/$(1).elf
BOARDS_BIN+=$(OD)/stm32/$(1).bin
BOARDS_HEX+=$(OD)/stm32/$(1).hex
$(OD)/stm32/$(1).elf: template_stm32.c libopencm3/lib/libopencm3_$(5).a
	@echo "  $(5) -> Creating $(OD)/stm32/$(1).elf"
	$(call RAWMakeBoard,RCC_$(2),$(2),$(3),$(4),$(1).elf)
endef

define stm32f0board
	$(call MakeBoard,$(1),$(2),$(3),$(STM32F0_CFLAGS),stm32f0)
endef
define stm32f1board
	$(call MakeBoard,$(1),$(2),$(3),$(STM32F1_CFLAGS),stm32f1)
endef
define stm32f2board
	$(call MakeBoard,$(1),$(2),$(3),$(STM32F2_CFLAGS),stm32f2)
endef
define stm32f3board
	$(call MakeBoard,$(1),$(2),$(3),$(STM32F3_CFLAGS),stm32f3)
endef
define stm32f4board
	$(call MakeBoard,$(1),$(2),$(3),$(STM32F4_CFLAGS),stm32f4)
endef
define stm32f7board
	$(call MakeBoard,$(1),$(2),$(3),$(STM32F7_CFLAGS),stm32f7)
endef
define stm32l0board
	$(call MakeBoard,$(1),$(2),$(3),$(STM32L0_CFLAGS),stm32l0)
endef
define stm32l1board
	$(call MakeBoard,$(1),$(2),$(3),$(STM32L1_CFLAGS),stm32l1)
endef
define stm32l4board
	$(call MakeBoard,$(1),$(2),$(3),$(STM32L4_CFLAGS),stm32l4)
endef
define stm32g0board
	$(call MakeBoard,$(1),$(2),$(3),$(STM32G0_CFLAGS),stm32g0)
endef

# STM32F0 boards
$(eval $(call stm32f0board,stm32f0-discovery,GPIOC,GPIO8))
$(eval $(call stm32f0board,nucleo-f030r8,GPIOA,GPIO5))
$(eval $(call stm32f0board,nucleo-f031k6,GPIOB,GPIO3))
$(eval $(call stm32f0board,nucleo-f042k6,GPIOB,GPIO3))
$(eval $(call stm32f0board,nucleo-f070rb,GPIOA,GPIO5))
$(eval $(call stm32f0board,nucleo-f072rb,GPIOA,GPIO5))
$(eval $(call stm32f0board,nucleo-f091rc,GPIOA,GPIO5))

# STM32F1 boards
$(eval $(call stm32f1board,stm32vldiscovery,GPIOC,GPIO8))
$(eval $(call stm32f1board,olimex-h103,GPIOC,GPIO12))
$(eval $(call stm32f1board,olimex-h107,GPIOC,GPIO6))
$(eval $(call stm32f1board,blackpill,GPIOB,GPIO12))
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

# STM32F2 boards
$(eval $(call stm32f2board,jobygps,GPIOC,GPIO3))

# STM32F3 boards
$(eval $(call stm32f3board,stm32f3-discovery,GPIOE,GPIO8))
$(eval $(call stm32f3board,nucleo-f302r8,GPIOB,GPIO13))
$(eval $(call stm32f3board,nucleo-f303k8,GPIOB,GPIO3))
$(eval $(call stm32f3board,nucleo-f303re,GPIOA,GPIO5))
$(eval $(call stm32f3board,nucleo-f334r8,GPIOA,GPIO5))

# STM32F4 boards
# New product code for original f4 discovery board.
$(eval $(call stm32f4board,stm32f407g-disc1,GPIOD,GPIO12))
$(eval $(call stm32f4board,stm32f4discover,GPIOD,GPIO12))
$(eval $(call stm32f4board,nucleo-f411re,GPIOA,GPIO5))
$(eval $(call stm32f4board,nucleo-f401re,GPIOA,GPIO5))
$(eval $(call stm32f4board,stm32f429i-disc1,GPIOG,GPIO13))
$(eval $(call stm32f4board,nucleo-f410rb,GPIOA,GPIO5))
$(eval $(call stm32f4board,nucleo-f446re,GPIOA,GPIO5))
$(eval $(call stm32f4board,olimex-p405,GPIOC,GPIO12))
$(eval $(call stm32f4board,olimex-e407,GPIOC,GPIO13))

# STM32F7 boards
$(eval $(call stm32f7board,stm32f746g-disco,GPIOI,GPIO1))
$(eval $(call stm32f7board,nucleo-f767zi,GPIOB,GPIO0))

# STM32L0 boards
$(eval $(call stm32l0board,stm32l0538-disco,GPIOB,GPIO4))
$(eval $(call stm32l0board,nucleo-l053r8,GPIOA,GPIO5))
$(eval $(call stm32l0board,nucleo-l073rz,GPIOA,GPIO5))
$(eval $(call stm32l0board,nucleo-l011k4,GPIOB,GPIO3))
$(eval $(call stm32l0board,nucleo-l031k6,GPIOB,GPIO3))

# STM32L1 boards
# New product code for original l1 discovery
$(eval $(call stm32l1board,32l152cdiscovery,GPIOB,GPIO6))
$(eval $(call stm32l1board,stm32l-discovery,GPIOB,GPIO6))
$(eval $(call stm32l1board,nucleo-l152re,GPIOA,GPIO5))
$(eval $(call stm32l1board,32l100cdiscovery,GPIOB,GPIO6))

# STM32L4 boards
$(eval $(call stm32l4board,stm32l476g-disco,GPIOE,GPIO8))
$(eval $(call stm32l4board,nucleo-stm32l432kc,GPIOB,GPIO3))
$(eval $(call stm32l4board,nucleo-stm32l476rg,GPIOA,GPIO5))
$(eval $(call stm32l4board,nucleo-l4r5zi,GPIOC,GPIO7,GPIOB,GPIO7))

# STM32G0 boards
$(eval $(call stm32g0board,nucleo-g071rb,GPIOA,GPIO5))
