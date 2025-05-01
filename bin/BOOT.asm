org 0x7C00
bits 16

%define ENDL 0x0D, 0x0A

_start:
jmp main

printchar:
mov ah, 0x0E
int 0x10

printstring:
push si
push ax
jmp .printchar_loop

.printchar_loop:
lodsb
or al, al
jz .printchar_loop_done
mov ah, 0x0E
mov bh, 0
jmp .printchar_loop

.printchar_loop_done:
pop ax
pop si
ret

main:
; setup data segments
mov ax, 0
mov ds, ax
mov es, ax
; setup stack
mov ss, ax
mov sp, 0x7C00

mov si, msg_hello
call printstring

msg_hello: dw "Hello World!", ENDL, 0

times 510-($-$$) db 0 ; Fill up Sector
dw 0xAA55