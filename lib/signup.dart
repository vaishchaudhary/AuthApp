import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:loginpage/main.dart';

class SignUp extends StatefulWidget {


  @override
  _SignUpState createState() => _SignUpState();


}

class _SignUpState extends State<SignUp> {

  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController1 = TextEditingController();
  TextEditingController passwordController2 = TextEditingController();
  final FirebaseAuth _auth=FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();
  String validateEmail(String value) {
    if(value.isEmpty)
      return 'Enter Username';
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value))
      return 'Enter Valid Username';
    else
      return null;
  }
  String validatepassword(String value)
  {
    if(value.isEmpty)
      return 'Enter Password';
    if(value.length<6||value.length>12)
      return 'Password must be in range:6-12';
    return null;
  }
  String validateconfirmpassword(String value)
  {
    if(value.isEmpty)
      return 'Enter Password';
    if(value.toString().compareTo(passwordController1.text)!=0)
      return 'password not matched';
    return null;
  }

  @override
  Widget build(BuildContext context) {

    return
      Scaffold(

        body: Builder(builder: (context)=>
            Padding(
                padding: EdgeInsets.all(15),
                child: ListView(
                  children: <Widget>[
                    Container(

                      alignment: Alignment.center,
                      padding: EdgeInsets.all(10),
                      child:
                      new  Image.asset(

                        'assets/logo.png',

                      ),


                    )

                    ,
                    Container(
                        alignment: Alignment.center,
                        padding: EdgeInsets.all(10),
                        child: Text(
                          'Sign Up',
                          style: TextStyle(fontSize: 20),
                        )),
                    Form(
                      key:_formKey,
                      child:
                      Column(
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.all(10),
                            child: TextFormField(

                              cursorColor: Colors.green,
                              controller: nameController,
                              decoration: InputDecoration(
                                focusedBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(color: Colors.green, width: 2.0)
                                ),
                                fillColor: Colors.green,
                                enabledBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(color: Colors.green, width: 2.0)
                                ),
                                labelText: 'User Name',
                                labelStyle: TextStyle(color: Colors.green),
                                errorBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(color: Colors.red, width: 2.0)
                                ),
                                focusedErrorBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(color: Colors.red, width: 2.0)
                                ),

                              ),

                              keyboardType: TextInputType.emailAddress,
                              validator: validateEmail,
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                            child: TextFormField(
                              cursorColor: Colors.green,
                              obscureText: true,
                              controller: passwordController1,
                              decoration: InputDecoration(
                                focusColor: Colors.green,

                                focusedBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(color: Colors.green, width: 2.0)
                                ),

                                enabledBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(color: Colors.green, width: 2.0)
                                ),
                                labelText: 'Password',
                                labelStyle: TextStyle(color: Colors.green),
                                errorBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(color: Colors.red, width: 2.0)
                                ),
                                focusedErrorBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(color: Colors.red, width: 2.0)
                                ),

                              ),
                              keyboardType: TextInputType.text,
                              validator: validatepassword,
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                            child: TextFormField(
                              cursorColor: Colors.green,
                              obscureText: true,
                              controller: passwordController2,
                              decoration: InputDecoration(
                                focusColor: Colors.green,

                                focusedBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(color: Colors.green, width: 2.0)
                                ),

                                enabledBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(color: Colors.green, width: 2.0)
                                ),
                                labelText: 'Confirm Password',
                                labelStyle: TextStyle(color: Colors.green),
                                errorBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(color: Colors.red, width: 2.0)
                                ),
                                focusedErrorBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(color: Colors.red, width: 2.0)
                                ),

                              ),
                              keyboardType: TextInputType.text,
                              validator: validateconfirmpassword,
                            ),
                          ),

                        ],
                      ),


                    ),
                    FlatButton(
                      onPressed: (){

                      },
                      textColor: Colors.green,
                      child: Text('Forgot Password'),
                    ),
                    Container(
                        height: 50,
                        padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                        child: RaisedButton(
                          textColor: Colors.white,
                          color: Colors.green,
                          child: Text('SignUp'),
                          onPressed: () async {
                            //  if(nameController.text.length==0)
                            if (_formKey.currentState.validate()){
                              print(nameController.text);
                              print(passwordController1.text);

                              try {
                                AuthResult result = await _auth
                                    .createUserWithEmailAndPassword(
                                    email: nameController.text.toString(),
                                    password: passwordController1.text.toString());
                                final FirebaseUser user = result.user;

                                assert (user != null);
                                assert (await user.getIdToken() != null);
                                print('user created');
                                Navigator.push(context,MaterialPageRoute(builder:(context)=> MyHomePage(title: 'User Created with '+nameController.text+'username',) ));
                              }
                              catch(e)
                              {
                                print('user already exists');
                                nameController.clear();
                                passwordController1.clear();
                                passwordController2.clear();
                                final snackBar = SnackBar(

                                  backgroundColor: Colors.red[400],

                                  content: Text('Username or password is incorrect',style: TextStyle(color: Colors.black),),
                                  action: SnackBarAction(
                                    label: 'Undo',
                                    textColor: Colors.green,
                                    onPressed: () {

                                    },
                                  ),
                                );
                              }
                            }


                          },
                        )),
                    Container(
                        child: Row(
                          children: <Widget>[
                            Text('Already have account?'),
                            FlatButton(
                              textColor: Colors.green,
                              child: Text(
                                'Sign in',
                                style: TextStyle(fontSize: 20),
                              ),
                              onPressed: ()  {
                                Navigator.push(context,MaterialPageRoute(builder:(context)=> MyHomePage(title: '') ));

                              },
                            )
                          ],
                          mainAxisAlignment: MainAxisAlignment.center,
                        )),
                  ],
                )),
        ) ,
        );
  }
}