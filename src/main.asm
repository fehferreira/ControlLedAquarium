
_readValueResistor:

;main.c,17 :: 		unsigned readValueResistor(char portRead){
;main.c,18 :: 		return ADC_Read(portRead);
	MOVF       FARG_readValueResistor_portRead+0, 0
	MOVWF      FARG_ADC_Read_channel+0
	CALL       _ADC_Read+0
;main.c,19 :: 		}
L_end_readValueResistor:
	RETURN
; end of _readValueResistor

_configTMR1:

;main.c,21 :: 		void configTMR1(void){
;main.c,22 :: 		T1CON	        = 0x31;
	MOVLW      49
	MOVWF      T1CON+0
;main.c,23 :: 		TMR1IF_bit	= 0;
	BCF        TMR1IF_bit+0, BitPos(TMR1IF_bit+0)
;main.c,24 :: 		TMR1H	        = 0x0B;
	MOVLW      11
	MOVWF      TMR1H+0
;main.c,25 :: 		TMR1L	        = 0xDC;
	MOVLW      220
	MOVWF      TMR1L+0
;main.c,26 :: 		TMR1IE_bit	= 1;
	BSF        TMR1IE_bit+0, BitPos(TMR1IE_bit+0)
;main.c,28 :: 		GIE_bit       = 1;
	BSF        GIE_bit+0, BitPos(GIE_bit+0)
;main.c,29 :: 		PEIE_bit      = 1;
	BSF        PEIE_bit+0, BitPos(PEIE_bit+0)
;main.c,30 :: 		}
L_end_configTMR1:
	RETURN
; end of _configTMR1

_resetTMR1:

;main.c,32 :: 		void resetTMR1(void){
;main.c,33 :: 		TMR1IF_bit = 0;
	BCF        TMR1IF_bit+0, BitPos(TMR1IF_bit+0)
;main.c,34 :: 		TMR1H	 = 0x0B;
	MOVLW      11
	MOVWF      TMR1H+0
;main.c,35 :: 		TMR1L	 = 0xDC;
	MOVLW      220
	MOVWF      TMR1L+0
;main.c,36 :: 		}
L_end_resetTMR1:
	RETURN
; end of _resetTMR1

_interrupt:
	MOVWF      R15+0
	SWAPF      STATUS+0, 0
	CLRF       STATUS+0
	MOVWF      ___saveSTATUS+0
	MOVF       PCLATH+0, 0
	MOVWF      ___savePCLATH+0
	CLRF       PCLATH+0

;main.c,38 :: 		void interrupt(){
;main.c,39 :: 		if (TMR1IF_bit){
	BTFSS      TMR1IF_bit+0, BitPos(TMR1IF_bit+0)
	GOTO       L_interrupt0
;main.c,40 :: 		resetTMR1();
	CALL       _resetTMR1+0
;main.c,41 :: 		ms++;
	INCF       _ms+0, 1
;main.c,42 :: 		}
L_interrupt0:
;main.c,43 :: 		}
L_end_interrupt:
L__interrupt13:
	MOVF       ___savePCLATH+0, 0
	MOVWF      PCLATH+0
	SWAPF      ___saveSTATUS+0, 0
	MOVWF      STATUS+0
	SWAPF      R15+0, 1
	SWAPF      R15+0, 0
	RETFIE
; end of _interrupt

_read24hValues:

;main.c,45 :: 		void read24hValues(void){
;main.c,46 :: 		configTMR1();
	CALL       _configTMR1+0
;main.c,48 :: 		while(hour < 24){
L_read24hValues1:
	MOVLW      24
	SUBWF      _hour+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_read24hValues2
;main.c,49 :: 		if(ms >= 4){
	MOVLW      4
	SUBWF      _ms+0, 0
	BTFSS      STATUS+0, 0
	GOTO       L_read24hValues3
;main.c,50 :: 		ms = 0;
	CLRF       _ms+0
;main.c,51 :: 		sec++;
	INCF       _sec+0, 1
;main.c,52 :: 		}
L_read24hValues3:
;main.c,53 :: 		if(sec >= 60){
	MOVLW      60
	SUBWF      _sec+0, 0
	BTFSS      STATUS+0, 0
	GOTO       L_read24hValues4
;main.c,54 :: 		sec = 0;
	CLRF       _sec+0
;main.c,55 :: 		minute++;
	INCF       _minute+0, 1
;main.c,56 :: 		}
L_read24hValues4:
;main.c,57 :: 		if(minute >= 60){
	MOVLW      60
	SUBWF      _minute+0, 0
	BTFSS      STATUS+0, 0
	GOTO       L_read24hValues5
;main.c,58 :: 		minute = 0;
	CLRF       _minute+0
;main.c,59 :: 		hour++;
	INCF       _hour+0, 1
;main.c,61 :: 		}
L_read24hValues5:
;main.c,62 :: 		}
	GOTO       L_read24hValues1
L_read24hValues2:
;main.c,63 :: 		}
L_end_read24hValues:
	RETURN
; end of _read24hValues

_updatingEepromData:

;main.c,65 :: 		void updatingEepromData(void){
;main.c,66 :: 		quant_values_eeprom = EEPROM_Read(QUANT_VALUE_EEPROM);
	MOVLW      1
	MOVWF      FARG_EEPROM_Read_Address+0
	CALL       _EEPROM_Read+0
	MOVF       R0+0, 0
	MOVWF      _quant_values_eeprom+0
;main.c,67 :: 		read_control_led    = EEPROM_Read(READ_CONTROL_LED);
	MOVLW      2
	MOVWF      FARG_EEPROM_Read_Address+0
	CALL       _EEPROM_Read+0
	MOVF       R0+0, 0
	MOVWF      _read_control_led+0
;main.c,68 :: 		last_value_eeprom   = EEPROM_Read(LAST_POSITION_EEPROM);
	MOVLW      26
	MOVWF      FARG_EEPROM_Read_Address+0
	CALL       _EEPROM_Read+0
	MOVF       R0+0, 0
	MOVWF      _last_value_eeprom+0
;main.c,70 :: 		if(read_control_led)
	MOVF       _read_control_led+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_updatingEepromData6
;main.c,71 :: 		return;
	GOTO       L_end_updatingEepromData
L_updatingEepromData6:
;main.c,73 :: 		read24hValues();
	CALL       _read24hValues+0
;main.c,74 :: 		}
L_end_updatingEepromData:
	RETURN
; end of _updatingEepromData

_initializePic:

;main.c,76 :: 		void initializePic(void){
;main.c,77 :: 		TRISA = 0x11111111;
	MOVLW      17
	MOVWF      TRISA+0
;main.c,78 :: 		TRISB = 0x00000000;
	CLRF       TRISB+0
;main.c,79 :: 		PORTA = 0x00000000;
	CLRF       PORTA+0
;main.c,80 :: 		PORTB = 0x00000000;
	CLRF       PORTB+0
;main.c,82 :: 		ADC_Init();
	CALL       _ADC_Init+0
;main.c,83 :: 		updatingEepromData();
	CALL       _updatingEepromData+0
;main.c,84 :: 		}
L_end_initializePic:
	RETURN
; end of _initializePic

_main:

;main.c,86 :: 		void main(void){
;main.c,87 :: 		initializePic();
	CALL       _initializePic+0
;main.c,89 :: 		while(1){
L_main7:
;main.c,91 :: 		}
	GOTO       L_main7
;main.c,92 :: 		}
L_end_main:
	GOTO       $+0
; end of _main
