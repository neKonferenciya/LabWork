void restart()
{
  t0 = 0;                            //reset timer
  ts = 0;
  
  if (play)
  {
    tcom = 0;     //reset counter
    
  background(0x735184);
  fill(255);
  textSize(15);
  text("SPACE или P(p) для Паузы", 10, 520);  //SPACE for pause
  text("ESC для ВЫХОДА", 10, 540);  //ESC for exit
  text("HandMade by TxBr", 10, 600);
  text("ПС2-81, МВТУ", 10, 615);
  text("Serial: "+Serial.list()[setserial], 10, 573);
  
  text("ЦАП: U(t) = "+A+"*sin( "+Om+"*t+"+B+"*t*t) + "+C+"*t*cos("+Om+"*t) + "+dU,750,415); 
  
  plot_grid(10,5,640,150,1);          // make a plotgrids
  plot_grid(660,5,640,150,1);
  plot_grid(10,200,640,150,1);
  plot_grid(660,200,640,150,1);
  plot_grid(660,430,640,150,1);
  }  
}
