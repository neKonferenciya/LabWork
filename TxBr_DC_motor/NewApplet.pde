class EmbeddedSketch extends JFrame {
  PApplet sketch;
  EmbeddedSketch(PApplet p) {
    int w = 400;
    int h = 400;
    sketch = p;
    setVisible(true);
      
    setLayout(new BorderLayout());
    add(p, BorderLayout.CENTER);
    p.init();
      
    Insets insets = getInsets();
    setSize(insets.left + w, insets.top + h);
    p.setBounds(insets.left, insets.top, w, h);
            
    setLocation(0, 0);
  }
}

class NewApplet extends PApplet {
  void setup() 
  { textSize(20);   }
  void draw()
   {
     fill(0);
     rect(0,0,400,400);
     fill(200);
     text("Меню установки соединения:",10,30);  //menu of setting serial connect
       for (int i=0;i<Serial.list().length;i++)
       {
         if (i==setserial)
         {
          fill(#ffaa33);
          text(i+": "+Serial.list()[i],20,80+i*30);
          fill(200);
         } 
         else
         {text(i+": "+Serial.list()[i],20,80+i*30);}
       }
       text("Кликните по порту из списка;",20,330);
       text("Порт выделился желтым;",20,360);
       text("Нажмите ПРОБЕЛ или 'P'",20,390);
   }
 
   void mousePressed() 
  {
    for (int i=0;i<Serial.list().length;i++)
    {
    if ((mouseY<80+i*30)&&(mouseY>60+i*30))
    {setserial = i;}
    }
  } 
  
        void keyPressed()
    {
      if ((key == 'P')||(key == 'p')||(key == 32))
      {
         COMport = new Serial(this, Serial.list()[setserial], 115200);    //make connect
         setVisible(false);
         play = true;
         setmenu = true;
         restart();
      }
    }
}
