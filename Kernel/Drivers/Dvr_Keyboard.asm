ReadKey:
	mov cl, 0
_RKLoop:
	mov ah, 0x00
	int 0x16
	cmp al, 0x08
	je _BackSpace
	cmp al, 0x0D
	je _ReturnKey
	cmp cl, 0x13
	je _RKLoop
	mov ah, 0x0E
	int 0x10
	stosb
	inc cl
	jmp _RKLoop

_ReturnKey:
	cmp cl, 0
	je _RKLoop
	mov ah, 0x0E
	int 0x10
	mov al, 0x0A
	int 0x10
	mov al, 0
	stosb
	ret

_BackSpace:
	cmp cl, 0
	je _RKLoop
	mov ah, 0x0E
	int 0x10
	mov al, 0x00
	int 0x10
	mov al, 0x08
	int 0x10
	dec cl
	dec di
	mov byte [di], 0
	jmp _RKLoop