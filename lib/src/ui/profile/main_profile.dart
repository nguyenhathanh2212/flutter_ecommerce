import 'package:flutter/material.dart';
import '../../firebase/fb_auth.dart';
import '../../blocs/auth_bloc.dart';

class MainProfile extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MainProfileState();
}

class _MainProfileState extends State<MainProfile> {
  FBAuth _fbAuth = FBAuth();
  dynamic _user;

  @override
  void initState() {
    _fbAuth.getCurrentUser().then((user) {
      setState(() {
        _user = user;
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    FBAuth _fbAuth = new FBAuth();
    // TODO: implement build
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height / 3,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/bg_profile.jpg'),
                fit: BoxFit.cover
              )
            ),
            child: Center(
              child: Column(
                children: <Widget>[
                  Container(
                    width: 130,
                    height: 130,
                    padding: EdgeInsets.all(0),
                    margin: EdgeInsets.fromLTRB(0, 50, 0, 0),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(75),
                        border: Border.all(
                          color: Colors.white,
                          width: 5,
                        ),
                        image: DecorationImage(
                          fit: BoxFit.scaleDown,
                          image: AssetImage('assets/images/avatar.jpg'),
                        )
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 5, left: 5, right: 5),
            color: Colors.black12,
            child: Column(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(top: 15, bottom: 15, left: 30, right: 20),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(width: 1, color: Colors.white),
                      top: BorderSide(width: 1, color: Colors.white),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Icon(
                        Icons.person,
                        size: 18,
                        color: Colors.blue,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 15),
                      ),
                      Text(
                        'Username',
                        style: TextStyle(
                          color: Colors.black54,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(top: 15, bottom: 15, left: 30, right: 20),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(width: 1, color: Colors.white),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Icon(
                        Icons.email,
                        size: 18,
                        color: Colors.deepOrange,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 15),
                      ),
                      Text(
                        _user != null ? _user.email : '',
                        style: TextStyle(
                          color: Colors.black54,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(top: 15, bottom: 15, left: 30, right: 20),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(width: 1, color: Colors.white),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      GestureDetector(
                        onTap: () {
                          _fbAuth.signOut().then((result) {
                            authBloc.setLoginStatus(AuthStatus.NOT_LOGGED_IN);
                          }).catchError((err) {
                            print('Err logout $err');
                          });
                        },
                        child: Row(
                          children: <Widget>[
                            Icon(
                              Icons.power_settings_new,
                              size: 18,
                              color: Colors.red,
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 15),
                            ),
                            Text(
                              'Logout',
                              style: TextStyle(
                                color: Colors.red,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
