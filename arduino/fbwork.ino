void fbWorking(char* binCode) {
  Serial.println("Sending code");
  Firebase.setBool(firebaseData, "/GarbageBin/GB01/CGC", true);
  Firebase.setString(firebaseData, "/GarbageBin/GB01/BinID", binCode);
  bool redeeming = true;
  do {
    if (Firebase.getBool(firebaseData, "/GarbageBin/GB01/CGC")) {
      if (firebaseData.dataType() == "boolean") {
        redeeming = firebaseData.boolData();
      }
    }
    Serial.println("Waiting for redeem");
    delay(300);
  }
  while (redeeming);

  tft.fillScreen(GLCD_CL_ORANGE);
  tft.setCursor(40,160);
  tft.setTextColor(ILI9341_BLACK);
  tft.setTextSize(2);
  tft.println("TICKET EARNED!");
}
