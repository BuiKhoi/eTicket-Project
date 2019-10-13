import 'dart:convert';
import 'package:eticket/ranking.dart';
import 'package:flutter/material.dart';
import 'explorevouchers.dart';
import 'hooman.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:http/http.dart';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/services.dart';
import 'itemvoucher.dart';
import 'login.dart';
import 'profilepage.dart';

class Dashboard extends StatefulWidget {
  Dashboard(this.hooman);

  Hooman hooman;

  @override
  State createState() {
    return new _dashboardState();
  }
}

class _dashboardState extends State<Dashboard> {
  Future<String> _scanQR() async {
    try {
      String qrResult = await BarcodeScanner.scan();
      return qrResult;
    } on PlatformException catch (ex) {
      if (ex.code == BarcodeScanner.CameraAccessDenied) {
        return "Camera permission was denied";
      } else {
        return "Unknown Error $ex";
      }
    } on FormatException {
      return "You pressed the back button before scanning anything";
    } catch (ex) {
      print(ex);
      return "Unknown Error $ex";
    }
  }

  List<Voucher> vouchers = [
    new Voucher(
        "https://scontent.fdad1-1.fna.fbcdn.net/v/t1.15752-9/s2048x2048/71662819_415364099123927_8959136715272880128_n.png?_nc_cat=103&_nc_oc=AQn8MrKRWsRBROZlydtEFnuCqfvhVi6FbGMpDIlo6R3bwaKXICWgBBouShCzMvmUoJc&_nc_ht=scontent.fdad1-1.fna&oh=637395a584a094b919ae582fff4029f2&oe=5E2B20A4",
        "60% discount for UrAir",
        125),
    new Voucher(
        "https://scontent.fdad1-1.fna.fbcdn.net/v/t1.15752-9/s2048x2048/72555850_660743177752727_155304179177357312_n.png?_nc_cat=102&_nc_oc=AQlcYOhD3XHT-6kzyycmW0p2PrCcpwpwsifQBPOKrZUJauJDhRI9VDaIzVDb4ZukR4s&_nc_ht=scontent.fdad1-1.fna&oh=a140c485311e361fff3f4a7b0dd47f93&oe=5E656675",
        "Parking ticket",
        125),
    new Voucher(
        "https://scontent.fdad2-1.fna.fbcdn.net/v/t1.15752-9/s2048x2048/72789534_1316414758531893_6850120065686175744_n.png?_nc_cat=109&_nc_oc=AQkqV1OGHVnDRInFDk33WHv4ETlgJjY1QNYj0chclJgPjsSq5f8mUpvh5qJfhO_wo_M&_nc_ht=scontent.fdad2-1.fna&oh=cfd38793d5751aa3983e89c700595142&oe=5E268317",
        "Highlands cofee",
        125),
  ];

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return Future.value(false);
      },
      child: Scaffold(
          appBar: AppBar(
            leading: Container(),
            backgroundColor: Colors.orange,
            title: Text('e-Tickets',
                style: TextStyle(
                  color: Colors.white,
                )),
          ),
          body: StaggeredGridView.count(
            crossAxisCount: 2,
            crossAxisSpacing: 12.0,
            mainAxisSpacing: 12.0,
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            children: <Widget>[
              _buildTile(
                Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text('Total tickets',
                                style: TextStyle(color: Colors.blueAccent)),
                            Text(widget.hooman.points.toString(),
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 34.0))
                          ],
                        ),
                        Image.asset("assets/ticket.png", height: 50, width: 50,)
                      ]),
                ),
              ),
              GestureDetector(
                onTap: () async {
                  //var camera = await availableCameras();
                  Navigator.of(context).push(MaterialPageRoute(builder: (_) => ProfilePage()));
                },
                child: _buildTile(
                  Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Material(
                              color: Colors.teal,
                              shape: CircleBorder(),
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Icon(Icons.settings_applications,
                                    color: Colors.white, size: 30.0),
                              )),
                          Padding(padding: EdgeInsets.only(bottom: 16.0)),
                          Text('General',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 24.0)),
                          Text('Edit details',
                              style: TextStyle(color: Colors.black45)),
                        ]),
                  ),
                ),
              ),
              GestureDetector(
                child: _buildTile(
                  Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Material(
                              color: Colors.amber,
                              shape: CircleBorder(),
                              child: Padding(
                                padding: EdgeInsets.all(16.0),
                                child: Icon(Icons.photo_camera,
                                    color: Colors.white, size: 30.0),
                              )),
                          Padding(padding: EdgeInsets.only(bottom: 16.0)),
                          Text('Scan',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 24.0)),
                          Text('Scan your QR code',
                              style: TextStyle(color: Colors.black45)),
                        ]),
                  ),
                ),
                onTap: () {
                  String code = "";
                  _scanQR().then((qrcode) {
//                  print(qrcode);
//
                    get("https://us-central1-devfest-2019-255504.cloudfunctions.net/redeemCode?code=" +
                            qrcode +
                            "&id=" +
                            widget.hooman.userId)
                        .then((response) {
                      widget.hooman.getPoints().then((new_point) {
                        widget.hooman.points = new_point;
                        showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                                  title: Text("Redeem status"),
                                  content: Text(response.body),
                                ));
                      });
                    });
                  });
                },
              ),
              _buildTile(
                Padding(
                    padding: EdgeInsets.only(top: 24.0, left: 12, right: 0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  'Special vouchers',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14),
                                ),
                              ],
                            ),
                            GestureDetector(
                              child: Text(
                                "See more >  ",
                                style: TextStyle(color: Colors.blueAccent),
                              ),
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (_) => ExploreVouchers()));
                              },
                            )
                          ],
                        ),
                        Padding(padding: EdgeInsets.only(bottom: 4.0)),
                        ItemVoucher(vouchers),
                      ],
                    )),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (_) => Ranking()));
                },
                child: _buildTile(
                  Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text('Best contributor',
                                  style: TextStyle(color: Colors.redAccent)),
                              Text(ranked_list[0].name,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 14.0))
                            ],
                          ),
                          Material(
                              color: Colors.green,
                              borderRadius: BorderRadius.circular(24.0),
                              child: Center(
                                  child: Padding(
                                      padding: EdgeInsets.all(16.0),
                                      child: Text(
                                        ranked_list[0].points.toString(),
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                        ),
                                      ))))
                        ]),
                  ),
                  onTap: () => {
                    //Navigator.of(context).push(MaterialPageRoute(builder: (_) => ShopItemsPage()))
                  },
                ),
              )
            ],
            staggeredTiles: [
              StaggeredTile.extent(2, 110.0),
              StaggeredTile.extent(1, 180.0),
              StaggeredTile.extent(1, 180.0),
              StaggeredTile.extent(2, 220.0),
              StaggeredTile.extent(2, 110.0),
            ],
          )),
    );
  }

  Widget _buildTile(Widget child, {Function() onTap}) {
    return Material(
        elevation: 14.0,
        borderRadius: BorderRadius.circular(12.0),
        shadowColor: Color(0x802196F3),
        child: InkWell(
            // Do onTap() if it isn't null, otherwise do print()
            //onTap: onTap != null ? () => onTap() : () { print('Not set yet'); },
            child: child));
  }
}
