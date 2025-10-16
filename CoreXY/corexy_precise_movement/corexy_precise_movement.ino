#include <Wire.h>
#include <Adafruit_PWMServoDriver.h>

Adafruit_PWMServoDriver pwm = Adafruit_PWMServoDriver();

#define SERVO_FREQ 50
#define SERVO_A 14
#define SERVO_B 15

#define SERVO_NEUTRAL 307
#define SERVO_FORWARD 440  
#define SERVO_REVERSE 170

// machine calibration
const float MAX_SPEED_REV_S = 0.5;   // servo speed at 100% cmd
const float REV_PER_CM      = 0.25;  // how many revs = 1 cm of travel

float posA = 0, posB = 0;    // current est. rotations
float targetA = 0, targetB = 0;

unsigned long prevTime = 0;

void setup() {
  Serial.begin(9600);
  pwm.begin();
  pwm.setPWMFreq(SERVO_FREQ);
  delay(1000);
  Serial.println("CoreXY control ready (w/a/s/d for motion)");
}

void setServoSpeed(uint8_t servoNum, int speed) {
  speed = constrain(speed, -100, 100);
  int pulse;
  if (speed == 0) pulse = SERVO_NEUTRAL;
  else if (speed > 0)
    pulse = map(speed, 0, 100, SERVO_NEUTRAL, SERVO_FORWARD);
  else
    pulse = map(speed, -100, 0, SERVO_REVERSE, SERVO_NEUTRAL);
  pwm.setPWM(servoNum, 0, pulse);
}

void moveToTargets() {
  // simple proportional controller
  while (true) {
    unsigned long now = millis();
    float dt = (now - prevTime) / 1000.0;
    prevTime = now;

    float errorA = targetA - posA;
    float errorB = targetB - posB;

    if (fabs(errorA) < 0.01 && fabs(errorB) < 0.01) break;

    int speedA = constrain(errorA * 400, -100, 100);  // proportional gain
    int speedB = constrain(errorB * 400, -100, 100);

    setServoSpeed(SERVO_A, speedA);
    setServoSpeed(SERVO_B, speedB);

    // update estimated positions
    posA += (speedA / 100.0) * MAX_SPEED_REV_S * dt;
    posB += (speedB / 100.0) * MAX_SPEED_REV_S * dt;

    delay(20);
  }

  setServoSpeed(SERVO_A, 0);
  setServoSpeed(SERVO_B, 0);
}

void loop() {
  if (Serial.available()) {
    char c = Serial.read();

    float dx = 0, dy = 0;
    if (c == 'w') dy = +1;     // up
    if (c == 's') dy = -1;     // down
    if (c == 'a') dx = -1;     // left
    if (c == 'd') dx = +1;     // right

    if (dx != 0 || dy != 0) {
      Serial.print("Move ");
      if (c == 'w') Serial.println("UP");
      if (c == 's') Serial.println("DOWN");
      if (c == 'a') Serial.println("LEFT");
      if (c == 'd') Serial.println("RIGHT");

      // CoreXY transform
      targetA += (dx + dy) * REV_PER_CM;
      targetB += (dx - dy) * REV_PER_CM;

      moveToTargets();

      Serial.print("PosA: "); Serial.print(posA, 3);
      Serial.print("  PosB: "); Serial.println(posB, 3);
    }
  }
}