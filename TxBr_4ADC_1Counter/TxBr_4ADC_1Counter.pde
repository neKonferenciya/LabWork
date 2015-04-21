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
float t = 0;        //global var of universal time
float t0 = 0; 
float tcom = 0;          //COM-port time-counter
boolean play = true;

float ts = 0;                        //time for speed_plot
int bufC = 0;                        //bufer for counter
float[] speedbuf = new float[5];     //bufer for speed
boolean speed_gr = false;            //draw speed graphic?
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
  //tdac = (float(millis())/1000)%float(maxs);
  
  float k256 = 256/5;
  //t = (millis()%(int(float(maxs)*1000)));
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
  adc4b = plot_draw(660,200,640,150,(Udac*(1/float(s4))*150/256),adc4b);
                                                         
 si++;
 if (si==3)
  {
 speed = ((speedbuf[0])+(speedbuf[1])+(speedbuf[2])+(speedbuf[3]))/4;
 si = 0;
 speed_gr = true;
 }
 
    if (countb)
      {counb = plot_draw(660,400,640,150,((counA%512)*150/512),counb);}            //Only positiv counter-plot
    else
    {  
      if (speed_gr)
      {
      speedb = speed_plot_draw(660,400,640,150,(speed*150/100),speedb);        //Show speed-plot (scale +/- 50 rot by sec)
      speed_gr = false;
      
        //if ((t/1000)*640/float(maxs)>(640-10))
        //{ts = ts - 1000*float(maxs)+150;}
        //else
        ts = t;
      }
    }
  } 
 
     t = (millis()%(int(float(maxs)*1000)));              //time NOW
     speedbuf[si] = (1000*float(bufC)/float(rot))/(t-tcom);      text(t-tcom,380,190);
                                
     tcom = (millis()%(int(float(maxs)*1000)));                  // Time ZONE
     { com_talk();  }      
     t0 = t;     
 
      if ((float(maxs)*1000-t)<=50)
     { restart(); }                        //  time for restart                       //  time for restart 
  }  
    
  sb1 = textrect(50, 170,80,25,s1,sb1,"k1=");    //enter correct koeff.
  sb2 = textrect(700, 170,80,25,s2,sb2,"k2=");
  sb3 = textrect(50, 360,80,25,s3,sb3,"k3=");
  sb4 = textrect(700, 360,80,25,s4,sb4,"k4=");
  rotb = textrect(720, 560,80,25,rot,rotb,"rot=");
  timb = textrect(50, 400,80,25,maxs,timb,"T=");
  countb = rotor(1100, 560,80,25,countb,"СЧЕТЧИК");
  Ab = textrect(500, 380,80,25,A,Ab,"A=");            //SIN options input
  Bb = textrect(500, 420,80,25,B,Bb,"B=");
  Cb = textrect(500, 460,80,25,C,Cb,"C=");
  dUb = textrect(500, 500,80,25,dU,dUb,"U0=");
  Omb = textrect(500, 540,80,25,Om,Omb,"Om=");
  
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

