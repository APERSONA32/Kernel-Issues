TSKMain:
	
	mov al, 1
	call SetDisplay

	pusha
	call ClearScreen
	popa

	pusha 
	mov dl, 0
	mov dh, 2
	call MoveCursor
	popa
	
	mov si, PROMPT
	call PrintToScreen

	mov di, USERNAME
	call ReadKey

	pusha
	call ClearScreen
	popa

	mov dh, 2
	mov dl, 0
	call MoveCursor
	call Commander



	OSNAME db 'TESTING}-{', 0
	KERVER db 'A 0.0.2}-{', 0
	PROMPT db 'Please enter your name > ', 0
	USERNAME times 21 db 0
	COMMANDER db 'Commander > ', 0
	COMMAND times 21 db 0
	CMDERR db '!!ATTENTION!! - Unknown Command or File', 0x0A, 0x0D, 0
	CMDHELP db 'help', 0
	CMDCLEAR db 'clear', 0
	CMDREBOOT db 'reboot', 0
	HELP db 'help, clear, reboot', 0x0A, 0x0D, 0

	%include "Kernel/Drivers/Dvr_Screen.asm"
	%include "Kernel/Drivers/Dvr_Keyboard.asm"
	%include "Kernel/CoreApps/Commander.asm"