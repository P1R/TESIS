#line 1 "C:/Users/p1r0/Desktop/Documents/GitHub/TESIS/Test-Servo/TestServo.c"
unsigned int current_duty, old_duty, i;
unsigned int pwm_period1;
sbit LAMPARA at GPIOC_ODRbits.B8;

void Conf_puertos(void)
{
 GPIO_Digital_Input(&GPIOA_BASE,_GPIO_PINMASK_0 | _GPIO_PINMASK_2);
 GPIO_Digital_Output(&GPIOC_BASE,_GPIO_PINMASK_8);
}


void main() {
 Conf_puertos();

 current_duty =700;
 pwm_period1 = PWM_TIM2_Init(50);
 PWM_TIM2_Set_Duty(current_duty, _PWM_NON_INVERTED, _PWM_CHANNEL2);
 PWM_TIM2_Start(_PWM_CHANNEL2, &_GPIO_MODULE_TIM2_CH2_PA1);

 while (1){
 if(GPIOA_IDR.B0){

 Delay_ms(1);
 current_duty = current_duty + 10;
 if(current_duty > pwm_period1) {
 current_duty = 666;
 }
 PWM_TIM2_Set_Duty(current_duty, _PWM_NON_INVERTED, _PWM_CHANNEL2);
 PWM_TIM2_Start(_PWM_CHANNEL2, &_GPIO_MODULE_TIM2_CH2_PA1);
 }
 else if(GPIOA_IDR.B2){
 Delay_ms(1);
 current_duty = current_duty - 10;
 if(current_duty < 700) {

 break;
 }
 PWM_TIM2_Set_Duty(current_duty, _PWM_NON_INVERTED, _PWM_CHANNEL2);
 PWM_TIM2_Start(_PWM_CHANNEL2, &_GPIO_MODULE_TIM2_CH2_PA1);
 }
 else
 Delay_ms(1);
 }
}
