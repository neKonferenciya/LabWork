public class plot
{
public float oldX=0;
public float oldY=0;
public int X0=0;
public int Y0=0;
public int dX=0;
public int dY=0;
public float Xmax=0;

public void refresh(int x0,int y0, int dx, int dy,float xmax)
{
  oldX = 0;
  oldY = 0;      //Clear bufer data
  
  X0=x0; Y0=y0; dX=dx; dY=dy; Xmax=xmax;
  
  fill(255);
  stroke(0);
  rect(X0,Y0,dX,dY);    // Draw rect
  
  stroke(200);
  for (int i=0;i<=9;i++)
  { line(X0,Y0+dY*i/10,X0+dX,Y0+dY*i/10); }     // Y grid

  for (int i=1;i<round(Xmax*10);i++)
  {line(X0+dX*i/(10*Xmax),Y0,X0+dX*i/(10*Xmax),Y0+dY);}
  textSize(10);                                 
  fill(0);
  stroke(0);
   for (int i=1;i<round(Xmax);i++)
  { line(X0+dX*i/Xmax,Y0,X0+dX*i/Xmax,Y0+dY);
  text(i,X0+2+dX*i/Xmax,Y0+dY-3);  }            //X-second grid
}
  
public void addpoint(float x,float y)
{
  stroke(255,0,0);
  if (y>dY) {y=dY;}
  if (y<0) {y=0;}
  line(X0+oldX*dX/Xmax,Y0+dY-oldY,X0+x*dX/Xmax,Y0+dY-y);
  oldX=x;
  oldY=y;
}
  
}
