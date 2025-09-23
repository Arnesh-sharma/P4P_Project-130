/*
  AnalogReadSerial

  Reads an analog input on pin 0, prints the result to the Serial Monitor.
  Graphical representation is available using Serial Plotter (Tools > Serial Plotter menu).
  Attach the center pin of a potentiometer to pin A0, and the outside pins to +5V and ground.

  This example code is in the public domain.

  https://www.arduino.cc/en/Tutorial/BuiltInExamples/AnalogReadSerial
*/

const float V_REF = 5.0;     // Analog reference voltage (e.g., 5V or 3.3V)
const float R_BITS = 10.0;   // ADC resolution (bits)
const float ADC_STEPS = (1 << int(R_BITS)) - 1;

// the setup routine runs once when you press reset:
void setup() {
  // initialize serial communication at 9600 bits per second:
  Serial.begin(9600);
}

// the loop routine runs over and over again forever:
void loop() {
  // read the input on analog pin 0:
  int rawSensorValue0 = analogRead(A0);
  int rawSensorValue1 = analogRead(A1);
  int rawSensorValue2 = analogRead(A2);
  // int rawSensorValue3 = analogRead(A3);
  // int rawSensorValue4 = analogRead(A4);
  // int rawSensorValue5 = analogRead(A5);

  // float sensorValue0 = (rawSensorValue0 / ADC_STEPS) * V_REF;
  // float sensorValue1 = (rawSensorValue1 / ADC_STEPS) * V_REF;
  // float sensorValue2 = (rawSensorValue2 / ADC_STEPS) * V_REF;
  // float sensorValue3 = (rawSensorValue3 / ADC_STEPS) * V_REF;
  // float sensorValue4 = (rawSensorValue4 / ADC_STEPS) * V_REF;
  // float sensorValue5 = (rawSensorValue5 / ADC_STEPS) * V_REF;

  // print out the value you read:
  Serial.print(rawSensorValue0); 
  Serial.print(",");
  Serial.print(rawSensorValue1); 
  Serial.print(",");
  Serial.print(rawSensorValue2); 
  // Serial.print(",");
  // Serial.print(rawSensorValue3);
  // Serial.print(",");
  // Serial.print(rawSensorValue4); 
  // Serial.print(",");
  // Serial.print(rawSensorValue5); 
  Serial.println(); 

  delay(1);  // delay in between reads for stability
}
