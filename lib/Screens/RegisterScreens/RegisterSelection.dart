import 'package:cap/Screens/RegisterScreens/AdminRegister/admin_token_register.dart';
import 'package:cap/Screens/RegisterScreens/ClientRegister/ClientRegistration.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class RegisterSelection extends StatefulWidget {
  const RegisterSelection({Key? key}) : super(key: key);

  @override
  State<RegisterSelection> createState() => _RegisterSelectionState();
}

class _RegisterSelectionState extends State<RegisterSelection> {

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        backgroundColor: Color(0xFFFFB35E),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Lottie.asset('images/choose.json'),
              adminButtonSelector(),
              clientButtonSelector(),
            ],
          ),
        ),
      ),
    );
  }

  Widget adminButtonSelector(){
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
            fixedSize: const Size(250,75),
            elevation: 10,
            primary: Color(0xFFF29C0B),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10)
            )
        ),
        onPressed: (){
          Navigator.push(
              context,
              MaterialPageRoute(builder: (context){
                return const AdminRegister();
              })
          );
        },
        child: const Text(
          "ADMINISTRADOR",
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w500,
          ),
        ));
  }

  Widget clientButtonSelector(){
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
          fixedSize: const Size(250,75),
          elevation: 10,
          primary: Color(0xFFF29C0B),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10)
          )
        ),
        onPressed: (){
          Navigator.push(
              context,
              MaterialPageRoute(builder: (context){
                return const ClientRegister();
              })
          );
        },
        child: const Text(
          "CLIENTE",
          style: TextStyle(

          ),
        ));
  }
}
