#line 1 "C:/Users/Felipe-Oficina/Documents/Programa��o/MIKROC/automatizadorAquarioLedsFotosensor/src/main.c"
void initializePic(){
 TRISA = 0x11111111;
 TRISB = 0x11111110;
 PORTA = 0x00000000;
 PORTB = 0x00000000;
}
void main(){
 initializePic();

 while(1){
 Delay_100ms();
 RB0_bit = ~RB0_bit;
 }
}
