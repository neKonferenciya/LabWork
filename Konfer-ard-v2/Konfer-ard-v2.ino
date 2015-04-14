/*
Инициализация
Принимает амплитуду сигнала, который нужно подать на выход
Считывет АЦП с трех каналов
Передает эти значения напряжений обратно на ПК
Подает на выход принятый в п.1 сигнал
Ожидает новую команду
 */
    int code = 0;
    int dcode = 0;
    int ADC1 = 0;
    int ADC2 = 0;
    int ADC3 = 0;
    int ADC4 = 0;

// the setup routine runs once when you press reset:
void setup() 
{
  Serial.begin(115200);
  DDRB = B00001111;  //пины порт В на выход (пины 8-11)
  DDRD = B11110000;  //пины порт D на выход (пины 4-7)
  
  attachInterrupt(1, encoder, RISING);  //Включить прерывания по int1
}

void outled(byte C)
{
 PORTD = (C&DDRB)*16  ;
 PORTB = (C&DDRD)/16  ; 
}  

void loop()
  {
    ADC1 = analogRead(A0);  // Запись АЦП0
    ADC2 = analogRead(A1);  // Запись АЦП1
    ADC3 = analogRead(A2);  // Запись АЦП2
    ADC4 = analogRead(A3);  // Запись АЦП2
    
  if (Serial.available() > 0)  //если есть входные данные, то начать процесс передачи данных
  {
    detachInterrupt(1);
    
    if (code>255)
    {dcode = (code%511)-256;}
      
    byte Data = Serial.read();
  
    Serial.write(ADC1/4);    // Отправка через порт В0
    Serial.write(ADC2/4);    // Отправка через порт В2
    Serial.write(ADC3/4);    // Отправка через порт В3
    Serial.write(ADC4/4);    // Отправка через порт В4
    Serial.write(code%255);    // Отправка цифрового байта повышения
    Serial.write(dcode);    // Отправка цифрового байта понижения
    
      outled(byte(Data)); //Вывод на цифровой выход принятых данных
      
      code = 0;
      dcode = 0;
      attachInterrupt(1, encoder, RISING);  //Включить прерывания
    }  
}

void encoder()          //Инкрементирование отсчет при положительном фронте пин3
{                    
    code = ++code; 
}
