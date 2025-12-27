@echo off
set IMG=os.img

echo [1] Cleaning up...
del /Q *.bin *.img *.o *.tmp zeros.bin 2>nul

echo [2] Compiling...
nasm -f bin boot.asm -o boot.bin
nasm -f win32 kernel_entry.asm -o kernel_entry.o
gcc -m32 -ffreestanding -c kernel.c -o kernel.o

echo [3] Link (Merge)...
ld -m i386pe --image-base 0 -T linker.ld -o kernel.tmp kernel_entry.o kernel.o
objcopy -O binary kernel.tmp kernel.bin

echo [4] Disk Image (with Padding)...
fsutil file createnew zeros.bin 1474560
copy /b boot.bin+kernel.bin+zeros.bin %IMG% >nul

echo.
echo [OK] Running...
qemu-system-i386 -fda os.img
pause