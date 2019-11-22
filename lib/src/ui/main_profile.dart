import 'package:flutter/material.dart';
import '../firebase/fb_auth.dart';
import '../blocs/auth_bloc.dart';
import 'profile/main_profile.dart';
import 'home/main_home.dart';

class MainApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  FBAuth _fbAuth = FBAuth();
  int _selectedIndexTab = 0;
  static List<Widget> _widgetOptions = <Widget>[
    MainHome(),
    Text(
      'Home2',
    ),
    Text(
      'Home3',
    ),
    MainProfile(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndexTab = index;
    });
  }

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
  Widget build(BuildContext context) {
    return Scaffold(
      body: _widgetOptions.elementAt(_selectedIndexTab),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text('Home'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            title: Text('Cart'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            title: Text('Notifications'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            title: Text('Profile'),
          ),
        ],
        currentIndex: _selectedIndexTab,
        selectedItemColor: Colors.deepOrange,
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}
