public class textbox
{
public boolean use = false;
public int textX = 0;
public int textY = 0;
public int textH = 20;
public int maxsym = 5;
public String s = "0";
  
 public void sett(int x,int y,int h,int l)
 { textX=x;
   textY=y;
   textH=h;
   maxsym=l;  }
  
 public void viewTextbox()
 {
   if ((mouseX>textX)&&(mouseX<textX+maxsym*15+4)&&(mouseY<textY+textH+5)&&(mouseY>textY))
   {fill(#507030); use = true;}     //color of rect
   else
   {fill(#735184); use = false;} 
   
   stroke(255,255,255);            //color of stroke
   rect(textX,textY,maxsym*15+4,textH+4);
  
  fill(255);                       //color of text
  textSize(textH);
  text(s,textX+4,textY+textH);
 } 
 
 public void editTextbox()
 {
    if ((use)&&(key>='0')&&(key<='9')&&(s.length()<maxsym)||(key==46)||(key=='-'))
    {
    s+=key;
    }
    
    if ((use)&&(int(key)==8)&&(s.length()>0))
    {
    s = s.substring(0,s.length()-1);
    } 
 }
 
}
