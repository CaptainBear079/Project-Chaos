org 0x7C00
bits 16

%define ENDL 0x0D, 0x0A

; FAT 12 Headers
jmp short _start
nop

bdb_oem:                   db 'MSWIN4.1'
bdb_bytes_per_sector:      dw 512
bdb_sectors_per_cluster:   db 1
bdb_reserved_srctors:      dw 1
bdb_fat_count:             db 2
bdb_dir_entries_count:     dw 0xE0
bdb_total_sectors:         dw 2880
bdb_media_descriptor_type: db 0xF0
bdb_sectors_per_fat:       dw 9
bdb_sectors_per_track:     dw 18
bdb_heads:                 dw 2
bdb_hidden_sectors:        dd 0
bdb_large_sector_count:    dd 0

ebr_drive_number:          db 0
                           db 0
ebr_signature:

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