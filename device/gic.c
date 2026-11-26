// GICv3

#include <arm_acle.h>
#include "../print.h"

void gic_init() {
   uint64_t el = __arm_rsr64("CurrentEL") >> 2;
   print("CurrentEL: ");
   print_uint(el);
   uint64_t x = __arm_rsr64("icc_sre_el1");
   print("\nicc_sre_el1: ");
   print_uint(x);
   print("\n");
}
