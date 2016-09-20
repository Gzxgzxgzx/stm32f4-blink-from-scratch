/**
 * @file - main.c
 * @author - Harlan James <root@aboyandhisgnu.org>
 * @description - Quick and dirt light blinkage from scratch for the
 * STM32F4(07VG) Discovery board.
 */

#include <stdint.h>

#define DELAY 0xEFFFF

/**
 * @Register Definitions - Register addresses
 */
#define RCC_AHB1ENR (*(volatile uint32_t *)0x40023830)
#define GPIOD_MODER (*(volatile uint32_t *)0x40020C00)
#define GPIOD_ODR   (*(volatile uint32_t *)0x40020C14)

/**
 * @Register Bits - The following values are used to configure the GPIO
 * registers.
 *
 * @see - http://www.hertaville.com/stm32f0-gpio-tutorial-part-1.html
 * @seealso - RM0090 (reference manual, contains register maps)
 */
#define GPIO_MODE_OUT (1 << 3)

#define PIN_12_OUTPUT (1 << 24)
#define PIN_13_OUTPUT (1 << 26)
#define PIN_14_OUTPUT (1 << 28)
#define PIN_15_OUTPUT (1 << 30)

#define LED_GREEN     (1 << 12)
#define LED_ORANGE    (1 << 13)
#define LED_RED       (1 << 14)
#define LED_BLUE      (1 << 15)

/**
 * @blink_light - Blinks the light for based on the DELAY
 *
 * @param led - the light to blink
 */
void blink_light(uint16_t led)
{
	uint32_t i;

	/* ON */
	GPIOD_ODR |= led;
	for (i = 0; i < DELAY; i++);

	/* OFF */
	GPIOD_ODR &= ~led;
	for (i = 0; i < DELAY; i++);
}

/**
 * @main - Main entry point for the program. Turns a light on and off!
 */
int main(void)
{
	RCC_AHB1ENR |= GPIO_MODE_OUT;
	GPIOD_MODER  = (PIN_12_OUTPUT) | (PIN_13_OUTPUT) | (PIN_14_OUTPUT) |
			(PIN_15_OUTPUT);

	for (;;)
	{
		blink_light(LED_GREEN);
		blink_light(LED_ORANGE);
		blink_light(LED_RED);
		blink_light(LED_BLUE);
	}
}
