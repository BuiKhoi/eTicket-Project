import 'package:flutter/material.dart';

import 'hooman.dart';
import 'login.dart';

class Ranking extends StatefulWidget {
  @override
  _RankingState createState() => _RankingState();
}

class _RankingState extends State<Ranking> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("RANKING", style: TextStyle(color: Colors.white),),
      ),
      body: ListView(
        children: getListViewWidets(),
      ),

    );
  }

  List<Widget> getListViewWidets() {
    var style = TextStyle(color: Colors.black, fontWeight: FontWeight.bold);
    List<Widget> list_ele = new List<Widget>();
    int counter = 1;
    for (var rank in ranked_list) {
      if (counter == 1) {
        list_ele.add(new Container(
          padding: EdgeInsets.all(24.0),
          child: Container(
            decoration: new BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(12.0),
            ),
            height: 200,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  ClipRRect(
                    borderRadius: BorderRadius.circular(50.0),
                    child: Image.network(rank.image,
                      height: 100,
                      width: 100,),
                  ),
                  Container(
                    height: 20,
                  ),
                  Text(rank.name, style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),),
                ],
              ),
            ),
          ),
        ));
      } else {
        list_ele.add(new Container(
          padding: EdgeInsets.fromLTRB(24.0, 0.0, 24.0, 24.0),
          child: Container(
            height: 80,
            decoration: BoxDecoration(
              color: Colors.lightGreen,
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: Row(
              children: <Widget>[
                Text("   " + counter.toString() + "     ", style: style,),
                ClipRRect(
                  borderRadius: BorderRadius.circular(25.0),
                  child: Image.network(rank.image,
                    height: 50,
                    width: 50,),
                ),
                Text("   " + rank.name),
                Expanded(child: Container(),),
                Text(rank.points.toString() + "      "),
              ],
            ),
          ),
        ));
      }
      counter += 1;
    }
    return list_ele;
  }
}
