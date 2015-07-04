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
textbox sint = new textbox();  // interpolation button
textbox T = new textbox();
textbox connectName = new textbox();
textbox myName = new textbox();
textbox adcEX = new textbox();

textbox ku1 = new textbox();
textbox ku2 = new textbox();
textbox ku0 = new textbox();    // koeff. for DAC
textbox kw1 = new textbox();
textbox kw2 = new textbox();

plot plot1 = new plot();
plot plot2 = new plot();
plot plot3 = new plot();
plot plot4 = new plot();

sweep U1 = new sweep();
sweep U2 = new sweep();        // phase-metr
sweep U3 = new sweep();

float a1 = 0;
float a2 = 0;
float a3 = 0;

float ki = 1;                  //  koeff. of current's resistor

float t0=0;
float dt=0;
float tphase = 0;

float Udac = 0;
float angl = 0;
float velocity=0;
int counA=0;        // for Counter
int bufC=0;

boolean play=false;
boolean adc2=false;
boolean speed=true;
boolean phase=false;
boolean setport=true;
boolean interpol=false;
int setserial = 0;

void setup()
{
 size(1300,630);
 background(0x000000);
  //restart(); 
  
 k1.sett(820,162+30,20,4,"Делитель=");  //set textbox
 k1.s="2";
 k2.sett(820,162+30*2,20,4,"Масштаб U="); 
 k3.sett(820,317+30,20,4,"Масштаб I =");
 k4.sett(820,472+30,20,4,"Тактов/оборот=");
 k4.s="360";

 ku1.sett(820,40*2,18,4,"U1=");
 ku1.s="1";
 ku2.sett(920,40*2,18,4,"U2=");
 ku2.s="0";
 ku0.sett(1020,40*2,18,4,"U0=");
 ku0.s="3.5";
 kw1.sett(820,7+40,18,4,"W1=");
 kw1.s="5";
 kw2.sett(920,7+40,18,4,"W2=");
 kw2.s="0";
 T.sett(1106,2*155+7-30,18,4,"Период (с): ");
 T.s="10.5";
 {sint.sett(1105,2*155+7,18,7,"Интерполяция:");}        // set interpol-switch
 
 adcEX.s="U1*sin(W1*t+W2*t*t)+U2*cos(W1*t)*t+U0   ";
 adcEX.sett(820,40*3,18,1,"Uцап=");
 
 connectName.sett(820,570,14,10,"      Порт: ");
 myName.sett(1005,600,18,1,"Разработчик: ");
 myName.s="Tx.Br. (Антошин)";

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
 ku1.viewTextbox(); 
 ku2.viewTextbox();
 ku0.viewTextbox();
 kw1.viewTextbox();
 kw2.viewTextbox();
 T.viewTextbox();
 
 if (phase) {s1.sett(820,7,20,4,"  Фаза=");}        // set phase or DAC
 else {s1.sett(820,7,20,7,"ЦАП=");}
 
 if (adc2) {s2.sett(820,7+155,18,4,"АЦП2=");}   // set ADC2 or..
 else {s2.sett(820,7+155,18,4,"АЦП1=");}          //..or set ADC1
 
 s3.sett(820,7+155*2,18,4,"АЦП3=");
 
 if (speed) {s4.sett(820,7+155*3,20,4," Скорость (об/с)=");}  //set speed or counter
 else {s4.sett(820,7+155*3,20,4,"Счетчик (тактов)=");}        
 

if (play)
    { 
  connectName.viewTextString(0x73,0x51,0x84);       // Name of serial port
  myName.viewTextString(0x73,0x51,0x84);
  adcEX.viewTextString(0x73,0x51,0x84);
  
  
  if (interpol) {sint.s="Вкл   ";}            // set interpolation on/off
  else {sint.s="Выкл  ";}
  sint.viewTextString(0x00,0x51,0x84);
  
  if (phase) {s1.viewTextNow( roundn(angl,10) ,0x00,0x51,0x84);}        //view phase or DAC
  else {s1.viewTextNow( roundn(Udac,1000) ,0x00,0x51,0x84);}              // Rounding adc output


  
                      t0=(float(millis())/1000)%float(T.s);
  Udac = roundn(float(ku1.s),10)*sin(roundn(float(kw1.s),100)*t0+roundn(float(kw2.s),100)*t0*t0)+((roundn(float(ku2.s),10)*t0*cos(roundn(float(kw1.s),100)*t0))%5)+roundn(float(ku0.s),10);
  if (Udac>5) {Udac=5;}
  if (Udac<0) {Udac=0;}          // limit of DAC 
  
      if (phase) {plot1.addpoint(t0,angl*plot1.dY/180);}       //plot PHASE or DAC
      else {plot1.addpoint(t0,Udac*plot1.dY/5);}               //  DAC   
      

                      t0=(float(millis())/1000)%float(T.s);
  if (interpol)
      {if (adc2) {plot2.Newton(t0,((a2*5/256)-(a3*5/1024))*float(k2.s)*plot2.dY/5);   // plot ADC2; view ADC2 or..
        s2.viewTextNow( roundn(plot2.New*float(k1.s)*5/plot2.dY,1000) ,0x00,0x51,0x84);}                            
      else {plot2.Newton(t0,((a1*5/256)-(a3*5/1024))*float(k2.s)*plot2.dY/5);         //plot ADC1; ..or view ADC1   
            s2.viewTextNow( roundn(plot2.New*5/plot2.dY,1000) ,0x00,0x51,0x84);  }                                            
       }                                  
  else
      {if (adc2) {plot2.addpoint(t0,((a2*5/256)-(a3*5/1024))*float(k2.s)*plot2.dY/5);            // plot ADC2
        s2.viewTextNow( roundn(((a2*5/256)-(a3*5/1024))*float(k1.s),1000) ,0x00,0x51,0x84);}     //view ADC2 or..
      else {plot2.addpoint(t0,((a1*5/256)-(a3*5/1024))*float(k2.s)*plot2.dY/5);                  //plot ADC1
            s2.viewTextNow( roundn(((a1*5/256)-(a3*5/1024)),1000) ,0x00,0x51,0x84);  }           // ..or view ADC1
      }
      
                      t0=(float(millis())/1000)%float(T.s);    
  if (interpol)                                  //plot of current
  {plot3.Newton(t0, float(k3.s)*(a3*ki*5*5/1024)*plot3.dY/5);
    s3.viewTextNow( roundn(plot3.New*5/(plot3.dY*5*float(k3.s)),1000) ,0x73,0x51,0x84);}
  else 
  {plot3.addpoint(t0, float(k3.s)*(a3*ki*5*5/1024)*plot3.dY/5);        //  1 A max for default
    s3.viewTextNow( roundn((a3*ki*5/1024),1000) ,0x73,0x51,0x84);}

                      t0=(float(millis())/1000)%float(T.s);
  int maxspeed = 50;
  if (interpol)
      {if (speed) {plot4.Newton(t0,velocity*plot4.dY/maxspeed);
          {s4.viewTextNow( roundn(plot4.New*maxspeed/plot4.dY,1000) ,0x00,0x51,0x84);  }  }  //view speed or counter      
      else {plot4.Newton(t0,(counA%(round(float(k4.s))))*plot4.dY/float(k4.s));
           s4.viewTextNow( counA%10000 ,0x00,0x51,0x84);    }
      }
  else
      {if (speed) {plot4.addpoint(t0,velocity*plot4.dY/50);
          s4.viewTextNow( roundn(velocity,1000) ,0x00,0x51,0x84);  }  // plot speed or counter || 50 spin/sec MAX
      else {  plot4.addpoint(t0,(counA%(round(float(k4.s))))*plot4.dY/float(k4.s));
              s4.viewTextNow( counA%10000 ,0x00,0x51,0x84);   }       //counA%360 /360
      } 
      
    if (interpol)
       { U1.wait(plot2.New*5/plot2.dY);           //  U by plot2
        U2.wait(plot4.New*maxspeed/plot4.dY);    // speed by plot4
        U3.wait( plot2.New*5/plot2.dY + plot4.New*maxspeed/plot4.dY ); } // SUM
    else
        {U1.wait( a1 );         
        U2.wait( velocity );    
        U3.wait( a1 + velocity ); }
      
  if ((t0-tphase) > 2*PI/( float(kw1.s) ))     /*Get phase*/  
      {
        angl = getPhase(U1.amp(),U2.amp(),U3.amp());
        U1.refresh();
        U2.refresh();
        U3.refresh();
        tphase = (float(millis())/1000)%float(T.s);
      }    
  

   if ((float(millis())/1000)%(float(T.s))>float(T.s)*0.98)          // TIME for restart
    {restart();  delay(1);}
    
    comTalk();
    //dt= (float(millis())/1000)%float(T.s) - dt;
    velocity=(bufC)/(/*6.2832*/dt*float(k4.s));                                //found speed rad/sec
    //dt = (float(millis())/1000)%float(T.s);
    
    }    //if play
  }  //else
}  // draw


