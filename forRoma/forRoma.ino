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
 
}

void outled(byte C)
{
 PORTD = (C&DDRB)*16  ;
 PORTB = (C&DDRD)/16  ; 
}  

void loop()
  {
    ADC1 = 10;  // Запись АЦП0
    ADC2 = 20;  // Запись АЦП1
    ADC3 = 123;  // Запись АЦП2
    ADC4 = 160;  // Запись АЦП2
    dcode1 = 250;         //Установка понижающего кода
    dcode2 = 300;
    
  if (Serial.available() > 0)  //если есть входные данные, то начать процесс передачи данных
  {
 
    
    byte Data = Serial.read();
  
    Serial.write(ADC1);    // Отправка через порт В0
    Serial.write(ADC2);    // Отправка через порт В2
    Serial.print(ADC3);    // Отправка через порт В3
    Serial.write(ADC4);    // Отправка через порт В4
    Serial.write(dcode1);    // Отправка цифрового байта повышения
    Serial.write(dcode2);    // Отправка цифрового байта понижения
     

    }  
}


