import processing.video.*;
import controlP5.*;
import com.temboo.core.*;
import com.temboo.Library.Yahoo.Weather.*;
import processing.sound.*;


ControlP5 cp5;
controlP5.Button Music;
SoundFile file;
ControlP5 gui;
Capture cam;
int musicOn = 0;
Table table1, table2, table3;
PFont f;  // Global font variable
float x;  // horizontal location of headline
int index = 0;
String[] headlines = {
  "Mentone, TX earthquake felt in Lubbock",
  "Elected officials, educators discuss the future of workforce education in Lubbock",
  "Purina Nutrition Center opens at Texas Tech University Veterinary School",
  };
  
  

void setup() {
  size(1650, 1250);
  x = 1100;
  
  String[] cameras = Capture.list();
  
  if (cameras.length == 0) {
    println("There are no cameras available for capture.");
    exit(); //<>//
  } else {
    println("Available cameras:");
    for (int i = 0; i < cameras.length; i++) {
      println(cameras[i]);
    }
    
    // The camera can be initialized directly using an 
    // element from the array returned by list():
    cam = new Capture(this, cameras[0]);
    cam.start();     
  }      

}

void draw() {
  background(225);
  fill(0);

  if (cam.available() == true) {
    cam.read();
  }
  image(cam, 50, 20, 1550, 1200);
  
  
  //time
  float h, m, s;
  h = hour();
  m = minute();
  s = second();
  fill(41, 212, 255);
  textSize(35);
  String time_string = "Time: ";
  if (h<10) time_string+="0";
  time_string += int(h);
  time_string+=":";
  if (m<10) time_string+="0";
  time_string += int(m);
  time_string+=":";
  if (s<10) time_string+="0";
  time_string += int(s);
  text(time_string, 80, 140);

  //date
  int d = day();    // Values from 1 - 31
  int mon = month();  // Values from 1 - 12
  int y = year();
  fill(41, 212, 255);
  textSize(35);
  String date_string = "Date: ";
  if (mon<10) date_string+="0";
  date_string += int(mon);
  date_string+="/";

  if (d<10) date_string+="0";
  date_string += int(d);
  date_string+="/";
  date_string += int(y);
  text(date_string, 80, 90);
  
  //weight
 weightH();
 
 //calendar and activies
 calendar();
 
 //news
   // Display headline at x  location
  textSize(30);
  textAlign(LEFT);
  fill(255, 102, 255);
  text(headlines[index], x+50, 1050, 400, 800);
  textSize(40);
  fill(41, 212, 255);
  textAlign(LEFT);
  text("Personalized News", x, 990, 400, 800);

  // decrement x
  x = x - 3;

  // ff x is less than the negative width,
  // then it is off the screen
  float w = textWidth(headlines[index]);
  if (x < 80) {
    x = 1100;
    index = (index + 1) % headlines.length;
  };
  
  //weather  
  textSize(35);
  fill(41, 212, 255);
  text("Current Temp: 38.65F", 1180, 90);
  fill(255, 102, 255);
  textSize(20);
  text("Feels Like: 40.69%", 1200, 140);
  text("High: 51.34F", 1200, 190);
  text("Low: 37.89F", 1200, 240);
  text("Wind Speed: 10.2MPH ", 1200, 290);
  text("Experiencing: Clouds", 1200, 340);
  
}


void calendar(){
  table2 = loadTable("Calendar.csv", "csv");
  textSize(35);
  fill(41, 212, 255);
  text("Todays Activites", 80, 440);
  fill(255, 102, 255);
  textSize(20);
  text("8AM: " + table2.getString(0,0), 100, 490);
  text("10AM: " + table2.getString(1,0), 100, 540);
  text("11AM: " + table2.getString(2,0), 100, 590);
  text("5PM: " + table2.getString(3,0), 100, 640);
  
}

void weightH (){
  table1 = loadTable("Health.csv", "csv");
  textSize(35);
  fill(41, 212, 255);
  text("Health/Weight", 80, 190);
  fill(255, 102, 255);
  textSize(20);
  text("Starting Weight: " +table1.getInt(0,0)+"lbs", 100, 240);
  text("Current Weight: " +table1.getInt(1,0)+"lbs", 100, 290);
  text("Goal Weight: " +table1.getInt(2,0)+"lbs", 100, 340);
  text("Weight Lost: " +table1.getInt(3,0)+"lbs", 100, 390);

}
void news(String[] x){
  table3 = loadTable("News.csv", "csv");
  String[] headlines = {
  table3.getString(0,0),
  table3.getString(1,0),
  table3.getString(2,0)
  };
}

public void Music() {
  file = new SoundFile(this,"music.mp3");
  file.play();
  
  //this changes the volume level (number between 0 and 1)
  file.amp(.5);
  }
  
void keyPressed() {
  if (keyPressed == true) {
      file = new SoundFile(this,"music.mp3");
      file.play();
  
  //this changes the volume level (number between 0 and 1)
  file.amp(.5);;
  } else {
    musicOn = 0;
  }
}
