void restart()
{
 background(0x735184);

a1=0; a2=0; a3=0; Udac=0;
tphase = 0;

plot1.refresh(10,7,800,150,float(T.s));

plot2.r=200;  plot3.g=2;  plot2.b=0;
plot2.refresh(10,7+155,800,150,float(T.s));

plot3.r=0;  plot3.g=0;  plot3.b=200;
plot3.refresh(10,7+155*2,800,150,float(T.s));

plot4.r=0;  plot4.g=100;  plot4.b=0;
plot4.refresh(10,7+155*3,800,150,float(T.s));

}




float roundn(float f, int N)
{
  return float(round(f*N))/N;
}




void comTalk()
{
 int a32 = 0;
 int buf1 = 0;
 int buf2 = 0;
 bufC = 0;
 
 COMport.write(int(Udac*255/5));
 delay(1); 
 a1 = COMport.read();
 a3 = COMport.read();
 a32 = COMport.read();
 a2 = COMport.read();
 buf1 = COMport.read();
 buf2 = COMport.read();
 dt = COMport.read();
 
 dt = dt/1000;
 a3 = a3+a32*255;    //return ADC2
 bufC = buf1+255*buf2; 
 counA += bufC;
}


float getPhase(float u1, float u2, float u3)
{
  float p=0;
  p = (180/PI) * acos( (u3*u3 - u1*u1 - u2*u2)/(2*u1*u2) );
 return p; 
}
