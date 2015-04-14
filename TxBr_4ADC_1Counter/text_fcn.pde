String s1 = "1";
boolean sb1 = false;
String s2 = "1";
boolean sb2 = false;
String s3 = "1";
boolean sb3 = false;
String s4 = "1";
boolean sb4 = false;
String rot = "360";
boolean rotb = false;
String maxs = "5";           //max second limite
boolean timb = false;     

String A = "2";        //SIN options
boolean Ab = false;
String B = "0";
boolean Bb = false;
String C = "0";
boolean Cb = false;
String dU = "2.5";
boolean dUb = false;
String Om = "3.14";
boolean Omb = false;

String entertext(String s)        //Function for entering text
{
     if ((key>='0')&&(key<='9')&&(s.length()<4)||(key==46)||(key=='-'))
    {
    s+=key;
    }
    
     if ((int(key)==8)&&(s.length()>0))
    {
    s = s.substring(0,s.length()-1);
    } 
    return s;
}


boolean textrect(int x, int y, int xh, int yh, String s, boolean sb, String comm)    
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
  text(comm+s, x+5, y+16);
  
  return sb;
}
