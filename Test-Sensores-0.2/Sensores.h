unsigned int adc1_valueFR, adc2_valueFR;
const float R=722.8327228e-6;
void Foto_ADC_Init(void);
float FotoA(void);
float FotoB(void);


void Foto_ADC_Init(void){
    GPIO_Digital_Output(&GPIOB_BASE,_GPIO_PINMASK_10|_GPIO_PINMASK_11|_GPIO_PINMASK_12);
    GPIO_Digital_Output(&GPIOB_BASE,_GPIO_PINMASK_13|_GPIO_PINMASK_14|_GPIO_PINMASK_15);
    GPIO_Analog_input(&GPIOC_BASE,_GPIO_PINMASK_0| _GPIO_PINMASK_1); //PC0 = Canal 10 del ADC1
    ADC_Set_Input_Channel(_ADC_CHANNEL_10| _ADC_CHANNEL_11);
    ADC1_Init();
}

float FotoA(void){
    char val[10];
    float voltsFR1;
    adc1_valueFR = ADC1_Get_Sample(10);
    voltsFR1 = R*adc1_valueFR;
    return voltsFR1;
}

float FotoB(void){
 char val2[10];
 float voltsFR2;
 adc2_valueFR = ADC1_Get_Sample(11);
 voltsFR2 = R*adc2_valueFR;
 return voltsFR2;
}