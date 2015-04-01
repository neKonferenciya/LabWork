import processing.serial.*; 
Serial COMport; 

float adc1 = 0;      //global var of ADC
float adc2 = 0;
float adc3 = 0;    
float adc4 = 0;
float adc1b = 0;      //global buffer var of ADC
float adc2b = 0;
float adc3b = 0;    
float adc4b = 0;
float counA = 0;
float counb = 0;
float t = 0;        //global var of universal time
float t0 = 0;
int test = 0; 
boolean play = true;
int bufC = 0;      //bufer for counter

void setup()
{      
    COMport = new Serial(this, Serial.list()[2], 115200);    //make connect
  
  size (1320, 620);
  restart();
}
                                                    //main body
void draw()
{
  if (play)
  {
  
  t = (millis()%int(float(maxs)*1000));    //new Time
  if (play)
  {                                                    //refresh of text
  text_canva(adc1*5*float(s1)/256,adc2*5*float(s2)/256,adc3*5*float(s3)/256,adc4*5*float(s4)/256);  
  adc1b = plot_draw(10,5,640,150,adc1*(1/float(s1))*150/256,adc1b);
  adc2b = plot_draw(660,5,640,150,adc2*(1/float(s2))*150/256,adc2b);
  adc3b = plot_draw(10,200,640,150,adc3*(1/float(s3))*150/256,adc3b);
  adc4b = plot_draw(660,200,640,150,(adc4*(1/float(s4))*150/256),adc4b);
 
 speed = (1000*bufC/float(rot))/(t-t0);
 
    if (countb)
      if (counA<0)
      {
      {counb = plot_draw(660,400,640,150,(150+(counA%256)*150/256),counb);}        //Show negativ counter-plot
      }
      else
      {
      {counb = plot_draw(660,400,640,150,((counA%256)*150/256),counb);}        //Show positiv counter-plot
      }
    else
    {speedb = plot_draw(660,400,640,150,(-speed*150/100+150/2),speedb);        //Show speed-plot (scale +/- 50 rot by sec)
    }
  }

     t0 = t;                               //old Time
 
 if (millis()%10 <= 5)
 {  test++;
   com_talk();  }
   

 
   if ((float(maxs)*1000-(millis()%int(float(maxs)*1000)))<=20)
  {  
    restart(); }                        //  time for restart
  }  
    
  sb1 = textrect(50, 170,80,25,s1,sb1,"k1=");    //enter correct koeff.
  sb2 = textrect(700, 170,80,25,s2,sb2,"k2=");
  sb3 = textrect(50, 360,80,25,s3,sb3,"k3=");
  sb4 = textrect(700, 360,80,25,s4,sb4,"k4=");
  rotb = textrect(720, 560,80,25,rot,rotb,"rot=");
  timb = textrect(50, 400,80,25,maxs,timb,"T=");
  countb = rotor(1100, 560,80,25,countb,"СЧЕТЧИК");
  
}

void keyPressed()                        // STOP-interrapt
{
  if ((key == 'P')||(key == 'p')||(key == 32))
  {
    play = play^true;                   //PAUSE!!! by P or Space
     textSize(60);
     fill(#ff0000);
     text("ПАУЗА", 190, 480); 
   restart();  
   }
   
   if (key==27)                        //exit by ESC
   {exit();}
 
 if (!play)
 {
    if (sb1)                           
   {s1 = entertext(s1);}
     if (sb2)
     {s2 = entertext(s2);}              //block of text
         if (sb3)
         {s3 = entertext(s3);} 
              if (sb4)
              {s4 = entertext(s4);} 
                  if (rotb)
                  {rot = entertext(rot);} 
                      if (timb)
                      {maxs = entertext(maxs); 
                      } 
 }                  
}

