import 'dart:async';

enum AuthStatus {
  NOT_DETERMINED,
  NOT_LOGGED_IN,
  LOGGED_IN,
}

class AuthBloc {
  StreamController _loginStatusControler = StreamController();

  Stream get loginStatusStream => _loginStatusControler.stream;

  void dispose() {
    _loginStatusControler.close();
  }

  void setLoginStatus(status) {
    _loginStatusControler.sink.add(status);
  }
}

final authBloc = AuthBloc();
