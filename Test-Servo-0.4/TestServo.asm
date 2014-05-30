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
SUB	SP, SP, #20
;TestServo.c,15 :: 		float SRVA, SRVB, Ubr = 0.1;
MOVW	R0, #52429
MOVT	R0, #15820
STR	R0, [SP, #8]
;TestServo.c,16 :: 		Conf_puertos();  //se configuran los puertos
BL	_Conf_puertos+0
;TestServo.c,18 :: 		current_duty = Cero;                        // initial value for current_duty
MOVW	R1, #3900
MOVW	R0, #lo_addr(_current_duty+0)
MOVT	R0, #hi_addr(_current_duty+0)
STR	R0, [SP, #16]
STRH	R1, [R0, #0]
;TestServo.c,19 :: 		pwm_period1 = PWM_TIM2_Init(50);
MOVS	R0, #50
BL	_PWM_TIM2_Init+0
MOVW	R1, #lo_addr(_pwm_period1+0)
MOVT	R1, #hi_addr(_pwm_period1+0)
STRH	R0, [R1, #0]
;TestServo.c,20 :: 		PWM_TIM2_Set_Duty(current_duty,  _PWM_NON_INVERTED, _PWM_CHANNEL2);
LDR	R0, [SP, #16]
LDRH	R0, [R0, #0]
MOVS	R2, #1
MOVS	R1, #0
BL	_PWM_TIM2_Set_Duty+0
;TestServo.c,21 :: 		PWM_TIM2_Start(_PWM_CHANNEL2, &_GPIO_MODULE_TIM2_CH2_PA1);
MOVW	R1, #lo_addr(__GPIO_MODULE_TIM2_CH2_PA1+0)
MOVT	R1, #hi_addr(__GPIO_MODULE_TIM2_CH2_PA1+0)
MOVS	R0, #1
BL	_PWM_TIM2_Start+0
;TestServo.c,23 :: 		while (1){
L_main0:
;TestServo.c,27 :: 		if(SRVA > SRVB && (SRVA-SRVB) > Ubr){
LDR	R2, [SP, #4]
LDR	R0, [SP, #0]
BL	__Compare_FP+0
MOVW	R0, #0
BLE	L__main30
MOVS	R0, #1
L__main30:
UXTB	R0, R0
CMP	R0, #0
IT	EQ
BEQ	L__main25
LDR	R2, [SP, #4]
LDR	R0, [SP, #0]
BL	__Sub_FP+0
LDR	R2, [SP, #8]
BL	__Compare_FP+0
MOVW	R0, #0
BLE	L__main31
MOVS	R0, #1
L__main31:
UXTB	R0, R0
CMP	R0, #0
IT	EQ
BEQ	L__main24
L__main23:
;TestServo.c,28 :: 		if(current_duty <= Min){
MOVW	R0, #lo_addr(_current_duty+0)
MOVT	R0, #hi_addr(_current_duty+0)
LDRH	R1, [R0, #0]
MOVW	R0, #1700
CMP	R1, R0
IT	HI
BHI	L_main5
;TestServo.c,29 :: 		current_duty = Min;
MOVW	R1, #1700
MOVW	R0, #lo_addr(_current_duty+0)
MOVT	R0, #hi_addr(_current_duty+0)
STRH	R1, [R0, #0]
;TestServo.c,30 :: 		goto Manten;
IT	AL
BAL	___main_Manten
;TestServo.c,31 :: 		}
L_main5:
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
;TestServo.c,34 :: 		current_duty = current_duty - 15;       // increment current_duty
MOVW	R1, #lo_addr(_current_duty+0)
MOVT	R1, #hi_addr(_current_duty+0)
LDRH	R0, [R1, #0]
SUBS	R0, #15
STRH	R0, [R1, #0]
;TestServo.c,35 :: 		PWM_TIM2_Set_Duty(current_duty,  _PWM_NON_INVERTED, _PWM_CHANNEL2); /// set newly acquired duty ratio
MOVS	R2, #1
MOVS	R1, #0
BL	_PWM_TIM2_Set_Duty+0
;TestServo.c,36 :: 		PWM_TIM2_Start(_PWM_CHANNEL2, &_GPIO_MODULE_TIM2_CH2_PA1); //agregamos que haga el cambio cada vez presionado el boton
MOVW	R1, #lo_addr(__GPIO_MODULE_TIM2_CH2_PA1+0)
MOVT	R1, #hi_addr(__GPIO_MODULE_TIM2_CH2_PA1+0)
MOVS	R0, #1
BL	_PWM_TIM2_Start+0
;TestServo.c,38 :: 		}
IT	AL
BAL	L_main9
;TestServo.c,27 :: 		if(SRVA > SRVB && (SRVA-SRVB) > Ubr){
L__main25:
L__main24:
;TestServo.c,40 :: 		else if(SRVA < SRVB && (SRVB-SRVA) > Ubr){
LDR	R2, [SP, #4]
LDR	R0, [SP, #0]
BL	__Compare_FP+0
MOVW	R0, #0
BGE	L__main32
MOVS	R0, #1
L__main32:
UXTB	R0, R0
CMP	R0, #0
IT	EQ
BEQ	L__main27
LDR	R2, [SP, #0]
LDR	R0, [SP, #4]
BL	__Sub_FP+0
LDR	R2, [SP, #8]
BL	__Compare_FP+0
MOVW	R0, #0
BLE	L__main33
MOVS	R0, #1
L__main33:
UXTB	R0, R0
CMP	R0, #0
IT	EQ
BEQ	L__main26
L__main22:
;TestServo.c,41 :: 		if(current_duty >= Max){
MOVW	R0, #lo_addr(_current_duty+0)
MOVT	R0, #hi_addr(_current_duty+0)
LDRH	R1, [R0, #0]
MOVW	R0, #6850
CMP	R1, R0
IT	CC
BCC	L_main13
;TestServo.c,42 :: 		current_duty = Max;
MOVW	R1, #6850
MOVW	R0, #lo_addr(_current_duty+0)
MOVT	R0, #hi_addr(_current_duty+0)
STRH	R1, [R0, #0]
;TestServo.c,43 :: 		goto Manten;
IT	AL
BAL	___main_Manten
;TestServo.c,44 :: 		}
L_main13:
;TestServo.c,46 :: 		Delay_ms(1);
MOVW	R7, #2665
MOVT	R7, #0
NOP
NOP
L_main15:
SUBS	R7, R7, #1
BNE	L_main15
NOP
NOP
;TestServo.c,47 :: 		current_duty = current_duty + 15;       // increment current_duty
MOVW	R1, #lo_addr(_current_duty+0)
MOVT	R1, #hi_addr(_current_duty+0)
LDRH	R0, [R1, #0]
ADDS	R0, #15
STRH	R0, [R1, #0]
;TestServo.c,48 :: 		PWM_TIM2_Set_Duty(current_duty,  _PWM_NON_INVERTED, _PWM_CHANNEL2); /// set newly acquired duty ratio
MOVS	R2, #1
MOVS	R1, #0
BL	_PWM_TIM2_Set_Duty+0
;TestServo.c,49 :: 		PWM_TIM2_Start(_PWM_CHANNEL2, &_GPIO_MODULE_TIM2_CH2_PA1); //agregamos que haga el cambio cada vez presionado el boton
MOVW	R1, #lo_addr(__GPIO_MODULE_TIM2_CH2_PA1+0)
MOVT	R1, #hi_addr(__GPIO_MODULE_TIM2_CH2_PA1+0)
MOVS	R0, #1
BL	_PWM_TIM2_Start+0
;TestServo.c,51 :: 		}
IT	AL
BAL	L_main17
;TestServo.c,40 :: 		else if(SRVA < SRVB && (SRVB-SRVA) > Ubr){
L__main27:
L__main26:
;TestServo.c,55 :: 		Manten:
___main_Manten:
;TestServo.c,56 :: 		Delay_ms(1);
MOVW	R7, #2665
MOVT	R7, #0
NOP
NOP
L_main18:
SUBS	R7, R7, #1
BNE	L_main18
NOP
NOP
;TestServo.c,57 :: 		PWM_TIM2_Set_Duty(current_duty,  _PWM_NON_INVERTED, _PWM_CHANNEL2);
MOVW	R0, #lo_addr(_current_duty+0)
MOVT	R0, #hi_addr(_current_duty+0)
LDRH	R0, [R0, #0]
MOVS	R2, #1
MOVS	R1, #0
BL	_PWM_TIM2_Set_Duty+0
;TestServo.c,58 :: 		PWM_TIM2_Start(_PWM_CHANNEL2, &_GPIO_MODULE_TIM2_CH2_PA1);
MOVW	R1, #lo_addr(__GPIO_MODULE_TIM2_CH2_PA1+0)
MOVT	R1, #hi_addr(__GPIO_MODULE_TIM2_CH2_PA1+0)
MOVS	R0, #1
BL	_PWM_TIM2_Start+0
;TestServo.c,59 :: 		}
L_main17:
L_main9:
;TestServo.c,60 :: 		Delay_ms(1);                 // slow down change pace a little
MOVW	R7, #2665
MOVT	R7, #0
NOP
NOP
L_main20:
SUBS	R7, R7, #1
BNE	L_main20
NOP
NOP
;TestServo.c,61 :: 		}
IT	AL
BAL	L_main0
;TestServo.c,62 :: 		}
L_end_main:
L__main_end_loop:
B	L__main_end_loop
; end of _main
