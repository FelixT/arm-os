// PL011 UART driver

#include <stdint.h>

volatile uint8_t *uart = (uint8_t*)0x9000000; // addr for virt

void putchar(char c) {
   *uart = c; // write to data register
}
