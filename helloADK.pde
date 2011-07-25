#include <Wire.h>
#include <Servo.h>

#include <Max3421e.h>
#include <Usb.h>
#include <AndroidAccessory.h>

#define  LED_RED       12

AndroidAccessory acc("Google, Inc.",
		     "DemoKit",
		     "DemoKit Arduino Board",
		     "1.0",
		     "http://www.android.com",
		     "0000000012345678");
void setup();
void loop();


void init_leds()
{
	digitalWrite(LED_RED, 1);
	pinMode(LED_RED, OUTPUT);
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
				if (msg[1] == 0x0)
					analogWrite(LED_RED, 255 - msg[2]);
				
			} 
		}

		
	} else {
		// reset outputs to default values on disconnect
		analogWrite(LED_RED, 255);
	}
	delay(10);
}
