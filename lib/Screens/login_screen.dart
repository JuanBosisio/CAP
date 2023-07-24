
import 'package:bordered_text/bordered_text.dart';
import 'package:cap/Screens/AdminHomeScreen.dart';
import 'package:flutter/material.dart';

class LogInScreen extends StatefulWidget {
  const LogInScreen({Key? key}) : super(key: key);

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  bool isChecked = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black), onPressed: () { return Navigator.pop(context); },
        ),
      ),
      backgroundColor: const Color(0xFFFFB35E),
      body:
      GestureDetector(
        onTap: (){
          FocusScope.of(context).unfocus();
        },
      child: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              BorderedText(
                strokeWidth: 6.0,
                strokeColor: Colors.black,
                child: const Text(
                  'INICIO SESION',
                  style: TextStyle(
                    color: Color(0xFFF29C0B),
                    fontWeight: FontWeight.bold,
                    fontSize: 45,
                  ),
                ),
              ),
              const SizedBox(height: 100,),
              buildEmail(),
              const SizedBox(height: 20,),
              buildPassword(),
              const SizedBox(height: 25,),
              buildRememberMe(),
              const SizedBox(height: 40,),
              buildLogInButton(),
              const SizedBox(height: 20,),

            ],
          )
        ),
      )
      ),
    );
  }



  Widget buildPassword(){
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 0),
      child: TextFormField(
        obscureText: true,
        decoration: const InputDecoration(
          hintText: 'Contraseña',
          hintStyle:
          TextStyle(fontSize: 15, color: Colors.white),
          icon: Icon(Icons.lock),
          labelText: 'Contraseña',
        ),
        validator: (String? value) {
          if (value == null ||
              value.isEmpty) {
            return 'Por favor, ingresa una contrasenia valida';
          }
          return null;
        },
      ),
    );
  }

  Widget buildRememberMe(){
    return Row(
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
        const Text("Recordar sesion",style: TextStyle(color: Colors.white),),
      ],
    );
  }

  Widget buildLogInButton(){
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        elevation: 10,
        padding: const EdgeInsets.symmetric(
            horizontal: 70, vertical: 20),
        primary: Colors.white,
      ),
      onPressed: () {
        Navigator.pushAndRemoveUntil(context,
            MaterialPageRoute(builder: (context){return const AdminHomeScreen();}),
                (route) => false);
      },
      child: const Text(
        "INICIAR SESION",
        style: TextStyle(
          fontSize: 15,
          color: Color(0xFFF29C0B),
        ),
      ),
    );
  }

  Widget buildEmail(){
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 0),
      child: TextFormField(
        decoration: const InputDecoration(
          hintText: 'ejemplo@emial.com',
          hintStyle: TextStyle(fontSize: 15, color: Colors.white),
          icon: Icon(Icons.email),
          labelText: 'Correo electronico',
        ),
        validator: (String? value) {
          if (value == null || value.isEmpty) {
            return 'Por favor, ingresa un correo electronico';
          }
          if (!RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(value)) {
            return 'Por favor, ingresa un correo electronico valido';
          }
          return null;
        },
      ),
    );
  }
}
