
[org 0x0100]
	jmp Driver
oldisr: dd 0
oldtim:	dd 0
tickcount: dw 0
Fish_p: dw 0
right_boundary: dw 3840, 3680, 3520, 3360, 3200, 3040
left_boundary: dw 3680, 3520, 3360, 3200, 3040, 2880
green_pellet_timer: dw 0
random_g: 
	dw 3140,3500,3300,3200,3700,3400,3752,3254,3456,3364,3790,3568,3146,3138,3636,3220,3502,3134,3446,3474,3252,3800,3198,3622,3122,3666  
random_r: 
	dw 3660,3728,3632,3289,3720,3253,3574,3140,3234,3402,3226,3666,3118,3050,3520,3308,3210,3708,3410,3753,3154,3436,3360,3690,3577,3346  
red_pellet_timer: dw 0
adder_g: dw 0
adder_r: dw 0
score:  dw 0
flag_exit: dw 0
green_pos : dw 0
red_pos: dw 0
message: db 10,13,'Player1: $',0,0
welcome:  db 'Hello ', 0 
whale:  db '><(((^> Welcome to Whale.io <^)))><', 0 
msg:  db 'Press Enter to Continue and Esc to Exit !', 0 
guide: db 'Guide', 0
move: db 'Use W,A,S,D Keys to Move Fish ', 0
coin1: db 'Collect Green Coins to add score by 10 !', 0
coin2: db 'Collect Red Coins to boost your score by 50 !', 0
name: db 'Hey ! Enter Your Name : ', 0 
msg0: db 'Developed By: ', 0
msg1: db 'M.Abdullah Sarwar 21L-5475', 0
msg2: db 'M.Abdullah  21L-7543', 0
last: db 'Are you sure you Want to Exit ?', 0
last2: db 'Yes (y) / No (n) ', 0
buffer:		db 80
		db 0
		times 80 db 0
;------------------------------------------------
strlen: push bp
		mov bp,sp
		push es
		push cx
		push di
		les di, [bp+4] 			; point es:di to string
		mov cx, 0xffff 			; load maximum number in cx
		mov al, 0 			; load a zero in al
		repne scasb 			; find zero in the string
		mov ax, 0xffff			; load maximum number in ax
		sub ax, cx 			; find change in cx
		dec ax 				; exclude null from length
		pop di
		pop cx
		pop es
		pop bp
		ret 4 
;------------------------------------------------
clrscr_gray: push es
		push ax
		push cx
		push di
		mov ax, 0xb800
		mov es, ax 			; point es to video base
		xor di, di 			; point di to top left column
		mov ax, 0x77DB 			; space char in normal attribute
		mov cx, 2000 			; number of screen locations
		cld 				; auto increment mode
		rep stosw 			; clear the whole screen
		pop di 
		pop cx
		pop ax
		pop es
		ret 
;------------------------------------------------
clrscr_black: push es
		push ax
		push cx
		push di
		mov ax, 0xb800
		mov es, ax 			; point es to video base
		xor di, di 			; point di to top left column
		mov ax, 0x0720			; space char in normal attribute
		mov cx, 2000 			; number of screen locations
		cld 				; auto increment mode
		rep stosw 			; clear the whole screen
		pop di 
		pop cx
		pop ax
		pop es
		ret 
;------------------------------------------------
printstr:	
			push bp
			mov bp, sp
			push es
			push ax
			push cx
			push si
			push di
			push ds 		; push segment of string
			mov ax, [bp+4]
			push ax 		; push offset of string
			call strlen 		; calculate string length 
			cmp ax, 0 		; is the string empty
			jz exittt 		; no printing if string is empty
			mov cx, ax 		; save length in cx
			mov ax, 0xb800
			mov es, ax 		; point es to video base
			mov al, 80 		; load al with columns per row
			mul byte [bp+8] 	; multiply with y position
			add ax, [bp+10] 	; add x position
			shl ax, 1 		; turn into byte offset
			mov di,ax 		; point di to required location
			mov si, [bp+4] 		; point si to string
			mov ah, [bp+6] 		; load attribute in ah
			cld 			; auto increment mode
			nextchar: lodsb 	; load next char in al
			stosw 			; print char/attribute pair
			loop nextchar 		; repeat for the whole string
		exittt:

			pop di
			pop si
			pop cx
			pop ax
			pop es
			pop bp
			ret 8 
