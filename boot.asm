[BITS 16]
[ORG 0x7C00]

start:
    mov si, msg
    call puts
    call return
    cli                
    xor ax, ax
    mov ds, ax
    mov es, ax
    mov ss, ax
    mov sp, 0x7C00 
         
    call load_kernel    
    jmp 0x1000         

load_kernel:
    mov ah, 0x02       
    mov al, 1         
    mov ch, 0           
    mov cl, 2            
    mov dh, 0          
    mov dl, 0x80         
    mov bx, 0x1000      
    int 0x13            
    ret
return:
    mov ah, 0x0E
    mov al, 0x0D
    int 0x10
    mov al, 0x0A
    int 0x10
    ret
puts:
    lodsb
    test al, al
    jz .done
    mov ah, 0x0E
    int 0x10
    jmp puts

.done:
    ret


msg db "Bootloader started"
times 510-($-$$) db 0   
dw 0xAA55             