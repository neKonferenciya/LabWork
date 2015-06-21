import processing.serial.*;
Serial COMport; 

textbox k1 = new textbox();   //textbox1
textbox k2 = new textbox();   //textbox2
textbox k3 = new textbox();
textbox k4 = new textbox();
textbox s1 = new textbox();
textbox s2 = new textbox();
textbox s3 = new textbox();
textbox s4 = new textbox();

plot plot1 = new plot();
plot plot2 = new plot();
plot plot3 = new plot();
plot plot4 = new plot();

float Uadc = 0;
float Tmax=5.5;
float t0=0;
boolean play=false;
boolean adc2=false;
boolean speed=false;
boolean phase=false;
boolean setport=true;
int setserial = 0;

void setup()
{
 size(1200,630);
 background(0x735184);
  //restart(); 
  
 k1.sett(820,20,20,4,"k1=");  //set textbox
 k2.sett(820,20+155,20,4,"k2="); 
 k3.sett(820,20+155*2,20,4,"k3=");
 k4.sett(820,20+155*3,20,4,"k4=");

}

void draw()
{
  if (setport)
  {
  fill(0);
     rect(0,0,400,400);
     fill(200);
     text("Меню установки соединения:",10,30);  //menu of setting serial connect
       for (int i=0;i<Serial.list().length;i++)
       {
         if (i==setserial)
         {
          fill(#ffaa33);
          text(i+": "+Serial.list()[i],20,80+i*30);
          fill(200);
         } 
         else
         {text(i+": "+Serial.list()[i],20,80+i*30);}
       }
       text("Кликните по порту из списка;",20,330);
       text("Порт выделился желтым;",20,360);
       text("Нажмите ПРОБЕЛ или 'P'",20,390);
  }
  else
 {
 k1.viewTextbox(); 
 k2.viewTextbox(); 
 k3.viewTextbox(); 
 k4.viewTextbox(); 
 
 if (phase) {s1.sett(820,60,20,4,"Фаза=");}        // set phase or DAC
 else {s1.sett(820,60,20,4,"ЦАП=");}
 
 if (adc2) {s2.sett(820,60+155,20,4,"АЦП2=");}   // set ADC2 or..
 else {s2.sett(820,60+155,20,4,"АЦП1=");}          //..or set ADC1
 
 s3.sett(820,60+155*2,20,4,"АЦП3=");
 
 if (speed) {s4.sett(820,60+155*3,20,4,"Скорость=");}  //set speed or counter
 else {s4.sett(820,60+155*3,20,4,"Счетчик=");}
 

if (play)
{ 
  if (phase) {s1.viewTextNow( roundn(45.42,10) );}    //view phase or DAC
  else {s1.viewTextNow( roundn(Uadc,1000) );}              // Rounding adn output
  
  if (adc2) {s2.viewTextNow( roundn(2,1000) );}   //view ADC2 or..
  else {s2.viewTextNow( roundn(1,1000) );}          // ..or view ADC1
  
  s3.viewTextNow( roundn(0,1000) );                 // Current
  
  if (speed) {s4.viewTextNow( roundn(3,1000) );}    //view speed or counter
  else {s4.viewTextNow( roundn(4,1) );}
  
  t0=(float(millis())/1000)%Tmax;
  Uadc = 2.5+2.5*sin(1*t0);
  if (phase) {plot1.addpoint(t0,45.4*plot1.dY/180);} //plot PHASE or DAC
  else {plot1.addpoint(t0,float(k1.s)*Uadc*plot1.dY/5);}  //  =K1*DAC
  
  if (adc2) {plot2.addpoint(t0,2*plot2.dY/5);}  // plot ADC1
  else {plot2.addpoint(t0,1*plot2.dY/5);}       //plot ADC2

  plot3.addpoint(t0,float(k3.s)*plot2.dY/5);    //plot of current

  if (speed) {plot4.addpoint(t0,3*plot2.dY/5);}  // plot speed or counter
  else {plot4.addpoint(t0,4*plot2.dY/5);}  

  if ((float(millis())/1000)%(Tmax)>Tmax-0.1)
    {restart();}
}
}
}


void keyPressed()
{
 if (!play) 
 {
  k1.editTextbox();
  k2.editTextbox();      //edit testboxs
  k3.editTextbox();
  k4.editTextbox();
 }
  
  
  
  if ((key == 'P')||(key == 'p')||(key == 32))
  {
    play = play^true;                   //PAUSE!!! by P or Space
     textSize(50);
     fill(#ff0000);
     text("Пауза", 810, 610); 
   //com_talk();
   Uadc=0;
   if (play)
   {restart();  }
   }
   

    if (((key == 'P')||(key == 'p')||(key == 32))&&(setport))
      {
         COMport = new Serial(this, Serial.list()[setserial], 115200);    //make connect
         play = true;
         setport = false;
         restart();
      } 

}

void mousePressed()
{
  if (setport)
  {
  for (int i=0;i<Serial.list().length;i++)
    {
    if ((mouseY<80+i*30)&&(mouseY>60+i*30))
    {setserial = i;}
    }
  }
  
 phase = s1.change(phase);
 adc2 = s2.change(adc2); 
 speed = s4.change(speed); 
}
