_InitMain:
;TestServo.c,4 :: 		void InitMain() {
SUB	SP, SP, #4
STR	LR, [SP, #0]
;TestServo.c,5 :: 		GPIO_Digital_Input (&GPIOA_BASE, _GPIO_PINMASK_3 | _GPIO_PINMASK_4 | _GPIO_PINMASK_5 | _GPIO_PINMASK_6); // configure PORTA pins as input
MOVS	R1, #120
MOVW	R0, #lo_addr(GPIOA_BASE+0)
MOVT	R0, #hi_addr(GPIOA_BASE+0)
BL	_GPIO_Digital_Input+0
;TestServo.c,6 :: 		}
L_end_InitMain:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _InitMain
_main:
;TestServo.c,8 :: 		void main() {
SUB	SP, SP, #4
;TestServo.c,9 :: 		InitMain();
BL	_InitMain+0
;TestServo.c,10 :: 		current_duty  = 100;                        // initial value for current_duty
MOVS	R1, #100
MOVW	R0, #lo_addr(_current_duty+0)
MOVT	R0, #hi_addr(_current_duty+0)
STR	R0, [SP, #0]
STRH	R1, [R0, #0]
;TestServo.c,11 :: 		current_duty1 = 100;                        // initial value for current_duty1
MOVS	R1, #100
MOVW	R0, #lo_addr(_current_duty1+0)
MOVT	R0, #hi_addr(_current_duty1+0)
STRH	R1, [R0, #0]
;TestServo.c,13 :: 		pwm_period1 = PWM_TIM1_Init(5000);
MOVW	R0, #5000
BL	_PWM_TIM1_Init+0
MOVW	R1, #lo_addr(_pwm_period1+0)
MOVT	R1, #hi_addr(_pwm_period1+0)
STRH	R0, [R1, #0]
;TestServo.c,14 :: 		pwm_period2 = PWM_TIM4_Init(5000);
MOVW	R0, #5000
BL	_PWM_TIM4_Init+0
MOVW	R1, #lo_addr(_pwm_period2+0)
MOVT	R1, #hi_addr(_pwm_period2+0)
STRH	R0, [R1, #0]
;TestServo.c,16 :: 		PWM_TIM1_Set_Duty(current_duty,  _PWM_NON_INVERTED, _PWM_CHANNEL1);  // Set current duty for PWM_TIM1
LDR	R0, [SP, #0]
LDRH	R0, [R0, #0]
MOVS	R2, #0
MOVS	R1, #0
BL	_PWM_TIM1_Set_Duty+0
;TestServo.c,17 :: 		PWM_TIM4_Set_Duty(current_duty1, _PWM_NON_INVERTED, _PWM_CHANNEL2);  // Set current duty for PWM_TIM4
MOVW	R0, #lo_addr(_current_duty1+0)
MOVT	R0, #hi_addr(_current_duty1+0)
LDRH	R0, [R0, #0]
MOVS	R2, #1
MOVS	R1, #0
BL	_PWM_TIM4_Set_Duty+0
;TestServo.c,19 :: 		PWM_TIM1_Start(_PWM_CHANNEL1, &_GPIO_MODULE_TIM1_CH1_PE9);
MOVW	R1, #lo_addr(__GPIO_MODULE_TIM1_CH1_PE9+0)
MOVT	R1, #hi_addr(__GPIO_MODULE_TIM1_CH1_PE9+0)
MOVS	R0, #0
BL	_PWM_TIM1_Start+0
;TestServo.c,20 :: 		PWM_TIM4_Start(_PWM_CHANNEL2, &_GPIO_MODULE_TIM4_CH2_PD13);
MOVW	R1, #lo_addr(__GPIO_MODULE_TIM4_CH2_PD13+0)
MOVT	R1, #hi_addr(__GPIO_MODULE_TIM4_CH2_PD13+0)
MOVS	R0, #1
BL	_PWM_TIM4_Start+0
;TestServo.c,22 :: 		while (1) {                                // endless loop
L_main0:
;TestServo.c,23 :: 		if (GPIOA_IDR.B3) {                // button on RA3 pressed
MOVW	R1, #lo_addr(GPIOA_IDR+0)
MOVT	R1, #hi_addr(GPIOA_IDR+0)
LDR	R0, [R1, #0]
CMP	R0, #0
IT	EQ
BEQ	L_main2
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
;TestServo.c,25 :: 		current_duty = current_duty + 5;       // increment current_duty
MOVW	R2, #lo_addr(_current_duty+0)
MOVT	R2, #hi_addr(_current_duty+0)
LDRH	R0, [R2, #0]
ADDS	R1, R0, #5
UXTH	R1, R1
STRH	R1, [R2, #0]
;TestServo.c,26 :: 		if (current_duty > pwm_period1) {      // if we increase current_duty greater then possible pwm_period1 value
MOVW	R0, #lo_addr(_pwm_period1+0)
MOVT	R0, #hi_addr(_pwm_period1+0)
LDRH	R0, [R0, #0]
CMP	R1, R0
IT	LS
BLS	L_main5
;TestServo.c,27 :: 		current_duty = 0;                    // reset current_duty value to zero
MOVS	R1, #0
MOVW	R0, #lo_addr(_current_duty+0)
MOVT	R0, #hi_addr(_current_duty+0)
STRH	R1, [R0, #0]
;TestServo.c,28 :: 		}
L_main5:
;TestServo.c,29 :: 		PWM_TIM1_Set_Duty(current_duty,  _PWM_NON_INVERTED, _PWM_CHANNEL1); // set newly acquired duty ratio
MOVW	R0, #lo_addr(_current_duty+0)
MOVT	R0, #hi_addr(_current_duty+0)
LDRH	R0, [R0, #0]
MOVS	R2, #0
MOVS	R1, #0
BL	_PWM_TIM1_Set_Duty+0
;TestServo.c,30 :: 		}
L_main2:
;TestServo.c,32 :: 		if (GPIOA_IDR.B4) {                // button on RA4 pressed
MOVW	R1, #lo_addr(GPIOA_IDR+0)
MOVT	R1, #hi_addr(GPIOA_IDR+0)
LDR	R0, [R1, #0]
CMP	R0, #0
IT	EQ
BEQ	L_main6
;TestServo.c,33 :: 		Delay_ms(1);
MOVW	R7, #2665
MOVT	R7, #0
NOP
NOP
L_main7:
SUBS	R7, R7, #1
BNE	L_main7
NOP
NOP
;TestServo.c,34 :: 		current_duty = current_duty - 5;       // decrement current_duty
MOVW	R2, #lo_addr(_current_duty+0)
MOVT	R2, #hi_addr(_current_duty+0)
LDRH	R0, [R2, #0]
SUBS	R1, R0, #5
UXTH	R1, R1
STRH	R1, [R2, #0]
;TestServo.c,35 :: 		if (current_duty > pwm_period1) {      // if we decrease current_duty greater then possible pwm_period1 value (overflow)
MOVW	R0, #lo_addr(_pwm_period1+0)
MOVT	R0, #hi_addr(_pwm_period1+0)
LDRH	R0, [R0, #0]
CMP	R1, R0
IT	LS
BLS	L_main9
;TestServo.c,36 :: 		current_duty = pwm_period1;          // set current_duty to max possible value
MOVW	R0, #lo_addr(_pwm_period1+0)
MOVT	R0, #hi_addr(_pwm_period1+0)
LDRH	R1, [R0, #0]
MOVW	R0, #lo_addr(_current_duty+0)
MOVT	R0, #hi_addr(_current_duty+0)
STRH	R1, [R0, #0]
;TestServo.c,37 :: 		}
L_main9:
;TestServo.c,38 :: 		PWM_TIM1_Set_Duty(current_duty,  _PWM_NON_INVERTED, _PWM_CHANNEL1); // set newly acquired duty ratio
MOVW	R0, #lo_addr(_current_duty+0)
MOVT	R0, #hi_addr(_current_duty+0)
LDRH	R0, [R0, #0]
MOVS	R2, #0
MOVS	R1, #0
BL	_PWM_TIM1_Set_Duty+0
;TestServo.c,39 :: 		}
L_main6:
;TestServo.c,41 :: 		if (GPIOA_IDR.B5) {                // button on RA5 pressed
MOVW	R1, #lo_addr(GPIOA_IDR+0)
MOVT	R1, #hi_addr(GPIOA_IDR+0)
LDR	R0, [R1, #0]
CMP	R0, #0
IT	EQ
BEQ	L_main10
;TestServo.c,42 :: 		Delay_ms(1);
MOVW	R7, #2665
MOVT	R7, #0
NOP
NOP
L_main11:
SUBS	R7, R7, #1
BNE	L_main11
NOP
NOP
;TestServo.c,43 :: 		current_duty1 = current_duty1 + 5;     // increment current_duty
MOVW	R2, #lo_addr(_current_duty1+0)
MOVT	R2, #hi_addr(_current_duty1+0)
LDRH	R0, [R2, #0]
ADDS	R1, R0, #5
UXTH	R1, R1
STRH	R1, [R2, #0]
;TestServo.c,44 :: 		if (current_duty1 > pwm_period2) {     // if we increase current_duty1 greater then possible pwm_period2 value
MOVW	R0, #lo_addr(_pwm_period2+0)
MOVT	R0, #hi_addr(_pwm_period2+0)
LDRH	R0, [R0, #0]
CMP	R1, R0
IT	LS
BLS	L_main13
;TestServo.c,45 :: 		current_duty1 = 0;                   // reset current_duty1 value to zero
MOVS	R1, #0
MOVW	R0, #lo_addr(_current_duty1+0)
MOVT	R0, #hi_addr(_current_duty1+0)
STRH	R1, [R0, #0]
;TestServo.c,46 :: 		}
L_main13:
;TestServo.c,47 :: 		PWM_TIM4_Set_Duty(current_duty1, _PWM_NON_INVERTED, _PWM_CHANNEL2);       // set newly acquired duty ratio
MOVW	R0, #lo_addr(_current_duty1+0)
MOVT	R0, #hi_addr(_current_duty1+0)
LDRH	R0, [R0, #0]
MOVS	R2, #1
MOVS	R1, #0
BL	_PWM_TIM4_Set_Duty+0
;TestServo.c,48 :: 		}
L_main10:
;TestServo.c,50 :: 		if (GPIOA_IDR.B6) {                // button on RA6 pressed
MOVW	R1, #lo_addr(GPIOA_IDR+0)
MOVT	R1, #hi_addr(GPIOA_IDR+0)
LDR	R0, [R1, #0]
CMP	R0, #0
IT	EQ
BEQ	L_main14
;TestServo.c,51 :: 		Delay_ms(1);
MOVW	R7, #2665
MOVT	R7, #0
NOP
NOP
L_main15:
SUBS	R7, R7, #1
BNE	L_main15
NOP
NOP
;TestServo.c,52 :: 		current_duty1 = current_duty1 - 5;     // decrement current_duty
MOVW	R2, #lo_addr(_current_duty1+0)
MOVT	R2, #hi_addr(_current_duty1+0)
LDRH	R0, [R2, #0]
SUBS	R1, R0, #5
UXTH	R1, R1
STRH	R1, [R2, #0]
;TestServo.c,53 :: 		if (current_duty1 > pwm_period2) {     // if we decrease current_duty1 greater then possible pwm_period1 value (overflow)
MOVW	R0, #lo_addr(_pwm_period2+0)
MOVT	R0, #hi_addr(_pwm_period2+0)
LDRH	R0, [R0, #0]
CMP	R1, R0
IT	LS
BLS	L_main17
;TestServo.c,54 :: 		current_duty1 = pwm_period2;         // set current_duty to max possible value
MOVW	R0, #lo_addr(_pwm_period2+0)
MOVT	R0, #hi_addr(_pwm_period2+0)
LDRH	R1, [R0, #0]
MOVW	R0, #lo_addr(_current_duty1+0)
MOVT	R0, #hi_addr(_current_duty1+0)
STRH	R1, [R0, #0]
;TestServo.c,55 :: 		}
L_main17:
;TestServo.c,56 :: 		PWM_TIM4_Set_Duty(current_duty1, _PWM_NON_INVERTED, _PWM_CHANNEL2);
MOVW	R0, #lo_addr(_current_duty1+0)
MOVT	R0, #hi_addr(_current_duty1+0)
LDRH	R0, [R0, #0]
MOVS	R2, #1
MOVS	R1, #0
BL	_PWM_TIM4_Set_Duty+0
;TestServo.c,57 :: 		}
L_main14:
;TestServo.c,59 :: 		Delay_ms(1);                             // slow down change pace a little
MOVW	R7, #2665
MOVT	R7, #0
NOP
NOP
L_main18:
SUBS	R7, R7, #1
BNE	L_main18
NOP
NOP
;TestServo.c,60 :: 		}
IT	AL
BAL	L_main0
;TestServo.c,61 :: 		}
L_end_main:
L__main_end_loop:
B	L__main_end_loop
; end of _main
