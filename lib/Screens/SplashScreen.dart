

import 'package:cap/Screens/IntroScreen.dart';
import 'package:cap/Screens/login_screen.dart';
import 'package:cap/Screens/WelcomeScreen.dart';
import 'package:cap/config/responsive.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _SplashScreen();

}

class _SplashScreen extends State<SplashScreen>{
  late SharedPreferences prefs;

  @override
  void initState(){
    initShare();
    if (prefs.getBool("welcomeChecked") == true){
      if(prefs.getBool("loginChecked") == true){
        Future.delayed(Duration(milliseconds: 1500),
                () {
              Navigator.pushAndRemoveUntil(context,
                  PageRouteBuilder(
                    transitionDuration: Duration(seconds:2),
                    transitionsBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) => FadeTransition(opacity: animation,child: child),
                    pageBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) => LogInScreen(),
                  ), (route) =>false);
            });
      } else {
        Future.delayed(Duration(milliseconds: 1500),
                () {
              Navigator.pushAndRemoveUntil(context,
                  PageRouteBuilder(
                    transitionDuration: Duration(seconds: 2),
                    transitionsBuilder: (BuildContext context,
                        Animation<double> animation,
                        Animation<double> secondaryAnimation, Widget child) =>
                        FadeTransition(opacity: animation, child: child),
                    pageBuilder: (BuildContext context,
                        Animation<double> animation,
                        Animation<double> secondaryAnimation) => IntroScreen(),
                  ), (route) => false);
            });
      }
    }else {
      Future.delayed(Duration(milliseconds: 1500),
              () {
            Navigator.pushAndRemoveUntil(context,
                PageRouteBuilder(
                  transitionDuration: Duration(seconds: 2),
                  transitionsBuilder: (BuildContext context,
                      Animation<double> animation,
                      Animation<double> secondaryAnimation, Widget child) =>
                      FadeTransition(opacity: animation, child: child),
                  pageBuilder: (BuildContext context,
                      Animation<double> animation,
                      Animation<double> secondaryAnimation) => WelcomeScreen(),
                ), (route) => false);
          });
      super.initState();
    }
  }

  initShare() async{
    prefs = await SharedPreferences.getInstance();
  }

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive.of(context);
    return Container(
      decoration: const BoxDecoration(
          gradient: RadialGradient(
            radius: .6,
            colors: [
              Color(0xFFFFFFFF),
              Color(0xFFF29C0B),
            ],
            stops: <double>[0.0,1.0],
          )),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(

          child:Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container (
                child: Image.asset(
                  'images/capLogo.png',
                  height: 300,
                ),
              ),
              SizedBox(height: 10,),
              const CircularProgressIndicator(
                backgroundColor: Colors.white,
                valueColor: AlwaysStoppedAnimation(Color(0xFFFFB35E)),
                strokeWidth: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }

}

