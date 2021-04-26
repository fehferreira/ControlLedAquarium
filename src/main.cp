#line 1 "C:/Users/Felipe-Oficina/Documents/Programação/MIKROC/automatizadorAquarioLedsFotosensor/src/main.c"







unsigned readValueResistor(unsigned short portReader){
 return ADC_Read(portReader);
}

void initializePic(){
 TRISA = 0x11111111;
 TRISB = 0x11111110;
 PORTA = 0x00000000;
 PORTB = 0x00000000;

 ADC_Init();
 Soft_UART_Init(&PORTB, 7 , 6 , 9600 , 0 );
}

void main(){
 unsigned value = 0;
 initializePic();

 while(1){
 Soft_UART_Write(readValueResistor( RB1_bit ));
 }
}
