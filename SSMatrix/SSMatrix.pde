textbox s1 = new textbox();   //textbox1
textbox s2 = new textbox();   //textbox1
plot plot1 = new plot();
plot plot2 = new plot();
plot plot3 = new plot();
plot plot4 = new plot();

float Tmax=5.5;
float t0=0;
boolean play=true;

void setup()
{
 size(1200,630);
  restart(); 
  
 s1.sett(30,30,20,5);  //set textbox1
 s2.sett(30,70,20,7);  //set textbox2

}

void draw()
{
  
 
 s1.viewTextbox(); 
 s2.viewTextbox(); 

if (play)
{
  t0=(float(millis())/1000)%Tmax;
  plot1.addpoint(t0,50+50*sin(1*t0)); 


  if ((float(millis())/1000)%(Tmax)>Tmax-0.1)
    {restart();}
}
}


void keyPressed()
{
 if (!play) 
 {
  s1.editTextbox();
  s2.editTextbox();      //edit testboxs
  
 }
  
  
  
  if ((key == 'P')||(key == 'p')||(key == 32))
  {
    play = play^true;                   //PAUSE!!! by P or Space
     textSize(50);
     fill(#ff0000);
     text("Пауза", 10, 610); 
   //com_talk();
   if (play)
   {restart();  }
   }
}
