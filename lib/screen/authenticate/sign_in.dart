import 'package:firebase_learning/services/auth.dart';
import 'package:firebase_learning/shared/constants.dart';
import 'package:firebase_learning/shared/loading.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {

  final Function toggleView;

  SignIn({this.toggleView});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  final AuthService _auth = AuthService();
  final _formkey = GlobalKey<FormState>();
  bool loading = false;

  String email = '';
  String password = '';
  String error = '';


  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        backgroundColor: Colors.brown[400],
        elevation: 0.0,
        title: Text("Sigin to Brew Crew"),

        actions: <Widget>[
          FlatButton.icon(
            icon: Icon(Icons.person),
            label: Text("Registered"),
            onPressed: (){
              widget.toggleView();
            },
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0,horizontal: 50.0),
        child: Form(
          key: _formkey,
          child: Column(
            children: <Widget>[
              SizedBox(height: 20.0,),
              TextFormField(
                decoration: textInputDecoration.copyWith(hintText: "Email"),
                validator: (val) => val.isEmpty ? "Please enter email": null,
                onChanged: (val){
                  setState(() {
                    email = val;
                  });
                },
              ),

              SizedBox(height: 20.0,),
              TextFormField(
                decoration: textInputDecoration.copyWith(hintText: "Password"),
                validator: (val) => val.length < 6 ? "Password must be greater then 6 letter": null,
                onChanged: (val){
                  setState(() {
                    password = val;
                  });
                },
                obscureText: true,
              ),
              SizedBox(height: 20.0,),
              RaisedButton(
                  color: Colors.pink[400],
                  child: Text(
                    'Sign In',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () async {
                    if(_formkey.currentState.validate()){
                      setState(() {
                        loading = true;
                      });
                      dynamic result = await _auth.sigInWitEmailAndPassword(email, password);
                      if(result == null) {
                        setState(() {
                          error = 'Could not sign in with those credentials';
                          loading = false;
                        });
                      }
                    }
                  }
              ),
                SizedBox(height: 12.0,),
                Text(error,
                style: TextStyle(
                fontSize: 14.0,
                color: Colors.red,
                ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
