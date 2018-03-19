#include <libopencm3/sam/memorymap.h>
#include <libopencm3/sam/d/port.h>

static void gpio_setup(void)
{
	PORT_DIR(PORT_LED1) = (1<<PIN_LED1);
	PORT_PINCFG(PORT_LED1, PIN_LED1) = 0;
#if defined PORT_LED2
	PORT_DIR(PORT_LED2) = (1<<PIN_LED2);
	PORT_PINCFG(PORT_LED2, PIN_LED2) = 0;
#endif
}

int main(void)
{
	gpio_setup();
	PORT_OUTTGL(PORT_LED1) = 1<<PIN_LED1;
	while (1) {
		PORT_OUTTGL(PORT_LED1) = 1<<PIN_LED1;
#if defined PORT_LED2
		PORT_OUTTGL(PORT_LED2) = 1<<PIN_LED2;
#endif
		/* wait a little bit */
		for (int i = 0; i < LITTLE_BIT; i++) {
			__asm__("nop");
		}
	}

	return 0;
}
