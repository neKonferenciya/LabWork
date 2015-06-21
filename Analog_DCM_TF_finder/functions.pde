void restart()
{
 background(0x735184);

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
