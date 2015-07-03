public class textbox
{
public boolean use = false;
public int textX = 0;
public int textY = 0;
public int textH = 20;
public int maxsym = 5;
public String s = "1";
public String sb = "e= ";
  
 public void sett(int x,int y,int h,int l, String s)
 { textX=x;
   textY=y;
   textH=h;
   maxsym=l;
   sb = s;  }
  
 public void viewTextbox()
 {
   if ((mouseX>textX)&&(mouseX<textX+(maxsym+sb.length())*15)&&(mouseY<textY+textH+5)&&(mouseY>textY))
   {fill(#507030); use = true;}     //color of rect
   else
   {fill(#735184); use = false;} 
   
   stroke(255,255,200);            //color of stroke
   rect(textX,textY,maxsym*0.81*textH+sb.length()*0.6*textH,textH+4);
  
  fill(255,255,200);                       //color of text
  textSize(textH);
  text(sb+s,textX+4,textY+textH);
 } 
 
 
  public void viewTextNow(float val, int r, int g, int b)
 {
   if ((mouseX>textX)&&(mouseX<textX+(maxsym+sb.length())*15)&&(mouseY<textY+textH+5)&&(mouseY>textY))
   {fill(r,g,b); use = true;}     //color of rect
   else
   {fill(#735184); use = false;} 
   
   stroke(255,255,200);            //color of stroke
   rect(textX,textY,(maxsym+sb.length())*15,textH+4);
  
  fill(255,255,200);                       //color of text
  textSize(textH);
  text(sb+val,textX+4,textY+textH);
 } 
 
   public void viewTextString(int r, int g, int b)
 {
   if ((mouseX>textX)&&(mouseX<textX+(maxsym+sb.length())*15)&&(mouseY<textY+textH+5)&&(mouseY>textY))
   {fill(r,g,b); use = true;}     //color of rect
   else
   {fill(#735184); use = false;} 
   
   stroke(255,255,200);            //color of stroke
   rect(textX,textY,s.length()*(0.55*textH)+sb.length()*(0.55*textH),textH+4);
  
  fill(255,255,200);                       //color of text
  textSize(textH);
  text(sb+s,textX+4,textY+textH);
 } 
 
 public void editTextbox()
 {
    if ((use)&&((key>='0')&&(key<='9')&&(s.length()<maxsym)||(key==46)||(key=='-')))
    {
    s+=key;
    }
    
    if ((use)&&(int(key)==8)&&(s.length()>0))
    {
    s = s.substring(0,s.length()-1);
    } 
 }
 
 public boolean change(boolean b)
 {
   if ((mouseX>textX)&&(mouseX<textX+(maxsym+sb.length())*15)&&(mouseY<textY+textH+5)&&(mouseY>textY))
   {b = b^true;}
   return b;
 }
 
}