;------------------------------------------------
Welcome_Logo:
		
		pusha 

		mov ax, 0xb800
		mov es, ax
		mov ax, 0x0000
		mov di, 194
		mov word[es:di], ax
		add di, 160
		mov word[es:di], ax
		add di, 160
		mov word[es:di], ax
		add di, 160
		mov word[es:di], ax
		add di, 160
		mov word[es:di], ax
		add di, 2
		mov word[es:di], ax
		add di, 2
		mov word[es:di], ax
		add di, 2
		mov word[es:di], ax
		add di, 2
		mov word[es:di], ax
		sub di, 160
		mov word[es:di], ax
		sub di, 160
		mov word[es:di], ax
		add di, 322
		mov word[es:di], ax
		add di, 2
		mov word[es:di], ax
		add di, 2
		mov word[es:di], ax
		add di, 2
		mov word[es:di], ax
		sub di, 160
		mov word[es:di], ax
		sub di, 160
		mov word[es:di], ax
		sub di, 160
		mov word[es:di], ax
		sub di, 160
		mov word[es:di], ax

		add di, 4
		mov word[es:di], ax
		add di, 160
		mov word[es:di], ax
		add di, 160
		mov word[es:di], ax
		add di, 2
		mov word[es:di], ax
		add di, 2
		mov word[es:di], ax
		add di, 2
		mov word[es:di], ax
		add di, 2
		mov word[es:di], ax
		push di
		sub di, 8
		add di, 160
		mov word[es:di], ax
		add di, 160
		mov word[es:di], ax
		pop di
		add di, 2
		mov word[es:di], ax
		sub di, 160
		mov word[es:di], ax
		sub di, 160
		mov word[es:di], ax
		add di, 320
		add di, 160
		mov word[es:di], ax
		add di, 160
		mov word[es:di], ax
		add di, 4
		
		mov word[es:di], ax
		sub di, 160
		mov word[es:di], ax
		sub di, 160
		mov word[es:di], ax
		sub di, 160
		mov word[es:di], ax
		sub di, 160
		mov word[es:di], ax
		add di, 2
		mov word[es:di], ax
		add di, 2
		mov word[es:di], ax
		add di, 2
		mov word[es:di], ax
		add di, 2
		mov word[es:di], ax

		add di, 160	
		mov word[es:di], ax
		
		add di, 160	
		mov word[es:di], ax
		push di
		sub di, 2
		mov word[es:di], ax
		sub di, 2
		mov word[es:di], ax
		sub di, 2
		mov word[es:di], ax
		pop di
		add di, 160	
		mov word[es:di], ax

		add di, 160	
		mov word[es:di], ax
		
		add di, 4
		mov word[es:di], ax
		push di
		sub di, 160
		mov word[es:di], ax
		sub di, 160
		mov word[es:di], ax
		sub di, 160
		mov word[es:di], ax
		sub di, 160
		mov word[es:di], ax
		pop di
		add di, 2
		mov word[es:di], ax
		add di, 2
		mov word[es:di], ax
		add di, 2
		mov word[es:di], ax
		add di, 2
		mov word[es:di], ax
	
		add di, 4
		mov word[es:di], ax
		push di
		sub di, 160
		mov word[es:di], ax
		sub di, 160
		mov word[es:di], ax
		add di, 2
		mov word[es:di], ax
		add di, 2
		mov word[es:di], ax
		add di, 2
		mov word[es:di], ax
		sub di, 6
		sub di, 160
		mov word[es:di], ax
		sub di, 160
		mov word[es:di], ax
		add di, 2
		mov word[es:di], ax
		add di, 2
		mov word[es:di], ax
		add di, 2
		mov word[es:di], ax
		sub di, 6
		pop di
		add di, 2
		mov word[es:di], ax
		add di, 2
		mov word[es:di], ax
		add di, 2
		mov word[es:di], ax
		add di, 6
		mov word[es:di], ax
		add di, 6
		mov word[es:di], ax
		push di
		sub di, 160
		mov word[es:di], ax
		sub di, 160
		mov word[es:di], ax
		sub di, 320
		mov word[es:di], ax
		
		pop di
		add di, 4
		mov word[es:di], ax

		sub di, 160
		mov word[es:di], ax
		sub di, 160
		mov word[es:di], ax
		add di, 2
		mov word[es:di], ax
		add di, 2
		mov word[es:di], ax
		add di, 2
		mov word[es:di], ax
		add di, 160
		mov word[es:di], ax
		add di, 160
		mov word[es:di], ax
		sub di, 2
		mov word[es:di], ax
		sub di, 2
		mov word[es:di], ax
		sub di, 2
		mov word[es:di], ax
		
		
		
			
		popa 
		ret
;------------------------------------------------
Welcome_Screen:	
		

		pusha
		
		mov ax, 38
		push ax 	; push x position
		mov ax, 8
		push ax 	; push y position
		mov ax, 0x70   ; blue on white
		push ax 	; push attribute
		mov ax, buffer+2
		push ax 	; push offset of string
		call printstr   ; print the string
		

		mov ax, 32
		push ax 	; push x position
		mov ax, 8
		push ax 	; push y position
		mov ax, 0x70   ; blue on white
		push ax 	; push attribute
		mov ax, welcome
		push ax 	; push offset of string
		call printstr   ; print the string


		
		mov ax, 22
		push ax 	; push x position
		mov ax, 10
		push ax 	; push y position
		mov ax, 0x70   ; blue on white
		push ax 	; push attribute
		mov ax, whale
		push ax 	; push offset of string
		call printstr   ; print the string

		mov ax, 36
		push ax 	; push x position
		mov ax, 12
		push ax 	; push y position
		mov ax, 0x74    ; blue on white
		push ax 	; push attribute
		mov ax, guide
		push ax 	; push offset of string
		call printstr   ; print the string

		mov ax, 26
		push ax 	; push x position
		mov ax, 14
		push ax 	; push y position
		mov ax, 0x70    ; blue on white
		push ax 	; push attribute
		mov ax, move
		push ax 	; push offset of string
		call printstr   ; print the string


		mov ax, 22
		push ax 	; push x position
		mov ax, 16
		push ax 	; push y position
		mov ax, 0x70    ; blue on white
		push ax 	; push attribute
		mov ax, coin1
		push ax 	; push offset of string
		call printstr   ; print the string

		mov ax, 20
		push ax 	; push x position
		mov ax, 18
		push ax 	; push y position
		mov ax, 0x70    ; blue on white
		push ax 	; push attribute
		mov ax, coin2
		push ax 	; push offset of string
		call printstr   ; print the string


		
		mov ax,22
		push ax 	; push x position
		mov ax, 20
		push ax 	; push y position
		mov ax, 0xF4    ; blue on white
		push ax 	; push attribute
		mov ax, msg
		push ax 	; push offset of string
		call printstr   ; print the string

		mov ax, 40
		push ax 	; push x position
		mov ax, 22
		push ax 	; push y position
		mov ax, 0x70    ; blue on white
		push ax 	; push attribute
		mov ax, msg0
		push ax 	; push offset of string
		call printstr   ; print the string

		mov ax, 54
		push ax 	; push x position
		mov ax, 23
		push ax 	; push y position
		mov ax, 0x70   ; blue on white
		push ax 	; push attribute
		mov ax, msg1
		push ax 	; push offset of string
		call printstr   ; print the string
	


		mov ax,54
		push ax 	; push x position
		mov ax, 24
		push ax 	; push y position
		mov ax, 0x70   ; red on white blinkingF4
		push ax 	; push attribute
		mov ax, msg2
		push ax 	; push offset of string
		call printstr 	; print the string

		call Welcome_Logo

		popa
		
	ret
