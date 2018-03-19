#if defined(LM3S)
#error "LM3S is very poorly supported file a ticket if you actually have this hw"
#include <libopencm3/lm3s/rcc.h>
#include <libopencm3/lm3s/gpio.h>
#elif defined(LM4F)
#include <libopencm3/lm4f/rcc.h>
#include <libopencm3/lm4f/gpio.h>
#else
#error "Unknown TI family!"
#endif

int main(void) {
        gpio_enable_ahb_aperture();

        periph_clock_enable(RCC_LED1);
	/* FIXME - may need to gpio_unlock_commit(port,pin)! */
        gpio_mode_setup(PORT_LED1, GPIO_MODE_OUTPUT, GPIO_PUPD_NONE, PIN_LED1);
        gpio_set_output_config(PORT_LED1, GPIO_OTYPE_PP, GPIO_DRIVE_2MA, PIN_LED1);
	gpio_set(PORT_LED1, PIN_LED1);

#if defined(RCC_LED2)
        periph_clock_enable(RCC_LED2);
        gpio_mode_setup(PORT_LED2, GPIO_MODE_OUTPUT, GPIO_PUPD_NONE, PIN_LED2);
        gpio_set_output_config(PORT_LED2, GPIO_OTYPE_PP, GPIO_DRIVE_2MA, PIN_LED2);
#endif
	while(1) {
		/* wait a little bit */
		for (int i = 0; i < LITTLE_BIT; i++) {
			__asm__("nop");
		}
		gpio_toggle(PORT_LED1, PIN_LED1);
#if defined(RCC_LED2)
		gpio_toggle(PORT_LED2, PIN_LED2);
#endif
	}
}
