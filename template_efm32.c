#include <libopencm3/efm32/cmu.h>
#include <libopencm3/efm32/gpio.h>

int main(void) {
	cmu_periph_clock_enable(CMU_GPIO);
	gpio_mode_setup(PORT_LED1, GPIO_MODE_PUSH_PULL, PIN_LED1);
	gpio_set(PORT_LED1, PIN_LED1);
#if defined(PORT_LED2)
        gpio_mode_setup(PORT_LED2, GPIO_MODE_PUSH_PULL, PIN_LED2);
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
