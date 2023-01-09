/*
This code randomly generates a 2 bit per cell cellular automaton.
A 'ruleset' is generated consisting of 2^18 2 bit values (although they are stored as bytes).
Cells are iterated by reading the 3x3 pixel square around the cell as an 18 bit number and then setting the cell to that index of the ruleset.
Edge cells loop around so there are no differences at the edges.
Press space to generate a new ruleset.
Press r to randomly reinitialize the cells.
*/

int mapSize=1<<8;
Map map;

void setup() {
  size(512, 512, JAVA2D);
  map=new Map(mapSize);
  noSmooth();
}

void draw() {
  map.iter();
  map.disp(0, 0, 2);
}

void keyPressed() {
  switch(key) {
    case ' ': map=new Map(mapSize); break;
    case 'r': map.randomizeCells(); break;
  }
}

int zfactor=4; //biases 0 in ruleset (4 seems to often look good)
class Map {
  int s;
  byte[][] cell; //cells loop
  byte[]rule;
  PImage dispImg;
  Map(int ts) {
    s=ts;
    cell=new byte[s][s];
    rule=new byte[1<<18];
    for(int i=0; i<1<<18; i++) { rule[i]=newRule(); }
    dispImg=createImage(s, s, RGB);
    randomizeCells();
  }
  byte newRule() {
    byte r=byte(random(4));
    r*=int(int(random(zfactor))==0);
    return(r);
  }
  
  void randomizeCells() {
    for(int i=0; i<s; i++) { for(int j=0; j<s; j++) {
      cell[i][j]=byte(random(4));
    } }
  }
  
  void iter() {
    int[][] buff=new int[s][s];
    for(int i=0; i<s; i++) { for(int j=0; j<s; j++) { //iterate through all cells
      int cellVal=0;
      for(int k=-1; k<2; k++) { for(int l=-1; l<2; l++) { //iterate through local 3x3
        int x=i+k, y=j+l;
        x+=int(x<0)*s; y+=int(y<0)*s; x%=s; y%=s; //loop around edges
        cellVal<<=2;
        cellVal+=cell[x][y];
      } }
      buff[i][j]=cellVal;
    } }
    for(int i=0; i<s; i++) { for(int j=0; j<s; j++) { //set cells to new values
      cell[i][j]=rule[buff[i][j]];
    } }
  }
  
  void disp(int px, int py, int z) { //position x, position y, magnification
    dispImg.loadPixels();
    for(int i=0; i<s; i++) { for(int j=0; j<s; j++) {
      dispImg.pixels[i+j*s]=color(int(cell[i][j]==1)*255, int(cell[i][j]==2)*255, int(cell[i][j]==3)*255);
    } }
    dispImg.updatePixels();
    image(dispImg, px, py, s*z, s*z);
  }
}
