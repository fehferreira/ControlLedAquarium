#line 1 "C:/Users/Felipe-Oficina/Documents/Programa��o/MIKROC/automatizadorAquarioLedsFotosensor/src/main.c"







volatile unsigned short quant_values_eeprom,
 last_value_eeprom,
 read_control_led;

char hour = 0,
 minute = 0,
 sec = 0,
 ms = 0;

unsigned readValueResistor(char portRead){
 return ADC_Read(portRead);
}

void configTMR1(void){
 T1CON = 0x31;
 TMR1IF_bit = 0;
 TMR1H = 0x0B;
 TMR1L = 0xDC;
 TMR1IE_bit = 1;

 GIE_bit = 1;
 PEIE_bit = 1;
}

void resetTMR1(void){
 TMR1IF_bit = 0;
 TMR1H = 0x0B;
 TMR1L = 0xDC;
}

void interrupt(){
 if (TMR1IF_bit){
 resetTMR1();
 ms++;
 }
}

void read24hValues(void){
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

 }
 }
}

void updatingEepromData(void){
 quant_values_eeprom = EEPROM_Read( 0x0001 );
 read_control_led = EEPROM_Read( 0x0002 );
 last_value_eeprom = EEPROM_Read( 0x001A );

 if(read_control_led)
 return;

 read24hValues();
}

void initializePic(void){
 TRISA = 0x11111111;
 TRISB = 0x00000000;
 PORTA = 0x00000000;
 PORTB = 0x00000000;

 ADC_Init();
 updatingEepromData();
}

void main(void){
 initializePic();

 while(1){

 }
}
