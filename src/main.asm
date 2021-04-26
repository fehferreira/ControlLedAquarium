
_readValueResistor:

;main.c,8 :: 		unsigned readValueResistor(unsigned short portReader){
;main.c,9 :: 		return ADC_Read(portReader);
	MOVF       FARG_readValueResistor_portReader+0, 0
	MOVWF      FARG_ADC_Read_channel+0
	CALL       _ADC_Read+0
;main.c,10 :: 		}
L_end_readValueResistor:
	RETURN
; end of _readValueResistor

_initializePic:

;main.c,12 :: 		void initializePic(){
;main.c,13 :: 		TRISA = 0x11111111;
	MOVLW      17
	MOVWF      TRISA+0
;main.c,14 :: 		TRISB = 0x11111110;
	MOVLW      16
	MOVWF      TRISB+0
;main.c,15 :: 		PORTA = 0x00000000;
	CLRF       PORTA+0
;main.c,16 :: 		PORTB = 0x00000000;
	CLRF       PORTB+0
;main.c,18 :: 		ADC_Init();
	CALL       _ADC_Init+0
;main.c,19 :: 		Soft_UART_Init(&PORTB,RX_PIN,TX_PIN,USART_BAUDRATE,INVERT_FLAG);
	MOVLW      PORTB+0
	MOVWF      FARG_Soft_UART_Init_port+0
	MOVLW      7
	MOVWF      FARG_Soft_UART_Init_rx_pin+0
	MOVLW      6
	MOVWF      FARG_Soft_UART_Init_tx_pin+0
	MOVLW      128
	MOVWF      FARG_Soft_UART_Init_baud_rate+0
	MOVLW      37
	MOVWF      FARG_Soft_UART_Init_baud_rate+1
	CLRF       FARG_Soft_UART_Init_baud_rate+2
	CLRF       FARG_Soft_UART_Init_baud_rate+3
	CLRF       FARG_Soft_UART_Init_inverted+0
	CALL       _Soft_UART_Init+0
;main.c,20 :: 		}
L_end_initializePic:
	RETURN
; end of _initializePic

_main:

;main.c,22 :: 		void main(){
;main.c,23 :: 		unsigned value = 0;
;main.c,24 :: 		initializePic();
	CALL       _initializePic+0
;main.c,26 :: 		while(1){
L_main0:
;main.c,27 :: 		Soft_UART_Write(readValueResistor(RESISTOR_PORT));
	MOVLW      0
	BTFSC      RB1_bit+0, BitPos(RB1_bit+0)
	MOVLW      1
	MOVWF      FARG_readValueResistor_portReader+0
	CALL       _readValueResistor+0
	MOVF       R0+0, 0
	MOVWF      FARG_Soft_UART_Write_udata+0
	CALL       _Soft_UART_Write+0
;main.c,28 :: 		}
	GOTO       L_main0
;main.c,29 :: 		}
L_end_main:
	GOTO       $+0
; end of _main
