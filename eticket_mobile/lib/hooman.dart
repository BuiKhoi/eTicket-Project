import 'package:http/http.dart';
import 'dart:convert';

class Hooman {
  Hooman(this.userId);

  String name = "Your name";
  int points = 0;
  String userId;

  Future<int> getPoints() async {
    String url = "https://us-central1-devfest-2019-255504.cloudfunctions.net/getUserTickets?id=";
    url += this.userId;
    var snapshot = await get(url);
    return int.parse(snapshot.body);
  }

//  String getNames() {
//    String url = "https://us-central1-devfest-2019-255504.cloudfunctions.net/getUserName?id=";
//    url += this.userId;
//    get(url).then((value) {
//      return value.body;
//    });
//  }

}

class RankedHooman {
  RankedHooman(this.name, this.points, this.image);

  String name;
  int points;
  String image;

  factory RankedHooman.fromJson(Map<String, dynamic> parsedJson){
    return RankedHooman(parsedJson['Name'], parsedJson['Points'], parsedJson['Image']);
  }
}