sbit LCD_RS at GPIOB_ODR.B10;
sbit LCD_EN at GPIOB_ODR.B11;
sbit LCD_D4 at GPIOB_ODR.B12;
sbit LCD_D5 at GPIOB_ODR.B13;
sbit LCD_D6 at GPIOB_ODR.B14;
sbit LCD_D7 at GPIOB_ODR.B15;

void delay(unsigned long contador);

void Config_ptos(void);
void Config_adc(void);

void Proceso(void);
void Proceso2(void);
//---------- LCD
void Lcd_Init();
void Lcd_Cmd();
void Lcd_Out();
//----------

unsigned int adc1_valueFR, adc2_valueFR;
const float R=722.8327228e-6;

void main() {
    Lcd_Init();
    Config_ptos();
    Config_adc();
    Lcd_Cmd(_LCD_CLEAR);               // Clear display
    Lcd_Out(1, 1, "9CM11-Volmetro");
    delay_ms(2000);
    Lcd_Cmd(_LCD_CLEAR);
    Lcd_Cmd(_LCD_CURSOR_OFF);
    while(1){
        Proceso();
        Proceso2();
    }
}

void Config_ptos(void){
    GPIO_Digital_Output(&GPIOB_BASE,_GPIO_PINMASK_10|_GPIO_PINMASK_11|_GPIO_PINMASK_12);
    GPIO_Digital_Output(&GPIOB_BASE,_GPIO_PINMASK_13|_GPIO_PINMASK_14|_GPIO_PINMASK_15);
    
    GPIO_Analog_input(&GPIOC_BASE,_GPIO_PINMASK_0| _GPIO_PINMASK_1); //PC0 = Canal 10 del ADC1
}
void Config_adc(void){
    ADC_Set_Input_Channel(_ADC_CHANNEL_10| _ADC_CHANNEL_11);
    ADC1_Init();
}

void Proceso(void){
    char val[10];
    float voltsFR1;
    adc1_valueFR = ADC1_Get_Sample(10);//valores para lectura directa en leds con anodo común
    voltsFR1 = R*adc1_valueFR;
    FloatToStr(voltsFR1,val);
    Lcd_Out(1, 1, val);
}

void Proceso2(void){
 char val2[10];
 float voltsFR2;
 adc2_valueFR = ADC1_Get_Sample(11);//valores para lectura directa en leds con anodo común
 voltsFR2 = R*adc2_valueFR;
 FloatToStr(voltsFR2,val2);
 Lcd_Out(2, 1, val2);
 delay(0xFFFFF);
 Lcd_Cmd(_LCD_CLEAR);
}

void delay(unsigned long contador) // Función para generar retardo
{
 while(--contador);
}