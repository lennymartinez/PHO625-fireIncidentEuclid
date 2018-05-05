import processing.pdf.*;

// LIBRARIES

// GLOBAL VARIABLES
PImage bg;
PImage bgAccumulate;
String csv[];
String myData[][];
//PFont Univers55, Univers65, Univers67, Univers75;
//StringDict months, incidentCategory;
String collectedData[][];


// SETUP
void setup() {
  //size(465,291);
  //size(1858,1161);
  size(1395,1161); 
  //size(2907, 2159);
  noLoop();
  //Univers55 = createFont("UniversLTStd.otf", 24);
  //Univers65 = createFont("UniversLTStd-Bold.otf", 24);
  //Univers67 = createFont("UniversLTStd-BoldCn.otf", 24);
  //Univers75 = createFont("UniversLTStd-Black.otf", 24);
  bg = loadImage("map10.png");
  csv = loadStrings("fireIncidentData_euclid_academic.csv");
  myData = new String[csv.length][6];
  for(int i=0; i<csv.length; i++) {
    myData[i] = csv[i].split(",");
  }
  //months = new StringDict();
  //months.set("1","Jan.");
  //months.set("2","Feb.");
  //months.set("3","March");
  //months.set("4","April");
  //months.set("5","May");
  //months.set("6","June");
  //months.set("7","July");
  //months.set("8","Aug.");
  //months.set("9","Sept.");
  //months.set("01","Jan.");
  //months.set("02","Feb.");
  //months.set("03","March");
  //months.set("04","April");
  //months.set("05","May");
  //months.set("06","June");
  //months.set("07","July");
  //months.set("08","Aug.");
  //months.set("09","Sept.");
  //months.set("10","Oct.");
  //months.set("11","Nov.");
  //months.set("12","Dec.");
}

void draw(){
  //println(myData.length);
  //int counter = 0;
  //for (int i = 1;i<myData.length; i++){ if (int(myData[i][4]) >0) {counter++; } }
  //println(counter);
  int counter = 213;
  background(bg);
  save("export2/image-0-0.png");
  noStroke();
  //int incidentCount = 0;
  collectedData = new String[counter][3];
  
  int numberOfPoints = myData.length;
  for(int i=1; i < numberOfPoints; i++) {
    int category = int(myData[i][4]);
    int a = 0;
    int b = 0;
    int c = 0;
    
    if (category > 0){
      //Here is where we'll make the different things happen
      
      //get the x, y coordinates of the dot
      float x = float(myData[i][5]);
      float y = float(myData[i][6]);
      
      //map the original x,y to the image
      float graphLong = map(x, -76.1307, -76.1131,0,width);
      float graphLat = map(y, 43.0421, 43.0314, 0, height);
      
      //add those to the collectedData array
      //if(i <213){
      //collectedData[i-1][0] = str(graphLong);
      //collectedData[i-1][1] = str(graphLat);
      //collectedData[i-1][2] = myData[i][4];
      //}
      //else{ break;}
    
    //check if the call was dangerous, not dangerous, or a false alarms
    if (category == 700){
      a = 255;
      b = 255;
      c = 2;
    } else if ((category == 500) || (category == 600) || (category == 900) ){
      a = 18;
      b = 131;
      c = 255;
    } else {
      a = 255;
      b = 18;
      c = 2;
    }
    fill(a,b,c);
    
    //draw the location at size normal (20), large (40), and xlarge (60)
    for (int k =0; k <11; k++) {
      int r = 10*(1+k);
      ellipse(graphLong, graphLat, r,r);
      save("export2/image-"+str(i)+"-"+str(k)+".png");
      delay(750);
    }
    
    //clear the background and draw all points in collected array at size
    bgAccumulate = loadImage("export2/image-"+str(i)+"-2.png");
    background(bgAccumulate);
    save("export2/image-"+str(i)+"-11.png");
    
    
    }
    else{
      //println("Nothing happened on line " + str(i));
      //println("date", myData[i][1], myData[i][2], myData[i][3]);
      //println("---");
      bgAccumulate = loadImage("export2/image-"+str(i-1)+"-11.png");
      background(bgAccumulate);
      for (int k =0; k <12; k++) {
        save("export2/image-"+str(i)+"-"+str(k)+".png");
      }
    }
    print(i);
    delay(1000);
  }
  println("We're done!");  
  











} //this is the end of DRAW loop

/*
// DRAW old version
void draw() {
  background(bg);
  String incidents;
  String incidentDay;
  int incident_count = 0;
  int num = myData.length;
  for(int j=1; j<num; j++){
    int category = int(myData[j][4]);
    String month = months.get(myData[j][1]);
    incidentDay = month + " " + myData[j][2] + ", " + myData[j][3];
    
    //Check if there was an incident
    if (category > 0) {
      //Something happened in this line. So update the counter
      incident_count = incident_count + 1;
      
      //Map where incident happened
      float graphLong = map(float(myData[j][5]),-76.1307, -76.1073,0,width);
      float graphLat = map(float(myData[j][6]), 43.0421, 43.0314, 0, height);
      
      fill(255,0,0,50);
      noStroke();
      ellipse(graphLong, graphLat, 20,20);
    }
    else {
      //Nothing Happened so we don't update
      println("Nothing happened on line " + str(j));
      println("date", myData[j][1], myData[j][2], myData[j][3]);
      println("---");
    }
    
    if (incident_count==1) {
        incidents = "1 Incident";
      }
      else {
      incidents = str(incident_count) + " Incidents";
    }
    
    fill(0);
    rect(width-150,10,400,170);
    fill(255);
    textFont(Univers67);
    textSize(72);
    text(incidentDay, width-400, 20, 400, 75);
    textFont(Univers55);
    textSize(40);
    text(incidents, width-400, 120, 400, 75);
    
    save("export/image_test-"+str(j)+".png");
  }
} */
