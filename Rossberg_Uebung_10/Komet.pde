//Variablen
    float tKomet = 0; //Time of the comet
    int diameterKometInMeter = 100 * 30;//Für bessere Darstellung 30 mal größer.
    float diameterKomet;
    float x0Komet = -170000;
    float y0Komet = 60000;
    float xPosKomet = x0Komet;
    float yPosKomet = y0Komet;
    float einschlagsWinkel0 = 10;
    float einschlagsWinkel;
    float v0Komet = kmINm(32000);
    float vKomet;
    float vXKomet;
    float vYKomet;
    float xPosKometInPX;
    float yPosKometInPX;   
    boolean cometActive;
    float hT; //Die Höhe des Kometen, wenn x=0 passiert wird. Wird in init() berechnet.
    
    //Reibung
    float cw = 0.45; //Luftreibungskoeffizient   
    float rho0 = 1.3; //Dichte auf Meereshöhe
    float p0 = 100000; //Atmosphärischer Druck in Hectopascal
    float AKomet = PI * pow(diameterKometInMeter, 2)/4; //Durchströmungsfläche des Kometen
    float VKomet = PI * pow(diameterKometInMeter, 3)/6; //Volumen des Kometen
    float mKomet = 0.1 * VKomet * 4000 + 0.9 * VKomet * 918;//Kometenmasse
    
    //Luftdichte in Abhängigkeit von der Höhe berechnen
    float calcRho (float aktuelleHoehe)
    {
        return rho0 * exp(-g * (rho0/p0 * aktuelleHoehe));
    }
    
    //Funktion zur Vereinfachung für vXKomet
    float squareStuffX()
    {
       return vXKomet * sqrt( pow(vXKomet, 2) + pow(vYKomet, 2) );
    }       
    //Funktion zur Vereinfachung für vYKomet
    float squareStuffY()
    {
       return vYKomet * sqrt( pow(vXKomet, 2) + pow(vYKomet, 2) );      
    }
    
//Funktionen
  void drawComet()
  {        
        if(active && cometActive)
        { 
          //Geschwindigkeiten berechnen
          vXKomet += ( -0.5 * (cw * AKomet / mKomet) * calcRho(yPosKomet) * squareStuffX() ) * timeQuant;
          vYKomet += ( -g -0.5 * (cw * AKomet / mKomet) * calcRho(yPosKomet) * squareStuffY() ) * timeQuant;       
         
          //Positionen berechnen.        
          xPosKomet = xPosKomet + vXKomet * timeQuant;                
          yPosKomet = yPosKomet + vYKomet * timeQuant;
        }
        
        //Maßstab anwenden
        xPosKometInPX = xPosKomet * M;       
        yPosKometInPX = yPosKomet * M;
        
        //Zeit stoppen, wenn der Komet den Boden berührt.
        if(yPosKometInPX-diameterKomet/2 <= 0)
          {
            active = false; //Komet stoppen
            rocketActive = false; //Rakete stoppen
            //Einschlagspunkt markieren    
            fill(255,0,0); 
            text("Einschlag!",xPosKometInPX,-yPosKometInPX);                      
          }          
        //if(xPosKomet >= 0){println(yPosKomet);  active = false; }
        //Komet zeichnen.
        fill(255,0,0);
        ellipseMode(CENTER);
        ellipse(xPosKometInPX,-yPosKometInPX, diameterKomet, diameterKomet);//y negativ, da das Koordinatensystem gedreht ist
  }