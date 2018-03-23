Commander:
	mov si, COMMANDER
	call PrintToScreen

	mov di, COMMAND
	call ReadKey

	call CompareCommand


CompareCommand:
	mov si, COMMAND
	mov di, CMDHELP
	call StringCompare
	jc Help
	
	mov di, CMDCLEAR
	call StringCompare
	jc Clear

	mov di, CMDREBOOT
	call StringCompare
	jc Reboot

	call Error
	


StringCompare:
	mov bl, [si]
	mov al, [di]
	cmp al, bl
	jne _NotSame
	cmp al, 0
	je _Same
	inc si
	inc di
	jmp StringCompare

_NotSame:
	clc
	ret

_Same:
	stc
	ret


Help:
	mov si, HELP
	call PrintToScreen
	call Commander

Clear:
	call ClearScreen
	mov dh, 2
	mov dl, 0
	call MoveCursor
	call Commander

Reboot:
	int 0x19

Error:
	mov si, CMDERR
	call PrintToScreen
	call Commander
	