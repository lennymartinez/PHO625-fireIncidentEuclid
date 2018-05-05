String csv[];
String myData[][];
PFont Univers55, Univers65, Univers67, Univers75;
StringDict months, incidentCategory;
String counterDangerous, counterNondangerous, counterFalse;
String monthOut, dayOut, yearOut, dateField;
void setup() {
  size(450,300);  
  noLoop();
  Univers55 = createFont("UniversLTStd.otf", 24);
  //Univers65 = createFont("UniversLTStd-Bold.otf", 24);
  Univers67 = createFont("UniversLTStd-BoldCn.otf", 24);
  //Univers75 = createFont("UniversLTStd-Black.otf", 24);

  csv = loadStrings("fireIncidentData_euclid_academic.csv");
  myData = new String[csv.length][6];
  for(int i=0; i<csv.length; i++) {
    myData[i] = csv[i].split(",");
  } //end of for loop
  
  months = new StringDict();
  months.set("1","Jan.");
  months.set("2","Feb.");
  months.set("3","March");
  months.set("4","April");
  months.set("5","May");
  months.set("6","June");
  months.set("7","July");
  months.set("8","Aug.");
  months.set("9","Sept.");
  months.set("01","Jan.");
  months.set("02","Feb.");
  months.set("03","March");
  months.set("04","April");
  months.set("05","May");
  months.set("06","June");
  months.set("07","July");
  months.set("08","Aug.");
  months.set("09","Sept.");
  months.set("10","Oct.");
  months.set("11","Nov.");
  months.set("12","Dec.");
  
  
} //end of setup()

void draw(){
  background(38,38,35);
  int countDangerous = 0;
  int countFalse = 0;
  int countNondangerous = 0;
  counterDangerous = "00 Dangerous calls";
  counterNondangerous = "00 Non-dangerous calls";
  counterFalse = "00 False alarm calls";
  dateField = months.get(myData[1][1]) + " " + myData[1][2] +", " + myData[1][3];
  makeDate(dateField, counterDangerous, counterNondangerous, counterFalse);
  save("export2/legend-0-0.png");
  
  int numberOfPoints = myData.length;
  
  for (int i =1; i<numberOfPoints; i++){
    background(38,38,35);
    //check if there something happened in that line
    int category = int(myData[i][4]);
    
    if (category >0){
      //something happened so we figure out what happened and then which thing to increase.
      if (category == 700){
        countFalse = countFalse + 1;
      } else if ((category == 500) || (category == 600) || (category == 900) ){
        countNondangerous = countNondangerous + 1;
      } else {
        countDangerous = countDangerous +1;
      }
    }//end loop of something happening
    else {
      //nothing happened, so we don't increase the count of anything.
    }//end of if-else loop for counter increase
    
    //Aside: Summary of counter changes
    //println("line "+str(i));
    //println("dangerous",countDangerous);
    //println("Nondangerous",countNondangerous);
    //println("false",countFalse);
    //println("--");
    
    // Let's get the counter text together
    
    
    //figure out suffix
    if(countDangerous == 1){
      counterDangerous = "01 Dangerous call";
    } else if(countDangerous < 10){
      counterDangerous = "0"+str(countDangerous) + " Dangerous calls";
    } else{
      counterDangerous = str(countDangerous) + " Dangerous calls";
    }
    
    if(countNondangerous == 1){
      counterNondangerous = "01 Non-dangerous call";
    } else if(countNondangerous < 10){
      counterNondangerous = "0"+str(countNondangerous) + " Non-dangerous calls";
    } else{
      counterNondangerous = str(countNondangerous) + " Non-dangerous calls";
    }
    
    if(countFalse == 1){
      counterFalse = "01 False alarm call";
    } else if(countFalse < 10){
      counterFalse = "0"+str(countFalse) + " False alarm calls";
    }     else{
      counterFalse = str(countFalse) + " False alarm calls";
    }
  
    //get fields for day
    monthOut = months.get(myData[i][1]);
    dayOut = myData[i][2];
    yearOut = myData[i][3];
    
    dateField = monthOut + " " + dayOut +", " + yearOut;
    
    //Aside: Summary of days
    //println("line "+str(i));
    //println(dateField);
    //println("--");
    
    //Let's plot this shit
    
    makeDate(dateField, counterDangerous, counterNondangerous, counterFalse);
    for (int k =0; k <12; k++) {
      save("export2/legend-"+str(i)+"-"+str(k)+".png");
    }
    
    println("Working "+str(i));
    delay(300);
  }//end of loop for loop
  
  println("We're done!");
}


void makeDate(String day, String count1, String count2, String count3){
    String dateField = day;
    String counterDangerous = count1;
    String counterNondangerous = count2;
    String counterFalse = count3;
    fill(255);
    textFont(Univers67);
    textSize(60);
    text(dateField, 20, 20, 410,75);
    
    float diameter = 50;
    float buffer = 15;
    float x0 = 45;
    float y0 = 120;
    float y1 = y0 + diameter+ buffer;
    float y2 = y1 + diameter + buffer;
    //println(y0);
    //println(y1);
    //println(y2);
    //create the circles
    noStroke();
    //dangerous
    fill(255,18,2);
    ellipse(x0, y0, diameter, diameter);
    //nondangerous
    fill(18,131,255);
    ellipse(x0,y1,diameter,diameter);
    
    //false alarm
    fill(255,255,2);
    ellipse(x0,y2,diameter, diameter);
    
    float radius = diameter/2.0;
    float xText = x0 + radius + 15;
    float textBuffer = radius -8 ;
    float y0Text = y0 - textBuffer;
    float y1Text = y1 - textBuffer;
    float y2Text = y2 - textBuffer;
    
    //create text for the counters
    fill(255);
    textFont(Univers55);
    textSize(28);
    text(counterDangerous, xText, y0Text, 400, diameter);
    text(counterNondangerous, xText, y1Text, 400, diameter);
    text(counterFalse, xText, y2Text, 400, diameter);
}
