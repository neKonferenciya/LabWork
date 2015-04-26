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
int counA = 0;
float counb = 0;
boolean countb = false; 
String counS = "ТАХОМЕТР";
float t = 0;        //global var of universal time
float t0 = 0; 
float tcom = 0;          //COM-port time-counter
boolean play = true;

float tphase = 0;      //time to phase
float phase = 0;
float maxdac = 0;
float maxspeed = 0;
float maxsum = 0;

float ts = 0;                        //time for speed_plot
int bufC = 0;                        //bufer for counter
float[] speedbuf = new float[5];     //bufer for speed
boolean speed_gr = false;            //draw speed graphic ???
boolean dac_gr = false;              //draw DAC graphic ???
String s_dac = "АЦП";
int si = 0;                          //conter of bufer 

int Udac = 0;            //DAC-voltag

void setup()
{      
    COMport = new Serial(this, Serial.list()[2], 115200);    //make connect
  size (1320, 620);
  restart();
}
                                                    
void draw()        //main body
{
  if (play)
  {
  
  float k256 = 256/5;
  t = (float(millis())/1000)%float(maxs);
  Udac = int(float(A)*k256*sin(float(Om)*t+float(B)*t*t)+(t*float(C)*k256*cos(float(Om)*t))%256+float(dU)*k256);
    if (Udac<0)
    {Udac = 0;};
    if (Udac>255)      //U(DAC) limit
    {Udac = 255;}
  
  if (play)
  {                                                    //refresh of text
  text_canva(adc1/k256,adc2/k256,adc3/k256,adc4/k256);  
  adc1b = plot_draw(10,5,640,150,adc1*(1/float(s1))*150/256,adc1b);
  adc2b = plot_draw(660,5,640,150,adc2*(1/float(s2))*150/256,adc2b);
  adc3b = plot_draw(10,200,640,150,adc3*(1/float(s3))*150/256,adc3b);
  if (dac_gr)
  { adc4b = plot_draw(660,200,640,150,(Udac*(1/float(s4))*150/256),adc4b); }
  else
  { adc4b = plot_draw(660,200,640,150,(adc4*(1/float(s4))*150/256),adc4b); }
                                                         
 si++;
 if (si==3)
  {
 speed = ((speedbuf[0])+(speedbuf[1])+(speedbuf[2])+(speedbuf[3]))/4;
 si = 0;
 speed_gr = true;
 }

 
    if (countb)
      {counb = plot_draw(660,430,640,150,((counA%512)*150/512),counb);}            //Only positiv counter-plot
    else
    {  
      if (speed_gr)
      {
      speedb = speed_plot_draw(660,430,640,150,(speed*150/100),speedb);        //Show speed-plot (scale +/- 50 rot by sec)
      speed_gr = false;
      
        ts = t;
      }
    }
  } 
 
     t = (millis()%(int(float(maxs)*1000)));                    //time NOW
     speedbuf[si] = (1000*float(bufC)/float(rot))/(t-tcom);     
                                
     tcom = (millis()%(int(float(maxs)*1000)));                  // Time ZONE
     { com_talk();  }      
     t0 = t;  
 
      if ((float(maxs)*1000-t)<=50)
     { restart(); }                        //  time for restart                       //  time for restart 
  }  
    
    if (speed>maxspeed)
    {maxspeed = speed;}
    if (Udac>int(maxdac))                                        // Phase-metr
    {maxdac = float(Udac);}
    if ((speed+Udac)>maxsum)
    {maxsum = speed+float(Udac);}
    if ((t-tphase)/1000>2*3.14/float(Om))                  
       {
         phase = (acos(((maxsum*maxsum)-(maxdac*maxdac)-(maxspeed*maxspeed))/(2*maxdac*maxspeed)))*180/3.14;
         tphase = (millis()%(int(float(maxs)*1000))); 
       }      
       text("Фаза = "+phase,1170,380);
    
  sb1 = textrect(50, 170,80,25,s1,sb1,"k1=");    //enter correct koeff.
  sb2 = textrect(700, 170,80,25,s2,sb2,"k2=");
  sb3 = textrect(50, 360,80,25,s3,sb3,"k3=");
  sb4 = textrect(700, 360,80,25,s4,sb4,"k4=");
  timb = textrect(50, 400,80,25,maxs,timb,"T=");
  
  rotb = textrect(720, 590,80,25,rot,rotb,"rot=");
  //countb = rotor(1100, 590,80,25,countb,"СЧЕТЧИК");
  
  Ab = textrect(500, 380,80,25,A,Ab,"U1=");  //SIN options input
  Omb = textrect(500, 420,80,25,Om,Omb,"W1=");
  Bb = textrect(500, 460,80,25,B,Bb,"W2=");
  Cb = textrect(500, 500,80,25,C,Cb,"U2=");
  dUb = textrect(500, 540,80,25,dU,dUb,"U0=");
  
  button(1115,360,45,25,s_dac);              // DAC-button
  button(1100, 590,90,25,counS);             // counter-button
  
}

void keyPressed()                        // STOP-interrapt
{
  if ((key == 'P')||(key == 'p')||(key == 32))
  {
    play = play^true;                   //PAUSE!!! by P or Space
     textSize(60);
     fill(#ff0000);
     text("ПАУЗА", 190, 480); 
     counA=0; 
     Udac = 0;
   com_talk();
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
                      {maxs = entertext(maxs);} 
      if (Ab)
      {A = entertext(A);} 
        if (Bb)
        {B = entertext(B);} 
          if (dUb)
          {dU = entertext(dU);} 
            if (Omb)
            {Om = entertext(Om);} 
              if (Cb)
              {C = entertext(C);} 
                      
 }      
}

void mousePressed()
{
  if ((mouseX>=1115)&&(mouseX<=1115+45)&&(mouseY>360)&&(mouseY<=360+25))      //change adc - dac graphic
  {
   dac_gr = dac_gr^true;
   
   if (dac_gr)
   { s_dac = "ЦАП"; }
   else
   { s_dac = "АЦП"; }
  }
  
    if ((mouseX>=1100)&&(mouseX<=1100+90)&&(mouseY>590)&&(mouseY<=590+25))      //change counter - speed graphic
  { 
   countb = countb^true;
   
   if (countb)
   { counS = " СЧЕТЧИК"; }
   else
   { counS = "ТАХОМЕТР"; }
  }  
}

