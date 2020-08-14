import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:loginpage/signup.dart';
import 'package:loginpage/home.dart';
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.green,
      ),
      home: MyHomePage(title: ''),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);


  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState(this.title);
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final FirebaseAuth _auth=FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();
  String  _username,_password;
 String title;
  _MyHomePageState(String title)
  {
    this.title=title;
  }

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
  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
//        appBar: AppBar(
//         backgroundColor: Colors.green,
//        ),
        body:Builder(
          builder: (context)=> Padding(
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
                        'Sign in',
                        style: TextStyle(fontSize: 20),
                      )),
                  if(title.length!=0)
                  Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(10),
                    child: Text(title!=null?title:'',style: TextStyle(color: Colors.amber),),
                  ),
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
                            onSaved: (String val) {
                              _username = val;
                            },
                            keyboardType: TextInputType.emailAddress,
                            validator: validateEmail,
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                          child: TextFormField(
                            cursorColor: Colors.green,
                            obscureText: true,
                            controller: passwordController,
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
                            onSaved: (String val) {
                              _password = val;
                            },
                            keyboardType: TextInputType.text,
                            validator: validatepassword,
                          ),
                        ),
                      ],
                    ),

                  ),


                  FlatButton(
                    onPressed: (){
                      //forgot password screen
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
                          child: Text('Login'),
                          onPressed: () async {
                            //  if(nameController.text.length==0)
                            if (_formKey.currentState.validate()) {
                              print(nameController.text);
                              print(passwordController.text);
                              try {
                                AuthResult result = await _auth
                                    .signInWithEmailAndPassword(
                                    email: nameController.text.toString(),
                                    password: passwordController.text.toString());
                                final FirebaseUser user = result.user;

                                assert(user != null);
                                assert(await user.getIdToken() != null);

                                final FirebaseUser currentUser = await _auth
                                    .currentUser();
                                assert(user.uid == currentUser.uid);
                                print('signInEmail succeeded: $user');
                                Navigator.push(context,MaterialPageRoute(builder:(context)=> Home(nameController.text) ));

                              }
                              catch (e) {
                                print("user name or password is incorrect");
                                setState(() {
                                  nameController.clear();
                                  passwordController.clear();
                                  _password=null;
                                  _username=null;
                                });
                                _password=null;
                                _username=null;
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

                                // Find the Scaffold in the widget tree and use
                                // it to show a SnackBar.
                                Scaffold.of(context).showSnackBar(snackBar);
                              }
                            }

                          }

                      )),
                  Container(
                      child: Row(
                        children: <Widget>[
                          Text('Does not have account?'),
                          FlatButton(
                            textColor: Colors.green,
                            child: Text(
                              'Sign Up',
                              style: TextStyle(fontSize: 20),
                            ),
                            onPressed: ()  {
                              Navigator.push(context,MaterialPageRoute(builder:(context)=> SignUp() ));
                            },
                          )
                        ],
                        mainAxisAlignment: MainAxisAlignment.center,
                      )),

                ],
              )),
        ),
        );
  }
}



