

import 'package:cap/config/responsive.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';


import '../models/WelcomePage1.dart';
import '../models/WelcomePage2.dart';
import '../models/WelcomePage3.dart';
import 'IntroScreen.dart';


class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  final PageController _controller = PageController();
  bool isChecked = false;
  bool onLastPage = false;
  late SharedPreferences prefs;

  @override
  void initState() {
    super.initState();

    initShared();
  }

  initShared() async{
    prefs = await SharedPreferences.getInstance();
  }
  
  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive.of(context);
    return Scaffold(
      backgroundColor: Color(0xFFFFB35E),
      body: Stack(
          children: [
            PageView(
              controller: _controller,

              onPageChanged: (index){
                setState((){
                  onLastPage = (index == 2);
                });
              },
              children: [
                WelcomePage1(),
                WelcomePage2(),
                WelcomePage3(),
              ],
            ),
            Container(
              alignment: const Alignment(0,0.65),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: () {
                      _controller.jumpToPage(2);
                    },
                    child: Text('saltar',
                      style: TextStyle(
                        fontSize: responsive.dp(1.8),
                      ),
                    ),
                  ),

                  SmoothPageIndicator(controller:_controller,
                      count: 3,
                      effect: const SlideEffect(
                        dotColor: Colors.white,
                        activeDotColor: Color(0xFFF29C0B),
                      ),
                  ),

                  onLastPage
                    ? GestureDetector(
                        onTap: () {
                          prefs.setBool('welcomeChecker', isChecked);
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context){
                                return IntroScreen();
                              }));
                        },
                        child: Text('terminar',
                          style: TextStyle(
                            fontSize: responsive.dp(1.8),
                          ),),
                      )
                      : GestureDetector(
                        onTap: () {
                        _controller.nextPage(
                            duration: Duration(milliseconds: 500),
                            curve: Curves.easeIn);
                        },

                        child: Text('siguiente',
                          style: TextStyle(
                            fontSize: responsive.dp(1.8),
                          ),),
                  ),
                ],
              )

            ),
            buildNoShowAgain(),
          ],
        ),
    );
  }

  Widget buildNoShowAgain(){
    return Container(
      alignment: Alignment(0,0.85),
      child: Row(

        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Checkbox(
            value: isChecked,
            onChanged: (value){
              isChecked = !isChecked;
              setState(() {
              });
            },
          ),
          Text("No volver a mostrar",style: TextStyle(color: Colors.white),),
        ],
      ),
    );
  }

}


