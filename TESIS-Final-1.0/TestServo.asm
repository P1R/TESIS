_Foto_ADC_Init:
;sensores.h,10 :: 		void Foto_ADC_Init(void){
SUB	SP, SP, #4
STR	LR, [SP, #0]
;sensores.h,11 :: 		GPIO_Analog_input(&GPIOC_BASE,_GPIO_PINMASK_0| _GPIO_PINMASK_1 | _GPIO_PINMASK_1); //PC0 = Canal 10 del ADC1
MOVS	R1, #3
MOVW	R0, #lo_addr(GPIOC_BASE+0)
MOVT	R0, #hi_addr(GPIOC_BASE+0)
BL	_GPIO_Analog_Input+0
;sensores.h,12 :: 		ADC_Set_Input_Channel(_ADC_CHANNEL_10| _ADC_CHANNEL_11 | _ADC_CHANNEL_12);
MOVW	R0, #7168
BL	_ADC_Set_Input_Channel+0
;sensores.h,13 :: 		ADC1_Init();
BL	_ADC1_Init+0
;sensores.h,14 :: 		}
L_end_Foto_ADC_Init:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _Foto_ADC_Init
_FotoA:
;sensores.h,16 :: 		float FotoA(void){
SUB	SP, SP, #4
STR	LR, [SP, #0]
;sensores.h,19 :: 		adc1_valueFR = ADC1_Get_Sample(10);
MOVS	R0, #10
BL	_ADC1_Get_Sample+0
MOVW	R1, #lo_addr(_adc1_valueFR+0)
MOVT	R1, #hi_addr(_adc1_valueFR+0)
STRH	R0, [R1, #0]
;sensores.h,20 :: 		voltsFR1 = R*adc1_valueFR;
BL	__UnsignedIntegralToFloat+0
MOVW	R2, #31868
MOVT	R2, #14909
BL	__Mul_FP+0
;sensores.h,21 :: 		return voltsFR1;
;sensores.h,22 :: 		}
L_end_FotoA:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _FotoA
_FotoB:
;sensores.h,24 :: 		float FotoB(void){
SUB	SP, SP, #4
STR	LR, [SP, #0]
;sensores.h,27 :: 		adc2_valueFR = ADC1_Get_Sample(11);
MOVS	R0, #11
BL	_ADC1_Get_Sample+0
MOVW	R1, #lo_addr(_adc2_valueFR+0)
MOVT	R1, #hi_addr(_adc2_valueFR+0)
STRH	R0, [R1, #0]
;sensores.h,28 :: 		voltsFR2 = R*adc2_valueFR;
BL	__UnsignedIntegralToFloat+0
MOVW	R2, #31868
MOVT	R2, #14909
BL	__Mul_FP+0
;sensores.h,29 :: 		return voltsFR2;
;sensores.h,30 :: 		}
L_end_FotoB:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _FotoB
_CFBV:
;sensores.h,32 :: 		float CFBV(void){
SUB	SP, SP, #4
STR	LR, [SP, #0]
;sensores.h,35 :: 		adc3_valueCFBV = ADC1_Get_Sample(12);
MOVS	R0, #12
BL	_ADC1_Get_Sample+0
MOVW	R1, #lo_addr(_adc3_valueCFBV+0)
MOVT	R1, #hi_addr(_adc3_valueCFBV+0)
STRH	R0, [R1, #0]
;sensores.h,36 :: 		voltsCFBV = RCFBV*adc2_valueFR;
MOVW	R0, #lo_addr(_adc2_valueFR+0)
MOVT	R0, #hi_addr(_adc2_valueFR+0)
LDRH	R0, [R0, #0]
BL	__UnsignedIntegralToFloat+0
MOVW	R2, #42548
MOVT	R2, #14921
BL	__Mul_FP+0
;sensores.h,37 :: 		return voltsCFBV;
;sensores.h,38 :: 		}
L_end_CFBV:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _CFBV
_UART_Inti:
;comunicacion.h,1 :: 		void UART_Inti(void){
SUB	SP, SP, #4
STR	LR, [SP, #0]
;comunicacion.h,2 :: 		UART1_Init(9600);
MOVW	R0, #9600
BL	_UART1_Init+0
;comunicacion.h,3 :: 		}
L_end_UART_Inti:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _UART_Inti
_Transmitir:
;comunicacion.h,5 :: 		void Transmitir( float A){
SUB	SP, SP, #20
STR	LR, [SP, #0]
;comunicacion.h,7 :: 		FloatToStr(A,CFBV);
ADD	R1, SP, #4
BL	_FloatToStr+0
;comunicacion.h,8 :: 		UART1_Write_Text(CFBV);
ADD	R1, SP, #4
MOV	R0, R1
BL	_UART1_Write_Text+0
;comunicacion.h,9 :: 		UART1_Write(13);
MOVS	R0, #13
BL	_UART1_Write+0
;comunicacion.h,10 :: 		UART1_Write(10);
MOVS	R0, #10
BL	_UART1_Write+0
;comunicacion.h,11 :: 		}
L_end_Transmitir:
LDR	LR, [SP, #0]
ADD	SP, SP, #20
BX	LR
; end of _Transmitir
_Conf_puertos:
;TestServo.c,10 :: 		void Conf_puertos(void)
SUB	SP, SP, #4
STR	LR, [SP, #0]
;TestServo.c,12 :: 		GPIO_Digital_Input(&GPIOA_BASE,_GPIO_PINMASK_2 | _GPIO_PINMASK_3);
MOVS	R1, #12
MOVW	R0, #lo_addr(GPIOA_BASE+0)
MOVT	R0, #hi_addr(GPIOA_BASE+0)
BL	_GPIO_Digital_Input+0
;TestServo.c,13 :: 		}
L_end_Conf_puertos:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _Conf_puertos
_main:
;TestServo.c,15 :: 		void main() {
SUB	SP, SP, #20
;TestServo.c,17 :: 		float SRVA, SRVB, Ubr = 0.2, CFBV;
MOVW	R0, #52429
MOVT	R0, #15948
STR	R0, [SP, #8]
;TestServo.c,18 :: 		Conf_puertos();  //se configuran los puertos
BL	_Conf_puertos+0
;TestServo.c,19 :: 		Foto_ADC_Init();
BL	_Foto_ADC_Init+0
;TestServo.c,20 :: 		UART_Inti();
BL	_UART_Inti+0
;TestServo.c,21 :: 		current_duty = Cero;                        // initial value for current_duty
MOVW	R1, #3900
MOVW	R0, #lo_addr(_current_duty+0)
MOVT	R0, #hi_addr(_current_duty+0)
STR	R0, [SP, #16]
STRH	R1, [R0, #0]
;TestServo.c,22 :: 		pwm_period1 = PWM_TIM2_Init(50);
MOVS	R0, #50
BL	_PWM_TIM2_Init+0
MOVW	R1, #lo_addr(_pwm_period1+0)
MOVT	R1, #hi_addr(_pwm_period1+0)
STRH	R0, [R1, #0]
;TestServo.c,23 :: 		PWM_TIM2_Set_Duty(current_duty,  _PWM_NON_INVERTED, _PWM_CHANNEL2);
LDR	R0, [SP, #16]
LDRH	R0, [R0, #0]
MOVS	R2, #1
MOVS	R1, #0
BL	_PWM_TIM2_Set_Duty+0
;TestServo.c,24 :: 		PWM_TIM2_Start(_PWM_CHANNEL2, &_GPIO_MODULE_TIM2_CH2_PA1);
MOVW	R1, #lo_addr(__GPIO_MODULE_TIM2_CH2_PA1+0)
MOVT	R1, #hi_addr(__GPIO_MODULE_TIM2_CH2_PA1+0)
MOVS	R0, #1
BL	_PWM_TIM2_Start+0
;TestServo.c,26 :: 		while (1){
L_main0:
;TestServo.c,27 :: 		SRVA = fotoA(); //PC0 lectura de ADC
BL	_FotoA+0
STR	R0, [SP, #0]
;TestServo.c,28 :: 		SRVB = fotoB(); //PC1 lectura de ADC
BL	_FotoB+0
STR	R0, [SP, #4]
;TestServo.c,29 :: 		CFBV = CFBV();  //PC2 Lectura de ADC
BL	_CFBV+0
;TestServo.c,30 :: 		Transmitir(CFBV);
BL	_Transmitir+0
;TestServo.c,32 :: 		if(SRVA > SRVB && (SRVA-SRVB) > Ubr){
LDR	R2, [SP, #4]
LDR	R0, [SP, #0]
BL	__Compare_FP+0
MOVW	R0, #0
BLE	L__main36
MOVS	R0, #1
L__main36:
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
BLE	L__main37
MOVS	R0, #1
L__main37:
UXTB	R0, R0
CMP	R0, #0
IT	EQ
BEQ	L__main24
L__main23:
;TestServo.c,33 :: 		if(current_duty <= Min){
MOVW	R0, #lo_addr(_current_duty+0)
MOVT	R0, #hi_addr(_current_duty+0)
LDRH	R1, [R0, #0]
MOVW	R0, #1700
CMP	R1, R0
IT	HI
BHI	L_main5
;TestServo.c,34 :: 		current_duty = Min;
MOVW	R1, #1700
MOVW	R0, #lo_addr(_current_duty+0)
MOVT	R0, #hi_addr(_current_duty+0)
STRH	R1, [R0, #0]
;TestServo.c,35 :: 		goto Manten;
IT	AL
BAL	___main_Manten
;TestServo.c,36 :: 		}
L_main5:
;TestServo.c,38 :: 		Delay_ms(1);
MOVW	R7, #2665
MOVT	R7, #0
NOP
NOP
L_main7:
SUBS	R7, R7, #1
BNE	L_main7
NOP
NOP
;TestServo.c,39 :: 		current_duty = current_duty - 15;       // increment current_duty
MOVW	R1, #lo_addr(_current_duty+0)
MOVT	R1, #hi_addr(_current_duty+0)
LDRH	R0, [R1, #0]
SUBS	R0, #15
STRH	R0, [R1, #0]
;TestServo.c,40 :: 		PWM_TIM2_Set_Duty(current_duty,  _PWM_NON_INVERTED, _PWM_CHANNEL2); /// set newly acquired duty ratio
MOVS	R2, #1
MOVS	R1, #0
BL	_PWM_TIM2_Set_Duty+0
;TestServo.c,41 :: 		PWM_TIM2_Start(_PWM_CHANNEL2, &_GPIO_MODULE_TIM2_CH2_PA1); //agregamos que haga el cambio cada vez presionado el boton
MOVW	R1, #lo_addr(__GPIO_MODULE_TIM2_CH2_PA1+0)
MOVT	R1, #hi_addr(__GPIO_MODULE_TIM2_CH2_PA1+0)
MOVS	R0, #1
BL	_PWM_TIM2_Start+0
;TestServo.c,43 :: 		}
IT	AL
BAL	L_main9
;TestServo.c,32 :: 		if(SRVA > SRVB && (SRVA-SRVB) > Ubr){
L__main25:
L__main24:
;TestServo.c,45 :: 		else if(SRVA < SRVB && (SRVB-SRVA) > Ubr){
LDR	R2, [SP, #4]
LDR	R0, [SP, #0]
BL	__Compare_FP+0
MOVW	R0, #0
BGE	L__main38
MOVS	R0, #1
L__main38:
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
BLE	L__main39
MOVS	R0, #1
L__main39:
UXTB	R0, R0
CMP	R0, #0
IT	EQ
BEQ	L__main26
L__main22:
;TestServo.c,46 :: 		if(current_duty >= Max){
MOVW	R0, #lo_addr(_current_duty+0)
MOVT	R0, #hi_addr(_current_duty+0)
LDRH	R1, [R0, #0]
MOVW	R0, #6850
CMP	R1, R0
IT	CC
BCC	L_main13
;TestServo.c,47 :: 		current_duty = Max;
MOVW	R1, #6850
MOVW	R0, #lo_addr(_current_duty+0)
MOVT	R0, #hi_addr(_current_duty+0)
STRH	R1, [R0, #0]
;TestServo.c,48 :: 		goto Manten;
IT	AL
BAL	___main_Manten
;TestServo.c,49 :: 		}
L_main13:
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
;TestServo.c,52 :: 		current_duty = current_duty + 15;       // increment current_duty
MOVW	R1, #lo_addr(_current_duty+0)
MOVT	R1, #hi_addr(_current_duty+0)
LDRH	R0, [R1, #0]
ADDS	R0, #15
STRH	R0, [R1, #0]
;TestServo.c,53 :: 		PWM_TIM2_Set_Duty(current_duty,  _PWM_NON_INVERTED, _PWM_CHANNEL2); /// set newly acquired duty ratio
MOVS	R2, #1
MOVS	R1, #0
BL	_PWM_TIM2_Set_Duty+0
;TestServo.c,54 :: 		PWM_TIM2_Start(_PWM_CHANNEL2, &_GPIO_MODULE_TIM2_CH2_PA1); //agregamos que haga el cambio cada vez presionado el boton
MOVW	R1, #lo_addr(__GPIO_MODULE_TIM2_CH2_PA1+0)
MOVT	R1, #hi_addr(__GPIO_MODULE_TIM2_CH2_PA1+0)
MOVS	R0, #1
BL	_PWM_TIM2_Start+0
;TestServo.c,56 :: 		}
IT	AL
BAL	L_main17
;TestServo.c,45 :: 		else if(SRVA < SRVB && (SRVB-SRVA) > Ubr){
L__main27:
L__main26:
;TestServo.c,60 :: 		Manten:
___main_Manten:
;TestServo.c,61 :: 		Delay_ms(1);
MOVW	R7, #2665
MOVT	R7, #0
NOP
NOP
L_main18:
SUBS	R7, R7, #1
BNE	L_main18
NOP
NOP
;TestServo.c,62 :: 		PWM_TIM2_Set_Duty(current_duty,  _PWM_NON_INVERTED, _PWM_CHANNEL2);
MOVW	R0, #lo_addr(_current_duty+0)
MOVT	R0, #hi_addr(_current_duty+0)
LDRH	R0, [R0, #0]
MOVS	R2, #1
MOVS	R1, #0
BL	_PWM_TIM2_Set_Duty+0
;TestServo.c,63 :: 		PWM_TIM2_Start(_PWM_CHANNEL2, &_GPIO_MODULE_TIM2_CH2_PA1);
MOVW	R1, #lo_addr(__GPIO_MODULE_TIM2_CH2_PA1+0)
MOVT	R1, #hi_addr(__GPIO_MODULE_TIM2_CH2_PA1+0)
MOVS	R0, #1
BL	_PWM_TIM2_Start+0
;TestServo.c,64 :: 		}
L_main17:
L_main9:
;TestServo.c,65 :: 		Delay_ms(1);                 // slow down change pace a little
MOVW	R7, #2665
MOVT	R7, #0
NOP
NOP
L_main20:
SUBS	R7, R7, #1
BNE	L_main20
NOP
NOP
;TestServo.c,66 :: 		}
IT	AL
BAL	L_main0
;TestServo.c,67 :: 		}
L_end_main:
L__main_end_loop:
B	L__main_end_loop
; end of _main
