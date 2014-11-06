import gab.opencv.*;
import org.opencv.core.Core;
import org.opencv.core.Mat;

PImage img;
PImage resultImg, processed;
float blackThreshold = 40;
float whiteThreshold = 130;
int gridSpacing = 5;
PFont font;
int fontSize = 16;
int nLines = 1;

OpenCV opencv; 

String filename = "witness.jpg";
String caption = "\"Never!\" answered the witness.";

void setup() {
  img = loadImage("images/"+filename); // original
  img.resize(500,0);
  resultImg = createImage(img.width, img.height, ARGB);
  font = loadFont("CCComicrazy-Regular-48.vlw");
   textFont(font, fontSize);
   
   nLines = caption.split("\n").length;

  size(img.width, img.height);

  // load the image with opencv
  opencv = new OpenCV(this, img);
//  opencv.brightness(40);
//  opencv.contrast(60);
//    opencv.blur(4);

  // run a canny edge filter
  opencv.blur(2);
  opencv.findCannyEdges(125,75);
//  opencv.dilate();
//  opencv.erode();
//  opencv.erode();

  // invert for black lines
  opencv.invert();
  
  Mat edges = opencv.getGray().clone();
  
  processed = opencv.getSnapshot();
  
  opencv.loadImage(img);
  Core.min(edges, opencv.getGray(), opencv.getGray());
  img = opencv.getSnapshot();
  
  // process the original image
  // into all-black, all-white, and transparent (so the hatching can show through)
  // based on brightness
  // (save result into resultImg, which has an alpha channel)
  resultImg.loadPixels();
  for (int i = 0; i < img.pixels.length; i++) {
    if (brightness(img.pixels[i]) < blackThreshold ) {
      resultImg.pixels[i] = color(0);
    }
    else if (brightness(img.pixels[i]) < whiteThreshold) {
      resultImg.pixels[i] = color(255, 0);
    } 
    else {
      resultImg.pixels[i] = color(255);
    }
 
  }
  resultImg.updatePixels();
  noLoop(); // if we draw over and over, blendMode(MULTIPLY) goes nuts
}

void draw() {
  background(255);

  // draw the hatching grid lines
  stroke(0);
  for (int i = 0; i < img.height; i++) {
    line(0, img.height-i*gridSpacing, img.width-i*gridSpacing, 0);
    if (i > 0) {
      line(0, img.height+i*gridSpacing, img.width+i*gridSpacing, 0);
    }
  }

  // draw all the images
  image(resultImg, 0, 0);
  

  
  
  // draw the contours lines over the processed image
//  blendMode(MUTLIPLY);
//  image(processed, 0, 0);
//  blendMode(NORMAL);
//  

  float cw = textWidth(caption);

  pushStyle();
  fill(255);
  stroke(0);
  strokeWeight(1);
  
  int rWidth = width-20;
  float rHeight = (fontSize*2)*nLines;
  
  int rTop = height-40;
  if(nLines == 2){
    rTop = height - 75;
  }
  int topMargin = 0;
  if(nLines == 1){
    topMargin = 5;
  }
  
  rect(10, rTop, rWidth, rHeight);
  popStyle();
    fill(0);
//noFill();
//  noStroke();
  stroke(0);
  text(caption, 10+(rWidth-cw)/2.0, rTop + rHeight/2 + topMargin);
  
  pushStyle();
  noFill();
  stroke(0);
  strokeWeight(3);
  rect(0,0, width-2, height-2);
  
  popStyle();
  
  println("processed/"+filename);
  save("processed/"+filename);
}
