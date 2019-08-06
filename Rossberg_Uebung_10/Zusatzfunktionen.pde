//Berechnet eine zufällige Position anhand von Position und Zufallsgrad in %
float calcRandomOffset(float actualPosition)
{
  float randomPosition = 0.0;  
  randomPosition = actualPosition * (1.1 - random(0.2));
  //randomPosition = actualPosition + random(-actualPosition/randomFactor,actualPosition/randomFactor); //Wählt einen zufälligen Wert zwischen +-randomFactor% von der Ausgangsposition.
 
  return randomPosition;
}

//Check if Rocket hits Comet

void checkForCollision()
{
  //Check if the rocket hits the comet
      hit = cometIsHit();
      if(hit)
      {
        //Komet stoppen
        active = false;
        rocketActive = false;
        //Trefferpunkt markieren    
        fill(255,0,0); 
        text("Treffer!",xPosKometInPX + 10,-yPosKometInPX + 10);                      
      } 
}

boolean cometIsHit()
{  
  return sq(xPosRakete - xPosKomet) + sq(yPosRakete - yPosKomet) <= sq(diameterKometInMeter/2 + raketeHoeheInMeter/2); 
}

//Wann treffen Rakete und Komete aufeinander? (Nullstellenvariante)
float predictCollision()
{
  float A = vXKomet;
  float B = vYKomet;
  float C = vXRakete;
  float D = vYRakete;
  float E = xPosKomet;
  float F = yPosKomet;
  float AC = A-C;
  float nenner = C * g + g/2 * AC;
  float p = (D * AC + C*D - B*C + E*g) / nenner;
  float q = (E*D + F*AC - E*B) / nenner;
  
  float t1 = -p/2 + sqrt(sq(p)/4 - q);
  float t2 = -p/2 - sqrt(sq(p)/4 - q); 
    
  return t1>t2? t1:t2; 
}

//Wann treffen Rakete und Komete aufeinander? (nach Ziolkowski)
float predictCollisionZiolkowski()
{
  float timeOfImpact = 0;
  float epsilon =  10e-8;  
  float timeOfImpactOld = 10e8;
  for (int i=0; i<100; i++)
  {    
  timeOfImpact = 1/vGas * ( hT - g * sq(timeQuant)/2 - vGas * (mStart/q - timeQuant) * log(1 - q * timeQuant / mStart) );
  if(abs(timeOfImpact - timeOfImpactOld) < epsilon) break;
  timeOfImpactOld = timeOfImpact;
  }
  //print(timeOfImpact);
  return timeOfImpact;
}


//Alle Werte resetten.
void resetAll()
{
      //Time cocerns
     tKomet = 0;
     tRakete = 0;     
     
     //Reset comet, rocket and timer
     active = false;
     rocketActive = false;
     cometActive = false;     
     xPosRakete = x0Rakete;
     yPosRakete = y0Rakete;    
     einschlagsWinkel = einschlagsWinkel0;
     
     //Zufällige Werte berechnen
     xPosKomet = calcRandomOffset(x0Komet);   
     yPosKomet = calcRandomOffset(y0Komet);
     vKomet = calcRandomOffset(v0Komet);
     einschlagsWinkel = calcRandomOffset(einschlagsWinkel0);
}

//Werte initialisieren
void init()
{    
     resetAll();
     momentanerWinkelRakete = startWinkelRakete;
     
     //Geschwindigkskomponenten berechnen.  
       //Komet
          vXKomet = vKomet * cos(2 * PI - radians(einschlagsWinkel));
          vYKomet = vKomet * sin(2 * PI - radians(einschlagsWinkel));
       //Rakete
          vXRakete = vRakete * cos( PI/2 + radians(startWinkelRakete));
          vYRakete = vRakete * sin( PI/2 + radians(startWinkelRakete));     
          
     //Höhe des Kometen über x = 0 berechnen.
     hT = yPosKomet + vYKomet * (-xPosKomet/vXKomet) - g/2 * sq(-xPosKomet/vXKomet);
     println("ht: " + hT);
}

//Km/h in m/h umrechnen
float kmINm(float velocity)
{
  return velocity/3.6;
}

//Draw the ground and the Background
void drawBackground()
{
  //Draw Background
   background(135,206,250);     
     fill(255);
  //Ground
    rectMode(CORNERS);
    fill(222,184,135);
    rect(-400,0,400,300);
}

//Countdown überprüfen.
void countItDown()
{ 
    if(Countdown <= 0) 
    {
    fill(255,0,0);
    text("FIRE!", -20,-200);
    //Startet die Rakete automatisch, wenn
    if(active){rocketActive = true;}
    } 
    else 
    {
    fill(255,0,0);
    text("Countdown: " + Countdown, -50, -200 );
    } 
}