org 0x7C00

jmp near Boot
nop

iOEM          db "TESTING "	;What Operating system formatted this drive
iSectSize     dw 0x0200         ;0x0200 = 512 bytes per sector count. Yhis means that each sector on the disk contains 512 bytes
iClustSize    db 0x01           ;One sector per cluster  
iResCnt       dw 0x0001         ;Reserved sectors. One- the boot sector
iFatCnt       db 0x02           ;Two compies of the same table
iRootSize     dw 0x00F4     	;size of root dir - 224 entries to the root directory
iTotalSect    dw 0x0B40    	;total sectors on the disk
iMedia        db 0xF0          	;media descriptor (FLOPPY DRIVE = 0xF0 || HDD = 0xF9)
iFatSize      dw 0x0009         ;size of each FAT
iTrackSect    dw 0x0009         ;sectors per track
iHeadCnt      dw 0x0002         ;number of r/w heads
iHiddentSect  dd 0x00000000     ;number of hidden sectors
iSect32       dd 0x00000000  	;number of > 32MB sectors
iBootDrive    db 0x80         	;holds drive of bootsector
iReserved     db 0x00          	;empty reserved attribute
iBootSign     db 0x29          	;extended bootsig
iVolID        db "TSOA"        	;disk serial
acVolumeLabel db "TERSYSONE  " 	;volume label
acFSType      db "FAT16   "    	;fs type



Boot:
	mov ax, 0x0000
	mov es, ax
	mov dx, ax
	mov ss, ax
	mov sp, 0x7C00
	mov bp, 0x0500

ReadDisk:
	mov ah, 0x02
	mov al, 1
	mov cl, 2
	mov ch, 0
	mov dh, 0
	mov dl, 0x80
	mov bx, 0x7E00
	int 0x13
	jc _ReadError
	jmp 0x0000:0x7E00

_ReadError:
	mov ah, 0x0E
	mov si, READERR
	_Loop:
	lodsb
	cmp al, 0
	je _Done
	int 0x10
	jmp _Loop
	_Done:
	cli
	hlt




READERR db '!!ATTENTION!! - Disk Read Error. The system has been halted to prevent damage.', 0x0A, 0x0D, 0

times 510 - ($-$$) db 0
dw 0xAA55

Start:

	call TSKMain


	%include "Kernel/TSK.asm"