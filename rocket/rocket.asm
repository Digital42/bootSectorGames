;; set 16 bit real  mode
BITS 16

;; set bootsector memory location
org 07C00h

;; vars
rocketX dw 66
rocketY dw 8
color	db 0E0h


;; set video mode
mov ax, 003h
int 10h

;; set up video memory
mov ax, 0B800h
mov es, ax


;; standard main game loop
game_loop:
	;;black out screen every cycle
	xor ax, ax
	xor di,di
	mov cx, 80*25
	;; stos take value of ax and stores id at address es:di | "rep stos"  will repeat this cx times
	rep stosw
        
	;; draw middle thing
	mov ah, [color]
	mov di, 78
	stosw

	mov ah, [color]
	mov di, 80
	stosw

	mov ah, 040h
	mov di, 238
	stosw
	;mov cx, 13
        ;.draw_mid_loop:
	;	stosw
	;	add di, 318
	;	loop .draw_mid_loop


;; player input
	;
	mov ah, 1
	int 16h
	cmp ah, 11h
	je w_press
	jmp continue

w_press:
	mov byte [color], 0F0h


;; continue?
continue:

	
;; cpu input
	;; delay timer
	mov bx, [046Ch]
	inc bx
	inc bx
	.delay:
		cmp [046Ch], bx
		jl .delay

jmp game_loop 

;; win/loss conditions

;; zero out bootsector
times 510-($-$$) db 0

;; magic number
dw 0AA55h
