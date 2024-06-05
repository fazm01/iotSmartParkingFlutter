#include <Arduino.h>
#if defined(PICO_RP2040)
#include <WiFi.h>
#elif defined(ESP8266)
#include <ESP8266WiFi.h>
#endif
#include <FirebaseESP8266.h>

#define IR1 D1
#define IR2 D2
#define IR3 D3
#define IR4 D4

#define RED1 D5
#define RED2 D6
#define RED3 D7
#define RED4 D8
FirebaseData fbdo;
const char* WIFI_SSID = "WE_B3825E";
const char* WIFI_PASSWORD = "20405156554";
String id = ""; 
int p1; //ir3
int p2; //ir4
int p3; //ir1
int p4; //ir2
void SetP1(int x){
    Firebase.setInt(fbdo, "/1b-HUzeenQ_C2tSo9Q0mWqyBjp1XvfTlyuvgQi1cm1V4/Destination/"+id+"/p1", x);  
};

void SetP2(int x){
    Firebase.setInt(fbdo, "/1b-HUzeenQ_C2tSo9Q0mWqyBjp1XvfTlyuvgQi1cm1V4/Destination/"+id+"/p2", x);  
};

void SetP3(int x){
    Firebase.setInt(fbdo, "/1b-HUzeenQ_C2tSo9Q0mWqyBjp1XvfTlyuvgQi1cm1V4/Destination/"+id+"/p3", x);  
};

void SetP4(int x){
    Firebase.setInt(fbdo, "/1b-HUzeenQ_C2tSo9Q0mWqyBjp1XvfTlyuvgQi1cm1V4/Destination/"+id+"/p4", x);  
};

void Board() {
  //ir1
  if (digitalRead(IR1) == LOW || p3 == 1) // if IR1 detects object 
  {
    digitalWrite(RED1, HIGH); // turn on RED1 led
    SetP3(1);

  } else if (digitalRead(IR1) == HIGH) {
    digitalWrite(RED1, LOW);
    SetP3(0); 
  }

  //ir2
  if (digitalRead(IR2) == LOW || p4 == 1) 
  {
    digitalWrite(RED2, HIGH);
    SetP4(1);

  } else if (digitalRead(IR2) == HIGH) {
    digitalWrite(RED2, LOW);
    SetP4(0);
  }

  //ir3
  if (digitalRead(IR3) == LOW) 
  {
    digitalWrite(RED3, HIGH);
    SetP1(1);

  } else if (digitalRead(IR3) == HIGH){
    digitalWrite(RED3, LOW);
    SetP1(0);
  }

  //ir4
  if (digitalRead(IR4) == LOW || p2 == 1) 
  {
    digitalWrite(RED4, HIGH);
    SetP2(1);


  } else if (digitalRead(IR4) == HIGH){
    digitalWrite(RED4, LOW);
    SetP2(0);
  }

  delay(1000);
}

