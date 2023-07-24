import 'package:cap/Screens/login_screen.dart';
import 'package:cap/Screens/RegisterScreens/RegisterSelection.dart';
import 'package:flutter/material.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({Key? key}) : super(key: key);

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        backgroundColor: Color(0xFFFFB35E),
        body:

        Column(
          children: [

            Container(
                      height: 450,
                      width: double.infinity,
                      alignment: Alignment.center,
                      decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius:  BorderRadius.only(
                              bottomLeft:  Radius.circular(50.0),
                              bottomRight: Radius.circular(50.0)
                          )
                      ),
                      child: Image.asset('images/capLogo.png',
                      height: 300.0,),
                    ),
            Container(child:
              Column(
                children: [
                  SizedBox(height: 40,),
                  buildRegisterButton(),
                  SizedBox(height: 40,),
                  const Text("Ya tienes una cuenta?",style: TextStyle(
                    fontWeight: FontWeight.w400,
                    color: Colors.white,
                    fontSize: 15
                  ),),
                  SizedBox(height: 20,),
                  buildTextLogin(),
                ],
              ),
            ),
          ],
        ),



      ),


    );
  }

  Widget buildRegisterButton(){
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        shape: const StadiumBorder(),
        elevation: 10,
        padding: const EdgeInsets.symmetric(
            horizontal: 80, vertical: 20),
        primary: Color(0xFFF29C0B),
      ),
      onPressed: () {
        Navigator.push(
            context,
            MaterialPageRoute(builder: (context){
              return const RegisterSelection();
            })
        );
      },
      child: const Text(
        "REGISTRARSE",
        style: TextStyle(
          fontSize: 15,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget buildTextLogin(){
    return TextButton(

      onPressed: () {
        Navigator.push(context, MaterialPageRoute(builder: (context){
          return LogInScreen();
        }));
      },
      child: const Text(
        "INICIAR SESION",
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 18,
          color: Colors.black,
          decoration: TextDecoration.underline,
          decorationThickness: 2,
        ),
      ),
    );
  }
}
