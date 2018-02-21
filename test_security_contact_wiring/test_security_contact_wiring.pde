//Button pin
const int CONTACT_PIN = 11;

//R LED pin
const int R_LED_PIN = 10;

//G LED pin
const int G_LED_PIN = 12;

//B LED pin
const int B_LED_PIN = 13;

//Door state
boolean open;

//Attribute that defines the button state
boolean buttonState;

//Current time when the button is tapped
long currTime;

//Number of current attempts
byte attempts;

void setup()
{
  Serial.begin(9600);
  buttonState = false;
  
  pinMode(R_LED_PIN, OUTPUT);
  pinMode(G_LED_PIN, OUTPUT);
  pinMode(B_LED_PIN, OUTPUT);
  pinMode(CONTACT_PIN,INPUT);
  
  setColor(0, 255, 255);
}

void loop()
{
   //Button input read and processing 
  if(!buttonState) {
    if(digitalRead(CONTACT_PIN)) {
      currTime = millis();
      buttonState = true;
      Serial.println("Contact on!");
    }
  }
  else {
    if(!digitalRead(CONTACT_PIN)) {
      if((millis()-currTime)>=5000) {
        setColor(0, 255, 0);
        open = true;
        Serial.println("Door opened!!");
        attempts = 0;
      }
      else {
        Serial.println("NOT ENTOUGH TIME");
      }
      buttonState = false;
    }
  }
  delay(100);
}

//Method that outputs the RGB specified color
void setColor(int redValue, int greenValue, int blueValue) {
  analogWrite(R_LED_PIN, redValue);
  analogWrite(G_LED_PIN, greenValue);
  analogWrite(B_LED_PIN, blueValue);
}
