boolean sb1 = false;
String[] as= new String[10];

void setup()
{ 
  size (500, 500);
  as[0]="";
}

void draw()
{
  background(0x735184);
  sb1 = text_rect(50,50,200,20,as[0],sb1);
  
}

void keyPressed()
{
  as[0] = enter_text(as[0],sb1);
}
