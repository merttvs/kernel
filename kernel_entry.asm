[bits 32]
[global _start]
[extern _kmain] 

_start:          
    call _kmain
    jmp $