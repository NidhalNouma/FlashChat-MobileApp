import 'package:flutter/material.dart';
import 'login_screen.dart';
import 'registration_screen.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flash_chat/components/ButtonP.dart';

class WelcomeScreen extends StatefulWidget {
  static const String id = 'Welcome';

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation _animation;

  @override
  void initState() {
    super.initState();

    _controller = new AnimationController(
      duration: Duration(seconds: 1),
      vsync: this,
    );

    _animation =
        CurvedAnimation(parent: _controller, curve: Curves.bounceInOut);

    _controller.forward();
    _controller.addListener(() {
      setState(() {});
    });

    _animation.addStatusListener((status) {
      // if (status == AnimationStatus.completed)
      //   _controller.reverse(from: 1);
      // else if (status == AnimationStatus.dismissed) _controller.forward();
    });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const colorizeColors = [
      Colors.purple,
      Colors.blue,
      Colors.yellow,
      Colors.red,
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              children: <Widget>[
                Hero(
                  tag: 'logo',
                  child: Container(
                    child: Image.asset('images/logo.png'),
                    height: _animation.value * 100,
                  ),
                ),
                AnimatedTextKit(
                  animatedTexts: [
                    ColorizeAnimatedText(
                      'Flash Chat',
                      textStyle: TextStyle(
                        fontSize: 45.0,
                        fontWeight: FontWeight.w900,
                      ),
                      colors: colorizeColors,
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 48.0,
            ),
            ButtonP(
              text: 'log in',
              color: Colors.lightBlueAccent,
              onPressed: () {
                Navigator.pushNamed(context, LoginScreen.id);
              },
            ),
            ButtonP(
              color: Colors.blueAccent,
              onPressed: () {
                Navigator.pushNamed(context, RegistrationScreen.id);
              },
              text: 'Register',
            ),
          ],
        ),
      ),
    );
  }
}
