import 'package:flutter/material.dart';

import 'itemvoucher.dart';
import 'login.dart';

class ExploreVouchers extends StatefulWidget {
  @override
  _ExploreVouchersState createState() => _ExploreVouchersState();
}

class _ExploreVouchersState extends State<ExploreVouchers> {

  List<Voucher> public = [
    new Voucher("https://scontent.fdad2-1.fna.fbcdn.net/v/t1.15752-9/s2048x2048/72593511_2495113247387629_7411132013899415552_n.png?_nc_cat=111&_nc_oc=AQmB-X1lneFvcrMHA8qltP5iLh0_nBGKpzTfw1A_PRzkiai12qyE0zDalnhNF0PNCCI&_nc_ht=scontent.fdad2-1.fna&oh=fabd2b715623c8d7133fe87e4c947ee3&oe=5E37375B", "Bus ticket", 130),
    new Voucher("https://scontent.fdad1-1.fna.fbcdn.net/v/t1.15752-9/s2048x2048/72426037_2524349944499169_2340282698397908992_n.png?_nc_cat=102&_nc_oc=AQmSx-h9JGblDxcMJVMqi4ptt7e0lntCzndY8ITTW4sg-Re0SOjQtQUtRb48nEBYO54&_nc_ht=scontent.fdad1-1.fna&oh=6a6c29f2025f4ba9523e5183f188acb3&oe=5E1B402F", "Train ticket", 160),
    new Voucher("https://scontent.fdad1-1.fna.fbcdn.net/v/t1.15752-9/s2048x2048/72555850_660743177752727_155304179177357312_n.png?_nc_cat=102&_nc_oc=AQlcYOhD3XHT-6kzyycmW0p2PrCcpwpwsifQBPOKrZUJauJDhRI9VDaIzVDb4ZukR4s&_nc_ht=scontent.fdad1-1.fna&oh=a140c485311e361fff3f4a7b0dd47f93&oe=5E656675", "Parking ticket", 80),
  ];

  List<Voucher> services = [
    new Voucher("https://scontent.fdad2-1.fna.fbcdn.net/v/t1.15752-9/s2048x2048/72568986_397522824273281_8579772587708514304_n.png?_nc_cat=107&_nc_oc=AQkkA25AopbKW09TEJYXgC5tBEeHR92aK1XiH6K4l7VkKS14t1JHuv1XB2WTNklGRiA&_nc_ht=scontent.fdad2-1.fna&oh=aafda242e314dae53db991c1fc0493af&oe=5E3794CA", "50% discount for grab", 100),
    new Voucher("https://scontent.fdad1-1.fna.fbcdn.net/v/t1.15752-9/s2048x2048/72678150_424763968417154_8167646866222088192_n.png?_nc_cat=102&_nc_oc=AQkGk24JkvYBLdUXnlW4tkf8I-rfwXQuTxn3s8ihPX-MhvDCgvVIZiy1z4jFcwWOkQQ&_nc_ht=scontent.fdad1-1.fna&oh=195b4c7a2b82e2685447c886e2b545af&oe=5E2F24C3", "10% off tiki trade", 80),
    new Voucher("https://scontent.fdad1-1.fna.fbcdn.net/v/t1.15752-9/s2048x2048/71662819_415364099123927_8959136715272880128_n.png?_nc_cat=103&_nc_oc=AQn8MrKRWsRBROZlydtEFnuCqfvhVi6FbGMpDIlo6R3bwaKXICWgBBouShCzMvmUoJc&_nc_ht=scontent.fdad1-1.fna&oh=637395a584a094b919ae582fff4029f2&oe=5E2B20A4", "60% discount for UrAir", 160),
  ];

