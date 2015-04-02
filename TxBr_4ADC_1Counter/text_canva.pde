void text_canva(float num1, float num2, float num3, float num4)      //function for painting main body
{ 
 fill(#735184);      //color of rect
 noStroke();         //no "abris"
 rect (20,155,1300,40);  //paint rect
 rect (20,355,1300,40);
 rect (840,595,1300,-40);
 rect (190,485,200,-55);
 fill(255);          //color of text
 textSize(20);       
 text("ADC1= "+float(round(num1*1000))/1000+" x"+s1, 200, 190);  //output text
 text("ADC2= "+float(round(num2*1000))/1000+" x"+s2, 850, 190);  
 text("ADC3= "+float(round(num3*1000))/1000+" x"+s3, 200, 380);  
 text("ADC4= "+float(round(num4*1000))/1000+" x"+s4, 850, 380);  
     if (countb)
     {text("Counter= "+counA, 850, 580); }
     else
     {text("Speed= "+speed, 850, 580);}
}
//
  // 
    //