;------------------------------------------------------


Input_Player1: 
		
		pusha
		
		mov ax, 0
		push ax 	; push x position
		mov ax, 22
		push ax 	; push y position
		mov ax, 07 	; blue on black
		push ax 	; push attribute
		mov ax, name
		push ax 	; push offset of string
		call printstr   ; print the stri
		mov dx, buffer
		mov ah, 0x0A
		int 0x21

		mov bh, 0
		mov bl, [buffer +1]
		mov byte[buffer+2+bx], '$'

		
		mov dx, message
		mov ah, 9
		int 0x21

		mov dx, buffer+2  
		mov ah, 9
		int 0x21 
		
		
	
		
		mov ah, 0 		; service 0 – get keystroke
		int 0x16 		; call BIOS keyboard service

		popa
		ret

;--------------------------------------------------------------------
; subroutine for Score Line
;--------------------------------------------------------------------
Print_Score_Line:
	
	push es
	push ax
	push di
	push cx
		
	
	mov ax, 0xb800
	mov es, ax	
		
	mov di, 0				
	mov ax, 0x01DB
	mov cx, 80
	
	lines:	
		
		mov word[es:di], ax
	
		add di, 2
		sub cx, 1
		jne lines			

	
	mov ax, 0xb800
	mov es, ax
	mov di, 64
	mov al, 'S'
	mov ah, 0x07
	mov word[es:di],ax

	mov di, 66
	mov al, 'c'
	mov ah, 0x07
	mov word[es:di],ax

	mov di,68
	mov al, 'o'
	mov ah, 0x07
	mov word[es:di],ax

	mov di,70
	mov al, 'r'
	mov ah, 0x07
	mov word[es:di],ax

	mov di, 72
	mov al, 'e'
	mov ah, 0x07
	mov word[es:di],ax

	mov di, 74
	mov al, 0x20
	mov ah, 0x07
	mov word[es:di],ax

	mov di, 76
	mov al, ':'
	mov ah, 0x07
	mov word[es:di],ax

	mov di, 78
	mov al, 0x20
	mov ah, 0x07
	mov word[es:di],ax

	pop cx
	pop di
	pop ax
	pop es
	ret
;--------------------------------------------------------------------
; subroutine to clear the screen
;--------------------------------------------------------------------
clrscr:			
	push es
	push ax
	push di
	push cx

	mov ax, 0xb800
	mov es, ax				

	mov di, 0
	mov cx, 2000				

	mov word [es:di], 0x0720		
	cld					;; add di, 2
	rep stosw				;;repeat cx times 
					
	pop cx
	pop di
	pop ax
	pop es

	ret
;--------------------------------------------------------------------
; subroutine for delay
;--------------------------------------------------------------------
delay : 		
	push ax
	push cx
	mov ax, 0

	d2:
		loop d2

	d1:			
		add ax, 1
		mov cx, 0xffff
		cmp ax, 0xffff
		jne d1

		mov cx, 0xFFFF
	d4:
		loop d4
	
	pop cx
	pop ax
	ret
;--------------------------------------------------------------------
; subroutine for Sky_Printing
;--------------------------------------------------------------------
Print_Sky:		
	push es
	push ax
	push di
	push cx

	mov ax, 0xb800
	mov es, ax				
	mov di, 160				
	mov cx, 0

	back:			
		mov word [es:di], 0x0BDB		
		add di, 2				
		add cx, 2
		cmp cx, 1440			
		jne back				

		pop cx
		pop di
		pop ax
		pop es
	ret
;--------------------------------------------------------------------
; subroutine for Greenry_Printing
;--------------------------------------------------------------------
Print_Greenry:	
	push es
	push ax
	push di
	push cx
		
	
	mov ax, 0xb800
	mov es, ax	
	
	mov di, 1440
	mov ax, 0x2000
	mov cx, 80

	cld 
	rep stosw		

	pop cx
	pop di
	pop ax
	pop es
	ret

;--------------------------------------------------------------------
; subroutine for ShipBackGround_Printing
;--------------------------------------------------------------------
Print_Ship_Background:	
	push es
	push ax
	push di
	push cx
					
	mov ax, 0xb800
	mov es, ax		
		
	mov di, 1600
	mov ax, 0x3000	
	mov cx, 1440
	
	cld
	rep stosw			

	pop cx
	pop di
	pop ax
	pop es
	ret


;--------------------------------------------------------------------
; subroutine for River Printing
;--------------------------------------------------------------------
Print_River:		
	push es
	push ax
	push di
	push cx
		
	
	mov ax, 0xb800
	mov es, ax	
		
	mov di, 2880				
	mov ax, 0x1000	
	mov cx, 1440
	
	riv:	
		cmp word[es:di], 0x4000
		je skip
		cmp word[es:di], 0x2000
		je skip
		mov word[es:di], ax
	skip:
		add di, 2
		sub cx, 1
		jne riv				

	pop cx
	pop di
	pop ax
	pop es
	ret

