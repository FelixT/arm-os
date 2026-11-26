.macro vec idx
   .balign 0x80
   // save (full) context
   // x0-x30 + sp + elr + spsr
   sub sp, sp, #34*8
   stp x0, x1, [sp, #16*0]
   mov x0, #\idx
   b exc_common // saves remaining regs
.endm

exc_common:
   stp x2, x3, [sp, #16*1]
   stp x4, x5, [sp, #16*2]
   stp x6, x7, [sp, #16*3]
   stp x8, x9, [sp, #16*4]
   stp x10, x11, [sp, #16*5]
   stp x12, x13, [sp, #16*6]
   stp x14, x15, [sp, #16*7]
   stp x16, x17, [sp, #16*8]
   stp x18, x19, [sp, #16*9]
   stp x20, x21, [sp, #16*10]
   stp x22, x23, [sp, #16*11]
   stp x24, x25, [sp, #16*12]
   stp x26, x27, [sp, #16*13]
   stp x28, x29, [sp, #16*14]
   // sp + elr + spsr
   mrs x10, sp_el0
   mrs x11, elr_el1
   mrs x12, spsr_el1
   stp x30, x10, [sp, #16*15]
   stp x11, x12, [sp, #16*16]

   mov x1, sp // pass pointer to context on stack
   bl exc_handler

   // restore context
   ldp x30, x10, [sp, #16*15]
   ldp x11, x12, [sp, #16*16]
   msr sp_el0, x10
   msr elr_el1, x11
   msr spsr_el1, x12

   ldp x0, x1, [sp, #16*0]
   ldp x2, x3, [sp, #16*1]
   ldp x4, x5, [sp, #16*2]
   ldp x6, x7, [sp, #16*3]
   ldp x8, x9, [sp, #16*4]
   ldp x10, x11, [sp, #16*5]
   ldp x12, x13, [sp, #16*6]
   ldp x14, x15, [sp, #16*7]
   ldp x16, x17, [sp, #16*8]
   ldp x18, x19, [sp, #16*9]
   ldp x20, x21, [sp, #16*10]
   ldp x22, x23, [sp, #16*11]
   ldp x24, x25, [sp, #16*12]
   ldp x26, x27, [sp, #16*13]
   ldp x28, x29, [sp, #16*14]

   add sp, sp, #34*8
   eret

// exception vector table

.balign 0x800
.global vector_el1
vector_el1:
   // current el, using sp_el0
   vec 0 // sync
   vec 1 // irq
   vec 2 // fiq
   vec 3 // error
   // current el, using sp_elx
   vec 4 // sync
   vec 5 // irq
   vec 6 // fiq
   vec 7 // error
