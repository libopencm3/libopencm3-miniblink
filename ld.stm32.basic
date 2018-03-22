/*
 * Generic linker script that works for ~all STM32 devices
 * ~all STM32 devices have flash at 0x08000000 and at least 8K
 * ~all STM32 devices have ram at 0x200000000 and at least 2K
 *
 * This is enough for miniblink, but if you try and copy this to your own
 * projects, "You're gonna have a bad day"
 */

MEMORY
{
	rom (rx) : ORIGIN = 0x08000000, LENGTH = 8K
	ram (rwx) : ORIGIN = 0x20000000, LENGTH = 2K
}

INCLUDE ./cortex-m-generic.ld
