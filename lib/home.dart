import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:loginpage/main.dart';

class Home extends StatefulWidget {

String username;

  Home(String username)
  {
    this.username=username;
  }
  @override
  _HomeState createState() => _HomeState(this.username);

//  @override
//  Widget build(BuildContext context) {
//    // TODO: implement build
//    return null;
//  }
}

class _HomeState extends State<Home> {


    String username;
  _HomeState(String username)
  {
    this.username=username;
  }


  @override
  Widget build(BuildContext context) {

    return
      Scaffold(

        body: Builder(builder: (context)=>
            Padding(
                padding: EdgeInsets.all(15),
                child:
                Column(
                 children: <Widget>[
                   Container(

                     alignment: Alignment.center,
                     padding: EdgeInsets.all(10),
                     child:
                     new  Image.asset(

                       'assets/logo.png',

                     ),


                   ) ,
                  Center(
                     child: Text('Welcome '+username+' in the Unthinkable Family',style: TextStyle(color: Colors.green,fontSize: 20),textAlign: TextAlign.center,),
                   ),
              Padding(
                padding: EdgeInsets.fromLTRB(10,20,10,10),
              ),
              Container(
                  height: 50,
                  width: double.maxFinite,

                  child: RaisedButton(
                    textColor: Colors.white,
                    color: Colors.green,
                    child: Text('Logout'),
                    onPressed: (){
                    Navigator.pop(context);
                    }
                  )
              )
                 ],
                )
            ),
        ) ,
      );
  }
}