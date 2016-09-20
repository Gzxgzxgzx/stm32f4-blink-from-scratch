/**
 * @file - stm32f407vg.ld
 * @author - Harlan James <root@aboyandhisgnu.org>
 * @description - Linker script for the project. This could be simplified down
 * to the MEMORY section and just the .text section so long as the vector table
 * goes first into memory.
 */
MEMORY
{
	ROM (rx)  : ORIGIN = 0x08000000, LENGTH = 1024K
	RAM (rwx) : ORIGIN = 0x20000000, LENGTH = 192K
}

_estack = 0x20020000;

SECTIONS
{
	.vector_table :
	{
		KEEP(*(.vector_table))
	} > ROM

	.text :
	{
		*(.text)
		*(.text.*)
	} > ROM

	.data :
	{
		*(.data)
		*(.data.*)
	} > ROM

	.bss :
	{
		*(.bss)
		*(.bss.*)
	} > ROM
}
