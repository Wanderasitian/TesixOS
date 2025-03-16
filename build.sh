nasm -f bin kernel.asm -o kernel.bin
nasm -f bin boot.asm -o boot.bin
cat boot.bin kernel.bin > os.img
qemu-system-x86_64 os.img
