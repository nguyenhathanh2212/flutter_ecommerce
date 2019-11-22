import 'package:flutter/material.dart';
import 'login.dart';
import 'register.dart';
import 'reset_password.dart';

enum PageSign {
  LOGIN,
  REGISTER,
  RESET_PASSWORD
}

class MainAuth extends StatelessWidget {
  MainAuth({this.pageSign});
  PageSign pageSign;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      initialRoute: getInitialRoute(),
      routes: {
        '/': (context) => Login(),
        '/register': (context) => Register(),
        '/reset_password': (context) => ResetPassword(),
      },
    );
  }

  String getInitialRoute() {
    pageSign = pageSign ?? PageSign.LOGIN;

    switch (pageSign) {
      case PageSign.LOGIN:
        return '/';
      case PageSign.REGISTER:
        return '/register';
      case PageSign.RESET_PASSWORD:
        return '/reset_password';
      default:
        return '/';
    }
  }
}
