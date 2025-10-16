#include <Wire.h>
#include <Adafruit_PWMServoDriver.h>

Adafruit_PWMServoDriver pwm = Adafruit_PWMServoDriver();

#define SERVO_FREQ 50
#define SERVO_A 14
#define SERVO_B 15

#define SERVO_NEUTRAL 307
#define SERVO_FORWARD 440
#define SERVO_REVERSE 170

// move speed settings
#define MOVE_SPEED 70      // % of max speed
#define MOVE_DURATION 1000 // milliseconds (1 second)

void setup() {
  Serial.begin(9600);
  pwm.begin();
  pwm.setPWMFreq(SERVO_FREQ);
  delay(1000);
  Serial.println("CoreXY 1-second motion ready (w/a/s/d)");
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

void moveCoreXY(float dx, float dy) {
  // CoreXY transform
  int speedA = (dx + dy) * MOVE_SPEED;
  int speedB = (dx - dy) * MOVE_SPEED;

  setServoSpeed(SERVO_A, speedA);
  setServoSpeed(SERVO_B, speedB);

  delay(MOVE_DURATION);  // run for 1 second

  // stop servos
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

      moveCoreXY(dx, dy);
    }
  }
}