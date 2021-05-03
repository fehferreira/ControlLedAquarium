#define RESISTOR_PORT RA0_bit

#define INITIAL_POSITION_EEPROM 0x0000
#define QUANT_VALUE_EEPROM      0x0001
#define READ_CONTROL_LED        0x0002
#define LAST_POSITION_EEPROM    0x001A
#define POWERON                 RD1_bit
#define POWEROFF                RD2_bit

volatile unsigned short quant_values_eeprom,
                        last_value_eeprom;

char hour   = 0,
     minute = 0,
     sec    = 0,
     ms     = 0;

void configTMR1(void){
    T1CON       = 0x31;
    TMR1IF_bit  = 0;
    TMR1H       = 0x0B;
    TMR1L       = 0xDC;
    TMR1IE_bit  = 1;
  
    GIE_bit     = 1;
    PEIE_bit    = 1;
}

void interrupt(){
    if (TMR1IF_bit){
        TMR1IF_bit  = 0;
        TMR1H       = 0x0B;
        TMR1L       = 0xDC;
        ms++;
    }
}

void updateValueEEPROM(void){
    quant_values_eeprom++;
    EEPROM_Write(INITIAL_POSITION_EEPROM + quant_values_eeprom,ADC_Read(RESISTOR_PORT));
    EEPROM_Write(QUANT_VALUE_EEPROM,quant_values_eeprom);
}

void read24hValues(void){
    POWERON = 1;
    POWEROFF = 0;

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
    
    EEPROM_Write(READ_CONTROL_LED,0x00);
}

void updatingEepromData(void){
    quant_values_eeprom = EEPROM_Read(QUANT_VALUE_EEPROM);
    last_value_eeprom   = EEPROM_Read(LAST_POSITION_EEPROM);
}

void initializePic(void){
    TRISA = 0b11111111;
    TRISB = 0b00000000;
    TRISD = 0b11111001;
    PORTA = 0b00000000;
    PORTB = 0b00000000;
    
    POWEROFF = 1;
    POWERON = 0;

    ADC_Init();
    updatingEepromData();
}

void main(void){
    initializePic();
    
    Delay_1sec();
    
    if(EEPROM_Read(READ_CONTROL_LED))read24hValues();
        
    while(1){



    }
}