/*
Инициализация
Принимает амплитуду сигнала, который нужно подать на выход
Считывет АЦП с трех каналов
Передает эти значения напряжений обратно на ПК
Подает на выход принятый в п.1 сигнал
Ожидает новую команду
 */
 
 float b = 0;
 
    int code = 0;
    byte dcode1 = 0;
    byte dcode2 = 0;
    byte ADC1 = 0;
    byte ADC2 = 0;
    byte ADC3 = 0;
    byte ADC4 = 0;

// the setup routine runs once when you press reset:
void setup() 
{
  Serial.begin(115200);
  
  attachInterrupt(0, encoder, RISING);  //Включить прерывания по int0
}

//void outled(byte C)
//{
// PORTD = (C&DDRB)*16  ;
// PORTB = (C&DDRD)/16  ; 
//}  

void loop()
  {
    ADC1 = (analogRead(A0))/4;  // Запись АЦП0
    ADC2 = (analogRead(A1))/4;  // Запись АЦП1
    ADC3 = (analogRead(A2))/4;  // Запись АЦП2
    ADC4 = (analogRead(A4))/4;  // Запись АЦП2
    
  if (Serial.available() > 0)  //если есть входные данные, то начать процесс передачи данных
  {
    
    detachInterrupt(0);
    
    dcode1 = byte(code%255);
      if (code>255)
      {dcode2 = int(code/256);}    //   2^16 бит счетчика
      
    byte Data = Serial.read();
  
    Serial.write(ADC1);    // Отправка через порт В0
    Serial.write(ADC2);    // Отправка через порт В2
    Serial.write(ADC3);    // Отправка через порт В3
    Serial.write(ADC4);    // Отправка через порт В4
    Serial.write(dcode1);    // Отправка цифрового байта повышения
    Serial.write(dcode2);    // Отправка цифрового байта понижения
    
      //outled(byte(Data)); //Вывод на цифровой выход принятых данных
      analogWrite(6,Data);  // Выход на ШИМ
      
      code = 0;
      dcode1 = 0;
      dcode2 = 0;
      attachInterrupt(0, encoder, RISING);  //Включить прерывания
    }  
}

void encoder()          //Инкрементирование отсчет при положительном фронте пин3
{     
  if (digitalRead(2)==LOW)
    { code = code+1; }
}
