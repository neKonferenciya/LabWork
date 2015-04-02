String enter_text(String s, boolean sb)        //Function for entering text
{
  if (sb)
  {
     if (((key>='0')&&(key<='9')&&(s.length()<20)||(key==46))||((key>='a')&&(key<='z')&&(s.length()<20)))
    {
    s+=key;
    }
    
     if ((int(key)==8)&&(s.length()>0))
    {
    s = s.substring(0,s.length()-1);
    } 
  } 
    return s;
}


boolean text_rect(int x, int y, int xh, int yh, String s, boolean sb)    
{                                              //function for drawing rect-text
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
  text(s, x+5, y+16);
  
  return sb;
}
