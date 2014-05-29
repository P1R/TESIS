#line 1 "C:/Users/JorgeAlejandro/Documents/GitHub/TESIS/Test-Sensores-0.2/Test-Sensores.c"
#line 1 "c:/users/jorgealejandro/documents/github/tesis/test-sensores-0.2/sensores.h"
unsigned int adc1_valueFR, adc2_valueFR;
const float R=722.8327228e-6;
void Foto_ADC_Init(void);
float FotoA(void);
float FotoB(void);


void Foto_ADC_Init(void){
 GPIO_Digital_Output(&GPIOB_BASE,_GPIO_PINMASK_10|_GPIO_PINMASK_11|_GPIO_PINMASK_12);
 GPIO_Digital_Output(&GPIOB_BASE,_GPIO_PINMASK_13|_GPIO_PINMASK_14|_GPIO_PINMASK_15);
 GPIO_Analog_input(&GPIOC_BASE,_GPIO_PINMASK_0| _GPIO_PINMASK_1);
 ADC_Set_Input_Channel(_ADC_CHANNEL_10| _ADC_CHANNEL_11);
 ADC1_Init();
}

float FotoA(void){
 char val[10];
 float voltsFR1;
 adc1_valueFR = ADC1_Get_Sample(10);
 voltsFR1 = R*adc1_valueFR;
 return voltsFR1;
}

float FotoB(void){
 char val2[10];
 float voltsFR2;
 adc2_valueFR = ADC1_Get_Sample(11);
 voltsFR2 = R*adc2_valueFR;
 return voltsFR2;
}
#line 2 "C:/Users/JorgeAlejandro/Documents/GitHub/TESIS/Test-Sensores-0.2/Test-Sensores.c"
sbit LCD_RS at GPIOB_ODR.B10;
sbit LCD_EN at GPIOB_ODR.B11;
sbit LCD_D4 at GPIOB_ODR.B12;
sbit LCD_D5 at GPIOB_ODR.B13;
sbit LCD_D6 at GPIOB_ODR.B14;
sbit LCD_D7 at GPIOB_ODR.B15;

void delay(unsigned long contador);
void Config_ptos(void);
void Proceso(void);
void Proceso2(void);

void Lcd_Init();
void Lcd_Cmd();
void Lcd_Out();


void main() {
 Lcd_Init();
 Foto_ADC_Init();
 Config_ptos();
 Lcd_Cmd(_LCD_CLEAR);
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
}

void Proceso(void){
 char val[10];
 float voltsFotoA;
 voltsFotoA = FotoA();
 FloatToStr(voltsFotoA,val);
 Lcd_Out(1, 1, val);
}

void Proceso2(void){
 char val2[10];
 float voltsFotoB;
 voltsFotoB = FotoB();
 FloatToStr(voltsFotoB,val2);
 Lcd_Out(2, 1, val2);
 delay(0xFFFFF);
 Lcd_Cmd(_LCD_CLEAR);
}

void delay(unsigned long contador)
{
 while(--contador);
}
