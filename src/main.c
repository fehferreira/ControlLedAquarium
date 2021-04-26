#define RESISTOR_PORT RA0_bit

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
        PORTB = ADC_Read(RESISTOR_PORT);
    }
}