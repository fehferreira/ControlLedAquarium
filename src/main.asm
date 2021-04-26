
_readValueResistor:

;main.c,3 :: 		unsigned readValueResistor(char portRead){
;main.c,4 :: 		return ADC_Read(portRead);
	MOVF       FARG_readValueResistor_portRead+0, 0
	MOVWF      FARG_ADC_Read_channel+0
	CALL       _ADC_Read+0
;main.c,5 :: 		}
L_end_readValueResistor:
	RETURN
; end of _readValueResistor

_initializePic:

;main.c,7 :: 		void initializePic(){
;main.c,8 :: 		TRISA = 0x11111111;
	MOVLW      17
	MOVWF      TRISA+0
;main.c,9 :: 		TRISB = 0x00000000;
	CLRF       TRISB+0
;main.c,10 :: 		PORTA = 0x00000000;
	CLRF       PORTA+0
;main.c,11 :: 		PORTB = 0x00000000;
	CLRF       PORTB+0
;main.c,13 :: 		ADC_Init();
	CALL       _ADC_Init+0
;main.c,14 :: 		}
L_end_initializePic:
	RETURN
; end of _initializePic

_main:

;main.c,16 :: 		void main(){
;main.c,17 :: 		initializePic();
	CALL       _initializePic+0
;main.c,19 :: 		while(1){
L_main0:
;main.c,20 :: 		PORTB = readValueResistor(RESISTOR_PORT);
	MOVLW      0
	BTFSC      RA0_bit+0, BitPos(RA0_bit+0)
	MOVLW      1
	MOVWF      FARG_readValueResistor_portRead+0
	CALL       _readValueResistor+0
	MOVF       R0+0, 0
	MOVWF      PORTB+0
;main.c,21 :: 		}
	GOTO       L_main0
;main.c,22 :: 		}
L_end_main:
	GOTO       $+0
; end of _main
