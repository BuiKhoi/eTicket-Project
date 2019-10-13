void displayQRContent(char* finalcode, uint16_t color1, uint16_t color2) {
  tft.fillScreen(color2);
  tft.setCursor(15, 20);
  tft.setTextColor(ILI9341_BLACK);
  tft.setTextSize(2);
  tft.println("Thank you so much!");
  tft.println();
  tft.setCursor(42,38);
  tft.println("Your code is: ");
  tft.setTextColor(ILI9341_WHITE);
  tft.println();
  tft.setTextSize(5);
  tft.setCursor(17,65);
  tft.println(finalcode);
  tft.println();
  
  QRCode qrcode;
  uint8_t qrcodeData[qrcode_getBufferSize(3)];
  qrcode_initText(&qrcode, qrcodeData, 3, 0, finalcode);
  tft.setCursor(0, 0);

  int dsize = (int) 200 / qrcode.size;
  int left_padding = (240 - dsize * qrcode.size) / 2;
  int top_padding = (350 - dsize * qrcode.size) / 2 + 30;
  for (uint8_t y = 0; y < qrcode.size; y++) {
    for (uint8_t x = 0; x < qrcode.size; x++) {
      //      Serial.println (qrcode_getModule(&qrcode, x, y) ? "\u2588\u2588" : "  ");
      tft.setCursor(17,58);
      tft.fillRect(dsize * y + left_padding, dsize * x + top_padding, dsize, dsize, qrcode_getModule(&qrcode, x, y) ? color1 : color2);
    }
  }
}
