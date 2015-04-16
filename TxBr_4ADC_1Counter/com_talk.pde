void com_talk()          //talking with COM-port
{
    int buf1 = 0;
    int buf2 = 0;
    bufC = 0;
    
    COMport.write(Udac);
    delay(20);
    adc1 = COMport.read();
    adc2 = COMport.read(); 
    adc3 = COMport.read(); 
    adc4 = COMport.read(); 
    buf1 = COMport.read();
    buf2 = COMport.read();
    
    bufC = buf1+255*buf2;      //encoder counter - 2^16
    
    counA = counA+bufC;
}


