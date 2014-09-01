HashMap data;

//user config
int panel_radius = 200;
//init
polyElement main_panel;

void setup(){
  size(700,700);
//  main_panel = new polyElement(panel_radius);
//  for (int i=0; i<10; i++){
//    
//    main_panel.addChild("test"+str(i));
//  }
  main_panel = randomData();
  strokeWeight(2);
  //noLoop();
}

void draw(){
  background(0);
  pushMatrix();
  translate(width/2, height/2);
  main_panel.render();
  popMatrix();
}

polyElement randomData(){
  polyElement out = new polyElement(100);
  for (int i=0; i<(int(random(3))+3); i++){
    polyElement layerDown = new polyElement(60);   
    for (j=0; j<(int(random(3))+3); j++){
      layerDown.addChild("CC"+str(j));
    }
    out.addChildElement(layerDown);
  }
  return out;
}

void clear(){
  main_panel = new polyElement(10);
}

void mouseClicked(){
  main_panel.deactivate();
  main_panel.mouseClicked(mouseX - int(width/2), mouseY - int(height/2));
}

polyElement getMainPanel(){
  return main_panel;
}
polyElement dataParser(HashMap hm){
  
  return new polyElement(100);
  
}
class polyElement extends screenElement {

  int n_sides;
  int txtSze = 15;
  String elemText = "test";
  polyElement parent;
  ArrayList<polyElement> children = new ArrayList();
  
  polyElement(int rad) {
    radius = rad;
    n_sides = 3;
    colorMode(HSB, 255);
    //fillColor = color(random(255),random(255),random(255));
    //strokeColor = color(random(255),random(255),random(255));
    fillColor = color(175);
    hoverColor = color(200);
    activeColor = color(255);
    strokeColor = color(0);
  }

  void render() {
    checkState();
    
    pushMatrix();
    autoTextSize();
    if (active){
      fill(activeColor);
    } else if (hover) {
      fill(hoverColor);
    } else {
      fill(fillColor);
    }
    stroke(strokeColor);
    translate(posx, posy);

    rotate(rot);
    
    drawPoly();
    
    fill(strokeColor);
    stroke(fillColor);
    renderText();
    
    renderChildren();
    
    popMatrix();
  }

  void addChild(String s){
    polyElement child = new polyElement(childRadius());
    child.elemText = s;
    addChildElement(child);
  }
  
  void addChildElement(polyElement child){
    child.parent = this;
    children.add(child);
    n_sides = max(3, children.size());
  }
  
  int childRadius(){
    return int(radius*.3);
  }

  void renderChildren(){
    int[][] lps = linkPoints(childRadius());
    for (int i=0; i<children.size(); i++){
      polyElement cur_elm = (polyElement) children.get(i);
      //console.log(cur_elm);
      cur_elm.setPos(lps[i][1], lps[i][0]);
      //cur_elm.setRot(cart2Pol(lps[i][1],lps[i][0])[0]);
      //console.log(cur_elm.toString()); //WHAT!!? this makes no sense
      cur_elm.render();
    }  
  }
  
  void setPos(int x, int y){
    super.setPos(x,y);
  }
  
  void drawPoly() {
    float rot_per = TWO_PI/n_sides; 
    beginShape();
    for (int i=0; i<n_sides; i++) {
      vertex(radius*sin(i*rot_per), radius*cos(i*rot_per));
    }
    vertex(radius*sin(0), radius*cos(0));
    endShape();
  }

  void renderText() {
    textAlign(CENTER, CENTER);
    textSize(txtSze);
    text(elemText, 0, 0);
  }

  void autoTextSize() {
    txtSze = (1.5*radius)/elemText.length();
  }

  String toString() {
    return "xpos:"+str(posx)+", ypos:"+str(posy);
  }

  int[][] polyPoints() {
    int[][] out = new int[n_sides][2];
    for (int i=0; i<n_sides; i++) {
      out[i][0] = radius*sin(i*rot_per);
      out[i][1] = radius*cos(i*rot_per);
    }
  }

  int[][] linkPoints(int nav_radius) {
    float rot_per = TWO_PI/n_sides;
    int[][] out = new int[n_sides][2];
    for (int i=0; i<n_sides; i++) {
      //out[i][0] = (radius+nav_radius)*sin(i*rot_per) + pow(-1, ceil((i+1)/2))*posx;
      //out[i][1] = (radius+nav_radius)*cos(i*rot_per) + pow(-1, ceil((i+1)/2))*posy;
      out[i][0] = (radius+nav_radius*1.5)*sin((i*rot_per)+rot); //y
      out[i][1] = (radius+nav_radius*1.5)*cos((i*rot_per)+rot); //x, this is backwards
    }
    return out;
  }

  void checkState(){
    if (!(active)){
      if (containsPoint(mouseX, mouseY)){
        hover = true;
      } else {
        hover = false;
      }
    }
  }
  
  boolean mouseClicked(int x, int y){
    boolean higher_active = false;
    for (int i=0; i<children.size();i++){
      boolean higher_active = higher_active || ((polyElement) children.get(i)).mouseClicked(x - posx, y - posy);
    }
    
    if (!(higher_active)){
      return super.mouseClicked(x,y);
    } else {
      return true;
    }
  }
  
  void deactivate(){
    active = false;
    for (int i=0; i<children.size(); i++){
      ((polyElement) children.get(i)).active = false;
    }
  }
}

class screenElement {
  int radius;
  int posx = 0;
  int posy = 0;
  float rot = 0;
 
  color fillColor;
  color strokeColor;
  color hoverColor;

  boolean active = false;
  boolean hover = false;
  
  void render(){

  }
  
  void rotObj(float how_much) {
    rot = (rot+how_much)%TWO_PI;
  }

  void setPos(int px, int py) {
    posx = px;
    posy = py;
  }  
  
  void setRot(float r) {
    rot = r;
  }

  int[] pol2Cart(int r, float theta) {
    float rot_per = TWO_PI/n_sides;
    int[] out = new int[2];
    out[0] = r * sin(theta);
    out[1] = r * cos(theta);
    return out;
  }

  int[] cart2Pol(int x, int y) {
    int[] out = new int[2];
    out[0] = atan(y/x);
    out[1] = int(sqrt(pow(x, 2) + pow(y, 2)));
    return out;
  }
  
  boolean containsPoint(int x, int y){
    boolean out = false;
    int[] pol_coor = cart2Pol(x-posx, y-posy);
    if (pol_coor[1] < radius) {
      out = true;
    }  
    return out;
  }
  
  boolean mouseClicked(int mX, int mY){
    if (containsPoint(mX, mY)){
      active = true;
    } else {
      active = false;
    }
    
    return active;
  }
}

