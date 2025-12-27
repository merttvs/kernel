ENTRY(_start)

SECTIONS
{
    . = 0x1000;

    .text : ALIGN(4)
    {
        kernel_entry.o(.text)
        *(.text*)
        *(.rdata*)
        *(.rodata*)
    }

    .data : ALIGN(4)
    {
        *(.data*)
    }

    .bss : ALIGN(4)
    {
        *(.bss*)
        *(COMMON)
    }
}