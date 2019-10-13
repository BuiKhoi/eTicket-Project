import 'package:eticket/voucherdetails.dart';
import 'package:flutter/material.dart';

class ItemVoucher extends StatefulWidget {
  ItemVoucher(this.vlist);

  List<Voucher> vlist;

  @override
  _ItemVoucherState createState() => _ItemVoucherState();
}

class _ItemVoucherState extends State<ItemVoucher> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: (300 -149+32-8).toDouble(),
      width: double.infinity,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: getVouchersWidget(widget.vlist),
      ),
    );
  }

  List<Widget> getVouchersWidget(List<Voucher> vouchers) {
    List<Widget> wList = new List<Widget>();
    for (var i in vouchers) {
      wList.add(getVoucherView(i.image, i.title, i.points));
    }

    return wList;
  }

  Widget getVoucherView(String image, String title, int points) {
    return Container(
      padding: EdgeInsets.only(right: 20),
      width: 280,
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (_) => VoucherDetails(
                  "https://scontent.fdad2-1.fna.fbcdn.net/v/t1.15752-9/72318714_1014670628869316_3569377913310543872_n.jpg?_nc_cat=111&_nc_oc=AQkdtjI0Qy1kka2BdzMjwPTU85phBAW6K1xcRhanxonoMjAfZDtXNWji9SUkh3vFvIk&_nc_ht=scontent.fdad2-1.fna&oh=7f05ca5afe04ae79739e4d3963d6db5c&oe=5E38C5B3",
                  true)));
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Image.network(image, fit: BoxFit.fitWidth),
            Text(
              title,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(points.toString() + " Points")
          ],
        ),
      ),
    );
  }
}

class Voucher {
  Voucher(this.image, this.title, this.points);

  String image;
  String title;
  int points;
}
