_Conf_puertos:
;TestServo.c,5 :: 		void Conf_puertos(void)
SUB	SP, SP, #4
STR	LR, [SP, #0]
;TestServo.c,7 :: 		GPIO_Digital_Input(&GPIOA_BASE,_GPIO_PINMASK_0);
MOVW	R1, #1
MOVW	R0, #lo_addr(GPIOA_BASE+0)
MOVT	R0, #hi_addr(GPIOA_BASE+0)
BL	_GPIO_Digital_Input+0
;TestServo.c,8 :: 		GPIO_Digital_Output(&GPIOC_BASE,_GPIO_PINMASK_8);
MOVW	R1, #256
MOVW	R0, #lo_addr(GPIOC_BASE+0)
MOVT	R0, #hi_addr(GPIOC_BASE+0)
BL	_GPIO_Digital_Output+0
;TestServo.c,9 :: 		}
L_end_Conf_puertos:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _Conf_puertos
_main:
;TestServo.c,12 :: 		void main() {
SUB	SP, SP, #4
;TestServo.c,13 :: 		Conf_puertos();
BL	_Conf_puertos+0
;TestServo.c,15 :: 		current_duty =8000;                        // initial value for current_duty
MOVW	R1, #8000
MOVW	R0, #lo_addr(_current_duty+0)
MOVT	R0, #hi_addr(_current_duty+0)
STR	R0, [SP, #0]
STRH	R1, [R0, #0]
;TestServo.c,16 :: 		pwm_period1 = PWM_TIM2_Init(50);
MOVS	R0, #50
BL	_PWM_TIM2_Init+0
MOVW	R1, #lo_addr(_pwm_period1+0)
MOVT	R1, #hi_addr(_pwm_period1+0)
STRH	R0, [R1, #0]
;TestServo.c,17 :: 		PWM_TIM2_Set_Duty(current_duty,  _PWM_NON_INVERTED, _PWM_CHANNEL2);
LDR	R0, [SP, #0]
LDRH	R0, [R0, #0]
MOVS	R2, #1
MOVS	R1, #0
BL	_PWM_TIM2_Set_Duty+0
;TestServo.c,18 :: 		PWM_TIM2_Start(_PWM_CHANNEL2, &_GPIO_MODULE_TIM2_CH2_PA1);
MOVW	R1, #lo_addr(__GPIO_MODULE_TIM2_CH2_PA1+0)
MOVT	R1, #hi_addr(__GPIO_MODULE_TIM2_CH2_PA1+0)
MOVS	R0, #1
BL	_PWM_TIM2_Start+0
;TestServo.c,20 :: 		while (1){
L_main0:
;TestServo.c,23 :: 		if(current_duty <=8000){
MOVW	R0, #lo_addr(_current_duty+0)
MOVT	R0, #hi_addr(_current_duty+0)
LDRH	R0, [R0, #0]
CMP	R0, #8000
IT	HI
BHI	L_main2
;TestServo.c,24 :: 		Delay_ms(1);
MOVW	R7, #2665
MOVT	R7, #0
NOP
NOP
L_main3:
SUBS	R7, R7, #1
BNE	L_main3
NOP
NOP
;TestServo.c,25 :: 		current_duty = current_duty - 10;       // increment current_duty
MOVW	R2, #lo_addr(_current_duty+0)
MOVT	R2, #hi_addr(_current_duty+0)
LDRH	R0, [R2, #0]
SUBW	R1, R0, #10
UXTH	R1, R1
STRH	R1, [R2, #0]
;TestServo.c,26 :: 		if (current_duty < 666) {      // if we increase current_duty greater then possible pwm_period1 value
MOVW	R0, #666
CMP	R1, R0
IT	CS
BCS	L_main5
;TestServo.c,27 :: 		current_duty = 8000;                    // reset current_duty value to zero
MOVW	R1, #8000
MOVW	R0, #lo_addr(_current_duty+0)
MOVT	R0, #hi_addr(_current_duty+0)
STRH	R1, [R0, #0]
;TestServo.c,28 :: 		}
L_main5:
;TestServo.c,29 :: 		PWM_TIM2_Set_Duty(current_duty,  _PWM_NON_INVERTED, _PWM_CHANNEL2); /// set newly acquired duty ratio
MOVW	R0, #lo_addr(_current_duty+0)
MOVT	R0, #hi_addr(_current_duty+0)
LDRH	R0, [R0, #0]
MOVS	R2, #1
MOVS	R1, #0
BL	_PWM_TIM2_Set_Duty+0
;TestServo.c,30 :: 		PWM_TIM2_Start(_PWM_CHANNEL2, &_GPIO_MODULE_TIM2_CH2_PA1); //agregamos que haga el cambio cada vez presionado el boton
MOVW	R1, #lo_addr(__GPIO_MODULE_TIM2_CH2_PA1+0)
MOVT	R1, #hi_addr(__GPIO_MODULE_TIM2_CH2_PA1+0)
MOVS	R0, #1
BL	_PWM_TIM2_Start+0
;TestServo.c,31 :: 		}
L_main2:
;TestServo.c,32 :: 		Delay_ms(1);                             // slow down change pace a little
MOVW	R7, #2665
MOVT	R7, #0
NOP
NOP
L_main6:
SUBS	R7, R7, #1
BNE	L_main6
NOP
NOP
;TestServo.c,33 :: 		}
IT	AL
BAL	L_main0
;TestServo.c,34 :: 		}
L_end_main:
L__main_end_loop:
B	L__main_end_loop
; end of _main
