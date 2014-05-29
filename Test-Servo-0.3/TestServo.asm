_Conf_puertos:
;TestServo.c,8 :: 		void Conf_puertos(void)
SUB	SP, SP, #4
STR	LR, [SP, #0]
;TestServo.c,10 :: 		GPIO_Digital_Input(&GPIOA_BASE,_GPIO_PINMASK_2 | _GPIO_PINMASK_3);
MOVS	R1, #12
MOVW	R0, #lo_addr(GPIOA_BASE+0)
MOVT	R0, #hi_addr(GPIOA_BASE+0)
BL	_GPIO_Digital_Input+0
;TestServo.c,11 :: 		}
L_end_Conf_puertos:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _Conf_puertos
_main:
;TestServo.c,13 :: 		void main() {
SUB	SP, SP, #4
;TestServo.c,14 :: 		Conf_puertos();
BL	_Conf_puertos+0
;TestServo.c,16 :: 		current_duty = Cero;                        // initial value for current_duty
MOVW	R1, #3900
MOVW	R0, #lo_addr(_current_duty+0)
MOVT	R0, #hi_addr(_current_duty+0)
STR	R0, [SP, #0]
STRH	R1, [R0, #0]
;TestServo.c,17 :: 		pwm_period1 = PWM_TIM2_Init(50);
MOVS	R0, #50
BL	_PWM_TIM2_Init+0
MOVW	R1, #lo_addr(_pwm_period1+0)
MOVT	R1, #hi_addr(_pwm_period1+0)
STRH	R0, [R1, #0]
;TestServo.c,18 :: 		PWM_TIM2_Set_Duty(current_duty,  _PWM_NON_INVERTED, _PWM_CHANNEL2);
LDR	R0, [SP, #0]
LDRH	R0, [R0, #0]
MOVS	R2, #1
MOVS	R1, #0
BL	_PWM_TIM2_Set_Duty+0
;TestServo.c,19 :: 		PWM_TIM2_Start(_PWM_CHANNEL2, &_GPIO_MODULE_TIM2_CH2_PA1);
MOVW	R1, #lo_addr(__GPIO_MODULE_TIM2_CH2_PA1+0)
MOVT	R1, #hi_addr(__GPIO_MODULE_TIM2_CH2_PA1+0)
MOVS	R0, #1
BL	_PWM_TIM2_Start+0
;TestServo.c,21 :: 		while (1){
L_main0:
;TestServo.c,23 :: 		if(GPIOA_IDR.B2 == 1 && GPIOA_IDR.B3 == 0){
MOVW	R1, #lo_addr(GPIOA_IDR+0)
MOVT	R1, #hi_addr(GPIOA_IDR+0)
LDR	R0, [R1, #0]
CMP	R0, #0
IT	EQ
BEQ	L__main25
MOVW	R1, #lo_addr(GPIOA_IDR+0)
MOVT	R1, #hi_addr(GPIOA_IDR+0)
LDR	R0, [R1, #0]
CMP	R0, #0
IT	NE
BNE	L__main24
L__main23:
;TestServo.c,24 :: 		if(current_duty <= Min){
MOVW	R0, #lo_addr(_current_duty+0)
MOVT	R0, #hi_addr(_current_duty+0)
LDRH	R1, [R0, #0]
MOVW	R0, #1700
CMP	R1, R0
IT	HI
BHI	L_main5
;TestServo.c,25 :: 		current_duty = Min;
MOVW	R1, #1700
MOVW	R0, #lo_addr(_current_duty+0)
MOVT	R0, #hi_addr(_current_duty+0)
STRH	R1, [R0, #0]
;TestServo.c,26 :: 		PWM_TIM2_Set_Duty(current_duty,  _PWM_NON_INVERTED, _PWM_CHANNEL2);
MOVW	R0, #1700
MOVS	R2, #1
MOVS	R1, #0
BL	_PWM_TIM2_Set_Duty+0
;TestServo.c,27 :: 		PWM_TIM2_Start(_PWM_CHANNEL2, &_GPIO_MODULE_TIM2_CH2_PA1);
MOVW	R1, #lo_addr(__GPIO_MODULE_TIM2_CH2_PA1+0)
MOVT	R1, #hi_addr(__GPIO_MODULE_TIM2_CH2_PA1+0)
MOVS	R0, #1
BL	_PWM_TIM2_Start+0
;TestServo.c,28 :: 		}
IT	AL
BAL	L_main6
L_main5:
;TestServo.c,30 :: 		Delay_ms(1);
MOVW	R7, #2665
MOVT	R7, #0
NOP
NOP
L_main7:
SUBS	R7, R7, #1
BNE	L_main7
NOP
NOP
;TestServo.c,31 :: 		current_duty = current_duty - 15;       // increment current_duty
MOVW	R1, #lo_addr(_current_duty+0)
MOVT	R1, #hi_addr(_current_duty+0)
LDRH	R0, [R1, #0]
SUBS	R0, #15
STRH	R0, [R1, #0]
;TestServo.c,32 :: 		PWM_TIM2_Set_Duty(current_duty,  _PWM_NON_INVERTED, _PWM_CHANNEL2); /// set newly acquired duty ratio
MOVS	R2, #1
MOVS	R1, #0
BL	_PWM_TIM2_Set_Duty+0
;TestServo.c,33 :: 		PWM_TIM2_Start(_PWM_CHANNEL2, &_GPIO_MODULE_TIM2_CH2_PA1); //agregamos que haga el cambio cada vez presionado el boton
MOVW	R1, #lo_addr(__GPIO_MODULE_TIM2_CH2_PA1+0)
MOVT	R1, #hi_addr(__GPIO_MODULE_TIM2_CH2_PA1+0)
MOVS	R0, #1
BL	_PWM_TIM2_Start+0
;TestServo.c,34 :: 		}
L_main6:
;TestServo.c,35 :: 		}
IT	AL
BAL	L_main9
;TestServo.c,23 :: 		if(GPIOA_IDR.B2 == 1 && GPIOA_IDR.B3 == 0){
L__main25:
L__main24:
;TestServo.c,37 :: 		else if(GPIOA_IDR.B2 == 0 && GPIOA_IDR.B3 == 1){
MOVW	R1, #lo_addr(GPIOA_IDR+0)
MOVT	R1, #hi_addr(GPIOA_IDR+0)
LDR	R0, [R1, #0]
CMP	R0, #0
IT	NE
BNE	L__main27
MOVW	R1, #lo_addr(GPIOA_IDR+0)
MOVT	R1, #hi_addr(GPIOA_IDR+0)
LDR	R0, [R1, #0]
CMP	R0, #0
IT	EQ
BEQ	L__main26
L__main22:
;TestServo.c,38 :: 		if(current_duty >= Max){
MOVW	R0, #lo_addr(_current_duty+0)
MOVT	R0, #hi_addr(_current_duty+0)
LDRH	R1, [R0, #0]
MOVW	R0, #6850
CMP	R1, R0
IT	CC
BCC	L_main13
;TestServo.c,39 :: 		current_duty = Max;
MOVW	R1, #6850
MOVW	R0, #lo_addr(_current_duty+0)
MOVT	R0, #hi_addr(_current_duty+0)
STRH	R1, [R0, #0]
;TestServo.c,40 :: 		PWM_TIM2_Set_Duty(current_duty,  _PWM_NON_INVERTED, _PWM_CHANNEL2);
MOVW	R0, #6850
MOVS	R2, #1
MOVS	R1, #0
BL	_PWM_TIM2_Set_Duty+0
;TestServo.c,41 :: 		PWM_TIM2_Start(_PWM_CHANNEL2, &_GPIO_MODULE_TIM2_CH2_PA1);
MOVW	R1, #lo_addr(__GPIO_MODULE_TIM2_CH2_PA1+0)
MOVT	R1, #hi_addr(__GPIO_MODULE_TIM2_CH2_PA1+0)
MOVS	R0, #1
BL	_PWM_TIM2_Start+0
;TestServo.c,42 :: 		}
IT	AL
BAL	L_main14
L_main13:
;TestServo.c,44 :: 		Delay_ms(1);
MOVW	R7, #2665
MOVT	R7, #0
NOP
NOP
L_main15:
SUBS	R7, R7, #1
BNE	L_main15
NOP
NOP
;TestServo.c,45 :: 		current_duty = current_duty + 15;       // increment current_duty
MOVW	R1, #lo_addr(_current_duty+0)
MOVT	R1, #hi_addr(_current_duty+0)
LDRH	R0, [R1, #0]
ADDS	R0, #15
STRH	R0, [R1, #0]
;TestServo.c,46 :: 		PWM_TIM2_Set_Duty(current_duty,  _PWM_NON_INVERTED, _PWM_CHANNEL2); /// set newly acquired duty ratio
MOVS	R2, #1
MOVS	R1, #0
BL	_PWM_TIM2_Set_Duty+0
;TestServo.c,47 :: 		PWM_TIM2_Start(_PWM_CHANNEL2, &_GPIO_MODULE_TIM2_CH2_PA1); //agregamos que haga el cambio cada vez presionado el boton
MOVW	R1, #lo_addr(__GPIO_MODULE_TIM2_CH2_PA1+0)
MOVT	R1, #hi_addr(__GPIO_MODULE_TIM2_CH2_PA1+0)
MOVS	R0, #1
BL	_PWM_TIM2_Start+0
;TestServo.c,48 :: 		}
L_main14:
;TestServo.c,49 :: 		}
IT	AL
BAL	L_main17
;TestServo.c,37 :: 		else if(GPIOA_IDR.B2 == 0 && GPIOA_IDR.B3 == 1){
L__main27:
L__main26:
;TestServo.c,53 :: 		Delay_ms(1);
MOVW	R7, #2665
MOVT	R7, #0
NOP
NOP
L_main18:
SUBS	R7, R7, #1
BNE	L_main18
NOP
NOP
;TestServo.c,54 :: 		current_duty = Cero;                        // initial value for current_duty
MOVW	R1, #3900
MOVW	R0, #lo_addr(_current_duty+0)
MOVT	R0, #hi_addr(_current_duty+0)
STRH	R1, [R0, #0]
;TestServo.c,55 :: 		PWM_TIM2_Set_Duty(current_duty,  _PWM_NON_INVERTED, _PWM_CHANNEL2);
MOVW	R0, #3900
MOVS	R2, #1
MOVS	R1, #0
BL	_PWM_TIM2_Set_Duty+0
;TestServo.c,56 :: 		PWM_TIM2_Start(_PWM_CHANNEL2, &_GPIO_MODULE_TIM2_CH2_PA1);
MOVW	R1, #lo_addr(__GPIO_MODULE_TIM2_CH2_PA1+0)
MOVT	R1, #hi_addr(__GPIO_MODULE_TIM2_CH2_PA1+0)
MOVS	R0, #1
BL	_PWM_TIM2_Start+0
;TestServo.c,57 :: 		}
L_main17:
L_main9:
;TestServo.c,58 :: 		Delay_ms(1);                 // slow down change pace a little
MOVW	R7, #2665
MOVT	R7, #0
NOP
NOP
L_main20:
SUBS	R7, R7, #1
BNE	L_main20
NOP
NOP
;TestServo.c,59 :: 		}
IT	AL
BAL	L_main0
;TestServo.c,60 :: 		}
L_end_main:
L__main_end_loop:
B	L__main_end_loop
; end of _main
