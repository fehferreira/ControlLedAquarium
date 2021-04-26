#define RESISTOR_PORT RB1_bit;

#define RX_PIN 7;
#define TX_PIN 6;
#define USART_BAUDRATE 9600;
#define INVERT_FLAG 0;

unsigned readValueResistor(unsigned short portReader){
    return ADC_Read(portReader);
}

void initializePic(){
    TRISA = 0x11111111;
    TRISB = 0x11111110;
    PORTA = 0x00000000;
    PORTB = 0x00000000;

    ADC_Init();
    Soft_UART_Init(&PORTB,RX_PIN,TX_PIN,USART_BAUDRATE,INVERT_FLAG);
}

void main(){
    unsigned value = 0;
    initializePic();
        
    while(1){
        value = readValueResistor(RESISTOR_PORT);
        Soft_UART_Write(value);
    }
}