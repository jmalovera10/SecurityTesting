#include <Keypad.h>

#include "WProgram.h"
void setup();
void loop();
const String KEY = "1234";

const byte ROWS = 4; 
const byte COLS = 3;

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

byte rowPins[ROWS] = {
  9, 8, 7, 6
}; 
byte colPins[COLS] = {
  5, 4, 3
};

Keypad customKeypad = Keypad(makeKeymap(hexaKeys), rowPins, colPins, ROWS, COLS); 

String currentKey;
boolean open;

void setup() {
  Serial.begin(9600);
  currentKey = "";
  open = false;
}

void loop() {
  char customKey = customKeypad.getKey();

  if (customKey) {  
    currentKey+=String(customKey);
    Serial.println(currentKey);
  }
  if (currentKey.length()== KEY.length()) {
    if(currentKey == KEY) {
      digitalWrite(10,HIGH);
      open = true;
    }
    else {
      currentKey = "";
    }
  }
  if (currentKey.contains("*")) {
    if(open) {
      open = false;
      digitalWrite(10,HIGH);
    }
    currentKey = "";
  }else if(currentKey.contains("#")){
    currentKey = "";
  }

  delay(100);
}