  List<Voucher> entertains = [
    new Voucher("https://scontent.fdad2-1.fna.fbcdn.net/v/t1.15752-9/s2048x2048/72789534_1316414758531893_6850120065686175744_n.png?_nc_cat=109&_nc_oc=AQkqV1OGHVnDRInFDk33WHv4ETlgJjY1QNYj0chclJgPjsSq5f8mUpvh5qJfhO_wo_M&_nc_ht=scontent.fdad2-1.fna&oh=cfd38793d5751aa3983e89c700595142&oe=5E268317", "20% off highlands cofee", 200),
    new Voucher("https://scontent.fdad1-1.fna.fbcdn.net/v/t1.15752-9/s2048x2048/73245694_768103540297571_7078400944722935808_n.png?_nc_cat=103&_nc_oc=AQlQiJL3jDJo29pxNR7YDcKxLvqvRCy-DHlohQdJ9sMIBVxiRhAm9xQ_Adm4SDXgazM&_nc_ht=scontent.fdad1-1.fna&oh=79f5c6663fd15ddfac79c37b0bb1d535&oe=5E294FC0", "20% off at McDonals", 200),
    new Voucher("https://scontent.fdad1-1.fna.fbcdn.net/v/t1.15752-9/72457827_725004091348770_8236960379884797952_n.jpg?_nc_cat=104&_nc_oc=AQljrWix11M-eAYiWSJt-qzQba1VSpqFmfah4NxCYDdrBvRkAy8q7nFIOjzwcpG1iuo&_nc_ht=scontent.fdad1-1.fna&oh=85e6b923d2edad4e9a1ac9db5e6d4f22&oe=5E1FA055", "The cofee house ticket", 300),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Rewards", style: TextStyle(color: Colors.white),),
        leading: GestureDetector(child: Icon(Icons.navigate_before, color: Colors.white, size: 30,),
        onTap: () {
          Navigator.pop((context));
        }),
        actions: <Widget>[
          Icon(Icons.monetization_on, color: Colors.white, size: 20,),
          Center(
            child: Text(" $point point", style: TextStyle(color: Colors.white, fontSize: 14),),
          ),
          Container(
            width: 20,
          )
        ],
      ),
      body: Container(
        color: Colors.white,
        child: ListView(
          children: <Widget>[
            _buildTile(
              Padding
                (
                  padding: const EdgeInsets.all(24.0),
                  child: Column
                    (
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>
                    [
                      Row
                        (
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>
                        [
                          Column
                            (
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>
                            [
                              Text('Public services',
                                style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 14),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Padding(padding: EdgeInsets.only(bottom: 4.0)),
                      ItemVoucher(public),
                    ],
                  )
              ),
            ),
            Container(height: 20,),

            _buildTile(
              Padding
                (
                  padding: const EdgeInsets.all(24.0),
                  child: Column
                    (
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>
                    [
                      Row
                        (
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>
                        [
                          Column
                            (
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>
                            [
                              Text('Services',
                                style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 14),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Padding(padding: EdgeInsets.only(bottom: 4.0)),
                      ItemVoucher(services),
                    ],
                  )
              ),
            ),
            Container(height: 20,),

            _buildTile(
              Padding
                (
                  padding: const EdgeInsets.all(24.0),
                  child: Column
                    (
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>
                    [
                      Row
                        (
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>
                        [
                          Column
                            (
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>
                            [
                              Text('Food and drinks',
                                style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 14),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Padding(padding: EdgeInsets.only(bottom: 4.0)),
                      ItemVoucher(entertains),
                    ],
                  )
              ),
            ),
            Container(height: 20,),
          ],
        ),
      ),
    );
  }

  Widget _buildTile(Widget child, {Function() onTap}) {
    return Material(
        elevation: 14.0,
        borderRadius: BorderRadius.circular(12.0),
        shadowColor: Color(0x802196F3),
        child: InkWell
          (
          // Do onTap() if it isn't null, otherwise do print()
          //onTap: onTap != null ? () => onTap() : () { print('Not set yet'); },
            child: child
        )
    );
  }
}
