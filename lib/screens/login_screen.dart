import 'package:firebase_auth/firebase_auth.dart';
import 'package:flash_chat/components/custom_roundedButton.dart';
import 'package:flash_chat/controllers/validator.dart';
import 'package:flutter/material.dart';
import 'package:flash_chat/constants.dart';
import 'chat_screen.dart';

class LoginScreen extends StatefulWidget {
  static final String routeID = "LoginScreen";
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final auth = FirebaseAuth.instance;
  String _pass;
  String _email;
  void loginFailed ()=> showDialog(
                      context: context, 
                      builder: (context){
                          return SimpleDialog(
                            title: Center(child: Text('Login Failed!')),
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
              cursorColor: Colors.orange,
              decoration: kCredentialTextFieldDecoration.copyWith(hintText:'Enter your email')
            ),
            SizedBox(
              height: 8.0,
            ),
            TextField(
              obscureText: true,
              onChanged: (value) {
                _pass = value;
              },
              cursorColor: Colors.orange,
              decoration: kCredentialTextFieldDecoration.copyWith(hintText:'Enter your password'),
            ),
            SizedBox(
              height: 24.0,
            ),
            CustomRoundedButtton(
              title: 'Login',
              color: Colors.orangeAccent,
              press: ()async{
                
                if(ValidatorEmailPassword(_email,_pass).validar())
                {
                  try{
                    await auth.signInWithEmailAndPassword(email: _email, password: _pass);
                    Navigator.pushNamed(context,ChatScreen.routeID);
                  }
                  catch(Exception){
                    loginFailed();
                  }
                }
                else {
                  loginFailed();
                } 

              },
            ),
          ],
        ),
      ),
    );
  }
}
