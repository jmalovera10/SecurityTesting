#include <Keypad.h>

//Specified password
const String KEY = "1234";

//Keypad rows
const byte ROWS = 4; 

//Keypad columns
const byte COLS = 3;

//Keypad mapping matrix
char hexaKeys[ROWS][COLS] = {
  {
    '1', '2', '3'
  }
  ,
  {
    '4', '5', '6'
  }
  ,
  {
    '7', '8', '9'
  }
  ,
  {
    '*', '0', '#'
  }
};

//Keypad row pins definition
byte rowPins[ROWS] = {
  9, 8, 7, 6
}; 

//Keypad column pins definition
byte colPins[COLS] = {
  5, 4, 3
};

//Keypad library initialization
Keypad customKeypad = Keypad(makeKeymap(hexaKeys), rowPins, colPins, ROWS, COLS); 

//Current key variable
String currentKey;
//Door state
boolean open;

void setup() {
  Serial.begin(9600);
  currentKey = "";
  open = false;
}

void loop() {
  char customKey = customKeypad.getKey();

  //Verification of input
  if (customKey) {  
    currentKey+=String(customKey);
    Serial.println(currentKey);
  }
  //If current key matches the key length
  if (currentKey.length()== KEY.length()) {
    if(currentKey == KEY) {
      digitalWrite(10,HIGH);
      open = true;
    }
    else {
      currentKey = "";
    }
  }
  //If the current key contains '*'
  if (currentKey.indexOf("*")>0) {
    if(open) {
      open = false;
      digitalWrite(10,HIGH);
    }
    currentKey = "";
  }//If the current key contains '#'
  else if(currentKey.indexOf("#")>0){
    currentKey = "";
  }

  delay(100);
}

