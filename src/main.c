#define RESISTOR_PORT RA0_bit

#define INITIAL_POSITION_EEPROM 0x0000
#define QUANT_VALUE_EEPROM      0x0001
#define READ_CONTROL_LED        0x0002
#define LAST_POSITION_EEPROM    0x001A

volatile unsigned short quant_values_eeprom,
                        last_value_eeprom,
                        read_control_led;

unsigned readValueResistor(char portRead){
    return ADC_Read(portRead);
}

void updatingEepromData(){
    quant_values_eeprom = EEPROM_Read(QUANT_VALUE_EEPROM);
    read_control_led    = EEPROM_Read(READ_CONTROL_LED);
    last_value_eeprom   = EEPROM_Read(LAST_POSITION_EEPROM);
}

void initializePic(){
    TRISA = 0x11111111;
    TRISB = 0x00000000;
    PORTA = 0x00000000;
    PORTB = 0x00000000;

    ADC_Init();
    updatingEepromData();
}

void main(){
    initializePic();
        
    while(1){

    }
}