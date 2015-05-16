void text_canva(float num1, float num2, float num3, float num4)      //function for painting main body
{ 
 fill(#735184);      //color of rect
 noStroke();         //no "abris"
 rect (20,155,1300,40);  //paint rect
 rect (20,355,1300,40);
 rect (840,625,1300,-40);
 rect (190,485,200,-55);
 fill(255);          //color of text
 textSize(20);       
 text("АЦП1= "+float(round(num1*float(s1)*1000))/1000+" x"+s1, 200, 190);  //output text
 text("АЦП2= "+float(round(num2*1000))/1000+" x"+s2, 850, 190);  
 text("АЦП3= "+float(round(num3*float(s3)*1000))/1000+" x"+s3, 200, 380);  
 text("Фаза= "+float(round(num4*10))/10, 850, 380);  
     if (countb)
     {text("Тактов= "+counA, 850, 610); }
     else
     {text("Скорость= "+float(round(speed*1000))/1000, 850, 610);}
}
//
  // 
    //
