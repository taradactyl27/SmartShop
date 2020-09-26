import 'package:flutter/material.dart';
import '../Animation/FadeAnimation.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

final storage = FlutterSecureStorage();
const SERVER_IP = 'http://10.0.2.2:5000';
class Landing extends StatefulWidget {
  @override
  _LandingState createState() => _LandingState();
}
class _LandingState extends State<Landing>{
  final TextEditingController _usercontroller = TextEditingController();
  final TextEditingController _passwordcontroller = TextEditingController();
  
  void displayDialog(context, title, text) => showDialog(
      context: context,
      builder: (context) =>
        AlertDialog(
          title: Text(title),
          content: Text(text)
        ),
    );

  Future<int> register(String email, String password) async{
    var res = await http.post(
      "$SERVER_IP/api/users/register",
      body: {
        "email": email,
        "password": password
      }
    );
    print(res.body.toString());
    return res.statusCode;
  }

  Future<String> login(String email, String password) async{
    var res = await http.post(
      "$SERVER_IP/api/users/login",
      body:{
        "email": email,
        "password": password
      }
    );
    return res.body;
  }
  String email, pass;

   @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      //backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height * 0.55,
            child: Stack(
              children: <Widget>[
                Positioned(
                    child: FadeAnimation(
                  1,
                  ClipPath(
                      clipper: WaveClipperTwo(),
                      child: Container(
                        height: 350.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(25.0),
                            bottomRight: Radius.circular(25.0)),
                          gradient: LinearGradient(
                          colors: [
                            //Color(0xFF80F9B7),
                            //Color(0xFF9ABDEB),
                            Color(0x99FC7B7B),
                            Color(0x99A6C1FF),
                          ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                 ),
                ),
                  ),
                    ),
                )),
                Positioned(
                top: 60,
                left: 0,
                right: 0,
                child: Center(
                  child: Text("SmartShop",
                    style: TextStyle(
                        fontFamily: 'Raleway',
                        fontSize: 44.0,
                        fontWeight: FontWeight.w600,
                        color: Colors.white)),
              )),
              Positioned(
                width: MediaQuery.of(context).size.width,
                top: MediaQuery.of(context).size.width * 0.20,//TRY TO CHANGE THIS **0.30** value to achieve your goal 
                child: Container(
                  margin: EdgeInsets.all(16.0),
                  child:Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Image.asset('assets/SmartShopping.png', scale: 0.35),
                      ]
                  ),
                ))
              /*Container(
                  alignment: Alignment(10, 10),
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("assets/SmartShopping.png"),
                          fit: BoxFit.cover
                          )),
              ),*///Container End
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                FadeAnimation(
                  1,
                  Container(
                    padding: EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: Colors.transparent,
                    ),
                    child: Column(
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.all(10.0),
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color: Color(0xffFC7B7B),
                              ),
                            ),
                          ),
                          child: TextField(
                            controller: _usercontroller,
                            style: new TextStyle(color: Colors.black),
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Username",
                              hintStyle: TextStyle(color: Colors.grey),
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(10.0),
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color: Color(0xffFC7B7B),
                              ),
                            ),
                          ),
                          child: TextField(
                            controller: _passwordcontroller,
                            obscureText: true,
                            style: new TextStyle(color: Colors.black),
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Password",
                                hintStyle: TextStyle(color: Colors.grey)),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                FadeAnimation(
                  1,
                  InkWell(
                    onTap: () async {
                      var user = _usercontroller.text;
                      var pass = _passwordcontroller.text;
                      if (user.substring(user.length-2,user.length-1) == "\\")
                        user = user.substring(0,user.length-2);
                      var res = await login(user,pass);
                      if (res == null){
                        displayDialog(context, "Error", "Login Failed, try again!");
                      }
                      else{
                        storage.write(key:"jwt",value: res);
                        Navigator.push(
                          context,
                           MaterialPageRoute(
                            // builder: (context) => Review.fromBase64(res)
                           )
                        );
                      }
                    },
                    child: Container(
                      height: 45,
                      margin: EdgeInsets.symmetric(horizontal: 40),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Color(0xffFC7B7B),
                      ),
                      child: Center(
                        child: Text(
                          "Login",
                          style: TextStyle(
                            fontSize: 18.0, 
                            color: Colors.white),
                        ),
                      ),
                    ),//Container
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                FadeAnimation(
                  1,
                  InkWell(
                    onTap: () async {
                      print("running register");
                      var user = _usercontroller.text;
                      if (user.substring(user.length-2,user.length-1) == "\\")
                        user = user.substring(0,user.length-2);
                      var pass = _passwordcontroller.text;
                      print(user);
                      print(pass);
                      var res  = await register(user, pass);
                      print(res);
                      if (res == 200)
                        displayDialog(context, "Success", "The user was created. Log in now.");
                      else if(res == 409)
                        displayDialog(context, "That username is already registered", "Please try to sign up using another username or log in if you already have an account.");
                      else{
                        displayDialog(context, "Error", "An unknown error occurred.");
                      }
                    },
                    child: Container(
                    height: 45,
                    margin: EdgeInsets.symmetric(horizontal: 40),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Color(0xffFC7B7B),
                    ),
                    child: Center(
                      child: Text(
                        "Register",
                        style: TextStyle(
                          fontSize: 18.0,
                          color: Colors.white),
                      ),
                    ),
                  ),
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                FadeAnimation(
                  1,
                  Center(
                    child: Text(
                      "Forgot Password?",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}