// UNO/Nano: 10-bit ADC, default prescaler (≈104 us / conversion)
// 6 channels ≈ 624 us; target Fs = 500 Hz (T ≈ 2000 us) is very safe.

const uint32_t FS = 500;          // target sample rate (Hz)
const uint32_t T_US = 1000000UL / FS;

void setup() {
  Serial.begin(57600);          // 1,000,000 baud to avoid bottleneck
  analogReference(DEFAULT);
  // optional: throw away first reads after mux switch
  Serial.println("t_us,A0,A1,A2,A3,A4,A5");  // CSV header
}

void loop() {
  static uint32_t next_t = micros();
  // pace the sampler with micros()
  uint32_t now = micros();
  if ((int32_t)(now - next_t) >= 0) {
    next_t += T_US;

    int a0 = analogRead(A0);
    int a1 = analogRead(A1);
    int a2 = analogRead(A2);
    int a3 = analogRead(A3);
    int a4 = analogRead(A4);
    int a5 = analogRead(A5);

    uint32_t t = micros();
    // CSV: timestamp in microseconds + 6 channels
    Serial.print(t); Serial.print(',');
    Serial.print(a0); Serial.print(',');
    Serial.print(a1); Serial.print(',');
    Serial.print(a2); Serial.print(',');
    Serial.print(a3); Serial.print(',');
    Serial.print(a4); Serial.print(',');
    Serial.println(a5);
  }
}
