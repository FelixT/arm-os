#include <arm_acle.h>

#include "print.h"

typedef struct ctx_t {
   uint64_t x[31];
   uint64_t sp;
   uint64_t elr;
   uint64_t spsr;
} ctx_t;

void exc_handler(int exception, ctx_t *context) {
   print("Exception ");
   print_uint(exception);
   print("\n");
   uint64_t esr = __arm_rsr64("esr_el1");
   uint8_t ec = (esr >> 26) & 0x3F; // exception class
   if(ec != 0x15) {
      // not a syscall
      print("Unhandled ec ");
      print_uint(ec);
      while(1) {} // hang system
   }
}
