
_initializePic:

;main.c,1 :: 		void initializePic(){
;main.c,2 :: 		TRISA = 0x11111111;
	MOVLW      17
	MOVWF      TRISA+0
;main.c,3 :: 		TRISB = 0x11111110;
	MOVLW      16
	MOVWF      TRISB+0
;main.c,4 :: 		PORTA = 0x00000000;
	CLRF       PORTA+0
;main.c,5 :: 		PORTB = 0x00000000;
	CLRF       PORTB+0
;main.c,6 :: 		}
L_end_initializePic:
	RETURN
; end of _initializePic

_main:

;main.c,7 :: 		void main(){
;main.c,8 :: 		initializePic();
	CALL       _initializePic+0
;main.c,10 :: 		while(1){
L_main0:
;main.c,11 :: 		Delay_100ms();
	CALL       _Delay_100ms+0
;main.c,12 :: 		RB0_bit = ~RB0_bit;
	MOVLW
	XORWF      RB0_bit+0, 1
;main.c,13 :: 		}
	GOTO       L_main0
;main.c,14 :: 		}
L_end_main:
	GOTO       $+0
; end of _main
