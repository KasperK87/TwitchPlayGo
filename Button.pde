class Button{
  PVector pos;
  PVector size;
  boolean selected = false;
  
  Button(float setX, float setY){
    pos = new PVector(setX, setY);
    size = new PVector(75,25);
  }
  
  boolean overButton(){
    if (mouseX > pos.x && mouseX < pos.x + size.x && mouseY > pos.y && mouseY < pos.y + size.y)
      return true;
    return false; 
  }
  
  public void render(){
    
    if (selected)
      fill(128);
    else
      fill(100);
      
    rect(pos.x, pos.y, size.x, size.y);
    
    if (selected)
    fill(255);
    else
    fill(0);
    textSize(16);
    text("Reset", pos.x+textWidth("reset")/2, pos.y+size.y/2+textAscent()/3); 
  }
  
  public void update(){
    if (overButton()){
      selected = true;
        if (mousePressed){
          bot.reset();
        }
      
    } else {
      selected = false;
    }
  }
}