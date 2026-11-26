ENTRY(_start)

SECTIONS {
    . = 0x40100000; /* past dtb at 0x40000000 */
    .startup . : { o/boot.o(.text) }
    .text : { *(.text) }
    .rodata : { *(.rodata) }

    . = ALIGN(4096); /* page boundary between code and data */

    .data : { *(.data) }
    .bss : { *(.bss COMMON) }
    . = ALIGN(16); /* two times pointer size */
    . += 0x1000; /* 4kB of stack memory */
    stack_top = .;
}
