#include "print.h"
#include "device/uart.h"

void print(const char *s) {
   while(*s != '\0') {
      putchar(*s);
      s++;
   }
}

void uinttohexstr(uint64_t num, char *out) {
   if(num == 0) {
      out[0] = '0';
      out[1] = '\0';
      return;
   }

   // get number length in digits
   uint64_t tmp = num;
   int length = 0;
   while(tmp > 0) {
      length++;
      tmp/=16;
   }
   
   out[length] = '\0';

   for(int i = 0; i < length; i++) {
      if(num%16 == 10) out[length-i-1] = 'A';
      else if(num%16 == 11) out[length-i-1] = 'B';
      else if(num%16 == 12) out[length-i-1] = 'C';
      else if(num%16 == 13) out[length-i-1] = 'D';
      else if(num%16 == 14) out[length-i-1] = 'E';
      else if(num%16 == 15) out[length-i-1] = 'F';
      else out[length-i-1] = '0' + num%16;
      num/=16;
   }
}

void print_uint(uint64_t num) {
   char buf[32];
   buf[0] = '0';
   buf[1] = 'x';
   uinttohexstr(num, buf+2);
   print(buf);
}
