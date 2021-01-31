import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flash_chat/components/custom_roundedButton.dart';
import 'package:flutter/material.dart';

import 'login_screen.dart';
import 'registration_screen.dart';

class WelcomeScreen extends StatefulWidget {
  static final String routeID = "HomeScreen";
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white10,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              
              children: <Widget>[
                Hero(
                  tag: 'flash-logo',
                  child: Container(
                    child: Image.asset('images/logo.png'),
                    height: 60.0,
                    margin: EdgeInsets.only(right: 20.0),
                  ),
                ),
                TypewriterAnimatedTextKit(
                  speed: Duration(milliseconds: 200),
                  stopPauseOnTap: true,
                  text: ['Now Chat'],
                  textStyle: TextStyle(
                    fontSize: 35.0,
                    fontWeight: FontWeight.w900,
                    color: Colors.white,
                    
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 48.0,
            ),
            CustomRoundedButtton(
              color: Colors.orangeAccent,
              press: ()=>Navigator.pushNamed(context,LoginScreen.routeID), 
              title: 'Log in'
            ),
            CustomRoundedButtton(
              color: Colors.orange,
              press: ()=>Navigator.pushNamed(context,RegistrationScreen.routeID), 
              title: 'Register'
            ),
            
          ],
        ),
      ),
    );
  }
}
