/*
Инициализация
Принимает амплитуду сигнала, который нужно подать на выход
Считывет АЦП с трех каналов
Передает эти значения напряжений обратно на ПК
Считает и передает количество тактов с энкодера
Считает и передает время выполнения цикла программы
Подает на выход принятый в п.1 сигнал
Ожидает новую команду
 */
 
    int code = 0;
    int dcode1 = 0;
    int dcode2 = 0;
    byte ADC1 = 0;
    byte ADC2 = 0;
    byte ADC21 = 0;
    byte ADC22 = 0;
    byte ADC3 = 0;
    byte dt = 0;

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
    ADC2 = analogRead(A2);      //Запись АЦП1
    ADC3 = (analogRead(A1))/4;  // Запись АЦП2
    
  if (Serial.available() > 0)  //если есть входные данные, то начать процесс передачи данных
  {
    
    detachInterrupt(0);
    
    ADC21 = (ADC2)%256;  // Запись АЦП1 старшая часть
    if ((ADC2)>255)
    {ADC22 = (ADC2)/256;}  // Запись АЦП1 младшая часть
    
    dcode1 = byte(code%255);
      if (code>255)
      {dcode2 = int(code/256);}    //   2^16 бит счетчика
      
    dt = millis() - dt;    // определение разности времени   
      
    byte Data = Serial.read();
  
    Serial.write(ADC1);    // Отправка через порт В0
    Serial.write(ADC21);    // Отправка через порт В2
    Serial.write(ADC22);    // Отправка через порт В3
    Serial.write(ADC3);    // Отправка через порт В4
    Serial.write(dcode1);    // Отправка байта младшего разряда
    Serial.write(dcode2);    // Отправка байта старшего разряда
    Serial.write(dt);        //  Отправка дифф. времени
    
    dt = millis();          // запись старого значения времени
    
      //outled(byte(Data)); //Вывод на цифровой выход принятых данных
      analogWrite(6,Data);  // Выход на ШИМ
      
      code = 0;
      dcode1 = 0;
      dcode2 = 0;
      ADC22 = 0;
      attachInterrupt(0, encoder, RISING);  //Включить прерывания
    }  
}

void encoder()          //Инкрементирование отсчет при положительном фронте пин3
{     
  if (digitalRead(2)==LOW)
    { code = code+1; }
}
