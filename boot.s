.global _start
_start:
   // setup stack pointer
   ldr x30, =stack_top
   mov sp, x30
   // setup exception vector table
   ldr x30, =vector_el1
   msr vbar_el1, x30
   isb // flush pipeline
   bl kmain
   b . // inf loop
