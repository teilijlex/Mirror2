/**
 * Mirror 2 
 * by Daniel Shiffman. 
 *
 * Each pixel from the video source is drawn as a rectangle with size based on brightness.  
 */
 
import processing.video.*;
import java.util.Calendar; //this for the time stamp
// Size of each cell in the grid
int cellSize = 2;
// Number of columns and rows in our system
int cols, rows;
// Variable for capture device
Capture video;


void setup() {
  size(640, 480);
  // Set up columns and rows
  cols = width / cellSize;
  rows = height / cellSize;
  colorMode(RGB, 255, 255, 255, 100);
  //colorMode(HSB, 255, 255, 255, 10);
  rectMode(CENTER);
  smooth();
  // This the default video input, see the GettingStartedCapture 
  // example if it creates an error
  video = new Capture(this, width, height);
  
  // Start capturing the images from the camera
  video.start();  

  background(0);
}


void draw() { 
  if (video.available()) {
    video.read();
    video.loadPixels();
     //background(0, 0, 255);
    //background(random(1,255), random(1,255), random(1,255));

    // Begin loop for columns
    for (int i = 0; i < cols;i++) {
      // Begin loop for rows
      for (int j = 0; j < rows;j++) {

        // Where are we, pixel-wise?
        int x = i * cellSize;
        int y = j * cellSize;
        int loc = (video.width - x - 1) + y*video.width; // Reversing x to mirror the image

        // Each rect is colored white with a size determined by brightness
        color c = video.pixels[loc];
        float sz = (brightness(c) / 255.0) * cellSize;
        fill(random(1,255));
        noStroke();
        rect(x + cellSize/2, y + cellSize/2, sz, sz);
      }
    }
  }
}


//can 
    //background(random(1,255), random(1,255), random(1,255));
void keyReleased() {
  if (key == 's' || key == 'S') saveFrame(timestamp()+"_##.png");
  //save picture
}


// timestamp
String timestamp() {
  Calendar now = Calendar.getInstance();
  return String.format("%1$ty%1$tm%1$td_%1$tH%1$tM%1$tS", now);
}



















