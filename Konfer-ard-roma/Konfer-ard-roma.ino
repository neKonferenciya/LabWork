/*
Инициализация
Принимает амплитуду сигнала, который нужно подать на выход
Считывет АЦП с трех каналов
Передает эти значения напряжений обратно на ПК
Подает на выход принятый в п.1 сигнал
Ожидает новую команду
 */
    int code1 = 0;
    int code2 = 0;
    int dcode1 = 0;
    int dcode2 = 0;
    int ADC1 = 0;
    int ADC2 = 0;
    int ADC3 = 0;
    int ADC4 = 0;

// the setup routine runs once when you press reset:
void setup() {
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
    
    byte Data = Serial.read();
  
    Serial.write(0);    // Отправка через порт В0
    Serial.write(127);    // Отправка через порт В2
    Serial.write(128);    // Отправка через порт В3
    Serial.write(250);    // Отправка через порт В4
    Serial.write(-10);    // Отправка цифрового байта повышения
    Serial.write(305);    // Отправка цифрового байта понижения
    
      outled(byte(Data)); //Вывод на цифровой выход принятых данных
      
      code2 = code1;
      dcode1 = 0;
      dcode2 = 0;
      attachInterrupt(1, encoder, RISING);  //Включить прерывания
    }  
}

void encoder()          //Положительный отсчет при положительном фронте пин3
{                       //  и высоком уровне пин2
  if (digitalRead(2)== HIGH)
  {
    code1 = ++code1; 
  }
  else
  {
    code1 = --code1;
  }
  
  if (code1>code2)
  {dcode1 = code1-code2;
  dcode2 = 0;}            //Установка повышающего кода
  
  if (code1<code2)
  {dcode2 = code2-code1;
  dcode1 = 0;}            //Установка понижающего кода
}
