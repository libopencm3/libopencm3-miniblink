#include <libopencm3/nrf/gpio.h>

int main(void) {
	gpio_mode_setup(PORT_LED1, GPIO_MODE_OUTPUT, GPIO_PUPD_NONE, PIN_LED1);
	gpio_set(PORT_LED1, PIN_LED1);
#if defined(PORT_LED2)
        gpio_mode_setup(PORT_LED2, GPIO_MODE_OUTPUT, GPIO_PUPD_NONE, PIN_LED2);
#endif
	while(1) {
		/* wait a little bit */
		for (int i = 0; i < LITTLE_BIT; i++) {
			__asm__("nop");
		}
		gpio_toggle(PORT_LED1, PIN_LED1);
#if defined(PORT_LED2)
		gpio_toggle(PORT_LED2, PIN_LED2);
#endif
	}
}
