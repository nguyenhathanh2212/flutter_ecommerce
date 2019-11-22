import 'package:flutter/material.dart';

class BanerSign extends StatelessWidget {
  BanerSign({this.labelScreen});
  String labelScreen;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      constraints: BoxConstraints(
        minHeight: MediaQuery.of(context).size.height / 3,
        minWidth: MediaQuery.of(context).size.width,
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
            colors: [
              Colors.deepOrange,
              Colors.deepOrangeAccent,
              Colors.orange,
              Colors.orangeAccent,
            ]
        ),
        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(100)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            child: Image.asset(
              'assets/images/logo.png',
              width: double.infinity,
            ),
            width: 130,
            height: 130,
            padding: EdgeInsets.all(10),
            margin: EdgeInsets.fromLTRB(0, 50, 0, 0),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(75),
                border: Border.all(
                  color: Colors.white,
                  width: 5,
                )
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(0, 40, 40, 40),
            width: double.infinity,
            child: Text(
              labelScreen ?? 'Login',
              textAlign: TextAlign.right,
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
          )
        ],
      ),
    );
  }
}