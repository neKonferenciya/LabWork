import processing.serial.*;
import javax.swing.JFrame;
import java.awt.BorderLayout;
import java.awt.Insets;
Serial COMport; 
int setserial = 0;

float adc1 = 0;      //global var of ADC
float adc21 = 0;
float adc22 = 0;    
float adc3 = 0;
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
boolean play = false;

float tphase = 0;      //time to phase
float phase0 = 0;
float phase2 = 0;
float phase3 = 0;
int bphase = 0;

float maxdac = 0;
float maxspeed = 0;
float maxadc1 = 0;
float maxadc3 = 0;
float mindac = 500;
float minspeed = 500;
float minadc1 = 500;
float minadc3 = 500;

float maxsum1 = 0;
float minsum1 = 1000; 
float maxsum2 = 0;
float minsum2 = 1000;
float maxsum3 = 0;
float minsum3 = 1000;//var for phase

float ts = 0;                        //time for speed_plot
int bufC = 0;                        //bufer for counter
float[] speedbuf = new float[6];     //bufer for speed
boolean speed_gr = false;            //draw speed graphic ???
String s_dac = "АЦП";
int si = 0;                          //conter of bufer 

int Udac = 0;            //DAC-voltag

NewApplet menu = new NewApplet();
EmbeddedSketch eSketch;
boolean setmenu = false;

void setup()
{      
  size (1320, 620);
  eSketch = new EmbeddedSketch(menu);
}
    
