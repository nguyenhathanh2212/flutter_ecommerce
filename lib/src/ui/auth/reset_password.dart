import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'main_auth.dart';
import '../../firebase/fb_auth.dart';
import 'baner.dart';

class ResetPassword extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _ResetPasswordState();
  }
}

class _ResetPasswordState extends State<ResetPassword> {
  FBAuth _fbAuth = new FBAuth();
  TextEditingController _emailTEController = TextEditingController();
  String _errorMsgEmail = '';

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
              BanerSign(labelScreen: 'Reset password'),
              Container(
                constraints: BoxConstraints(
                    minWidth: MediaQuery.of(context).size.width,
                    minHeight: MediaQuery.of(context).size.height / 3
                ),
                padding: EdgeInsets.fromLTRB(30, 50, 30, 0),
                child: Center(
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
                    ],
                  ),
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
                      child: SizedBox(
                        height: 42,
                        width: double.infinity,
                        child: RaisedButton(
                          onPressed: processResetPassword,
                          color: Colors.deepOrangeAccent,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(Radius.circular(25))
                          ),
                          child: Text(
                            'RESET',
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
                              children: <TextSpan>[
                                TextSpan(
                                  recognizer: TapGestureRecognizer()..onTap = () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => MainAuth(pageSign: PageSign.LOGIN)
                                      )
                                  );
                                },
                                text: 'Login',
                                  style: TextStyle(
                                      color: Colors.blue,
                                      fontSize: 14
                                  ),
                                ),
                                TextSpan(
                                  text: ' - ',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 14)
                                ),
                                TextSpan(
                                  recognizer: TapGestureRecognizer()..onTap = () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => MainAuth(pageSign: PageSign.REGISTER)
                                        )
                                    );
                                  },
                                  text: 'Register',
                                  style: TextStyle(
                                      color: Colors.blue,
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

  void processResetPassword() {
    String email = _emailTEController.text;
    validateEmail(email);

    if (_errorMsgEmail.length == 0) {
      _fbAuth.resetPassword(email).catchError((err) {
        print('Error reset password : $err');
      });
    }
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
}