;--------------------------------------------------------------------
; subroutine for Crows Printing
;--------------------------------------------------------------------
Print_Crow: 				
	push bp
	mov bp, sp
	push es
	push ax
	push si

	mov di, [bp+4]
	mov ax, 0xb800
	mov es, ax					
	
 	mov si, di
	add di, 2
	mov word [es:di], 0x00DB
	add di, 2
	mov word [es:di], 0x00DB

	sub di, 6
	mov word [es:di], 0x00DB

	sub di, 2
	mov word [es:di], 0x00DB
	
	
	add si, 160
	mov word[es:si], 0x00DB

		
	pop si
	pop ax
	pop es
	pop bp
	
	ret 2
;--------------------------------------------------------------------
; subroutine for Sun Printing
;--------------------------------------------------------------------
Print_Sun:		
	push bp
	mov bp, sp
	push es
	push ax
	push si

	mov di, [bp+4]
	mov ax, 0xb800
	mov es, ax				
	mov ax, di
	mov cx, 4
			
	sun: 			
		mov word [es:di], 0x0EDB
		add di, 2
		mov word [es:di], 0x0EDB
		sub di, 4
		mov word [es:di], 0x0EDB

		mov di, ax
		add di, 160
		sub cx, 2

		jne sun
		
		pop si
		pop ax
		pop es
		pop bp
		
	ret 2
;--------------------------------------------------------------------
; subroutine for Mountain Printing
;--------------------------------------------------------------------
Print_Square:

		pusha

		mov ax, 0xb800
		mov es, ax
		mov di, 1802
		mov cx, 34
		print1:	
			mov word [es:di], 0x70DB
			add di, 2
		dec cx
		jne print1
		sub di, 2
		mov al, '-'
		mov ah, 0x04
		mov word[es:di], ax
		
		add di, 2
		
		mov word[es:di], 0x70DB

		add di, 2
		mov al, 'x'
		mov ah, 0x04
		mov word[es:di], ax
	
		add di, 160
		mov cx,5
		print2:	
			mov word [es:di], 0x70DB
			add di, 160
		dec cx
		jne print2
		
		mov word [es:di], 0x70DB
		sub di, 2
		mov cx,34
		print3:	
			mov word [es:di], 0x70DB
			sub di, 2
		dec cx
		jne print3

		mov word [es:di], 0x70DB
		sub di, 160
		mov cx,5
		print4:	
			mov word [es:di], 0x70DB
			sub di, 160
		dec cx
		jne print4
		
		popa
		ret
Print_Mountains:		
	push bp
	mov bp, sp
	push es
	push ax
	push si

	mov di, [bp+4]
	mov ax, 0xb800
	mov es, ax				
	mov ax, di

	middle_line: 		
		mov di, ax
		mov si, di
		mov word [es:di], 0x04DB
			

	outer_bounds:		
		add si, 162
		add di, 158

		mov word [es:si], 0x04DB
		mov word [es:di], 0x04DB		
		cmp di, 1280				
		jna outer_bounds		 		
		
		add ax, 160
		cmp ax, 1280				
		jna middle_line
  
		add di, 2
		mov word [es:di], 0x04DB
		
		pop si
		pop ax
		pop es
		pop bp
		ret 2
;--------------------------------------------------------------------
; subroutine for Print Ships
;--------------------------------------------------------------------	
Print_Ships: 
		
	push bp
	mov bp, sp
	push es
	push ax
	push si
	push di
	
	mov di, [bp+6]
	mov si, [bp+4]

	mov ax, 0xb800
	mov es, ax			

	;--------------------------------------------------------------------	
	layer_1:		
		mov word [es:di], 0x08DB
		mov word [es:si], 0x08DB
		add si, 2
		sub di, 2
		cmp si, di
		jna layer_1
	;--------------------------------------------------------------------	

		mov di, [bp+6]
		mov si, [bp+4]	
		sub di, 160
		sub si, 160 

		add di, 2
		sub si, 2
		mov word [es:di], 0x08DB
		mov word [es:si], 0x08DB
		
		mov di, [bp+6]
		mov si, [bp+4]
				
		sub di, 160
		sub si, 160 

	;--------------------------------------------------------------------	
	layer_2:		
		mov word [es:di], 0x08DB
		mov word [es:si], 0x08DB
		add si, 2
		sub di, 2
		cmp si, di
		jna layer_2
	;--------------------------------------------------------------------	

		mov di, [bp+6]
		mov si, [bp+4]	
		sub di, 320
		sub si, 320 

		add di, 2
		sub si, 2
		mov word [es:di], 0x04DB
		mov word [es:si], 0x04DB
	
		add di, 2
		sub si, 2
		mov word [es:di], 0x04DB
		mov word [es:si], 0x04DB
		
		mov di, [bp+6]
		mov si, [bp+4]
				
		sub di, 320
		sub si, 320


	;--------------------------------------------------------------------
	layer_3:		
		mov word [es:di], 0x04DB
		mov word [es:si], 0x04DB
		add si, 2
		sub di, 2
		cmp si, di
		jna layer_3
	;--------------------------------------------------------------------	

		mov di, [bp+6]
		mov si, [bp+4]

		mov ax, 0xb800
		mov es, ax			

		sub di, 480
		sub si, 480

		add si, 2
		sub di, 2

	;--------------------------------------------------------------------	
	layer_4:		
		mov word [es:di], 0x07DB
		mov word [es:si], 0x07DB
		add si, 2
		sub di, 2
		cmp si, di
		jna layer_4
	;--------------------------------------------------------------------	
		
		pop di
		pop si
		pop ax
		pop es
		pop bp
		ret 4
;--------------------------------------------------------------------
; subroutine for Print Coin
;--------------------------------------------------------------------	
Print_Green_Coin:
		
	push bp
	mov bp, sp
	push es
	push ax
	push di
	
		mov di, [bp+4]
		mov ax, 0xb800
		mov es, ax
		mov word[es:di], 0x2000
								
		
	pop di
	pop ax
	pop es
	pop bp
		
	ret 2
