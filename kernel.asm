[BITS 16]
[ORG 0x1000]

section .bss
input_buffer resb 32  ; Буфер для ввода

section .text
start:
    mov si, input_buffer
    call read_string     
    call return  
    call check_input  
    jmp $


read_string:
    mov di, input_buffer
.loop:
    mov ah, 0x00            
    int 0x16
    cmp al, 0x0D       
    je .done
    stosb             
    mov ah, 0x0E       
    int 0x10
    jmp .loop
.done:
    mov byte [di], 0      
    ret

check_input:
    mov si, input_buffer
    mov di, clearr
.loop:
    mov al, [si]
    cmp al, [di]
    jne wrong
    cmp al, 0           
    je clear
    inc si
    inc di
    jmp .loop
wrong:
    mov si, wrong_msg
    call puts
    call return
    jmp start
    ret
clear:
    ret


puts:
    mov ah, 0x0E
.loop:
    lodsb
    cmp al, 0
    je .done
    int 0x10
    jmp .loop
.done:
    ret


return:
    mov ah, 0x0E
    mov al, 0x0D
    int 0x10
    mov al, 0x0A
    int 0x10
    ret

section .data
clearr db "clear", 0
krnl_loaded db "Kernel loaded", 0
wrong_msg db "Unknown command", 0