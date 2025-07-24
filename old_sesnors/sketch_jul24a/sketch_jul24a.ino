void setup() {
  // put your setup code here, to run once:
  Serial.begin(9600); 

}

void loop() {
  // put your main code here, to run repeatedly:
  int A0_val = analogRead(A0); 
  // int A1_val = analogRead(A1); 
  // int A2_val = analogRead(A2); 
  // int A3_val = analogRead(A3); 
  // int A4_val = analogRead(A4); 
  // int A5_val = analogRead(A5); 

  Serial.println(A0_val);
  //Serial.print(A1_val);
  //Serial.print(A2_val);
  //Serial.print(A3_val);
  // Serial.print(A4_val);
  // Serial.print(A5_val); // println at the end of the line

}