;--------------------------------------------------------------------
; subroutine for Print Coin
;--------------------------------------------------------------------	
Print_Red_Coin:
		
	push bp
	mov bp, sp
	push es
	push ax
	push di
	
		mov di, [bp+4]
		mov ax, 0xb800
		mov es, ax
		mov word[es:di], 0x4000						
		
	pop di
	pop ax
	pop es
	pop bp
		
	ret 2
;--------------------------------------------------------------------
; subroutine for Print Fishes
;--------------------------------------------------------------------	
Print_Left_Fish: 

	push bp
	mov bp, sp
	push es
	push ax
	push si
	push di

	mov di, [bp+4]
	mov ax, 0xb800
	mov es, ax				
	mov ax, di
	mov si, di
	mov cx, 4

	mov ah, 0x1B
	mov al, '<'
	mov [es:di], ax
	
	add di, 2
	mov ah, 0x10
	mov al, '`'
	mov [es:di], ax
	
	add di, 2
	mov ah, 0x1B
	mov al, ')'
	mov [es:di], ax
	
	add di, 2
	mov ah, 0x1B
	mov al, ')'
	mov [es:di], ax
	
	add di, 2
	mov ah, 0x1B
	mov al, ')'
	mov [es:di], ax
	
	add di, 2
	mov ah, 0x1B
	mov al, '>'
	mov [es:di], ax
	
	add di, 2
	mov ah, 0x1B
	mov al, '<'
	mov [es:di], ax
	



	pop di
	pop si
	pop ax
	pop es
	pop bp
		
	ret 2
		
Print_Right_Fish: 

	push bp
	mov bp, sp
	push es
	push ax
	push si
	push di

	mov di, [bp+4]
	mov ax, 0xb800
	mov es, ax				
	mov ax, di
	mov si, di
	mov cx, 4

	mov ah, 0x1B
	mov al, '>'
	mov [es:di], ax
	
	sub di, 2
	mov ah, 0x10
	mov al, '`'
	mov [es:di], ax
	
	sub di, 2
	mov ah, 0x1B
	mov al, '('
	mov [es:di], ax
	
	sub di, 2
	mov ah, 0x1B
	mov al, '('
	mov [es:di], ax
	
	sub di, 2
	mov ah, 0x1B
	mov al, '('
	mov [es:di], ax
	
	sub di, 2
	mov ah, 0x1B
	mov al, '<'
	mov [es:di], ax
	
	sub di, 2
	mov ah, 0x1B
	mov al, '>'
	mov [es:di], ax
	



	pop di
	pop si
	pop ax
	pop es
	pop bp
		
	ret 2

Print_Down_Fish: 

	push bp
	mov bp, sp
	push es
	push ax
	push si
	push di

	mov di, [bp+4]
	mov ax, 0xb800
	mov es, ax				
	mov ax, di
	mov si, di
	mov cx, 4

	add di, 160
	mov ah, 0x1B
	mov al, '\'
	mov [es:di], ax
	
	add di, 2
	mov ah, 0x1B
	mov al, '/'
	mov [es:di], ax
		
	sub di, 2
	sub di, 160
	
	mov ah, 0x10
	mov al, '*'
	mov [es:di], ax
	
	sub di, 160
	mov ah, 0x1B
	mov al, '('
	mov [es:di], ax

	add di, 2
	mov ah, 0x1B
	mov al, ')'
	mov [es:di], ax
	
	sub di, 2
	
	sub di, 160
	mov ah, 0x1B
	mov al, '\'
	mov [es:di], ax

	add di, 2
	mov ah, 0x1B
	mov al, '/'
	mov [es:di], ax

	pop di
	pop si
	pop ax
	pop es
	pop bp
		
	ret 2

Print_Up_Fish: 

	push bp
	mov bp, sp
	push es
	push ax
	push si
	push di

	
	mov di, [bp+4]
	mov ax, 0xb800
	mov es, ax				
	mov ax, di
	mov si, di
	mov cx, 4
	
	sub di, 160
	mov ah, 0x1B
	mov al, '/'
	mov [es:di], ax
	
	add di, 2
	mov ah, 0x1B
	mov al, '\'
	mov [es:di], ax
		
	sub di, 2
	add di, 160
	
	mov ah, 0x10
	mov al, '*'
	mov [es:di], ax
	
	add di, 160
	mov ah, 0x1B
	mov al, '('
	mov [es:di], ax

	add di, 2
	mov ah, 0x1B
	mov al, ')'
	mov [es:di], ax
	
	sub di, 2
	add di, 160
	mov ah, 0x1B
	mov al, '/'
	mov [es:di], ax

	add di, 2
	mov ah, 0x1B
	mov al, '\'
	mov [es:di], ax

	pop di
	pop si
	pop ax
	pop es
	pop bp
		
	ret 2
;--------------------------------------------------------------------
; subroutine for Print Number
;--------------------------------------------------------------------
printnum: push bp
				mov bp, sp
				push es
				push ax
				push bx
				push cx
				push dx
				push di

				mov ax, 0xb800
				mov es, ax			

				mov ax, [bp+4]		
				mov bx, 10			
				mov cx, 0			

nextdigit:		mov dx, 0			; zero upper half of dividend
				div bx			; divide by 10 AX/BX --> Quotient --> AX, Remainder --> DX ..... 
				add dl, 0x30		; convert digit into ascii value
				push dx			; save ascii value on stack

				inc cx			; increment count of values
				cmp ax, 0		; is the quotient zero
				jnz nextdigit		; if no divide it again


				mov di, 78		; point di to top left column
nextpos:		pop dx				; remove a digit from the stack
				mov dh, 0x07		; use normal attribute
				mov [es:di], dx		; print char on screen
				add di, 2		; move to next screen location
				loop nextpos		; repeat for all digits on stack

				pop di
				pop dx
				pop cx
				pop bx
				pop ax
				pop es
				pop bp
				ret 2
