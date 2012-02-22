#include <Wire.h>
#include <Servo.h>

#include <Max3421e.h>
#include <Usb.h>
#include <AndroidAccessory.h>

#define  LED       13

AndroidAccessory acc("3D Robotics",
		     "PhoneDrone",
		     "Phone Drone ADK Board",
		     "1.0",
		     "https://groups.google.com/forum/?fromgroups#!forum/phone-drone-adk",
		     "0000000012345678");
void setup();
void loop();


void init_leds()
{
	digitalWrite(LED, 1);
	pinMode(LED, OUTPUT);
}

void setup()
{
	Serial.begin(115200);
	Serial.print("\r\nStart");
	init_leds();
	acc.powerOn();
}

void loop()
{
	byte err;
	byte idle;
	static byte count = 0;
	byte msg[3];
	long touchcount;

	if (acc.isConnected()) {
		int len = acc.read(msg, sizeof(msg), 1);
		int i;
		byte b;
		uint16_t val;
		int x, y;
		char c0;

		if (len > 0) {
			// assumes only one command per packet
			if (msg[0] == 0x2) {
				if (msg[1] == 0x0){
                                  Serial.print(msg[2],DEC); Serial.print(" ");
                                  int value = msg[2];
                                  if  (value > 128){
			            digitalWrite(13, HIGH);
                                  }
                                   else{
                                    digitalWrite(13, LOW);
                                   }
                                 }
				
			} 
		}

		
	} else {
		// reset outputs to default values on disconnect
		digitalWrite(13, LOW);
	}
	delay(10);
}
