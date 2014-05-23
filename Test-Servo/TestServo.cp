#line 1 "C:/Users/p1r0/Desktop/Sistemas de tiempo real/ProyectoFinal/Test-Servo/TestServo.c"
unsigned int current_duty, old_duty, current_duty1, old_duty1;
unsigned int pwm_period1, pwm_period2;

void InitMain() {
 GPIO_Digital_Input (&GPIOA_BASE, _GPIO_PINMASK_3 | _GPIO_PINMASK_4 | _GPIO_PINMASK_5 | _GPIO_PINMASK_6);
}

void main() {
 InitMain();
 current_duty = 100;
 current_duty1 = 100;

 pwm_period1 = PWM_TIM1_Init(5000);
 pwm_period2 = PWM_TIM4_Init(5000);

 PWM_TIM1_Set_Duty(current_duty, _PWM_NON_INVERTED, _PWM_CHANNEL1);
 PWM_TIM4_Set_Duty(current_duty1, _PWM_NON_INVERTED, _PWM_CHANNEL2);

 PWM_TIM1_Start(_PWM_CHANNEL1, &_GPIO_MODULE_TIM1_CH1_PE9);
 PWM_TIM4_Start(_PWM_CHANNEL2, &_GPIO_MODULE_TIM4_CH2_PD13);

 while (1) {
 if (GPIOA_IDR.B3) {
 Delay_ms(1);
 current_duty = current_duty + 5;
 if (current_duty > pwm_period1) {
 current_duty = 0;
 }
 PWM_TIM1_Set_Duty(current_duty, _PWM_NON_INVERTED, _PWM_CHANNEL1);
 }

 if (GPIOA_IDR.B4) {
 Delay_ms(1);
 current_duty = current_duty - 5;
 if (current_duty > pwm_period1) {
 current_duty = pwm_period1;
 }
 PWM_TIM1_Set_Duty(current_duty, _PWM_NON_INVERTED, _PWM_CHANNEL1);
 }

 if (GPIOA_IDR.B5) {
 Delay_ms(1);
 current_duty1 = current_duty1 + 5;
 if (current_duty1 > pwm_period2) {
 current_duty1 = 0;
 }
 PWM_TIM4_Set_Duty(current_duty1, _PWM_NON_INVERTED, _PWM_CHANNEL2);
 }

 if (GPIOA_IDR.B6) {
 Delay_ms(1);
 current_duty1 = current_duty1 - 5;
 if (current_duty1 > pwm_period2) {
 current_duty1 = pwm_period2;
 }
 PWM_TIM4_Set_Duty(current_duty1, _PWM_NON_INVERTED, _PWM_CHANNEL2);
 }

 Delay_ms(1);
 }
}
