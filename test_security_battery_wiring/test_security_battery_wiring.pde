// Pines para los LEDs
#define LED_OK 2
#define LED_LOW 3
#define BATTERY_PIN 0
 
// Variables
int batteryValue = 0;
float voltage = 0;
int ledDelay = 800;
 
// Umbrales
float maximo = 1.6;
float medio = 1.4;
float minimo = 0.3;
 
void setup() {
  // Iniciamos el monitor serie
  Serial.begin(9600);
 
  // Los pines de LED en modo salida
  pinMode(LED_OK, OUTPUT);
  pinMode(LED_LOW, OUTPUT);
  pinMode(LEDROJO, OUTPUT);
 
}
 
void loop() {
  // Leemos valor de la entrada analógica
  analogValor = analogRead(ANALOGPILA);
 
  // Obtenemos el voltaje
  voltaje = 0.0048 * analogValor;
  Serial.print("Voltaje: ");
  Serial.println(voltaje);
 
  // Dependiendo del voltaje mostramos un LED u otro
  if (voltaje >= maximo)
  {
    digitalWrite(LED_OK, HIGH);
    delay(ledDelay);
    digitalWrite(LED_OK, LOW);
  }
  else if (voltaje < maximo && voltaje > medio)
  {
    digitalWrite(LED_LOW, HIGH);
    delay(ledDelay);
    digitalWrite(LED_LOW, LOW);
  }
  else if (voltaje < medio && voltaje > minimo)
  {
    digitalWrite(LEDROJO, HIGH);
    delay(ledDelay);
    digitalWrite(LEDROJO, LOW);
  }
 
  // Apagamos todos los LEDs
  digitalWrite(LED_OK, LOW);
  digitalWrite(LED_LOW, LOW);
  digitalWrite(LEDROJO, LOW);
}