;-------------------------------------------------------------------
; -------------------------------KBISR------------------------------			    
;-------------------------------------------------------------------		
kbisr:
	push ax
	push es
	push di
	push cx
	push bx
	push dx
	push si

	push cs
	pop ds

	mov ax, 0xb800
	mov es, ax
	in al, 0x60	

	cmp al, 0x11			; up direction key
	je Fish_up
	jmp nextcmp1

	nextcmp1:
		cmp al, 0x1f		; down direction key
		je near Fish_down
		jmp nextcmp2

	nextcmp2:
		cmp al, 0x1e		; left direction key
		je near Fish_left
		jmp nextcmp3

	nextcmp3:
		cmp al, 0x20		; right direction key		
		je near Fish_right
		jmp Exit_Checker

	Exit_Checker:
		cmp al, 0x01		; esc key
		jne none_matches
		mov word[cs:flag_exit], 1
	
	none_matches:
		pop si
		pop dx
		pop bx
		pop cx
		pop di
		pop es
		pop ax
		jmp far [cs:oldisr]	; jump to orignal ISR
		
;---------------------Fish_Up-----------------------------
Fish_up:
		mov ax,	word[cs:Fish_p]
		cmp ax, 3200
		jb near sound
		jbe dont_mov

		
		sub ax, 160
		mov word[cs:Fish_p], ax
		push word[cs:Fish_p]

		call Print_River
		call Print_Up_Fish

;---------------Green_Coin_Score_Adder_Logic-------------

		mov dx,	word[cs:Fish_p]
		mov bx, [cs:green_pos]

			
			cmp bx, dx
			je near Score_Adder_Green_Up
			green_up:
				;jmp exit

;---------------Red_Coin_Score_Adder_Logic-------------

		mov dx,	word[cs:Fish_p]
		mov bx, [cs:red_pos]

			cmp bx, dx
			je near Score_Adder_Red_Up
			red_up:
				jmp exit
		dont_mov:
			jmp exit


;---------------------Fish_Down-----------------------------
	Fish_down:
		
		mov dx,	word[cs:Fish_p]
		cmp dx, 3680
		ja near sound
		
		add dx, 160
		mov word[cs:Fish_p], dx
		push word[cs:Fish_p]
		call Print_River
		call Print_Down_Fish

;---------------Green_Coin_Score_Adder_Logic-------------

		mov dx,	word[cs:Fish_p]
		mov bx, [cs:green_pos]

			
			cmp bx, dx
			je near Score_Adder_Green_Down
			green_down:
				;jmp exit

;---------------Red_Coin_Score_Adder_Logic-------------

		mov dx,	word[cs:Fish_p]
		mov bx, [cs:red_pos]

			cmp bx, dx
			je near Score_Adder_Red_Down
			red_down:
				jmp exit
		
		

		dont_move:	
			jmp exit

;---------------------Fish_Left-----------------------------
	Fish_left:

	
		mov ax,	word[cs:Fish_p]
		mov si, 0
		mov cx, 6
		boundary2:
			mov bx, [cs:left_boundary+si]
			cmp bx, ax
			je manage_pos2
			add si,2
			dec cx
			jnz boundary2

	managed2:
		sub ax, 2
		mov word[cs:Fish_p], ax
		push word[cs:Fish_p]
		call Print_River
		call Print_Left_Fish

;---------------Green_Coin_Score_Adder_Logic-------------

		mov dx,	word[cs:Fish_p]
		mov bx, [cs:green_pos]

			
			cmp bx, dx
			je near Score_Adder_Green_Left
			green_left:
				;jmp exit

;---------------Red_Coin_Score_Adder_Logic-------------

		mov dx,	word[cs:Fish_p]
		mov bx, [cs:red_pos]

			cmp bx, dx
			je near Score_Adder_Red_Left
			red_left:
				jmp exit

		manage_pos2:
			add ax, 160
			jmp managed2



;---------------------Fish_Right-----------------------------
	Fish_right:
		
		mov ax,	word[cs:Fish_p]
		mov si, 0
		mov cx, 6
		boundary1:
			mov bx, [cs:right_boundary+si]
			cmp bx, ax
			jz manage_pos1
			add si, 2
			dec cx
			jnz boundary1

	managed1:		
		add ax, 2
		mov word[cs:Fish_p], ax
		push word[cs:Fish_p]
		call Print_River
		call Print_Right_Fish

;---------------Green_Coin_Score_Adder_Logic-------------

		mov dx,	word[cs:Fish_p]
		mov bx, [cs:green_pos]
	
			cmp bx, dx
			je near Score_Adder_Green_Right
			green_right:
				

;---------------Red_Coin_Score_Adder_Logic-------------

		mov dx,	word[cs:Fish_p]
		mov bx, [cs:red_pos]

			cmp bx, dx
			je near Score_Adder_Red_Right
			red_right:
				
		jmp exit

		manage_pos1:
			sub ax, 160
			jmp managed1


	Score_Adder_Green_Up:
		
			add word[cs:score], 10
			mov ax, [cs:score]
			push ax
			call printnum
			jmp green_up

	
	Score_Adder_Red_Up:
		
			add word[cs:score], 50
			mov ax, [cs:score]
			push ax
			call printnum
			jmp red_up

	Score_Adder_Green_Down:
		
			add word[cs:score], 10
			mov ax, [cs:score]
			push ax
			call printnum
			jmp green_down

	
	Score_Adder_Red_Down:
		
			add word[cs:score], 50
			mov ax, [cs:score]
			push ax
			call printnum
			jmp red_down

	Score_Adder_Green_Left:
		
			add word[cs:score], 10
			mov ax, [cs:score]
			push ax
			call printnum
			jmp green_left

	Score_Adder_Red_Left:
		
			add word[cs:score], 50
			mov ax, [cs:score]
			push ax
			call printnum
			jmp red_left



	Score_Adder_Green_Right:
		
			add word[cs:score], 10
			mov ax, [cs:score]
			push ax
			call printnum
			jmp green_left

	Score_Adder_Red_Right:
		
			add word[cs:score], 50
			mov ax, [cs:score]
			push ax
			call printnum
			jmp red_left

			
