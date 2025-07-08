[BITS 16]   ; 16-bit mode
[ORG 0x000] ; Set origin to 0x000

%define ENDL 0x0D, 0x0A

_start:
jmp short main
nop

; FAT 32 Headers

OEMLabel          db 'CHAOS.SE'      ; OEM Name (8 bytes)

BytesPerSector    dw 0x0200          ; Bytes per sector
SectorsPerCluster db 0x0008          ; Sectors per cluster
ReservedSectors   dw 0x0020          ; Reserved sectors
TotalFATs         db 2               ; Number of FATs
RootEntries       dw 0               ; Root entries (0 for FAT32)
TotalSectors16    dw 0               ; Total sectors (if < 65536, else 0)
MediaDescriptor   db 0xF8            ; Media descriptor
SectorsPerFAT16   dw 0               ; Sectors per FAT (FAT12/16, 0 for FAT32)
SectorsPerTrack   dw 63              ; Sectors per track
NumHeads          dw 255             ; Number of heads
HiddenSectors     dd 0               ; Hidden sectors
TotalSectors32    dd 0               ; Total sectors (FAT32, 0 for FAT12/16)

; FAT32 Extended BIOS Parameter Block
SectorsPerFAT32 dd 123             ; Sectors per FAT (FAT32)
ExtFlags        dw 0               ; Flags
FSVersion       dw 0               ; Version
RootCluster     dd 2               ; Root directory cluster
FSInfoSector    dw 1               ; FSInfo sector
BackupBootSector dw 6              ; Backup boot sector
Reserved        db 12 dup(0)       ; Reserved

DriveNumber     db 0x80            ; Drive number
Reserved1       db 0               ; Reserved
BootSignature   db 0x29            ; Boot signature
VolumeID        dd 12345678h       ; Volume ID
VolumeLabel     db 'MAIN DISK  '   ; Volume label (11 bytes)
FileSystemType  db 'FAT32   '      ; File system type (8 bytes)

; Boot code starts here
main:
; setup data segments
mov ax, 0
mov ds, ax
mov es, ax
; setup stack
mov ss, ax
mov sp, 0x7C00

call print_hello ; Call the print_hello function
jmp void

print_hello:
mov si, hello_message ; Load the address of the message


void:
nop
jmp void ; Infinite loop to prevent falling through

hello_message: dw 'Hello, World!', ENDL, 0

times 510-($-$$) db 0 ; Fill boot sector
dw 0xAA55 ; Boot signature