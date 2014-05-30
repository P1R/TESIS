#line 1 "C:/Users/p1r0/Desktop/Documents/GitHub/TESIS/Test-Servo-0.3/TestServo.c"




unsigned int current_duty, old_duty, i;
unsigned int pwm_period1;

void Conf_puertos(void)
{
 GPIO_Digital_Input(&GPIOA_BASE,_GPIO_PINMASK_2 | _GPIO_PINMASK_3);
}

void main() {
 Conf_puertos();

 current_duty =  3900 ;
 pwm_period1 = PWM_TIM2_Init(50);
 PWM_TIM2_Set_Duty(current_duty, _PWM_NON_INVERTED, _PWM_CHANNEL2);
 PWM_TIM2_Start(_PWM_CHANNEL2, &_GPIO_MODULE_TIM2_CH2_PA1);

 while (1){

 if(GPIOA_IDR.B2 == 1 && GPIOA_IDR.B3 == 0){
 if(current_duty <=  1700 ){
 current_duty =  1700 ;
 PWM_TIM2_Set_Duty(current_duty, _PWM_NON_INVERTED, _PWM_CHANNEL2);
 PWM_TIM2_Start(_PWM_CHANNEL2, &_GPIO_MODULE_TIM2_CH2_PA1);
 }
 else{
 Delay_ms(1);
 current_duty = current_duty - 5;
 PWM_TIM2_Set_Duty(current_duty, _PWM_NON_INVERTED, _PWM_CHANNEL2);
 PWM_TIM2_Start(_PWM_CHANNEL2, &_GPIO_MODULE_TIM2_CH2_PA1);
 }
 }

 else if(GPIOA_IDR.B2 == 0 && GPIOA_IDR.B3 == 1){
 if(current_duty >=  6850 ){
 current_duty =  6850 ;
 PWM_TIM2_Set_Duty(current_duty, _PWM_NON_INVERTED, _PWM_CHANNEL2);
 PWM_TIM2_Start(_PWM_CHANNEL2, &_GPIO_MODULE_TIM2_CH2_PA1);
 }
 else{
 Delay_ms(1);
 current_duty = current_duty + 5;
 PWM_TIM2_Set_Duty(current_duty, _PWM_NON_INVERTED, _PWM_CHANNEL2);
 PWM_TIM2_Start(_PWM_CHANNEL2, &_GPIO_MODULE_TIM2_CH2_PA1);
 }
 }


 else{
 Delay_ms(1);
 current_duty =  3900 ;
 PWM_TIM2_Set_Duty(current_duty, _PWM_NON_INVERTED, _PWM_CHANNEL2);
 PWM_TIM2_Start(_PWM_CHANNEL2, &_GPIO_MODULE_TIM2_CH2_PA1);
 }
 Delay_ms(1);
 }
}
