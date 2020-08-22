import 'package:firebase_learning/model/brew.dart';
import 'package:firebase_learning/screen/home/brew_list.dart';
import 'package:firebase_learning/screen/home/setting_form.dart';
import 'package:firebase_learning/services/auth.dart';
import 'package:firebase_learning/services/database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {

  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {

    void showSettingPanel(){
      showModalBottomSheet(context: context, builder: (context){
        return Container(
          padding: EdgeInsets.symmetric(vertical: 20.0,horizontal: 60.0),
          child: SettingForm(),
        );
      });
    }

    return StreamProvider<List<Brew>>.value(
      value: DatabaseService().brews,
      child: Scaffold(
        backgroundColor: Colors.brown[50],
        appBar: AppBar(
          title: Text("Brew Crew"),
          backgroundColor: Colors.brown[400],
          elevation: 0.0,
          actions: <Widget>[
            FlatButton.icon(
                onPressed: () async {
                  await _auth.sigOut();
                },
                icon: Icon(Icons.person),
                label: Text("Logout"),
            ),
            FlatButton.icon(
              icon: Icon(Icons.settings),
              label: Text("settings"),
              onPressed: () => showSettingPanel(),
            ),
          ],
        ),
        body: BrewList(),
      ),
    );
  }
}
