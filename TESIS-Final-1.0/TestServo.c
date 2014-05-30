#include "Sensores.h"
#define Cero    3900  //definimos PWM para 0 grados
#define Max     6850  //definimos PWM para 90 grados
#define Min     1700  //definimos PWM para -90 grados
//definimos ciclo de trabajo y periodo
unsigned int current_duty, old_duty, i;
unsigned int pwm_period1;
//configuraciones de puertos
void Conf_puertos(void)
{
 GPIO_Digital_Input(&GPIOA_BASE,_GPIO_PINMASK_2 | _GPIO_PINMASK_3);
}

void main() {
  //se declaran sensores y Umbral de estabilidad
  float SRVA, SRVB, Ubr = 0.2;
  Conf_puertos();  //se configuran los puertos
  Foto_ADC_Init();
  current_duty = Cero;                        // initial value for current_duty
  pwm_period1 = PWM_TIM2_Init(50);
  PWM_TIM2_Set_Duty(current_duty,  _PWM_NON_INVERTED, _PWM_CHANNEL2);
  PWM_TIM2_Start(_PWM_CHANNEL2, &_GPIO_MODULE_TIM2_CH2_PA1);

    while (1){
    SRVA = fotoA(); //PA2
    SRVB = fotoB(); //PA3
    //GIRA A UN LADO -90 Grados PA2 mayor
     if(SRVA > SRVB && (SRVA-SRVB) > Ubr){
         if(current_duty <= Min){
             current_duty = Min;
             goto Manten;
             }
         else{
             Delay_ms(1);
             current_duty = current_duty - 15;       // increment current_duty
             PWM_TIM2_Set_Duty(current_duty,  _PWM_NON_INVERTED, _PWM_CHANNEL2); /// set newly acquired duty ratio
             PWM_TIM2_Start(_PWM_CHANNEL2, &_GPIO_MODULE_TIM2_CH2_PA1); //agregamos que haga el cambio cada vez presionado el boton
         }
      }
      //GIRA AL OTRO +90 bit 3 mayor
     else if(SRVA < SRVB && (SRVB-SRVA) > Ubr){
         if(current_duty >= Max){
             current_duty = Max;
             goto Manten;
             }
         else{
             Delay_ms(1);
             current_duty = current_duty + 15;       // increment current_duty
             PWM_TIM2_Set_Duty(current_duty,  _PWM_NON_INVERTED, _PWM_CHANNEL2); /// set newly acquired duty ratio
             PWM_TIM2_Start(_PWM_CHANNEL2, &_GPIO_MODULE_TIM2_CH2_PA1); //agregamos que haga el cambio cada vez presionado el boton
         }
     }
     //por defecto en posicion 0 grados
     //NOTA: DEBE CAMBIARSE ESTO PARA BUSCAR ESTABILIDAD Y MANTENER EL PUNTO
     else{
     Manten:
         Delay_ms(1);
         PWM_TIM2_Set_Duty(current_duty,  _PWM_NON_INVERTED, _PWM_CHANNEL2);
         PWM_TIM2_Start(_PWM_CHANNEL2, &_GPIO_MODULE_TIM2_CH2_PA1);
     }
    Delay_ms(1);                 // slow down change pace a little
    }
}