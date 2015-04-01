/*
Инициализация
Принимает амплитуду сигнала, который нужно подать на выход
Считывет АЦП с трех каналов
Передает эти значения напряжений обратно на ПК
Подает на выход принятый в п.1 сигнал
Ожидает новую команду
 */
    int code1 = 128;
    int code2 = 0;
    int ADC1 = 0;
    int ADC2 = 0;
    int ADC3 = 0;
    int ADC4 = 0;

// the setup routine runs once when you press reset:
void setup() {
  Serial.begin(57600);
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
    
    byte Data = Serial.read();
  
    Serial.write(ADC1/4);    // Отправка через порт В0
    delay(1);
    Serial.write(ADC2/4);    // Отправка через порт В2
    delay(1);
    Serial.write(ADC3/4);    // Отправка через порт В3
    delay(1);
    Serial.write(ADC4/4);    // Отправка через порт В4
    delay(1);
    Serial.write(code2-code1);    // Отправка цифрового байта
    //Serial.println(Data);  // Контрольная отправка принятого кода
    
      //code = 128;       //Очищение цифрового бита
      outled(byte(Data)); //Вывод на цифровой выход принятых данных
      
      code2 = code1;
      
      attachInterrupt(1, encoder, RISING);  //Включить прерывания
    }  
}

void encoder()          //Полоительный отсчет при положительном фронте пин3
{                       //  и высоком уровне пин2
  if (digitalRead(2)== HIGH)
  {
    code1 = ++code1; 
  }
  else
  {
    code1 = --code1;
  }
}
