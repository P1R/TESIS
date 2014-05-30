void UART_Inti(void){
 UART1_Init(9600);  
}

void Transmitir( float A){
 char CFBV[15];
 FloatToStr(A,CFBV);
 UART1_Write_Text(CFBV);
 UART1_Write(13);
 UART1_Write(10);
}