void keyPressed()
{
 if (!play) 
 {
  k1.editTextbox();
  k2.editTextbox();      //edit testboxs
  k3.editTextbox();
  k4.editTextbox();
  ku1.editTextbox();
  ku2.editTextbox();
  ku0.editTextbox();
  kw1.editTextbox();
  kw2.editTextbox();
  T.editTextbox();
 }
  
  
  
  if (((key == 'P')||(key == 'p')||(key == 32))&&(!setport))
  {
    play = play^true;                   //PAUSE!!! by P or Space
     textSize(50);
     fill(#ff1000);
     text("Пауза", 1150, 450); 
   
   Udac=0;
   counA = 0;
   comTalk();
   if (play)
   {restart();}
   }
   

    if (((key == 'P')||(key == 'p')||(key == 32))&&(setport))
      {
         COMport = new Serial(this, Serial.list()[setserial], 115200);    //make connect
         play = true;
         setport = false;
         restart();
         connectName.s = Serial.list()[setserial];
      } 
}

void mousePressed()
{
  if (setport)
  {
  for (int i=0;i<Serial.list().length;i++)
    {
    if ((mouseY<90+i*30)&&(mouseY>60+i*30))
    {setserial = i;}
    }
  }
  
 phase = s1.change(phase);
 adc2 = s2.change(adc2); 
 speed = s4.change(speed); 
 interpol = sint.change(interpol); 
}
