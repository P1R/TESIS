_Foto_ADC_Init:
;sensores.h,8 :: 		void Foto_ADC_Init(void){
SUB	SP, SP, #4
STR	LR, [SP, #0]
;sensores.h,9 :: 		GPIO_Digital_Output(&GPIOB_BASE,_GPIO_PINMASK_10|_GPIO_PINMASK_11|_GPIO_PINMASK_12);
MOVW	R1, #7168
MOVW	R0, #lo_addr(GPIOB_BASE+0)
MOVT	R0, #hi_addr(GPIOB_BASE+0)
BL	_GPIO_Digital_Output+0
;sensores.h,10 :: 		GPIO_Digital_Output(&GPIOB_BASE,_GPIO_PINMASK_13|_GPIO_PINMASK_14|_GPIO_PINMASK_15);
MOVW	R1, #57344
MOVW	R0, #lo_addr(GPIOB_BASE+0)
MOVT	R0, #hi_addr(GPIOB_BASE+0)
BL	_GPIO_Digital_Output+0
;sensores.h,11 :: 		GPIO_Analog_input(&GPIOC_BASE,_GPIO_PINMASK_0| _GPIO_PINMASK_1); //PC0 = Canal 10 del ADC1
MOVS	R1, #3
MOVW	R0, #lo_addr(GPIOC_BASE+0)
MOVT	R0, #hi_addr(GPIOC_BASE+0)
BL	_GPIO_Analog_Input+0
;sensores.h,12 :: 		ADC_Set_Input_Channel(_ADC_CHANNEL_10| _ADC_CHANNEL_11);
MOVW	R0, #3072
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
_main:
;Test-Sensores.c,19 :: 		void main() {
;Test-Sensores.c,20 :: 		Lcd_Init();
BL	_Lcd_Init+0
;Test-Sensores.c,21 :: 		Foto_ADC_Init();
BL	_Foto_ADC_Init+0
;Test-Sensores.c,22 :: 		Config_ptos();
BL	_Config_ptos+0
;Test-Sensores.c,23 :: 		Lcd_Cmd(_LCD_CLEAR);               // Clear display
MOVS	R0, #1
BL	_Lcd_Cmd+0
;Test-Sensores.c,24 :: 		Lcd_Out(1, 1, "9CM11-Volmetro");
MOVW	R0, #lo_addr(?lstr1_Test_45Sensores+0)
MOVT	R0, #hi_addr(?lstr1_Test_45Sensores+0)
MOV	R2, R0
MOVS	R1, #1
MOVS	R0, #1
BL	_Lcd_Out+0
;Test-Sensores.c,25 :: 		delay_ms(2000);
MOVW	R7, #24915
MOVT	R7, #81
NOP
NOP
L_main0:
SUBS	R7, R7, #1
BNE	L_main0
NOP
NOP
NOP
NOP
;Test-Sensores.c,26 :: 		Lcd_Cmd(_LCD_CLEAR);
MOVS	R0, #1
BL	_Lcd_Cmd+0
;Test-Sensores.c,27 :: 		Lcd_Cmd(_LCD_CURSOR_OFF);
MOVS	R0, #12
BL	_Lcd_Cmd+0
;Test-Sensores.c,28 :: 		while(1){
L_main2:
;Test-Sensores.c,29 :: 		Proceso();
BL	_Proceso+0
;Test-Sensores.c,30 :: 		Proceso2();
BL	_Proceso2+0
;Test-Sensores.c,31 :: 		}
IT	AL
BAL	L_main2
;Test-Sensores.c,32 :: 		}
L_end_main:
L__main_end_loop:
B	L__main_end_loop
; end of _main
_Config_ptos:
;Test-Sensores.c,34 :: 		void Config_ptos(void){
SUB	SP, SP, #4
STR	LR, [SP, #0]
;Test-Sensores.c,35 :: 		GPIO_Digital_Output(&GPIOB_BASE,_GPIO_PINMASK_10|_GPIO_PINMASK_11|_GPIO_PINMASK_12);
MOVW	R1, #7168
MOVW	R0, #lo_addr(GPIOB_BASE+0)
MOVT	R0, #hi_addr(GPIOB_BASE+0)
BL	_GPIO_Digital_Output+0
;Test-Sensores.c,36 :: 		GPIO_Digital_Output(&GPIOB_BASE,_GPIO_PINMASK_13|_GPIO_PINMASK_14|_GPIO_PINMASK_15);
MOVW	R1, #57344
MOVW	R0, #lo_addr(GPIOB_BASE+0)
MOVT	R0, #hi_addr(GPIOB_BASE+0)
BL	_GPIO_Digital_Output+0
;Test-Sensores.c,37 :: 		}
L_end_Config_ptos:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _Config_ptos
_Proceso:
;Test-Sensores.c,39 :: 		void Proceso(void){
SUB	SP, SP, #16
STR	LR, [SP, #0]
;Test-Sensores.c,42 :: 		voltsFotoA = FotoA();
BL	_FotoA+0
;Test-Sensores.c,43 :: 		FloatToStr(voltsFotoA,val);
ADD	R1, SP, #4
BL	_FloatToStr+0
;Test-Sensores.c,44 :: 		Lcd_Out(1, 1, val);
ADD	R0, SP, #4
MOV	R2, R0
MOVS	R1, #1
MOVS	R0, #1
BL	_Lcd_Out+0
;Test-Sensores.c,45 :: 		}
L_end_Proceso:
LDR	LR, [SP, #0]
ADD	SP, SP, #16
BX	LR
; end of _Proceso
_Proceso2:
;Test-Sensores.c,47 :: 		void Proceso2(void){
SUB	SP, SP, #16
STR	LR, [SP, #0]
;Test-Sensores.c,50 :: 		voltsFotoB = FotoB();
BL	_FotoB+0
;Test-Sensores.c,51 :: 		FloatToStr(voltsFotoB,val2);
ADD	R1, SP, #4
BL	_FloatToStr+0
;Test-Sensores.c,52 :: 		Lcd_Out(2, 1, val2);
ADD	R0, SP, #4
MOV	R2, R0
MOVS	R1, #1
MOVS	R0, #2
BL	_Lcd_Out+0
;Test-Sensores.c,53 :: 		delay(0xFFFFF);
MOVW	R0, #65535
MOVT	R0, #15
BL	_delay+0
;Test-Sensores.c,54 :: 		Lcd_Cmd(_LCD_CLEAR);
MOVS	R0, #1
BL	_Lcd_Cmd+0
;Test-Sensores.c,55 :: 		}
L_end_Proceso2:
LDR	LR, [SP, #0]
ADD	SP, SP, #16
BX	LR
; end of _Proceso2
_delay:
;Test-Sensores.c,57 :: 		void delay(unsigned long contador) // Funci�n para generar retardo
;Test-Sensores.c,59 :: 		while(--contador);
L_delay4:
SUBS	R1, R0, #1
MOV	R0, R1
CMP	R1, #0
IT	EQ
BEQ	L_delay5
IT	AL
BAL	L_delay4
L_delay5:
;Test-Sensores.c,60 :: 		}
L_end_delay:
BX	LR
; end of _delay
