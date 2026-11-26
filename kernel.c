#include "device/gic.h"
#include "print.h"

// booted into el1 (kernel) by qemu
void kmain(void) {
   print("Booted\n\n");
   gic_init();
   asm volatile("svc #0"); // supervisor call
   print("Returned\n");
   // hangs in boot.s
}
