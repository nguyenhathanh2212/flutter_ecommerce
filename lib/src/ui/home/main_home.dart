import 'package:flutter/material.dart';
import '../../firebase/fb_auth.dart';
import '../../blocs/auth_bloc.dart';
import '../profile/main_profile.dart';

class MainHome extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MainHomeState();
}

class _MainHomeState extends State<MainHome> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
      ),
      body: Center(
        child: Text('Text'),
      ),
    );
  }
}
