float plot_draw(int x0, int y0, int xh, int yh, float A, float Abuf, int colo)    //function for painting graphic
{
    t = (millis()%(int(float(maxs)*1000)));    //new Time
  
    if (A>yh)
    {A=yh;}                       //hight limit
        if (A<0)
        {A=0;}                       //low limit
    
    stroke(colo);              //color of line
    line(x0+(t0/1000)*xh/float(maxs),(y0+yh-Abuf),x0+(t/1000)*xh/float(maxs),(y0+yh-A));

    Abuf = A;                //put at buffer
    return Abuf;
}

float speed_plot_draw(int x0, int y0, int xh, int yh, float A, float Abuf)    //function for painting graphic
{
    t = (millis()%(int(float(maxs)*1000)));    //new Time
  
    if (A>yh)
    {A=yh;}                       //hight limit
        if (A<0)
        {A=0;}                       //low limit
   // A=(A+Abuf)/2;
    stroke(#ff2400);              //color of line
    line(x0+(ts/1000)*xh/float(maxs),(y0+yh-Abuf),x0+(t/1000)*xh/float(maxs),(y0+yh-A));

    Abuf = A;                //put at buffer
    return Abuf;
}
