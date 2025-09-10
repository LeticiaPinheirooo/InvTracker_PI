#include <Ultrasonic.h>

const int PINO_TRIGGER = 13;
const int PINO_ECHO = 12;

HC_SR04 sensor(PINO_TRIGGER, PINO_ECHO);

void setup() {
  Serial.begin(9600);
  }

void loop() {
  Serial.print("Estado_Crítico:");
  Serial.print(60);
  Serial.print(",");
  Serial.print("Capacidade_Total:");
  Serial.print(10);
  Serial.print(",");

  Serial.print("Dist:");
  Serial.println(sensor.distance());

  delay(1000);
}
