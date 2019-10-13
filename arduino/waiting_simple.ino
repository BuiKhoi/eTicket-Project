void waitingSimple(){
  tft.fillScreen(GLCD_CL_GREEN);
  tft.setCursor(45, 100);
  tft.setTextColor(ILI9341_BLACK);
  tft.setTextSize(2);
  tft.println("Give me your");
  tft.setCursor(55, 150);
  tft.setTextSize(3);
  tft.println("GARBAGE");
}
