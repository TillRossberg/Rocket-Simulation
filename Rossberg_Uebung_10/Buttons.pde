//Variablen
    boolean active = false; //State of the program.
    //Buttonstates
    boolean startButtonOver = false;
    boolean resetButtonOver = false;
    boolean startRocketButtonOver = false;
    boolean plusButtonOver = false;
    boolean minusButtonOver = false;
    
//Draw the buttons
  void drawButtons()
  {   
     if(!active)
    {
      //StartButton
      rectMode(RADIUS);
      if(startButtonOver){fill(210,105,30);}else{fill(205,133,63);}     
      rect(600,350,20,20,7);
      fill(255);
      text("Start", 587,355);
    }
    else
    {
      //ResetButton
      rectMode(RADIUS);
      if(resetButtonOver){fill(210,105,30);}else{fill(205,133,63);}
      rect(600,350,20,20,7);
      fill(255);
      text("Reset", 584,355);      
    }
    
      //Raketenstart    
      rectMode(RADIUS);
      if(startRocketButtonOver){fill(210,105,30);}else{fill(205,133,63);}     
      rect(600,400,25,10,7);
      fill(255);
      text("Rakete", 582,405);
    
      //Schubregler
      fill(205,133,63);
      rect(700,350,8,30,7);
      fill(30,144,255);
      ellipse(700, 350, 20, 20);
      fill(0);
      text("Schub", 684,392);       
      
      //Winkel einstellen
      fill(205,133,63);
      rect(600,450,50,10,7);
      fill(255);
      text("Winkel einstellen", 557,455);
      //-
      if(plusButtonOver){fill(210,105,30);}else{fill(205,133,63);}     
      rect(630,470,10,10,7);
      fill(255);
      text("-", 626,475);
      //+
      if(minusButtonOver){fill(210,105,30);}else{fill(205,133,63);}     
      rect(570,470,10,10,7);
      fill(255);
      text("+", 568,475);     
      //Winkel
      fill(205,133,63);
      rect(600,470,10,10,7);
      fill(255);
      text(int(startWinkelRakete), 593,475);
      
  }


//Buttonfunktionen
  //Scannen nach buttonpositionen
  void update(int x, int y) 
  {    
    //Startbutton
    if (overRect(600,350,20,20) && !active ) 
    {
      startButtonOver = true; 
    }
    else{startButtonOver = false;}
    //Starrockettbutton
    if (overRect(600,400,25,10) && active ) 
    {
      startRocketButtonOver = true; 
    }
    else{startRocketButtonOver = false;}
    //ResetButton
    if (overRect(600,350,20,20) && active ) 
    {
      resetButtonOver = true;      
    }
    else{resetButtonOver = false;}
    //Plusbutton
    if (overRect(630,470,10,10)) 
    {
      plusButtonOver = true;      
    }
    else{plusButtonOver = false;}
    //Minusbutton
    if (overRect(570,470,10,10)) 
    {
      minusButtonOver = true;      
    }
    else{minusButtonOver = false;}
  }
  
  //Ist die Maus über einem rechteckigen Button?
  boolean overRect(int x, int y, int width, int height)  
  {
    if (mouseX >= x-width && mouseX <= x+width && 
        mouseY >= y-height && mouseY <= y+height) 
        {return true;}
        else 
        {return false;}
  }
  
  //Die resultierenden Aktionen.
  void mousePressed()
  {
   //Start simulation.
   if(startButtonOver && !active)
   {
     resetAll();
     init();
     //Countdown = predictCollisionZiolkowski();//Funktioniert noch nicht
     Countdown = predictCollision();
     active = true;   
     cometActive = true;    
   }
   
   //Reset simulation.
   if(resetButtonOver && active)
   {
     resetAll();
   }
   
   //Start rocket.
   if(startRocketButtonOver && active)
   {
      //Start Rocket 
      rocketActive = true;    
   }
   
   //Adjust starting Angle of the Rocket
   if(minusButtonOver && !rocketActive)
   {
    if(startWinkelRakete < 10)
    {
      startWinkelRakete = startWinkelRakete + 1;
     
    }
   }
   
   if(plusButtonOver && !rocketActive)
   {
    if(startWinkelRakete > -10)
    {
      startWinkelRakete = startWinkelRakete - 1;
     
    }
   }  
  }