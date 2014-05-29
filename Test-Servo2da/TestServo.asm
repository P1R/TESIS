_Conf_puertos:
;TestServo.c,17 :: 		void Conf_puertos(void)
SUB	SP, SP, #4
STR	LR, [SP, #0]
;TestServo.c,19 :: 		GPIO_Digital_Output(&GPIOB_BASE,_GPIO_PINMASK_10|_GPIO_PINMASK_11|_GPIO_PINMASK_12);
MOVW	R1, #7168
MOVW	R0, #lo_addr(GPIOB_BASE+0)
MOVT	R0, #hi_addr(GPIOB_BASE+0)
BL	_GPIO_Digital_Output+0
;TestServo.c,20 :: 		GPIO_Digital_Output(&GPIOB_BASE,_GPIO_PINMASK_13|_GPIO_PINMASK_14|_GPIO_PINMASK_15);
MOVW	R1, #57344
MOVW	R0, #lo_addr(GPIOB_BASE+0)
MOVT	R0, #hi_addr(GPIOB_BASE+0)
BL	_GPIO_Digital_Output+0
;TestServo.c,21 :: 		GPIO_Digital_Input(&GPIOA_BASE,_GPIO_PINMASK_0);
MOVW	R1, #1
MOVW	R0, #lo_addr(GPIOA_BASE+0)
MOVT	R0, #hi_addr(GPIOA_BASE+0)
BL	_GPIO_Digital_Input+0
;TestServo.c,22 :: 		GPIO_Digital_Output(&GPIOC_BASE,_GPIO_PINMASK_8);
MOVW	R1, #256
MOVW	R0, #lo_addr(GPIOC_BASE+0)
MOVT	R0, #hi_addr(GPIOC_BASE+0)
BL	_GPIO_Digital_Output+0
;TestServo.c,23 :: 		}
L_end_Conf_puertos:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _Conf_puertos
_main:
;TestServo.c,26 :: 		void main() {
SUB	SP, SP, #24
;TestServo.c,29 :: 		Conf_puertos();
BL	_Conf_puertos+0
;TestServo.c,30 :: 		Lcd_Init();
BL	_Lcd_Init+0
;TestServo.c,31 :: 		Lcd_Cmd(_LCD_CLEAR);
MOVS	R0, #1
BL	_Lcd_Cmd+0
;TestServo.c,32 :: 		Lcd_Cmd(_LCD_CURSOR_OFF);
MOVS	R0, #12
BL	_Lcd_Cmd+0
;TestServo.c,35 :: 		current_duty = 3900;                        // initial value for current_duty
MOVW	R1, #3900
MOVW	R0, #lo_addr(_current_duty+0)
MOVT	R0, #hi_addr(_current_duty+0)
STR	R0, [SP, #20]
STRH	R1, [R0, #0]
;TestServo.c,36 :: 		pwm_period1 = PWM_TIM2_Init(50);
MOVS	R0, #50
BL	_PWM_TIM2_Init+0
MOVW	R1, #lo_addr(_pwm_period1+0)
MOVT	R1, #hi_addr(_pwm_period1+0)
STRH	R0, [R1, #0]
;TestServo.c,37 :: 		PWM_TIM2_Set_Duty(current_duty,  _PWM_NON_INVERTED, _PWM_CHANNEL2);
LDR	R0, [SP, #20]
LDRH	R0, [R0, #0]
MOVS	R2, #1
MOVS	R1, #0
BL	_PWM_TIM2_Set_Duty+0
;TestServo.c,38 :: 		PWM_TIM2_Start(_PWM_CHANNEL2, &_GPIO_MODULE_TIM2_CH2_PA1);
MOVW	R1, #lo_addr(__GPIO_MODULE_TIM2_CH2_PA1+0)
MOVT	R1, #hi_addr(__GPIO_MODULE_TIM2_CH2_PA1+0)
MOVS	R0, #1
BL	_PWM_TIM2_Start+0
;TestServo.c,39 :: 		FloatToStr(pwm_period1,val);
ADD	R0, SP, #9
STR	R0, [SP, #20]
MOVW	R0, #lo_addr(_pwm_period1+0)
MOVT	R0, #hi_addr(_pwm_period1+0)
LDRH	R0, [R0, #0]
BL	__UnsignedIntegralToFloat+0
MOV	R1, R0
LDR	R0, [SP, #20]
STR	R1, [SP, #0]
MOV	R1, R0
LDR	R0, [SP, #0]
BL	_FloatToStr+0
;TestServo.c,40 :: 		FloatToStr(current_duty,val1);
ADD	R0, SP, #14
STR	R0, [SP, #20]
MOVW	R0, #lo_addr(_current_duty+0)
MOVT	R0, #hi_addr(_current_duty+0)
LDRH	R0, [R0, #0]
BL	__UnsignedIntegralToFloat+0
MOV	R1, R0
LDR	R0, [SP, #20]
STR	R1, [SP, #0]
MOV	R1, R0
LDR	R0, [SP, #0]
BL	_FloatToStr+0
;TestServo.c,41 :: 		Lcd_Out(1, 1, val);
ADD	R0, SP, #9
MOV	R2, R0
MOVS	R1, #1
MOVS	R0, #1
BL	_Lcd_Out+0
;TestServo.c,42 :: 		Lcd_Out(2, 3, val1);
ADD	R0, SP, #14
MOV	R2, R0
MOVS	R1, #3
MOVS	R0, #2
BL	_Lcd_Out+0
;TestServo.c,43 :: 		delay(0xFFFFF);
MOVW	R0, #65535
MOVT	R0, #15
BL	_delay+0
;TestServo.c,44 :: 		while (1){
L_main0:
;TestServo.c,47 :: 		if(current_duty <=6850){
MOVW	R0, #lo_addr(_current_duty+0)
MOVT	R0, #hi_addr(_current_duty+0)
LDRH	R1, [R0, #0]
MOVW	R0, #6850
CMP	R1, R0
IT	HI
BHI	L_main2
;TestServo.c,49 :: 		Delay_ms(1);
MOVW	R7, #2665
MOVT	R7, #0
NOP
NOP
L_main3:
SUBS	R7, R7, #1
BNE	L_main3
NOP
NOP
;TestServo.c,50 :: 		current_duty = current_duty - 15;       // increment current_duty
MOVW	R2, #lo_addr(_current_duty+0)
MOVT	R2, #hi_addr(_current_duty+0)
LDRH	R0, [R2, #0]
SUBW	R1, R0, #15
UXTH	R1, R1
STRH	R1, [R2, #0]
;TestServo.c,51 :: 		if (current_duty < 1700 ) {      // if we increase current_duty greater then possible pwm_period1 value
MOVW	R0, #1700
CMP	R1, R0
IT	CS
BCS	L_main5
;TestServo.c,52 :: 		current_duty = 6850;                    // reset current_duty value to zero
MOVW	R1, #6850
MOVW	R0, #lo_addr(_current_duty+0)
MOVT	R0, #hi_addr(_current_duty+0)
STRH	R1, [R0, #0]
;TestServo.c,53 :: 		}
L_main5:
;TestServo.c,54 :: 		PWM_TIM2_Set_Duty(current_duty,  _PWM_NON_INVERTED, _PWM_CHANNEL2); /// set newly acquired duty ratio
MOVW	R0, #lo_addr(_current_duty+0)
MOVT	R0, #hi_addr(_current_duty+0)
LDRH	R0, [R0, #0]
MOVS	R2, #1
MOVS	R1, #0
BL	_PWM_TIM2_Set_Duty+0
;TestServo.c,55 :: 		PWM_TIM2_Start(_PWM_CHANNEL2, &_GPIO_MODULE_TIM2_CH2_PA1); //agregamos que haga el cambio cada vez presionado el boton
MOVW	R1, #lo_addr(__GPIO_MODULE_TIM2_CH2_PA1+0)
MOVT	R1, #hi_addr(__GPIO_MODULE_TIM2_CH2_PA1+0)
MOVS	R0, #1
BL	_PWM_TIM2_Start+0
;TestServo.c,56 :: 		FloatToStr(current_duty,val1);
ADD	R0, SP, #4
STR	R0, [SP, #20]
MOVW	R0, #lo_addr(_current_duty+0)
MOVT	R0, #hi_addr(_current_duty+0)
LDRH	R0, [R0, #0]
BL	__UnsignedIntegralToFloat+0
MOV	R1, R0
LDR	R0, [SP, #20]
STR	R1, [SP, #0]
MOV	R1, R0
LDR	R0, [SP, #0]
BL	_FloatToStr+0
;TestServo.c,57 :: 		Lcd_Out(1, 1, val);
ADD	R0, SP, #9
MOV	R2, R0
MOVS	R1, #1
MOVS	R0, #1
BL	_Lcd_Out+0
;TestServo.c,58 :: 		Lcd_Out(2, 1, val1);
ADD	R0, SP, #4
MOV	R2, R0
MOVS	R1, #1
MOVS	R0, #2
BL	_Lcd_Out+0
;TestServo.c,60 :: 		Lcd_Cmd(_LCD_CLEAR);
MOVS	R0, #1
BL	_Lcd_Cmd+0
;TestServo.c,61 :: 		}
L_main2:
;TestServo.c,62 :: 		Delay_ms(1);                 // slow down change pace a little
MOVW	R7, #2665
MOVT	R7, #0
NOP
NOP
L_main6:
SUBS	R7, R7, #1
BNE	L_main6
NOP
NOP
;TestServo.c,63 :: 		}
IT	AL
BAL	L_main0
;TestServo.c,64 :: 		}
L_end_main:
L__main_end_loop:
B	L__main_end_loop
; end of _main
_delay:
;TestServo.c,66 :: 		void delay(unsigned long contador) // Función para generar retardo
;TestServo.c,68 :: 		while(--contador);
L_delay8:
SUBS	R1, R0, #1
MOV	R0, R1
CMP	R1, #0
IT	EQ
BEQ	L_delay9
IT	AL
BAL	L_delay8
L_delay9:
;TestServo.c,69 :: 		}
L_end_delay:
BX	LR
; end of _delay