void draw()        //main body
{
  if (setmenu)
  {
  if (play)
  {
  
  float k256 = 256/5;
  float k1024 = 1024/5;
  t = (float(millis())/1000)%float(maxs);
  Udac = int(float(A)*k256*sin(float(Om)*t+float(B)*t*t)+(t*float(C)*k256*cos(float(Om)*t))%256+float(dU)*k256);
    if (Udac<0)
    {Udac = 0;};

    if (Udac>255)      //U(DAC) limit
    {Udac = 255;}
  
  if (play)
  {                                                    //refresh of text
  text_canva(adc1/k256,adc21/k1024,adc3/k256,phase0);  
  adc1b = plot_draw(10,5,640,150,adc1*(1)*150/256,adc1b,#ff2400);
  adc2b = plot_draw(660,5,640,150,adc21*(1/float(s2))*150/1024,adc2b,#ff2400);          //change
  adc3b = plot_draw(10,200,640,150,adc3*(1)*150/256,adc3b,#ff2400);
  adc4b = plot_draw(660,200,640,150,(Udac*150/256),adc4b,#ff2400);
  bphase = int(plot_draw(660,200,640,150,phase0*150/180,bphase,#0000ff)); 
                                                         
 si++;
 if (si==4)
 {
 //speed = (sqrt((speedbuf[0])*(speedbuf[1]))+sqrt((speedbuf[2])*(speedbuf[3]))+sqrt((speedbuf[3])*(speedbuf[4]))+sqrt((speedbuf[1])*(speedbuf[4])))/2; 
 speed = ((speedbuf[0])+(speedbuf[1])+(speedbuf[2])+(speedbuf[3]))/4;
 si = 0;
 speed_gr = true;
 }
 
    if (countb)
      {counb = plot_draw(660,430,640,150,((counA%512)*150/512),counb,#ff2400);}            //Only positiv counter-plot
    else
    {  
      if (speed_gr)
      {
      speedb = speed_plot_draw(660,430,640,150,(speed*150/30),speedb);        //Show speed-plot (scale max 20 rot by sec)
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
     { restart(); }                        //  time for restart           
  }  
    

    if (speed>maxspeed)
    {maxspeed = speed;}
    if (speed<minspeed)
    {minspeed = speed;}
    if (Udac>int(maxdac))                                        // Phase-metr
    {maxdac = float(Udac);}
    if (Udac<int(mindac))                                        
    {mindac = float(Udac);}
    if (adc1>maxadc1)
    {maxadc1 = adc1;}
    if (adc3>maxadc3)
    {maxadc3 = adc3;}
    
    if (adc1<minadc1)
    {minadc1 = adc1;}
    if (adc3<minadc3)
    {minadc3 = adc3;}
    
    if ((speed+Udac)>maxsum1)                                     // Phase-metr 1
    {maxsum1 = speed+float(Udac);}
    if ((speed+Udac)<minsum1)
    {minsum1 = speed+float(Udac);}  
    if ((adc1+Udac)>maxsum2)                                      // Phase-metr 2
    {maxsum2 = adc1+float(Udac);}
    if ((adc1+Udac)<minsum2)
    {minsum2 = adc1+float(Udac);}
    if ((adc3+Udac)>maxsum3)                                      // Phase-metr 3
    {maxsum3 = adc3+float(Udac);}
    if ((adc3+Udac)<minsum3)
    {minsum3 = adc3+float(Udac);}
    
    t = (millis()); 
    if ((t-tphase)/1000>2*3.14/(float(Om)))                      //get phase                
       {
         if ((maxdac-mindac)*(maxspeed-minspeed)==0)
         {phase0 = 0;}
         else
         {phase0 = acos(((maxsum1-minsum1)*(maxsum1-minsum1)-(maxdac-mindac)*(maxdac-mindac)-(maxspeed-minspeed)*(maxspeed-minspeed))/(2*(maxdac-mindac)*(maxspeed-minspeed)));}
         phase2 = acos(((maxsum2-minsum2)*(maxsum2-minsum2)-(maxdac-mindac)*(maxdac-mindac)-(maxadc1-minadc1)*(maxadc1-minadc1))/(2*(maxdac-mindac)*(maxadc1-minadc1)));
         phase3 = acos(((maxsum3-minsum3)*(maxsum3-minsum3)-(maxdac-mindac)*(maxdac-mindac)-(maxadc3-minadc3)*(maxadc3-minadc3))/(2*(maxdac-mindac)*(maxadc3-minadc3)));
         tphase = (millis()); 
         phase0 = (phase0-phase2/2-phase3/2)*180/3.14;

        maxdac = 0;
        maxspeed = 0;
        maxadc1 = 0;
        maxadc3 = 0;        //return default
        mindac = 500;
        minspeed = 500;
        minadc1 = 500;
        minadc3 = 500;         
          maxsum1 = 0;
          minsum1 = 1000; 
          maxsum2 = 0;
          minsum2 = 1000;
          maxsum3 = 0;
          minsum3 = 1000;
       }  
       fill(255);          //color of text
       textSize(20);
       if (play)
       {
         text("T = "+float(round((float(millis())/1000)%float(maxs)*100))/100,1190,380);
       }
    
  sb1 = textrect(50, 170,80,25,s1,sb1,"k1=");    //enter correct koeff.
  sb2 = textrect(700, 170,80,25,s2,sb2,"k2=");
  sb3 = textrect(50, 360,80,25,s3,sb3,"k3=");
  timb = textrect(50, 400,80,25,maxs,timb,"T=");
  
  rotb = textrect(720, 590,80,25,rot,rotb,"rot=");
  
  Ab = textrect(500, 380,80,25,A,Ab,"U1=");  //SIN options input
  Omb = textrect(500, 420,80,25,Om,Omb,"W1=");
  Bb = textrect(500, 460,80,25,B,Bb,"W2=");
  Cb = textrect(500, 500,80,25,C,Cb,"U2=");
  dUb = textrect(500, 540,80,25,dU,dUb,"U0=");
  
  button(1100, 590,90,25,counS);             // counter-button
  
  }
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
    if ((mouseX>=1100)&&(mouseX<=1100+90)&&(mouseY>590)&&(mouseY<=590+25))      //change counter - speed graphic
  { 
   countb = countb^true;
   
   if (countb)
   { counS = " СЧЕТЧИК"; }
   else
   { counS = "ТАХОМЕТР"; }
  }  
}

