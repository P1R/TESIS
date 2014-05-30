unsigned int adc1_valueFR, adc2_valueFR, adc3_valueCFBV;
const float R=722.8327228e-6; // Resolucion para sensores fotoresistencias
const float  RCFBV=769.2307692e-6;
void Foto_ADC_Init(void);
float FotoA(void); // Fotoresistencias 1 
float FotoB(void); // Fotoresistencias 2
float CFBV(void); // celada foto 


void Foto_ADC_Init(void){
    GPIO_Analog_input(&GPIOC_BASE,_GPIO_PINMASK_0| _GPIO_PINMASK_1 | _GPIO_PINMASK_1); //PC0 = Canal 10 del ADC1
    ADC_Set_Input_Channel(_ADC_CHANNEL_10| _ADC_CHANNEL_11 | _ADC_CHANNEL_12);
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

float CFBV(void){
 char val3[10];
 float voltsCFBV;
 adc3_valueCFBV = ADC1_Get_Sample(12);
 voltsCFBV = RCFBV*adc2_valueFR;
 return voltsCFBV;
}