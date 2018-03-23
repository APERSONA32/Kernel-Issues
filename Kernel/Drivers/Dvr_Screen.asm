PrintToScreen:
	mov ah, 0x0E

_PTSLoop:
	lodsb
	cmp al, 0
	je _PTSDone
	int 0x10
	jmp _PTSLoop

_PTSDone:
	ret

MoveCursor:
	mov ah, 0x02
	mov bh, 1
	int 0x10
	ret

SetDisplay:
	mov ah, 0x05
	int 0x10
	ret

ClearScreen:
	mov ah, 0x07
	mov al, 0
	mov ch, 0
	mov cl, 0
	mov dh, 100
	mov dl, 100
	mov bh, 0xF1
	int 0x10
	mov bh, 0x1F
	mov dh, 0
	mov dl, 100
	call ClearLine
	mov dh, 0
	mov dl, 0
	call MoveCursor

	mov si, OSNAME
	call PrintToScreen
	mov si, KERVER
	call PrintToScreen
	mov si, USERNAME
	call PrintToScreen
	ret
	
ClearLine:
	mov ah, 0x07
	mov al, 1
	int 0x10
	ret
	
GetCursorPosition:
	mov ah, 0x03
	int 0x10
