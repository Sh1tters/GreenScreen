
import processing.video.*;
byte TestCameraInList = 0; //Dumt navn, men sigende
Capture video;
PImage img;
boolean active;

void setup() {
  size(1920, 1080);

  // This the default video input, see the GettingStartedCapture
  // example if it creates an error
  video = new Capture(this, width, height);


  // Start capturing the images from the camera
  video.start();

  loadPixels();
  img = loadImage("data.jpg");
  img.resize(1920, 1080);
  img.loadPixels();
}

void draw() {
  if (video.available()) {
    // When using video to manipulate the screen, use video.available() and
    // video.read() inside the draw() method so that it's safe to draw to the screen
    video.read(); // Read the new frame from the camera
    video.loadPixels(); // Make its pixels[] array available

    if (active) {

      for ( int x =0; x< video.width; x++)
        for ( int y =0; y< video.height; y++) {
          color pix = video.get(x, y);
          float r = red(pix);
          float g = green(pix);
          float b = blue(pix);

          if ( r < 125 && g >=125 && b < 125 ) {
            video.pixels[x + y * video.width] = img.pixels[x + y * video.width];
          }
        }
    }


    video.updatePixels();
    image(video, 0, 0, video.width, video.height);
  }
}

void keyPressed() {
  if (keyCode == 32) {
    if (active)active = false;
    else active = true;
  }
}
