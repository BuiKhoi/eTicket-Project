import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class VoucherDetails extends StatefulWidget {
  VoucherDetails(this.image, this.redeemable);

  String image;
  bool redeemable;

  @override
  _VoucherDetailsState createState() => _VoucherDetailsState();
}

class _VoucherDetailsState extends State<VoucherDetails> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      child: GestureDetector(
        child: Image.network(widget.image),
        onTap: () {
          if (widget.redeemable) {
            showDialog(
                context: context,
                builder: (context) => AlertDialog(
                      title: Text("Voucher redeem successfully"),
                      content: Text("Your code is 13132"),
                    )).then((returnval) {
                      print("Redeemed");
            });
          } else {
            showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text("Voucher redeem unsucessful"),
                  content: Text("You don't have enough points"),
                ));
          }
        },
      ),
    );
  }
}
