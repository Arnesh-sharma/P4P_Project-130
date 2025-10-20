const int analogPin = A0;
const int threshold = 512; // Midpoint for 10-bit ADC
unsigned long lastCrossTime = 0;
float frequency = 0;
bool lastState = false;

void setup() {
  Serial.begin(9600);
  Serial.println("Starting frequency measurement...");
}

void loop() {
  int value = analogRead(analogPin);
  bool currentState = (value > threshold);

  // Detect rising edge
  if (currentState && !lastState) {
    unsigned long currentTime = micros();
    if (lastCrossTime > 0) {
      unsigned long period = currentTime - lastCrossTime;
      frequency = 1000000.0 / period; // Hz
    }
    lastCrossTime = currentTime;
  }

  lastState = currentState;

  // Print both raw value and frequency
  Serial.print("Value: ");
  Serial.print(value);
  Serial.print("  Frequency: ");
  Serial.println(frequency);

  delay(50); // Prevent spamming
}
