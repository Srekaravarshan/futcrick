import 'package:flutter/material.dart';
import 'package:futcrick/AuthService.dart';
import 'package:futcrick/Constants.dart';
import 'package:provider/provider.dart';


final TextEditingController _emailController = new TextEditingController();
final TextEditingController _passwordController = new TextEditingController();

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: secondaryColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          TextField(
            controller: _emailController,
            decoration: InputDecoration(
                border: OutlineInputBorder(borderSide: BorderSide(color: iconColor)),
                labelText: 'Email address'
            ),
          ),
          TextField(
            controller: _passwordController,
            decoration: InputDecoration(
              border: OutlineInputBorder(borderSide: BorderSide(color: iconColor)),
              labelText: 'Password',
            ),
          ),
          RaisedButton(onPressed: (){
            context.read<AuthService>().signUp(_emailController.text.trim(), _passwordController.text.trim());
          }, child: Text('Sign up')),
          RaisedButton(onPressed: (){
            context.read<AuthService>().signUpWithGoogle();
          }, child: Text('Sign up with google')),
        ],
      ),
    );
  }
}
