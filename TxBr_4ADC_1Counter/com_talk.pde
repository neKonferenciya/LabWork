void com_talk()          //talking with COM-port
{
    int buf1 = 0;
    int buf2 = 0;
    bufC = 0;
    
    //tcontrol = millis();
    COMport.write((Udac));
    delay(1);
    adc1 = COMport.read();
    adc2 = COMport.read(); 
    adc3 = COMport.read(); 
    adc4 = COMport.read(); 
    buf1 = COMport.read();
    buf2 = COMport.read();
    
    //text((millis()-tcontrol),1200,600);
    
    bufC = buf1+255*buf2;      //encoder counter - 2^16
    
    counA += bufC;
}


