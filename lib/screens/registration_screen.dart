import 'package:firebase_auth/firebase_auth.dart';
import 'package:flash_chat/constants.dart';
import 'package:flash_chat/controllers/validator.dart';
import 'package:flash_chat/screens/chat_screen.dart';
import 'package:flash_chat/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flash_chat/components/custom_roundedButton.dart';

class RegistrationScreen extends StatefulWidget {
  static final String routeID = "RegistrationScreen";
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  String _email;
  String _password;
  final auth = FirebaseAuth.instance;
  UserCredential user;
  void registrationFailed ()=> showDialog(
                      context: context, 
                      builder: (context){
                          return SimpleDialog(
                            title: Center(child: Text('Register Failed!')),
                            children: [
                              Center(child: Text('Verify email or password'))
                            ],
                          );
                      });
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white12,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Flexible(
              child: Hero(
                tag: 'flash-logo',
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
              onChanged: (value) {
                _email = value; 
              },
              cursorColor: Colors.orangeAccent,
              decoration: kCredentialTextFieldDecoration.copyWith(hintText: 'Enter your email'), 
              keyboardType:TextInputType.emailAddress,
            ),
            SizedBox(
              height: 8.0,
            ),
            TextField(
              onChanged: (value) {
                _password = value;
              },
              cursorColor: Colors.orangeAccent,
              decoration: kCredentialTextFieldDecoration.copyWith(hintText: 'Enter your password'),
              obscureText: true,
              
            ),
            SizedBox(
              height: 24.0,
            ),
            CustomRoundedButtton(
              title: 'Register', 
              color: Colors.orange, 
              press: ()async {
                ValidatorEmailPassword(_email,_password).validar() ?  

                      await auth.createUserWithEmailAndPassword(email:_email,password:_password) != null ? Navigator.pushNamed(context,LoginScreen.routeID) : registrationFailed() 
                      :
                      registrationFailed();
              },
            )
          ],
        ),
      ),
    );
  }

}

