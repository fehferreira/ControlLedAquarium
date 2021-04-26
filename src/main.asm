
_initializePic:

;main.c,3 :: 		void initializePic(){
;main.c,4 :: 		TRISA = 0x11111111;
	MOVLW      17
	MOVWF      TRISA+0
;main.c,5 :: 		TRISB = 0x00000000;
	CLRF       TRISB+0
;main.c,6 :: 		PORTA = 0x00000000;
	CLRF       PORTA+0
;main.c,7 :: 		PORTB = 0x00000000;
	CLRF       PORTB+0
;main.c,9 :: 		ADC_Init();
	CALL       _ADC_Init+0
;main.c,10 :: 		}
L_end_initializePic:
	RETURN
; end of _initializePic

_main:

;main.c,12 :: 		void main(){
;main.c,13 :: 		initializePic();
	CALL       _initializePic+0
;main.c,15 :: 		while(1){
L_main0:
;main.c,16 :: 		PORTB = ADC_Read(RESISTOR_PORT);
	MOVLW      0
	BTFSC      RA0_bit+0, BitPos(RA0_bit+0)
	MOVLW      1
	MOVWF      FARG_ADC_Read_channel+0
	CALL       _ADC_Read+0
	MOVF       R0+0, 0
	MOVWF      PORTB+0
;main.c,17 :: 		}
	GOTO       L_main0
;main.c,18 :: 		}
L_end_main:
	GOTO       $+0
; end of _main
