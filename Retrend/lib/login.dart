import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  Firestore db = Firestore.instance;
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  Future<bool> isLoggedIn;
  @override
  void initState() {
    super.initState();
  }

  Future<bool> _login() async{
    bool isLoggedIn = false;
    await db.collection("Users").getDocuments().then((document){
      //Loop over all the documents returned
      document.documents.forEach((store) {

        if(store["username"] == _usernameController.text.trim() && store["password"] == _passwordController.text.trim()){
          isLoggedIn = true;
        }
      });

      });

      return isLoggedIn;
      }


  void login() async{
    setState(() {
      isLoggedIn = _login();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:FutureBuilder(
        future: isLoggedIn,
        builder: (BuildContext context, AsyncSnapshot<bool> snapshot){
          if(snapshot.hasData){
            if(snapshot.data)
              Navigator.pop(context);
          }
          bool hasError = false;
          if(snapshot.hasData)
            hasError = snapshot.data? false: true;
          if(!hasError){
            return  SafeArea(
              child: ListView(
                padding: EdgeInsets.symmetric(horizontal: 24.0),
                children: <Widget>[
                  SizedBox(height: 80.0),
                  Column(
                    children: <Widget>[
                      Image.asset('assets/diamond.png'),
                      SizedBox(height: 16.0),
                      Text('ReTrend'),
                    ],
                  ),
                  SizedBox(height: 120.0),
                  TextField(
                    controller: _usernameController,
                    decoration: InputDecoration(
                      filled: true,
                      labelText: 'Username',
                    ),
                  ),
                  SizedBox(height: 12.0),
                  TextField(
                    controller: _passwordController,
                    decoration: InputDecoration(
                      filled: true,
                      labelText: 'Password',
                    ),
                    obscureText: true,
                  ),
                  ButtonBar(
                    children: <Widget>[
                      FlatButton(
                        child: Text('CANCEL'),
                        onPressed: () {
                          _usernameController.clear();
                          _passwordController.clear();
                        },
                      ),
                      RaisedButton(
                        child: Text('LOG IN'),
                        onPressed: () {
                          login();
                        },
                      ),
                    ],
                  ),
                ],
              ),
            );
          }else{
            return  SafeArea(
              child: ListView(
                padding: EdgeInsets.symmetric(horizontal: 24.0),
                children: <Widget>[
                  SizedBox(height: 80.0),
                  Column(
                    children: <Widget>[
                      Image.asset('assets/diamond.png'),
                      SizedBox(height: 16.0),
                      Text('ReTrend'),
                    ],
                  ),
                  SizedBox(height: 120.0),
                  Text("Incorrect Login Details", style: TextStyle(color: Colors.red),),
                  SizedBox(height: 10.0),
                  TextField(
                    controller: _usernameController,
                    decoration: InputDecoration(
                      filled: true,
                      labelText: 'Username',
                    ),
                  ),
                  SizedBox(height: 12.0),
                  TextField(
                    controller: _passwordController,
                    decoration: InputDecoration(
                      filled: true,
                      labelText: 'Password',
                    ),
                    obscureText: true,
                  ),
                  ButtonBar(
                    children: <Widget>[
                      FlatButton(
                        child: Text('CANCEL'),
                        onPressed: () {
                          _usernameController.clear();
                          _passwordController.clear();
                        },
                      ),
                      RaisedButton(
                        child: Text('LOG IN'),
                        onPressed: () {
                          login();
                        },
                      ),
                    ],
                  ),
                ],
              ),
            );
          }
        },
      )

    );
  }
}