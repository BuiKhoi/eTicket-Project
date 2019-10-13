bool corac() {

  unsigned long duration; //biến đo thời gian
  int distance;           //biến lưu khoảng cách


  digitalWrite(trig, 0);  //tắt chân trig
  delayMicroseconds(2);   //chờ 2ms
  digitalWrite(trig, 1);  //phát xung từ chân trig
  delayMicroseconds(5);   //xung có độ dài 5 microSeconds
  digitalWrite(trig, 0);  //tắt chân trig

  /* Tính toán thời gian */
  duration = pulseIn(echo, HIGH); // Đo độ rộng xung HIGH ở chân echo.
  distance = int(duration / 2 / 29.412); // Tính khoảng cách đến vật.


  Serial.print(distance);
  Serial.println("cm");

  if (distance < 30) {
    return true;
  }
  else {
    return false;
  }
}
