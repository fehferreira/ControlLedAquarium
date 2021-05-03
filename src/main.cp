#line 1 "C:/Users/Felipe-Oficina/Documents/Programação/MIKROC/automatizadorAquarioLedsFotosensor/src/main.c"









volatile unsigned short quant_values_eeprom,
 last_value_eeprom;

char hour = 0,
 minute = 0,
 sec = 0,
 ms = 0;

void configTMR1(void){
 T1CON = 0x31;
 TMR1IF_bit = 0;
 TMR1H = 0x0B;
 TMR1L = 0xDC;
 TMR1IE_bit = 1;

 GIE_bit = 1;
 PEIE_bit = 1;
}

void interrupt(){
 if (TMR1IF_bit){
 TMR1IF_bit = 0;
 TMR1H = 0x0B;
 TMR1L = 0xDC;
 ms++;
 }
}

void updateValueEEPROM(void){
 quant_values_eeprom++;
 EEPROM_Write( 0x0000  + quant_values_eeprom,ADC_Read( RA0_bit ));
 EEPROM_Write( 0x0001 ,quant_values_eeprom);
}

void read24hValues(void){
  RD1_bit  = 1;
  RD2_bit  = 0;

 configTMR1();

 while(hour < 24){
 if(ms >= 4){
 ms = 0;
 sec++;
 }
 if(sec >= 60){
 sec = 0;
 minute++;
 }
 if(minute >= 60){
 minute = 0;
 hour++;
 updateValueEEPROM();
 }
 }

 EEPROM_Write( 0x0002 ,0x00);
}

void updatingEepromData(void){
 quant_values_eeprom = EEPROM_Read( 0x0001 );
 last_value_eeprom = EEPROM_Read( 0x001A );
}

void initializePic(void){
 TRISA = 0b11111111;
 TRISB = 0b00000000;
 TRISD = 0b11111001;
 PORTA = 0b00000000;
 PORTB = 0b00000000;

  RD2_bit  = 1;
  RD1_bit  = 0;

 ADC_Init();
 updatingEepromData();
}

void main(void){
 initializePic();

 Delay_1sec();

 if(EEPROM_Read( 0x0002 ))read24hValues();

 while(1){



 }
}
