void initializePic(){
    TRISA = 0x11111111;
    TRISB = 0x11111110;
    PORTA = 0x00000000;
    PORTB = 0x00000000;
}

readValueResistor()

void main(){
    initializePic();
        
    while(1){
        readValueResistor(RESISTORPORT);
    }
}