void Board2() {
  //ir1
  if (digitalRead(IR1) == LOW) // if IR1 detects object 
  {
    digitalWrite(RED1, HIGH); // turn on RED1 led
  }
  else
  {
    digitalWrite(RED1, LOW); 
  }

  //ir2
  if (digitalRead(IR2) == LOW) 
  {
    digitalWrite(RED2, HIGH);
  }
  else
  {
    digitalWrite(RED2, LOW);
  }

  //ir3
  if (digitalRead(IR3) == LOW) 
  {
    digitalWrite(RED3, HIGH);
  }
  else
  {
    digitalWrite(RED3, LOW);
  }

  //ir4
  if (digitalRead(IR4) == LOW) 
  {
    digitalWrite(RED4, HIGH);
  }
 else
  {
    digitalWrite(RED4, LOW);
  }

  //pt.2

  if(p1==0){
    digitalWrite(RED3, LOW);
  }
  else{
    digitalWrite(RED3, HIGH);
  }

  if(p2==0){
    digitalWrite(RED4, LOW);
  }
  else{
    digitalWrite(RED4, HIGH);
  }

  if(p3==0){
    digitalWrite(RED1, LOW);
  }
  else{
    digitalWrite(RED1, HIGH);
  }

  if(p4==0){
    digitalWrite(RED2, LOW);
  }
  else{
    digitalWrite(RED2, LOW);
  }


  if(digitalRead(IR1) == LOW && p3 == 0){
    digitalWrite(RED1, HIGH);
    SetP3(1);
    
  }
   if(digitalRead(IR2) == LOW && p4 == 0){
    digitalWrite(RED2, HIGH);
    SetP4(1);
   
  }
   if(digitalRead(IR3) == LOW && p1 == 0){
    digitalWrite(RED3, HIGH);
    SetP1(1);
    
  }
   if(digitalRead(IR4) == LOW && p2 == 0){
    digitalWrite(RED4, HIGH);
    SetP2(1);
   
  }



 if(digitalRead(IR1) == LOW && p3 == 1){
   digitalWrite(RED1, HIGH);
   if(digitalRead(IR1) == HIGH){
      digitalWrite(RED1, LOW);
      SetP3(0);
    }
  }
   if(digitalRead(IR2) == LOW && p4 == 1){
     digitalWrite(RED2, HIGH);
      if(digitalRead(IR2) == HIGH){
      digitalWrite(RED2, LOW);
      SetP4(0);
    }
  }
   if(digitalRead(IR3) == LOW && p1 == 1){
     digitalWrite(RED3, HIGH);
     if(digitalRead(IR3) == HIGH){
      digitalWrite(RED3, LOW);
      SetP1(0);
    }  
  }
   if(digitalRead(IR4) == LOW && p2 == 1){
     digitalWrite(RED4, HIGH);
      if(digitalRead(IR4) == HIGH){
      digitalWrite(RED4, LOW);
      SetP2(0);
    }
  }

  //pt.5

   if(digitalRead(IR1) == HIGH && p3 == 1){
     digitalWrite(RED1, HIGH);
  }
   if(digitalRead(IR2) == HIGH && p4 == 1){
     digitalWrite(RED2, HIGH);
  }
   if(digitalRead(IR3) == HIGH && p1 == 1){
     digitalWrite(RED3, HIGH);
  }
   if(digitalRead(IR4) == HIGH && p2 == 1){
     digitalWrite(RED4, HIGH);
  }

  //pt.6

    if(digitalRead(IR1) == HIGH && p3 == 0){
     digitalWrite(RED1, LOW);
  }
   if(digitalRead(IR2) == HIGH && p4 == 0){
     digitalWrite(RED2, LOW);
  }
   if(digitalRead(IR3) == HIGH && p1 == 0){
     digitalWrite(RED3, LOW);
  }
   if(digitalRead(IR4) == HIGH && p2 == 0){
     digitalWrite(RED4, LOW);
  }

  delay(1000);
}


void GetFirebase(){
   if(Firebase.getString(fbdo, "/location_Id")){
    id = fbdo.stringData();
    Firebase.getInt(fbdo, "/1b-HUzeenQ_C2tSo9Q0mWqyBjp1XvfTlyuvgQi1cm1V4/Destination/"+id+"/p1");
    p1 = fbdo.intData();

    Firebase.getInt(fbdo, "/1b-HUzeenQ_C2tSo9Q0mWqyBjp1XvfTlyuvgQi1cm1V4/Destination/"+id+"/p2");
    p2 = fbdo.intData();
    
    Firebase.getInt(fbdo, "/1b-HUzeenQ_C2tSo9Q0mWqyBjp1XvfTlyuvgQi1cm1V4/Destination/"+id+"/p3");
    p3 = fbdo.intData();
    
    Firebase.getInt(fbdo, "/1b-HUzeenQ_C2tSo9Q0mWqyBjp1XvfTlyuvgQi1cm1V4/Destination/"+id+"/p4");
    p4 = fbdo.intData();
    Serial.println(id + " " + p1 + " " + p2 + " " + p3 + " " + p4);
  }
};


void setup() {  
  pinMode(IR1, INPUT);  //ir sensor1
  pinMode(IR2, INPUT);  //ir sensor2
  pinMode(IR3, INPUT);  //ir sensor3
  pinMode(IR4, INPUT);  //ir sensor4
  pinMode(RED1, OUTPUT);  //RED led1
  pinMode(RED2, OUTPUT);  //RED led2
  pinMode(RED3, OUTPUT);  //RED led3
  pinMode(RED4, OUTPUT);  //RED led4
  Serial.begin(9600);
   
  
  // connect to wifi.  
  WiFi.begin(WIFI_SSID, WIFI_PASSWORD);  
  Serial.print("connecting");  
  while (WiFi.status() != WL_CONNECTED) {  
    Serial.print(".");  
    delay(500);  
  }  
  Serial.println();  
  Serial.print("connected: ");  
  Serial.println(WiFi.localIP());  
    
  Firebase.begin("https://smartparking-bd17d-default-rtdb.firebaseio.com/", "psRstLoao2eXmfSu7as9kXv60bsnZZe70LhjWkCe");  

}  
  
  
void loop() {
  /**GetFirebase(); //all on/off values of all destination classes, which ever destination is on is the destination read
  if(returnedMap.onoff == ON)
  {
    SetBoard(returnedMap); //write destination irs to board
    GetBoard(); //reads only unreserved board irs
    SetFirebase(); //sends only unreserved board irs
  }
  */
  Board2();
  GetFirebase();
  
  
}  
