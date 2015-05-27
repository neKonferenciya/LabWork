void restart()
{
 background(0x735184);

plot1.refresh(10,7,800,150,Tmax);
plot2.refresh(10,7+155,800,150,Tmax);
plot3.refresh(10,7+155*2,800,150,Tmax);
plot4.refresh(10,7+155*3,800,150,Tmax);
}

float roundn(float f, int N)
{
  return float(round(f*N))/N;
}
