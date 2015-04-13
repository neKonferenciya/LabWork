boolean countb = false; 
float speed = 0;
float speedb = 0;
float dcount = 0;

boolean rotor(int x, int y, int xh, int yh, boolean sb, String comm)    
{                                              //function for drawing counter-plot in rect
  fill(#735184); 
  stroke(255);
  rect(x,y,xh,yh);
  if ((mouseX>=x)&&(mouseX<=x+xh)&&(mouseY>y)&&(mouseY<=y+yh))
  {
  fill(#806b2a);               //Block of rect
  rect(x,y,xh,yh);
  sb = true;
  }
  else
  {sb = false;}
  
  fill(255);
  textSize(15);                         //Block of output text
  text(comm, x+5, y+19);
  
  return sb;
}
  //
    //
      //
