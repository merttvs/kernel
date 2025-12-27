void port_byte_out(unsigned short port, unsigned char data) {
    __asm__ __volatile__("outb %0, %1" : : "a"(data), "Nd"(port));
}

void update_cursor(int x, int y) {
    unsigned short pos = (y * 80) + x;

    port_byte_out(0x3D4, 0x0E);
    port_byte_out(0x3D5, (unsigned char)(pos >> 8));

    port_byte_out(0x3D4, 0x0F);
    port_byte_out(0x3D5, (unsigned char)(pos & 0xFF));
}

void kmain(void)
{
    volatile char* video_memory = (volatile char*)0xB8000;

    for(int i = 0; i < 80 * 25; i++) {
        video_memory[i * 2] = ' ';
        video_memory[i * 2 + 1] = 0x1F;
    }

    const char* message = "MERTTVS'S OS, WELCOME!";
    int j = 0;

    while(message[j] != 0) {
        video_memory[j * 2] = message[j];
        video_memory[j * 2 + 1] = 0x1E;
        j++;
    }

    update_cursor(j, 0);
}
