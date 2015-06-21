public class plot
{
public float oldX=0;
public float oldY=0;
public int X0=0;
public int Y0=0;
public int dX=0;
public int dY=0;
public int r=150;
public int g=0;
public int b=0;
public float Xmax=0;
public float[][] a = new float[4][2]; 
int i = 0; 
int j = 0;
float sum = 0;
float ts = 0;

public void refresh(int x0,int y0, int dx, int dy,float xmax)
{
  oldX = 0;
  oldY = 0;      //Clear bufer data
  
  X0=x0; Y0=y0; dX=dx; dY=dy; Xmax=xmax;
  
  fill(250);
  stroke(0);
  rect(X0,Y0,dX,dY);    // Draw rect
  
  stroke(210);
  for (int i=0;i<=9;i++)
  { line(X0,Y0+dY*i/10,X0+dX,Y0+dY*i/10); }     // Y grid

  for (int i=1;i<round(Xmax*10);i++)
  {line(X0+dX*i/(10*Xmax),Y0,X0+dX*i/(10*Xmax),Y0+dY);}
  textSize(10);                                 
  fill(0);
  stroke(150);
   for (int i=1;i<round(Xmax);i++)
  { line(X0+dX*i/Xmax,Y0,X0+dX*i/Xmax,Y0+dY);
  text(i,X0+2+dX*i/Xmax,Y0+dY-3);  }            //X-second grid
}
  
public void addpoint(float x,float y)
{
  stroke(r,g,b);
  if (y>dY) {y=dY;}
  if (y<0) {y=0;}
  line(X0+oldX*dX/Xmax,Y0+dY-oldY,X0+x*dX/Xmax,Y0+dY-y);
  oldX=x;
  oldY=y;
}

public void Newton(float y, float t)
{
  int N = 5;

  if (j<N) {j++; sum+=y; ts+=t;}
  else
  {
  if (i<3) 
{  a[i][0] = ts/N;
   a[i][1] = sum/N;
   i++;
   sum = 0;
   ts = 0;
   j=0;     }
  else
    {
  for (float x=a[0][0];x<a[2][0];x+=0.01)
      {
      float h=a[2][1]-a[1][1];  
      float H=a[0][1]+( (a[1][1]-a[0][1])*(x-a[0][0])/h )+( (a[2][1]-2*a[1][1]+a[0][1])*( -1+(x-a[0][0])/h )*(x-a[0][0])/(2*h) );  
      addpoint(t,H);
      }
    i=0;
    }          // ????????
  } 
}
  
}
