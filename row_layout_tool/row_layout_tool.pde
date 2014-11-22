ArrayList<PImage> panelImages;
int panelMargin = 10;
int pageWidth = 1000;

boolean selecting = false;

int rowHeight = 100;

void setup() {
  size(pageWidth, 500);
  panelImages = new ArrayList<PImage>();
}

void draw() {
  if (!selecting) {

    background(255);  

    pushMatrix();
    pushStyle();
    noFill();
    stroke(0);
    for (PImage img : panelImages) {
      
      image(img, 0, 0);
      rect(0,0, img.width, img.height);
      translate(img.width + panelMargin, 0);
    }
    popStyle();
    popMatrix();
    
   

    pushStyle();
    fill(0);
    rect(25, height-45, 30, 20);
    fill(255);
    text("add", 30, height-30);
    fill(255);
    rect(20, height-25, 110, 20);
    fill(0);
    text("row height: " + rowHeight, 25, height-10);
    
    popStyle();
  }
}

void mousePressed() {
  if (mouseX > 25 && mouseX < 55) {
    if (mouseY > height-45 && mouseY < height-25) {
      selecting = true;
      selectInput("Select a panel image", "fileSelected");
    }
  }
}

void keyPressed(){
  heightForRow();
}

void resizeImages(int targetHeight) {
//  int w = int(width / float(panelImages.size()));

  for (PImage img : panelImages) {
    img.resize(0, targetHeight);
  }
}

int heightForRow(){
 
  int h = 100;
  int totalWidth = 0;
  while(totalWidth < pageWidth){
    totalWidth = 0;

    for (PImage img : panelImages) {
      // scale image to current row height
      float iw = img.width;
      float ih = img.height;
      float pro = h / ih;
      iw *= pro;
      
      totalWidth += iw;
    }
    
    totalWidth += panelMargin * (panelImages.size()-1);
    if(totalWidth > 1000){
      h--;
      break;
    }
    h++;
  }
  
  println("totalWidth: " + totalWidth + " rowHeight: " + h);
  return h;
}


void fileSelected(File selection) {
  if (selection == null) {
    println("Window was closed or the user hit cancel.");
  } 
  else {
    panelImages.add(loadImage(selection.getAbsolutePath()));
    rowHeight = heightForRow();
    resizeImages(rowHeight);
    selecting = false;
  }
}

