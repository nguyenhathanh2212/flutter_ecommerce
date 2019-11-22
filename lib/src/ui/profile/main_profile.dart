import 'package:flutter/material.dart';
import '../../firebase/fb_auth.dart';
import '../../blocs/auth_bloc.dart';

class MainProfile extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MainProfileState();
}

class _MainProfileState extends State<MainProfile> {
  @override
  Widget build(BuildContext context) {
    FBAuth _fbAuth = new FBAuth();

    // TODO: implement build
    return Container(
      child: Column(
        children: <Widget>[
          RaisedButton(
            child: Text('Logout'),
            onPressed: () {
              _fbAuth.signOut().then((result) {
                authBloc.setLoginStatus(AuthStatus.NOT_LOGGED_IN);
              }).catchError((err) {
                print('Err logout $err');
              });
            },
          )
        ],
      ),
    );
  }
}
