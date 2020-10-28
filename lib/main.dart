import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/animation.dart';
import 'package:sdgs15/LoginAnimation.dart';
import 'package:flutter/scheduler.dart';

void main() => runApp(new MyApp()); //bagian main

class MyApp extends StatelessWidget {
    @override
    Widget build(BuildContext context) {
      return new MaterialApp(
        title: "FANA", //judul aplikasi
        debugShowCheckedModeBanner: false, //untuk menghilangkan tulisan debug
        home: new LoginPage(), //untuk mengetahui kita berada di home apa
      );
    }
}

class LoginPage extends StatefulWidget {
  const LoginPage({Key key}) : super(key: key);
  @override
  _LoginPageState createState() => new _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with TickerProviderStateMixin{
  var statusClick=0;

  TextEditingController editingControllerUser;
  TextEditingController editingControllerPass;
  AnimationController animationControllerButton;
  @override
  void initState() {
    editingControllerUser= new TextEditingController(text: '');
    editingControllerPass= new TextEditingController(text: '');
    // TODO: implement initState
    super.initState();
    animationControllerButton=AnimationController(duration: Duration(seconds: 3), vsync: this)
    ..addStatusListener((status) {
      if (status== AnimationStatus.dismissed){
        setState(() {
          statusClick=0;
    });
      }
      });

  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    animationControllerButton.dispose();
  }

  Future<Null> _playAnimation() async{
    try{
      await animationControllerButton.forward();
      await animationControllerButton.reverse();
    } on TickerCanceled{}

  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/img/login.png'), fit: BoxFit.cover
          )
        ),
        child: ListView(
          padding: const EdgeInsets.all(0.0),
          children: <Widget>[
            Stack(
              alignment: AlignmentDirectional.bottomCenter,
              children: <Widget>[
              Column(children: <Widget>[
                Padding(padding: const EdgeInsets.only(top: 400.0),),
                Container(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children: <Widget>[
                      TextField(
                        controller: editingControllerUser,
                        decoration: InputDecoration(
                        icon: Icon(Icons.person_outline, color: Colors.white,),
                        hintText: "Username"
                      ),),
                      TextField(
                        controller: editingControllerPass,
                        decoration: InputDecoration(
                        icon: Icon(Icons.lock_outline, color: Colors.white,),
                          hintText: "Password"
                      ),),
                      FlatButton(padding: const EdgeInsets.only(top: 100.0,bottom: 30.0),
                      onPressed: null,
                        child: Text("Don't have an account? Sign Up here",
                        style: TextStyle(
                        fontSize: 12.0,
                        color: Colors.black54,
                        fontWeight: FontWeight.w300,
                        letterSpacing: 0.5
                        ),),
                      )
                    ],
                  ),

                ),
              ],),
                 statusClick==0
                 ? new InkWell(
                  onTap: (){
                    setState(() {
                      statusClick=1;
                    });
                    _playAnimation();
                  },
                  child: new SignIn())
                : new StartAnimation(
                   buttonController: animationControllerButton.view,
                   user: editingControllerUser.text,
                   pass: editingControllerPass.text,
                   )
            ],)
          ],
        ),
      ),
    );
  }
}
class SignIn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Padding(
      padding: const EdgeInsets.all(60.0),
      child: new Container(
      alignment: FractionalOffset.center,
      width: 320.0,
      height: 60.0,
      decoration: BoxDecoration(
        color: Colors.green,
        borderRadius: BorderRadius.all(const Radius.circular(30.0))
      ),
      child: Text("Sign In",
      style: TextStyle(color: Colors.white,
      fontSize: 20.0,
        fontWeight: FontWeight.w300,
        letterSpacing: 0.3
      ),
      )
    ),
    );
  }
}