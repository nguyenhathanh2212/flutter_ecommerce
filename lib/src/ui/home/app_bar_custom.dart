import 'package:flutter/material.dart';

class AppBarCustom extends StatefulWidget {
  AppBarCustom({this.showAppBar = true});
  bool showAppBar;
  @override
  State<StatefulWidget> createState() => AppBarCustomState();
}

class AppBarCustomState extends State<AppBarCustom> {
  @override
  Widget build(BuildContext context) {
    Widget appBarCustom = AppBar(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            child: Row(
              children: <Widget>[
                Icon(
                  Icons.shopping_cart,
                ),
                Text(
                  ' M..T..',
                  style: TextStyle(
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ],
            ),
          ),
          Container(
            child: Row(
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {},
                ),
                IconButton(
                  icon: Icon(Icons.shopping_cart),
                  onPressed: () {},
                )
              ],
            ),
          )
        ],
      ),
      flexibleSpace: Container(
        decoration: new BoxDecoration(
          gradient: new LinearGradient(
            colors: [
              Colors.deepOrange,
              Colors.deepOrangeAccent,
              Colors.orange,
              Colors.orangeAccent,
            ],
          ),
        ),
      ),
    );

    return AnimatedContainer(
        curve: Curves.fastLinearToSlowEaseIn,
        height: widget.showAppBar ? 80 : 24,
        duration: Duration(seconds: 2),
        child: widget.showAppBar ? appBarCustom : Container(
          height: 24,
          width: double.infinity,
          color: Colors.cyan,
        ),
    );
  }
}
