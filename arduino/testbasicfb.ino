
#include <WiFi.h>
#include "FirebaseESP32.h"
#include "qrcode.h"
#include "string"
#include "SPI.h"
#include "Adafruit_GFX.h"
#include "Adafruit_ILI9341.h"


#define FIREBASE_HOST "devfest-2019-255504.firebaseio.com" //Do not include https:// in FIREBASE_HOST
#define FIREBASE_AUTH "1GJCgYplVf7PweVLgryQ1m8wBYugpuJ64dvDyl1X"
#define WIFI_SSID "Hackathon2019_Team"
#define WIFI_PASSWORD "gdgmientrung@dnes"

#define GLCD_CL_ORANGE 0xFCA0
#define GLCD_CL_GREEN 0x07E0

#define TFT_DC 4
#define TFT_CS 15
#define TFT_RST 2
#define TFT_MISO 19
#define TFT_MOSI 23
#define TFT_CLK 18

const int trig = 32;
const int echo = 34;

Adafruit_ILI9341 tft = Adafruit_ILI9341(TFT_CS, TFT_DC, TFT_MOSI, TFT_CLK, TFT_RST, TFT_MISO);

//Define FirebaseESP32 data object
FirebaseData firebaseData;

void printJsonObjectContent(FirebaseData &data);

void setup()
{

  Serial.begin(9600);
  tft.begin();

  pinMode(trig, OUTPUT);
  pinMode(echo, INPUT);

  WiFi.begin(WIFI_SSID, WIFI_PASSWORD);
  Serial.print("Connecting to Wi-Fi");
  delay(1000);
  while (WiFi.status() != WL_CONNECTED)
  {
    tft.setCursor(0,150);
    tft.setTextColor(ILI9341_BLACK);
    tft.setTextSize(2);
    tft.println("Check again the Wifi");
    //    //    Serial.print(".");
    delay(300);
  }
  Serial.println();
  Serial.print("Connected with IP: ");
  Serial.println(WiFi.localIP());
  Serial.println();

  Firebase.begin(FIREBASE_HOST, FIREBASE_AUTH);
  Serial.println("Firebase initialized");
  Firebase.reconnectWiFi(true);

  //6. Optional, set number of auto retry when read/store data
  Firebase.setMaxRetry(firebaseData, 3);

  //  Firebase.setReadTimeout(firebaseData, 1000);

  //7. Optional, set number of read/store data error can be added to queue collection
  Firebase.setMaxErrorQueue(firebaseData, 30);

  //8. Optional, use classic HTTP GET and POST requests.
  //This option allows get and delete functions (PUT and DELETE HTTP requests) works for
  //device connected behind the Firewall that allows only GET and POST requests.
  Firebase.enableClassicRequest(firebaseData, true);

  uint8_t x = tft.readcommand8(ILI9341_RDMODE);
  Serial.print("Display Power Mode: 0x"); Serial.println(x, HEX);
  x = tft.readcommand8(ILI9341_RDMADCTL);
  Serial.print("MADCTL Mode: 0x"); Serial.println(x, HEX);
  x = tft.readcommand8(ILI9341_RDPIXFMT);
  Serial.print("Pixel Format: 0x"); Serial.println(x, HEX);
  x = tft.readcommand8(ILI9341_RDIMGFMT);
  Serial.print("Image Format: 0x"); Serial.println(x, HEX);
  x = tft.readcommand8(ILI9341_RDSELFDIAG);
  Serial.print("Self Diagnostic: 0x"); Serial.println(x, HEX);

}

void loop() {
  while (WiFi.status() == WL_CONNECTED) {
    if (corac() == true) {
      char BinCode[8] = "GB01";
      char chaa[16];
      String(100 + rand() % (999 + 1 - 100)).toCharArray(chaa, 16);
      char code[8] = {};
      strcpy(code, strcat(BinCode, chaa));
      displayQRContent(code, ILI9341_BLACK, GLCD_CL_ORANGE);
      fbWorking(code);
      delay(4000);
    }
    else {
      waitingSimple();
    }
  }
  tft.setCursor(0, 150);
  tft.setTextColor(ILI9341_BLACK);
  tft.setTextSize(2);
  tft.println("Check again the Wifi");
}
