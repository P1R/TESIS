#line 1 "C:/Users/p1r0/Desktop/Documents/GitHub/TESIS/Test-Servo-0.4/TestServo.c"
#line 1 "c:/users/p1r0/desktop/documents/github/tesis/test-servo-0.4/sensores.h"
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
#line 6 "C:/Users/p1r0/Desktop/Documents/GitHub/TESIS/Test-Servo-0.4/TestServo.c"
unsigned int current_duty, old_duty, i;
unsigned int pwm_period1;

void Conf_puertos(void)
{
 GPIO_Digital_Input(&GPIOA_BASE,_GPIO_PINMASK_2 | _GPIO_PINMASK_3);
}

void main() {

 float SRVA, SRVB, Ubr = 0.2;
 Conf_puertos();
 Foto_ADC_Init();
 current_duty =  3900 ;
 pwm_period1 = PWM_TIM2_Init(50);
 PWM_TIM2_Set_Duty(current_duty, _PWM_NON_INVERTED, _PWM_CHANNEL2);
 PWM_TIM2_Start(_PWM_CHANNEL2, &_GPIO_MODULE_TIM2_CH2_PA1);

 while (1){
 SRVA = fotoA();
 SRVB = fotoB();

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
