#define RESISTORPORT RB1_bit;

void initializePic(){
    TRISA = 0x11111111;
    TRISB = 0x11111110;
    PORTA = 0x00000000;
    PORTB = 0x00000000;
}

unsigned readValueResistor(unsigned short portReader){
    return ADC_Read(portReader);
}

void main(){
    initializePic();
        
    while(1){
        readValueResistor(RESISTORPORT);
    }
}