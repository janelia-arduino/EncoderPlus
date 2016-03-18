/* Encoder Library - Basic Example
 * http://www.pjrc.com/teensy/td_libs_Encoder.html
 *
 * This example code is in the public domain.
 */

#include <EncoderPlus.h>

// Change these two numbers to the pins connected to your encoder.
//   Best Performance: both pins have interrupt capability
//   Good Performance: only the first pin has interrupt capability
//   Low Performance:  neither pin has interrupt capability

const int ENCODER_A_PIN = 3;
const int ENCODER_B_PIN = 4;
const int STEP_PIN = 22;
const int DIR_PIN = 23;

volatile int dir = LOW;
volatile int step = LOW;

EncoderPlus myEnc(ENCODER_A_PIN,ENCODER_B_PIN);
//   avoid using pins with LEDs attached

void positiveCallback()
{
  if (dir != HIGH)
  {
    dir = HIGH;
    digitalWrite(DIR_PIN,dir);
  }
  step = (step == HIGH) ? LOW : HIGH;
  digitalWrite(STEP_PIN,step);
}

void negativeCallback()
{
  if (dir != LOW)
  {
    dir = LOW;
    digitalWrite(DIR_PIN,dir);
  }
  step = (step == HIGH) ? LOW : HIGH;
  digitalWrite(STEP_PIN,step);
}

void setup() {
  Serial.begin(9600);
  Serial.println("Basic EncoderPlus Test:");

  pinMode(STEP_PIN,OUTPUT);
  digitalWrite(STEP_PIN,HIGH);
  pinMode(DIR_PIN,OUTPUT);
  digitalWrite(DIR_PIN,HIGH);

  myEnc.attachPositiveCallback(positiveCallback);
  myEnc.attachNegativeCallback(negativeCallback);
}

long oldPosition  = -999;

void loop() {
  long newPosition = myEnc.read();
  if (newPosition != oldPosition) {
    oldPosition = newPosition;
    Serial.print("position: ");
    Serial.println(newPosition);
    Serial.print("step: ");
    Serial.println(step);
    Serial.print("dir: ");
    Serial.println(dir);
    Serial.println();
  }
}
