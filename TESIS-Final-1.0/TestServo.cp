#line 1 "C:/Users/JorgeAlejandro/Documents/GitHub/TESIS/TESIS-Final-1.0/TestServo.c"
#line 1 "c:/users/jorgealejandro/documents/github/tesis/tesis-final-1.0/sensores.h"
unsigned int adc1_valueFR, adc2_valueFR, adc3_valueCFBV;
const float R=722.8327228e-6;
const float RCFBV=769.2307692e-6;
void Foto_ADC_Init(void);
float FotoA(void);
float FotoB(void);
float CFBV(void);


void Foto_ADC_Init(void){
 GPIO_Analog_input(&GPIOC_BASE,_GPIO_PINMASK_0| _GPIO_PINMASK_1 | _GPIO_PINMASK_1);
 ADC_Set_Input_Channel(_ADC_CHANNEL_10| _ADC_CHANNEL_11 | _ADC_CHANNEL_12);
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

float CFBV(void){
 char val3[10];
 float voltsCFBV;
 adc3_valueCFBV = ADC1_Get_Sample(12);
 voltsCFBV = RCFBV*adc2_valueFR;
 return voltsCFBV;
}
#line 1 "c:/users/jorgealejandro/documents/github/tesis/tesis-final-1.0/comunicacion.h"
void UART_Inti(void){
 UART1_Init(9600);
}

void Transmitir( float A){
 char CFBV[15];
 FloatToStr(A,CFBV);
 UART1_Write_Text(CFBV);
 UART1_Write(13);
 UART1_Write(10);
}
#line 7 "C:/Users/JorgeAlejandro/Documents/GitHub/TESIS/TESIS-Final-1.0/TestServo.c"
unsigned int current_duty, old_duty, i;
unsigned int pwm_period1;

void Conf_puertos(void)
{
 GPIO_Digital_Input(&GPIOA_BASE,_GPIO_PINMASK_2 | _GPIO_PINMASK_3);
}

void main() {

 float SRVA, SRVB, Ubr = 0.2, CFBV;
 Conf_puertos();
 Foto_ADC_Init();
 UART_Inti();
 current_duty =  3900 ;
 pwm_period1 = PWM_TIM2_Init(50);
 PWM_TIM2_Set_Duty(current_duty, _PWM_NON_INVERTED, _PWM_CHANNEL2);
 PWM_TIM2_Start(_PWM_CHANNEL2, &_GPIO_MODULE_TIM2_CH2_PA1);

 while (1){
 SRVA = fotoA();
 SRVB = fotoB();
 CFBV = CFBV();
 Transmitir(CFBV);

 if(SRVA > SRVB && (SRVA-SRVB) > Ubr){
 if(current_duty <=  1700 ){
 current_duty =  1700 ;
 goto Manten;
 }
 else{
 Delay_ms(1);
 current_duty = current_duty - 15;
 PWM_TIM2_Set_Duty(current_duty, _PWM_NON_INVERTED, _PWM_CHANNEL2);
 PWM_TIM2_Start(_PWM_CHANNEL2, &_GPIO_MODULE_TIM2_CH2_PA1);
 }
 }

 else if(SRVA < SRVB && (SRVB-SRVA) > Ubr){
 if(current_duty >=  6850 ){
 current_duty =  6850 ;
 goto Manten;
 }
 else{
 Delay_ms(1);
 current_duty = current_duty + 15;
 PWM_TIM2_Set_Duty(current_duty, _PWM_NON_INVERTED, _PWM_CHANNEL2);
 PWM_TIM2_Start(_PWM_CHANNEL2, &_GPIO_MODULE_TIM2_CH2_PA1);
 }
 }


 else{
 Manten:
 Delay_ms(1);
 PWM_TIM2_Set_Duty(current_duty, _PWM_NON_INVERTED, _PWM_CHANNEL2);
 PWM_TIM2_Start(_PWM_CHANNEL2, &_GPIO_MODULE_TIM2_CH2_PA1);
 }
 Delay_ms(1);
 }
}
