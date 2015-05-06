import processing.serial.*;
import javax.swing.JFrame;
import java.awt.BorderLayout;
import java.awt.Insets;
Serial COMport; 
int setserial = 2;

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
boolean play = false;

float tphase = 0;      //time to phase
int phase = 0;
int bphase = 0;

float maxdac = 0;
float maxspeed = 0;
float mindac = 500;
float minspeed = 500;
float maxsum = 0;
float minsum = 1000;    //var for phase

float ts = 0;                        //time for speed_plot
int bufC = 0;                        //bufer for counter
float[] speedbuf = new float[6];     //bufer for speed
boolean speed_gr = false;            //draw speed graphic ???
boolean dac_gr = false;              //draw DAC graphic ???
String s_dac = "АЦП";
int si = 0;                          //conter of bufer 

int Udac = 0;            //DAC-voltag

NewApplet menu = new NewApplet();
EmbeddedSketch eSketch;
boolean menuview = true;

  void setup() 
  {
  size(400,400); 
  textSize(20);   
  }
  
  void draw()
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
   }
 
   void mousePressed() 
  {
    for (int i=0;i<Serial.list().length;i++)
    {
    if ((mouseY<80+i*30)&&(mouseY>60+i*30))
    {setserial = i;}
    }
    
  }
  
      void keyPressed()
    {
      if ((key == 'P')||(key == 'p')||(key == 32))
      {
         COMport = new Serial(this, Serial.list()[setserial], 115200);    //make connect
         eSketch = new EmbeddedSketch(menu);
      }
    }

