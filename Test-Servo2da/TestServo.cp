#line 1 "C:/Users/JorgeAlejandro/Documents/GitHub/TESIS/Test-Servo2da/TestServo.c"
sbit LCD_RS at GPIOB_ODR.B10;
sbit LCD_EN at GPIOB_ODR.B11;
sbit LCD_D4 at GPIOB_ODR.B12;
sbit LCD_D5 at GPIOB_ODR.B13;
sbit LCD_D6 at GPIOB_ODR.B14;
sbit LCD_D7 at GPIOB_ODR.B15;

void delay(unsigned long contador);
void Lcd_Init();
void Lcd_Cmd();
void Lcd_Out();

unsigned int current_duty, old_duty, i;
unsigned int pwm_period1;
sbit LAMPARA at GPIOC_ODRbits.B8;

void Conf_puertos(void)
{
 GPIO_Digital_Output(&GPIOB_BASE,_GPIO_PINMASK_10|_GPIO_PINMASK_11|_GPIO_PINMASK_12);
 GPIO_Digital_Output(&GPIOB_BASE,_GPIO_PINMASK_13|_GPIO_PINMASK_14|_GPIO_PINMASK_15);
 GPIO_Digital_Input(&GPIOA_BASE,_GPIO_PINMASK_0);
 GPIO_Digital_Output(&GPIOC_BASE,_GPIO_PINMASK_8);
}


void main() {
 char val[5];
 char val1[5];
 Conf_puertos();
 Lcd_Init();
 Lcd_Cmd(_LCD_CLEAR);
 Lcd_Cmd(_LCD_CURSOR_OFF);


 current_duty = 3900;
 pwm_period1 = PWM_TIM2_Init(50);
 PWM_TIM2_Set_Duty(current_duty, _PWM_NON_INVERTED, _PWM_CHANNEL2);
 PWM_TIM2_Start(_PWM_CHANNEL2, &_GPIO_MODULE_TIM2_CH2_PA1);
 FloatToStr(pwm_period1,val);
 FloatToStr(current_duty,val1);
 Lcd_Out(1, 1, val);
 Lcd_Out(2, 3, val1);
 delay(0xFFFFF);
 while (1){


 if(current_duty <=6850){
 char val1[5];
 Delay_ms(1);
 current_duty = current_duty - 15;
 if (current_duty < 1700 ) {
 current_duty = 6850;
 }
 PWM_TIM2_Set_Duty(current_duty, _PWM_NON_INVERTED, _PWM_CHANNEL2);
 PWM_TIM2_Start(_PWM_CHANNEL2, &_GPIO_MODULE_TIM2_CH2_PA1);
 FloatToStr(current_duty,val1);
 Lcd_Out(1, 1, val);
 Lcd_Out(2, 1, val1);

 Lcd_Cmd(_LCD_CLEAR);
 }
 Delay_ms(1);
 }
}

void delay(unsigned long contador)
{
 while(--contador);
}