;-------------------------------------------------------------------
	sound:	
		IN AL, 61h  ;Save state
		PUSH AX  

		MOV BX, 6818		; 1193180/175
		MOV AL, 6Bh  		; Select Channel 2, write LSB/BSB mode 3
		OUT 43h, AL 

		MOV AX, BX 
		OUT 24h, AL  		; Send the LSB

		MOV AL, AH  
		OUT 42h, AL  		; Send the MSB

		IN AL, 61h   		; Get the 8255 Port Contence
		OR AL, 3h      
		OUT 61h, AL  		;End able speaker and use clock channel 2 for input

		MOV CX, 03h 		; High order wait value
		MOV DX, 0D04h		; Low order wait value
		MOV AX, 86h		;Wait service

		INT 15h        

		POP AX			;restore Speaker state
		OUT 61h, AL
;-------------------------------------------------------------------
	exit:
		mov al, 0x20
		out 0x20, al		; send EOI to PIC

		pop si
		pop dx
		pop bx
		pop cx
		pop di
		pop es
		pop ax
		iret		; return from interupt
				 
;-------------------------------------------------------------------
; -------------------------------TIMER------------------------------			    
;-------------------------------------------------------------------
timer:
	pusha
	
	push cs
	pop ds

	green_timer:
		inc word[cs:green_pellet_timer]				; green pellet with 10 points
		cmp word[cs:green_pellet_timer], 54			; so have a less time to be eaten ; will remian for 3 secs
		jne red_timer
		mov word [cs:green_pellet_timer], 0			; else restore to zero
		
		mov si, word[cs:adder_g]
		mov di, word [cs:random_g+si-2]				; time completed of previous green pellet
		mov word [es:di], 0x01DB				; replaced by river colour
		mov di, word [cs:random_g+si]
		mov [cs:green_pos],di
		push di							; pushing the next random index of green coin
		Call Print_Green_Coin
			
		check_index_g:
			add si, 2	
			mov word[cs:adder_g], si
			cmp si, 50
			jb red_timer

			array_ended_g:
				mov si, 0
				mov word[cs:adder_g], si

	red_timer:
		inc word[cs:red_pellet_timer]				; red pellet with 5 points 
		cmp word[cs:red_pellet_timer], 90			; so have more time than green one		; will remain for 5 sec
		jne counter
		mov word[cs:red_pellet_timer], 0			; else restore to zero

		mov si, word[cs:adder_r]
		mov di, word [cs:random_r+si-2]				; time completed of previous red pellet
		mov word [es:di], 0x01DB				; replaced by river colour
		mov di, word [cs:random_r+si]
		mov [cs:red_pos],di
		push di							; pushing the next random index of red coin				
		call Print_Red_Coin

		check_index_r:
			add si, 2	
			mov word[cs:adder_r], si
			cmp si, 50
			jb counter

			array_ended_r:
				mov si, 0
				mov word[cs:adder_r], si


	counter:
	inc word [cs:tickcount]				; increment tickcount
	cmp word [cs:tickcount], 6			; 18 ticks in a sec
	je mov_call
	jmp do_nothing

	mov_call:
		call Movements
		mov word [cs:tickcount], 0
		jmp do_nothing


	do_nothing:
	
	mov al, 0x20		; Send EOI to PIC (Imp)
	out 0x20, al

	
	popa
	iret				; return from interupt

;-------------------------------------------------------------------
; -------------------------1st Portion------------------------------			    
;-------------------------------------------------------------------							
Sky_Surroundings:						  

	push bp
	push di

	mov di, 450				   ;-	
	push di					   ;-
	call Print_Mountains		   	   ;-
						   ;-
	mov di,204				   ;-	
	push di					   ;-
	call Print_Mountains		   	   ;-
						   ;-
	mov di, 492				   ;-	
	push di					   ;-
	call Print_Mountains		   	   ;-	
					           ;-
	mov di, 556				   ;-	
	push di					   ;-
	call Print_Mountains		   	   ;-
						   ;-
	mov di, 580				   ;-	
	push di					   ;-
	call Print_Mountains		   	   ;-
						   ;-
	mov di, 310				   ;-
	push di				           ;-
	call Print_Sun                             ;-
						   ;-
	mov di, 166				   ;-
	push di				           ;-
	call Print_Crow	                           ;-
						   ;-
	mov di, 270				   ;-
	push di				           ;-
	call Print_Crow	                           ;-
						   ;-
	mov di, 220				   ;-
	push di				           ;-
	call Print_Crow	                           ;-
						   ;-	
	pop di
	pop bp

	ret					   ;-

;-------------------------------------------------------------------
; -------------------------2nd Portion------------------------------			    
;-------------------------------------------------------------------
Ships_Surroundings:       					   	
	push bp
	push di
	push si

	mov di, 2830				   ;	Ending Point
	push di					   ;
	mov si, 2800				   ;	Staring Point
	push si				  	   ;
	call Print_Ships		           ;
						   ;					   ;	
	mov di, 2290				   ;	Ending Point
	push di					   ;
	mov si, 2264				   ;	Staring Point
	push si				  	   ;
	call Print_Ships		           ;
						   ;
	mov di, 2714				   ;	Ending Point
	push di					   ;
	mov si, 2690				   ;	Staring Point
	push si				  	   ;
	call Print_Ships		           ;
							;
	pop si							;
	pop di					;
	pop bp					   ;
	ret					   ;
								   ;
