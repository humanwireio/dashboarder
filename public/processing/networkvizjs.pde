graph g;
int min_test_n_nodes = 2;
int test_n_edges = 1;

void setup(){
  size(800,600);
  g = new graph();
  fill(255);
  stroke(255,0,0);
  //addTestData();
}

void addTestData(){ 
  for (int i=0; i<min_test_n_nodes; i++){
    addNode("Test"+str(i));
  }
  for (int i=0; i<test_n_edges; i++){
    addEdge("Test"+str(i), "Test"+str(i+1));
  }
}

void draw(){
  background(0);
  g.render();
}

void clearGraph(){
  g = new graph();
}

void addNode(String name){
  g.addNode(new node(name));
}

void addEdge(String n1, String n2, int w){
  addNode(n1);
  addNode(n2);
  g.addEdge(new edge(g.nodeHash.get(n1), g.nodeHash.get(n2), w));
}

graph getGraph(){
  return g;
}

void setPos(String node_name, int posx, int posy){
  g.setPos(node_name, posx, posy);
}

void mouseMoved(){
  g.mouseMoved(mouseX, mouseY);
}

void mouseClicked(){
  g.mouseClicked(mouseX, mouseY);
}
class edge {
  
  Node node1;
  Node node2;
  int weight;
  
  edge(Node n1, Node n2, int w){
    node1 = n1;
    node2 = n2;
    weight = w;
  }
  
  void render(){
    strokeWeight(weight);
    line(node1.graph_x, node1.graph_y, node2.graph_x, node2.graph_y);
  }
  
}
class graph{
 
  //node hashmap
  HashMap nodeHash;
  ArrayList edgeList;
  
  graph(){
    clearGraph();
  }
  
  void render(){
    render_edges(); //draw edges first so they don't cover nodes
    render_nodes();
  }
  
  void render_nodes(){
    Iterator i = nodeHash.entrySet().iterator();
    
    while (i.hasNext()) {
      Map.Entry me = (Map.Entry)i.next();
      me.getValue().render(); //may not be able to chain this
    }
  }
  
  void render_edges(){ 
    for (int i=0; i<edgeList.size(); i++){
      edgeList.get(i).render(); //may not be able to chain like this
    }
  }
  
  void addNode(Node n){
   if (!(isNode(n.name))){
    nodeHash.put(n.name, n); 
   }
  }
  
  void removeNode(Node n){
    nodeHash.remove(n.name);
  }
  
  void addEdge(Edge e){
    edgeList.add(e);
  }
  
  void removeEdge(Edge e){
    edgeList.remove(e);
  }
  
  void clearGraph(){
    nodeHash = new HashMap();
    edgeList = new ArrayList();
  }
  
  boolean isNode(String s){
    boolean out = false;
    return nodeHash.containsKey(s);
  }
  
  void setPos(String node_name, int n_x, int n_y){
    node the_node_i_want = nodeHash.get(node_name);
    the_node_i_want.graph_x = n_x;
    the_node_i_want.graph_y = n_y;
  }
  
  void mouseMoved(int x, int y){
    Iterator i = nodeHash.entrySet().iterator();
    
    while (i.hasNext()) {
      Map.Entry me = (Map.Entry)i.next();
      node temp_node = (node)me.getValue();
      temp_node.mouseMoved(x, y);
    }
  }
  
  void mouseClicked(int x, int y){
    Iterator i = nodeHash.entrySet().iterator();
    
    while (i.hasNext()) {
      Map.Entry me = (Map.Entry)i.next();
      node temp_node = (node)me.getValue();
      temp_node.mouseClicked(x, y);
    }
  }
}

class node {
  
  String name;
  int graph_x = int(random(width*(.8+.1)));
  int graph_y = int(random(height*(.8+.1)));
  color hoverFill = color(0,0,125);
  boolean hover = false;
  color activeFill = color(125,0,0);
  boolean active = false; 
  
  node(String n){
    name = n;
  }
  
  void render(){
    if (hover){
      fill(hoverFill);
    } else {
      if (active){
        fill(activeFill);
      } else {
        fill(40);
      }
    }
    strokeWeight(3);
    ellipse(graph_x, graph_y, 50,40);
    textAlign(CENTER,CENTER);
    fill(250);
    textSize(17);
    text(name, graph_x, graph_y);
  }
  
  void mouseMoved(int x, int y){
    if (sqrt(pow(x-graph_x,2)+pow(y-graph_y,2))<50){
      if (!(active)){
        hover = true;
      }
    } else {
      hover = false;
    }  
  }
  
  void mouseClicked(int x, int y){
    if (sqrt(pow(x-graph_x,2)+pow(y-graph_y,2))<50){
      active = !(active);
      hover = !(active);
    }
  }
}

