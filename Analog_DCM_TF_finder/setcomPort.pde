void setcomPort()
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
