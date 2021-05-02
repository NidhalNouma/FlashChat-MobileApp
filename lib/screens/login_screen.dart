import 'package:flash_chat/functions/Auth.dart';
import 'package:flash_chat/screens/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:flash_chat/components/ButtonP.dart';
import 'package:flash_chat/constants.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class LoginScreen extends StatefulWidget {
  static const String id = 'Login';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String email;
  String password;
  bool spin = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: spin,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Flexible(
                child: Hero(
                  tag: 'logo',
                  child: Container(
                    height: 200.0,
                    child: Image.asset('images/logo.png'),
                  ),
                ),
              ),
              SizedBox(
                height: 48.0,
              ),
              TextField(
                textAlign: TextAlign.center,
                keyboardType: TextInputType.emailAddress,
                onChanged: (value) {
                  email = value;
                },
                decoration: KTIDecoration,
              ),
              SizedBox(
                height: 8.0,
              ),
              TextField(
                textAlign: TextAlign.center,
                obscureText: true,
                onChanged: (value) {
                  password = value;
                },
                decoration: KTIDecoration.copyWith(
                  hintText: 'Enter your password',
                ),
              ),
              SizedBox(
                height: 24.0,
              ),
              ButtonP(
                color: Colors.lightBlueAccent,
                onPressed: () {
                  setState(() {
                    this.spin = true;
                  });
                  MyAuth().login(email, password, (err) {
                    if (err == null)
                      Navigator.pushNamedAndRemoveUntil(
                          context, ChatScreen.id, (route) => false);
                    setState(() {
                      this.spin = false;
                    });
                  });
                },
                text: 'Log In',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
