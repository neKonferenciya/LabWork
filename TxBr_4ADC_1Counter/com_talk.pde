void com_talk()          //talking with COM-port
{
    int buf1 = 0;
    int buf2 = 0;
    
    COMport.write(test);
    delay(1);
    adc1 = COMport.read();
    adc2 = COMport.read(); 
    adc3 = COMport.read(); 
    adc4 = COMport.read(); 
    buf1 = COMport.read();
    buf2 = COMport.read();
    
    //if (bufC>128)
    {bufC = buf1-buf2;}
    
    counA = counA+bufC;
}


