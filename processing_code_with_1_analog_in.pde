import processing.serial.*;

import cc.arduino.*;

Arduino arduino;


void setup() {
    // Prints out the available serial ports.
    println(Arduino.list()); 
    
    arduino = new Arduino(this, Arduino.list()[0], 57600);
  
    arduino.pinMode(7, Arduino.OUTPUT);
    arduino.pinMode(8, Arduino.OUTPUT);
    
    arduino.pinMode(12, Arduino.OUTPUT);
    arduino.pinMode(13, Arduino.OUTPUT);
    
    size(900, 900);
    println(Arduino.list()); 
}

//draw the canvas
void draw() {
      
    //for each column
    for (int i =0; i<3; i++)
    {
        delay(18);
        setColMux(i);
        // for each row
        for(int j=0;j<3; j++)
        {
            delay(18);
            setRowMux(j);
            //set color of each square
            int Color = arduino.analogRead(0);
            setColor(i,j,Color);
        }
        
    }    
}



//select the column you want to turn on
void setColMux(int Control)
{
  //select C0
  if (Control == 0) 
  {
      arduino.digitalWrite(12, Arduino.LOW); //S0
      arduino.digitalWrite(13, Arduino.LOW); //S1
  }
  
  //select C1
  else if (Control == 1)
  {
      arduino.digitalWrite(12, Arduino.HIGH); //S0
      arduino.digitalWrite(13, Arduino.LOW); //S1
  }
  
  //select C1
  else if (Control == 2)
  {
      arduino.digitalWrite(12, Arduino.LOW); //S0
      arduino.digitalWrite(13, Arduino.HIGH);//S1
  }   
  else
  {
     println("Error Selecting Col pinMux"); 
  }
}


//select row you want to turn on
void setRowMux(int Control)
{
  //select C0
  if (Control == 0) {
      arduino.digitalWrite(7, Arduino.LOW); //S0
      arduino.digitalWrite(8, Arduino.LOW); //S1
  }
  
  //select C1
  else if (Control == 1)
  {
      arduino.digitalWrite(7, Arduino.HIGH); //S0
      arduino.digitalWrite(8, Arduino.LOW); //S1
  }
  
  //select C1
  else if (Control == 2)
  {
      arduino.digitalWrite(7, Arduino.LOW); //S0
      arduino.digitalWrite(8, Arduino.HIGH);//S1
  }   
  else
  {
     println("Error Selecting Row pinMux"); 
  }
}

//parameter:
//x location, y location & input voltage 
void setColor(int x, int y, int Vin)
{
  // convert voltage to grayscale color, 0 - 255
   println(Vin);
   int Color = Vin*255/1000;
   
   fill(Color);
   rect(300*x,300*y,300,300);
}