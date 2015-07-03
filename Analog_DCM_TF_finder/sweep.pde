public class sweep
{
  float max = 0;
  float min = 99999;            // var for sweep
  
 public void wait(float b)    //found max and min
{
  if (b>max)  {max = b;}
  if (b<min)  {min = b;}
} 

public void refresh()
  { max = 0;
    min = 999999;  }
    
public float amp()
{return (max-min);}
  
  
   
  
}
