void plot_grid(int x0, int y0, int xh, int yh, float step)      //function for painting plot's grid
{
  fill(255);              //color of plot
  rect (x0,y0,xh,yh);     //paint white rect
  stroke(200);              //color of line
  
  for (int i=0; i<=round(float(maxs)/step)-1; i++)        
  {
    stroke(0);
    line((x0+i*step*xh/float(maxs)),y0,(x0+i*step*xh/float(maxs)),y0+yh);  //Y-line black
      for (int j=1;j<=4;j++)                              
      {
       stroke(200);              //color of line 
       line((x0+i*step*xh/float(maxs))+j*step*xh/(5*float(maxs)),y0,(x0+i*step*xh/float(maxs))+j*step*xh/(5*float(maxs)),y0+yh);  //Y-line grey 
      }
    textSize(10); 
    fill(0);
    text((i*step),(x0+i*step*xh/float(maxs)),y0+round(yh/2)+12);        //timescale
  }
  for (int i=1;i<=9;i++)
  {
    line(x0,(y0+(i*yh/10)),x0+xh,((y0+(i*yh/10))));  //X-line gray
  }
    stroke(0);              //color of line
    line(x0,(y0+(yh/2)),x0+xh,((y0+(yh/2))));  //X-line black  
}
