void com_talk()          //talking with COM-port
{
    COMport.write(test);
    delay(1);
    adc1 = COMport.read();
    adc2 = COMport.read(); 
    adc3 = COMport.read(); 
    adc4 = COMport.read(); 
    bufC = COMport.read();
    
    if (bufC>128)
    {bufC = bufC-256;}
    
    counA = counA+bufC;
}


