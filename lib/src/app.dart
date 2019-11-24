import 'package:flutter/material.dart';
import 'ui/auth/main_auth.dart';
import 'firebase/fb_auth.dart';
import 'ui/main_app.dart';
import 'blocs/auth_bloc.dart';
import 'blocs/service_bloc.dart';
import 'blocs/item_bloc.dart';

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: AppPage(),
    );
  }
}

// ignore: must_be_immutable
class AppPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _AppPageState();
}

class _AppPageState extends State<AppPage> {
  FBAuth _fbAuth = new FBAuth();

  @override
  void initState() {
    _fbAuth.getCurrentUser().then((user) {
      setState(() {
        if (user == null) {
          authBloc.setLoginStatus(AuthStatus.NOT_LOGGED_IN);
        } else {
          authBloc.setLoginStatus(AuthStatus.LOGGED_IN);
        }
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    authBloc.dispose();
    serviceBloc.dispose();
    itemBloc.dispose();
    super.dispose();
  }

  Widget waitingScreen() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: authBloc.loginStatusStream,
      builder: (context, snapshot) {
        if(snapshot.hasData) {
          switch(snapshot.data) {
            case AuthStatus.NOT_DETERMINED:
              return waitingScreen();
            case AuthStatus.NOT_LOGGED_IN:
              return MainAuth();
            case AuthStatus.LOGGED_IN:
              return MainApp();
            default:
              return waitingScreen();
          }
        }

        return waitingScreen();
      },
    );
  }
}