;--------------------------------------------------------------------
; -------------------------3rd Portion------------------------------			    
;--------------------------------------------------------------------
River_Surroundings: 

	mov ax, 3300
	mov [Fish_p], ax
	push word[Fish_p]
	call Print_Left_Fish

	ret
;--------------------------------------------------------------------
; subroutine for SkyMovement
;--------------------------------------------------------------------
Sky_Movements:		

	push bp
	push ax
	push bx
	push cx
	push dx
	push si
	push di

	mov dx, 160
	mov bx, 0
	mov ax, 0xb800
	mov es, ax
	mov ds, ax

	left_movement:

		mov di, dx
		mov si, di
		add si, 2
		mov cx, 80     

		mov bp, [es:di] 

		cld
		rep movsw
		sub si, 4         
		mov [es:si] , bp

		add dx, 160
	    inc bx
	    cmp bx, 9
		jne left_movement

	pop di
	pop si
	pop dx
	pop cx
	pop bx
	pop ax
	pop bp
    
    ret		
;--------------------------------------------------------------------
; subroutine for Ship_Movement
;--------------------------------------------------------------------
Ship_Movements:		
	
	push bp
	push ax
	push bx
	push cx
	push dx
	push si
	push di
    
	mov ax, 0xb800
    mov bx, 0
    mov es, ax
    mov ds, ax
    mov ax, 0
    mov dx, 1758	

    right_movement:
        
    	mov cx, 80     
    	mov di, dx
    	mov si, di
    	sub si, 2

    	mov bp, [es:di] 
	
    	std
    	rep movsw

    	add si, 4      
    	mov [es:si] , bp

    	    add dx, 160
    	    add bx, 1
    	    cmp bx, 8

    	jne right_movement
    
	pop di
	pop si
	pop dx
	pop cx
	pop bx
	pop ax
	pop bp

    ret	

; -------------------------------------------------------------------
; subroutine for Initializing
;--------------------------------------------------------------------
Initialization:
	call Print_Sky
	call Print_Ship_Background
	call Print_River
	call Print_Greenry
	ret

;--------------------------------------------------------------------
; subroutine for Movements
;--------------------------------------------------------------------
Movements:	
		
	call Sky_Movements
 	call Ship_Movements
	
	ret
;--------------------------------------------------------------------
Intro:
		pusha 
		call clrscr_black
		call Input_Player1
		call clrscr_gray
		call Welcome_Screen	
		popa 
		ret
;--------------------------------------------------------------------
Print_Exit_Messsage
		pusha
		call Print_Square
		mov ax, 24
		push ax 	; push x position
		mov ax, 13
		push ax 	; push y position
		mov ax, 0x70    ; blue on white
		push ax 	; push attribute
		mov ax, last
		push ax 	; push offset of string
		call printstr   ; print the string

		mov ax, 30
		push ax 	; push x position
		mov ax, 15
		push ax 	; push y position
		mov ax, 0xF4   ; blue on white
		push ax 	; push attribute
		mov ax, last2
		push ax 	; push offset of string
		call printstr   ; print the string
		popa
		ret
;--------------------------------------------------------------------
unhook:
			push bp
			mov bp,sp
			push ax
			push cx
			push si
			push di
			push es
			push ds

		xor ax, ax
		mov es, ax

		
		mov ax, [oldisr]						; disable interrupts
		mov bx, [oldisr+2]
		mov cx, [oldtim]						; disable interrupts
		mov dx, [oldtim+2]						; store segment at n*4+2

		cli
		
		mov word [es:9*4], ax						; store offset at n*4
		mov word[es:9*4+2], bx
		mov word [es:8*4], cx						; store offset at n*4
		mov word[es:8*4+2],dx						; store segment at n*4+2
	
		sti
		
	pop ds
	pop es
	pop di
	pop si
	pop cx
	pop ax	
	pop bp
			
	ret
;--------------------------------------------------------------------
; Driver
;--------------------------------------------------------------------	
Driver:
	
	call Intro
	
		mov ah, 1										; getchar()
		int 0x21 

		cmp al, 13
		je inGame
		jmp exitt
		
	inGame:
	call clrscr
			
	call Initialization
	call Print_Score_Line
	call Sky_Surroundings
	call Ships_Surroundings
	call River_Surroundings

	
	xor ax, ax
	mov es, ax								; point es to IVT base

	push word[score]
	call printnum 	

	mov ax, [es:9*4]
	mov [oldisr], ax							; save offset of old routine
	mov ax, [es:9*4+2]
	mov [oldisr+2], ax							; save segment of old routine

	mov ax, [es:8*4]	
	mov [oldtim] , ax
	mov ax, [es:8*4+2]
	mov [oldtim+2], ax
	
						
	cli 									; disable interrupts
	mov word [es:9*4], kbisr						; store offset at n*4
	mov [es:9*4+2], cs							; store segment at n*4+2
	mov word [es:8*4], timer						; store offset at n*4
	mov [es:8*4+2], cs 							; store segment at n*4+2
	sti 		
							; enable interrupts


	mov ax, 0xb800
	mov es, ax
	
	checks:
		cmp word[flag_exit], 1
		jne checks
		
	mov ah, 1					; getchar()
		int 0x21 
	
	last_screen:
		call clrscr_gray
		call Welcome_Logo
		call Print_Exit_Messsage		
		call unhook
	
		mov ah, 1				; getchar()
		int 0x21
		cmp al, 121 			;'Y' Ascii
		je exitt
		cmp al, 110			;'N' Ascii
		je inGame

	
	exitt:	

	mov ax, 0x4c00
	int 0x21
