//Variablen
//Rakete
    float tRakete = 0;//Time of the rocket
    boolean rocketActive = false;
    float x0Rakete = 0;
    float y0Rakete = 3000;
    float xPosRakete = x0Rakete;//Startposition X.
    float yPosRakete = y0Rakete;//Startposition Y.
    float raketeHoehe;
    float raketeBreite;
    float raketeBreiteInMeter = 20*30;//Für bessere Darstellung 30 mal größer.
    float raketeHoeheInMeter = 100*30;//Für bessere Darstellung 30 mal größer.
    float vRakete = kmINm(30000); //in km pro h
    float vXRakete;
    float vYRakete;
    float startWinkelRakete = 0;
    float momentanerWinkelRakete = 0;
    float xPosRaketeInPX;
    float yPosRaketeInPX;    
    float v0XRakete = 0;
    float v0YRakete = 0;
    
    float vGas = 50; //Austrittsgeschwindigkeit des Antriebsgases
    float q = 250; //Massendurchsatz
    float m0 = 5000; //Leermasse
    float mStart = 10000;//Leermasse + Treibstoffmasse
    float mRakete = mStart; //momentane Raketenmasse
    float tMax = 20; //Brenndauer in s
//Funktionen
void drawRocket()
{    
      if(rocketActive)
      {
        //Geschwindigkeiten berechnen.
        vYRakete += ( - g + vGas * g/mRakete )* timeQuant;
        
        //Massenverlust berechnen
        if(mRakete != m0){ mRakete = mRakete - q * timeQuant;} 

               
        //Positionen berechnen.        
        xPosRakete = xPosRakete + vXRakete * timeQuant;                
        yPosRakete = yPosRakete + vYRakete * timeQuant;          
        
        //Winkel zwischen den Geschwindigkeiteskomponenten berechnen.
        momentanerWinkelRakete = atan2(vYRakete,vXRakete);      
        
      }
     
      //So wird die Winkelveränderung beim Einstellen des Winkels angezeigt, auch wenn die Rakete noch nicht gestartet wurde.  
      if(!rocketActive){momentanerWinkelRakete = PI/2 + radians(startWinkelRakete);}
      
      //Maßstab anwenden
      xPosRaketeInPX = xPosRakete * M;       
      yPosRaketeInPX = yPosRakete * M;       
     
      pushMatrix();      
      translate(xPosRaketeInPX,-yPosRaketeInPX);//y negativ, da das Koordinatensystem gedreht ist
      rotate(-momentanerWinkelRakete);      
      //draw the rocket
      rectMode(RADIUS);
      fill(0,200,0);
      rect(0,0,raketeHoehe,raketeBreite);
      popMatrix();
}