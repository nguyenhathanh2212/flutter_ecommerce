import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'main_auth.dart';
import '../../firebase/fb_auth.dart';
import '../../blocs/auth_bloc.dart';
import 'baner.dart';

class Register extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _RegisterState();
  }
}

class _RegisterState extends State<Register> {
  bool _hidePassword = true;
  bool _hidePasswordConfirm = true;
  TextEditingController _emailTEController = TextEditingController();
  TextEditingController _usernameTEController = TextEditingController();
  TextEditingController _passwordTEController = TextEditingController();
  TextEditingController _passwordConfirmTEController = TextEditingController();
  String _errorMsgUsername = '';
  String _errorMsgEmail = '';
  String _errorMsgPassword = '';
  String _errorMsgPasswordConfirm = '';
  FBAuth _fbAuth = new FBAuth();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: <Widget>[
            Container(
              constraints: BoxConstraints(
                minHeight: MediaQuery.of(context).size.height,
              ),
              child: Column(
                children: <Widget>[
                  BanerSign(labelScreen: 'Register'),
                  Container(
                    constraints: BoxConstraints(
                        minWidth: MediaQuery.of(context).size.width,
                        minHeight: MediaQuery.of(context).size.height / 3
                    ),
                    padding: EdgeInsets.fromLTRB(30, 50, 30, 0),
                    child: Column(
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.only(left: 20, right: 20, top: 2, bottom: 2),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                    color: _errorMsgUsername.length > 0 ? Colors.red : Colors.black12,
                                    blurRadius: 5,
                                )
                              ]
                          ),
                          child: TextField(
                            style: TextStyle(
                                fontSize: 16
                            ),
                            onChanged: (username) => validateUsername(username),
                            controller: _usernameTEController,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Username',
                              icon: Icon(
                                Icons.person,
                                color: Colors.grey,
                                size: 16,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 8),
                          child: Text(
                            _errorMsgUsername,
                            textAlign: TextAlign.end,
                            style: TextStyle(
                              color: Colors.red,
                              fontSize: 13,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(left: 20, right: 20, top: 2, bottom: 2),
                          margin: EdgeInsets.only(top: 15),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                    color: _errorMsgEmail.length > 0 ? Colors.red : Colors.black12,
                                    blurRadius: 5
                                )
                              ]
                          ),
                          child: TextField(
                            style: TextStyle(
                                fontSize: 16
                            ),
                            onChanged: (email) => validateEmail(email),
                            controller: _emailTEController,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Email',
                              icon: Icon(
                                Icons.email,
                                color: Colors.grey,
                                size: 16,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 8),
                          child: Text(
                            _errorMsgEmail,
                            textAlign: TextAlign.end,
                            style: TextStyle(
                              color: Colors.red,
                              fontSize: 13,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(left: 20, right: 20, top: 2, bottom: 2),
                          margin: EdgeInsets.only(top: 15),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                    color: _errorMsgPassword.length > 0 ? Colors.red : Colors.black12,
                                    blurRadius: 5
                                )
                              ]
                          ),
                          child: Stack(
                            alignment: AlignmentDirectional.centerEnd,
                            children: <Widget>[
                              TextField(
                                obscureText: _hidePassword,
                                style: TextStyle(
                                    fontSize: 16
                                ),
                                onChanged: (password) => validatePassword(password),
                                controller: _passwordTEController,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Password',
                                  icon: Icon(
                                    Icons.vpn_key,
                                    color: Colors.grey,
                                    size: 16,
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: toggleHidePassword,
                                child: Icon(
                                  Icons.remove_red_eye,
                                  size: 18,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 8),
                          child: Text(
                            _errorMsgPassword,
                            textAlign: TextAlign.end,
                            style: TextStyle(
                              color: Colors.red,
                              fontSize: 13,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(left: 20, right: 20, top: 2, bottom: 2),
                          margin: EdgeInsets.only(top: 15),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                    color: _errorMsgPasswordConfirm.length > 0 ? Colors.red : Colors.black12,
                                    blurRadius: 5
                                )
                              ]
                          ),
                          child: Stack(
                            alignment: AlignmentDirectional.centerEnd,
                            children: <Widget>[
                              TextField(
                                obscureText: _hidePasswordConfirm,
                                style: TextStyle(
                                    fontSize: 16
                                ),
                                onChanged: (passwordConfirm) => validatePasswordConfirm('', passwordConfirm),
                                controller: _passwordConfirmTEController,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Confirm Password',
                                  icon: Icon(
                                    Icons.vpn_key,
                                    color: Colors.grey,
                                    size: 16,
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: toggleHidePasswordConfirm,
                                child: Icon(
                                  Icons.remove_red_eye,
                                  size: 18,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 8),
                          child: Text(
                            _errorMsgPasswordConfirm,
                            textAlign: TextAlign.end,
                            style: TextStyle(
                              color: Colors.red,
                              fontSize: 13,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    constraints: BoxConstraints(
                      minWidth: MediaQuery.of(context).size.width,
                    ),
                    padding: EdgeInsets.fromLTRB(30, 0, 30, 30),
                    child: Column(
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(top: 20),
                          child: SizedBox(
                            height: 42,
                            width: double.infinity,
                            child: RaisedButton(
                              onPressed: processRegister,
                              color: Colors.deepOrangeAccent,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(25))
                              ),
                              child: Text(
                                'REGISTER',
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Container(
                            padding: EdgeInsets.only(top: 30),
                            child:
                            RichText(
                              text: TextSpan(
                                  text: "Already a USER? ",
                                  style: TextStyle(
                                      color: Colors.black54,
                                      fontSize: 14
                                  ),
                                  children: <TextSpan>[
                                    TextSpan(
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = redirectLoginPage,
                                      text: 'Login',
                                      style: TextStyle(
                                          color: Colors.deepOrangeAccent,
                                          fontSize: 14
                                      ),
                                    )
                                  ]
                              ),
                            )
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              iconTheme: IconThemeData(color: Colors.black54),
            ),
          ],
        )
      ),
    );
  }

  void redirectLoginPage() {
    Navigator.push(context,
      MaterialPageRoute(
          builder: (context) => MainAuth(pageSign: PageSign.LOGIN)
      ),
    );
  }

  void toggleHidePassword() {
    setState(() {
      _hidePassword = !_hidePassword;
    });
  }

  void toggleHidePasswordConfirm() {
    setState(() {
      _hidePasswordConfirm = !_hidePasswordConfirm;
    });
  }

  void processRegister() {
    String username = _usernameTEController.text;
    String email = _emailTEController.text;
    String password = _passwordTEController.text;
    String passwordConfirm = _passwordConfirmTEController.text;
    validateUsername(username);
    validateEmail(email);
    validatePassword(password);
    validatePasswordConfirm(password, passwordConfirm);

    if (_errorMsgEmail.length == 0
      && _errorMsgPassword.length == 0
      && _errorMsgPasswordConfirm.length == 0
      && _errorMsgUsername.length == 0) {
      _fbAuth.signUp(email, password, username).then((userId) {
        if (userId != null) authBloc.setLoginStatus(AuthStatus.LOGGED_IN);
      }).catchError((err) {
        setState(() {
          _errorMsgEmail = _fbAuth.processErrorMessage(err.code);
        });
        print('Error register $err');
      });
    }
  }

  void validateUsername(String username) {
    setState(() {
      _errorMsgUsername = '';

      if (username.length == 0) {
        _errorMsgUsername = 'Username field is required';
      }
    });
  }

  void validateEmail(String email) {
    setState(() {
      _errorMsgEmail = '';

      if (email.length == 0) {
        _errorMsgEmail = 'Email field is required';
      } else if (!email.contains('@') || email.substring(email.length - 1) == '@') {
        _errorMsgEmail = 'Email field is not valid';
      }
    });
  }

  void validatePassword(String password) {
    setState(() {
      _errorMsgPassword = '';

      if (password.length == 0) {
        _errorMsgPassword = 'Password field is required';
      } else if (password.length < 6) {
        _errorMsgPassword = 'Password field must be greater than 6 characters';
      }
    });
  }

  void validatePasswordConfirm(String password, String passwordConfirm) {
    setState(() {
      _errorMsgPasswordConfirm = '';

      if (password.length > 0 && password != passwordConfirm) {
        _errorMsgPasswordConfirm = 'Password confirm field not match';
      }
    });
  }
}
