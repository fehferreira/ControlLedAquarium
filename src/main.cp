#line 1 "C:/Users/Felipe-Oficina/Documents/Programação/MIKROC/automatizadorAquarioLedsFotosensor/src/main.c"


void initializePic(){
 TRISA = 0x11111111;
 TRISB = 0x00000000;
 PORTA = 0x00000000;
 PORTB = 0x00000000;

 ADC_Init();
}

void main(){
 initializePic();

 while(1){
 PORTB = ADC_Read( RA0_bit );
 }
}
