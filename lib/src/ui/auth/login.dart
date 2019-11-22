import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'main_auth.dart';
import '../../firebase/fb_auth.dart';
import '../../blocs/auth_bloc.dart';
import 'baner.dart';

class Login extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _LoginState();
  }
}

class _LoginState extends State<Login> {
  FBAuth _fbAuth = new FBAuth();
  bool _hidePassword = true;
  TextEditingController _emailTEController = TextEditingController();
  TextEditingController _passwordTEController = TextEditingController();
  String _errorMsgEmail = '';
  String _errorMsgPassword = '';

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          constraints: BoxConstraints(
            minHeight: MediaQuery.of(context).size.height,
          ),
          child: Column(
            children: <Widget>[
              BanerSign(labelScreen: 'Login'),
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
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Email',
                          icon: Icon(
                            Icons.email,
                            color: Colors.grey,
                            size: 16,
                          ),
                        ),
                        controller: _emailTEController,
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
                          Container(
                            padding: EdgeInsets.only(right: 25),
                            child: TextField(
                              obscureText: _hidePassword,
                              style: TextStyle(
                                  fontSize: 16
                              ),
                              onChanged: (password) => validatePassword(password),
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Password',
                                icon: Icon(
                                  Icons.vpn_key,
                                  color: Colors.grey,
                                  size: 16,
                                ),
                              ),
                              controller: _passwordTEController,
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
                      width: double.infinity,
                      padding: EdgeInsets.only(top: 20),
                      child: GestureDetector(
                        child: Text(
                          'Forgot Password?',
                          textAlign: TextAlign.end,
                          style: TextStyle(
                              color: Colors.black54,
                              fontSize: 14
                          ),
                        ),
                        onTap: redirectResetPasswrodPage,
                      )
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
                      margin: EdgeInsets.only(top: 50),
                      child: SizedBox(
                        height: 42,
                        width: double.infinity,
                        child: RaisedButton(
                          onPressed: processLogin,
                          color: Colors.deepOrangeAccent,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(Radius.circular(25))
                          ),
                          child: Text(
                            'LOGIN',
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
                            text: "Don't have account? ",
                            style: TextStyle(
                                color: Colors.black54,
                                fontSize: 14
                            ),
                            children: <TextSpan>[
                              TextSpan(
                                recognizer: TapGestureRecognizer()
                                  ..onTap = redirectRegisterPage,
                                text: 'Register',
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
      ),
    );
  }

  void redirectRegisterPage() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => MainAuth(pageSign: PageSign.REGISTER)
        )
    );
  }

  void redirectResetPasswrodPage() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MainAuth(pageSign: PageSign.RESET_PASSWORD),
      ),
    );
  }

  void toggleHidePassword() {
    setState(() {
      _hidePassword = !_hidePassword;
    });
  }

  void processLogin() {
    String email = _emailTEController.text;
    String password = _passwordTEController.text;
    validateEmail(email);
    validatePassword(password);

    if (_errorMsgPassword.length == 0
      && _errorMsgEmail.length == 0) {
      _fbAuth.signIn(email, password).then((userId) {
        if (userId != null) authBloc.setLoginStatus(AuthStatus.LOGGED_IN);
      }).catchError((err) {
        setState(() {
          _errorMsgEmail = _fbAuth.processErrorMessage(err.code);
        });
        print('Error login : $err');
      });
    }
  }

  void validateEmail(String email) {
    setState(() {
      _errorMsgEmail = '';

      if (email.length == 0) {
        _errorMsgEmail = 'Email field is required';
      } else if (!email.contains('@') || email.substring(email.length - 1) == '@') {
        _errorMsgEmail = 'Email field is invalid';
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
}
