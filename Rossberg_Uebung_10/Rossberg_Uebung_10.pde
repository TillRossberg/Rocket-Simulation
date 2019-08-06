//"Rettet die Erde!" von Till Roßberg (s0552254) 24.10.2016
  //Generell
    float timeScale = 5;//momentaner Zeitfaktor    
    int SCREEN_WIDTH = 800;
    int SCREEN_HEIGHT = 600;
    int frameRate = 60;
    float timeQuant = timeScale/frameRate;//Kleinste Zeiteinheit
    float M = 0.002; //Maßstab 2px = 1km
    float g = 9.81; //Gravitationskonstante in m/s^2    
    float Countdown;
    boolean hit = false;
    
void setup()
  {
   //Generell
   size(800,600);
   frameRate(frameRate);
           
   //Maßstabsumrechnungen
   diameterKomet = diameterKometInMeter * M;     
   raketeHoehe = raketeHoeheInMeter * M;
   raketeBreite = raketeBreiteInMeter * M;     
  }

void draw()
  {  
     //Mambojambo
     update(mouseX, mouseY);
     pushMatrix();//muss dat sein?
     translate(400,300);//Standardkoordinatensystem in karthesisches K. umwandeln. 
     drawBackground();
     
     //Time concerns
       if(active)
       {
          tKomet = tKomet + timeQuant;        
          if(rocketActive){tRakete = tRakete + timeQuant;}
          Countdown -= timeQuant; //Countdown runterzählen.    
          //Flugzeiten ausgeben
          text("Comettime:  " + tKomet, 270, -250);
          text("Rockettime: " + tRakete, 270, -230);          
       }
             
    //Debugzeuch hier
      //text("Hit here pls!", 340,0);//Da sollte der Komet ungefähr einschlagen.
      
      drawComet(); 
      drawRocket();
      checkForCollision();
      countItDown();
      popMatrix();    
      drawButtons();      
  }
  