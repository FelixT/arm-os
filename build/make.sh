aarch64-elf-as ../boot.s -o o/boot.o
aarch64-elf-as ../exception.s -o o/exception.o

c_flags="-ffreestanding"
c_device_files="uart gic"
c_files="print exc_handler"
o_files="o/uart.o o/gic.o o/print.o o/boot.o o/exception.o o/exc_handler.o"

for file in $c_device_files; do
   aarch64-elf-gcc $c_flags -c ../device/$file.c -o o/$file.o
done
for file in $c_files; do
   aarch64-elf-gcc $c_flags -c ../$file.c -o o/$file.o
done

aarch64-elf-gcc $c_flags -c ../kernel.c -o o/kernel.o

aarch64-elf-ld -nostdlib -Tlinker.ld $o_files o/kernel.o -o o/kernel.elf

for arg in "$@"; do
  if [[ "$arg" == "-b" ]]; then
    exit 0
  fi
done

# `-kernel` flag boots straight in
qemu-system-aarch64 -machine virt,gic-version=3 -cpu cortex-a57 -kernel o/kernel.elf -nographic
