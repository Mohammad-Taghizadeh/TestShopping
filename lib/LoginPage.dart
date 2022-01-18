import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:test_shopping/LoginResponse.dart';
import 'package:test_shopping/StoreMainMenuPage.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var usernamecontroller = TextEditingController();
  var passwordcontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: Text(
          'Login',
          style: TextStyle(color: Colors.grey[200]),
        ),
        centerTitle: true,
      ),
      body: loginUI(),
    );
  }

  Widget loginUI() {
    return Builder(
      builder: (context) => Stack(
        children: [
          Padding(
            padding: EdgeInsets.only(left: 15.0, top: 30.0),
            child: Align(
              child: Text(
                'SignIn',
                style: TextStyle(fontSize: 65.0, color: Colors.grey[300]),
              ),
              alignment: Alignment.topLeft,
            ),
          ),
          Center(
            child: Padding(
              padding: EdgeInsets.only(left: 65, right: 65),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Material(
                    elevation: 12.0,
                    shadowColor: Colors.grey[300],
                    borderRadius: BorderRadius.all(Radius.circular(30.0)),
                    child: TextField(
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'UserName',
                          icon: Padding(
                              padding: EdgeInsets.only(left: 15.0),
                              child: Icon(
                                Icons.person,
                                color: Colors.grey[600],
                              )),
                          contentPadding:
                              EdgeInsets.fromLTRB(10.0, 18.0, 10.0, 18.0)),
                      textAlign: TextAlign.center,
                      controller: usernamecontroller,
                    ),
                  ),
                  SizedBox(
                    height: 25.0,
                  ),
                  Material(
                    elevation: 12.0,
                    shadowColor: Colors.grey[300],
                    borderRadius: BorderRadius.all(Radius.circular(30.0)),
                    child: TextField(
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'PassWord',
                          icon: Padding(
                              padding: EdgeInsets.only(left: 15.0),
                              child: Icon(
                                Icons.lock,
                                size: 20.0,
                                color: Colors.grey[600],
                              )),
                          contentPadding:
                              EdgeInsets.fromLTRB(10.0, 18.0, 10.0, 18.0)),
                      textAlign: TextAlign.center,
                      obscureText: true,
                      controller: passwordcontroller,
                    ),
                  ),
                  SizedBox(
                    height: 25.0,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 35, right: 35),
                    child: Material(
                      color: Colors.amber[700],
                      elevation: 8.0,
                      borderRadius: BorderRadius.all(Radius.circular(30.0)),
                      child: GestureDetector(
                        onTap: () {
                          print("Ammmmad");
                          SendLoginReqeust(
                              context: context,
                              username: usernamecontroller.text,
                              password: passwordcontroller.text);
                        },
                        child: Container(
                          height: 60.0,
                          child: Center(
                            child: Text(
                              'Login',
                              style: TextStyle(
                                  color: Colors.grey[200], fontSize: 20.0),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void SendLoginReqeust(
      {@required BuildContext context,
      @required String username,
      @required String password}) async {
    var url = "http://welearnacademy.ir/flutter/api/?type=login";
    var body = Map<String, dynamic>();
    body['username'] = username;
    body['password'] = password;
    Response response = await post(url, body: body);
    print(response.statusCode);
    if (response.statusCode == 200) {
      var loginjson = json.decode(utf8.decode(response.bodyBytes));
      var model = LoginResponse(loginjson['result'], loginjson['message']);
      if (model.result == 1) {
        Navigator.of(context).pushReplacement(
          PageRouteBuilder(
              transitionDuration: Duration(milliseconds: 800),
              pageBuilder: (BuildContext context, Animation<double> animation,
                  Animation<double> secondAnimation) {
                return Store();
              },
              transitionsBuilder: (BuildContext context,
                  Animation<double> animation,
                  Animation<double> secondAnimation,
                  Widget child) {
                return ScaleTransition(
                    child: child,
                    scale: Tween<double>(begin: 0, end: 1).animate(
                        CurvedAnimation(
                            parent: animation, curve: Curves.elasticOut)));
              }),
        );
      } else if (model.result == 0) {

        ShowMySnackBar(context, model.message);
      }
    }
  }

  void ShowMySnackBar(BuildContext context, String message) {
    Scaffold.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }
}
