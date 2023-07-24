import 'dart:async';
import 'package:cap/Screens/RegisterScreens/AdminRegister/admin_information.dart';
import 'package:cap/managers/MQTTManager.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class AdminRegister extends StatefulWidget {
  const AdminRegister({Key? key}) : super(key: key);

  @override
  State<AdminRegister> createState() => _AdminRegisterState();
}

class _AdminRegisterState extends State<AdminRegister> {
  late MQTTManager _manager;
  bool validateEmail = false;
  late bool _tokenVisible;
  TextEditingController token = TextEditingController();
  TextEditingController email = TextEditingController();
  final  _formkey = GlobalKey<FormState>();
  late String ayuda;
  late bool statusChange;


  @override
  void initState() {
    super.initState();
    _tokenVisible = false;
    statusChange = false;
  }
  @override
  Widget build(BuildContext context) {
    _manager = Provider.of<MQTTManager>(context);

    if (_manager.state == "Desconectado") {
      _manager.connect();
    }

    ayuda = _manager.access;


    if(ayuda == 'correcto' && statusChange == false){


      Timer(const Duration(seconds: 3),(){
        _manager.disconnect();

        WidgetsBinding.instance.addPostFrameCallback((_) { Navigator.pushAndRemoveUntil(context,
            MaterialPageRoute(builder: (context){return const AdminInformationRegister();}),
                (route) => false);});
      });
    } else if (ayuda == 'incorrecto' && statusChange == false){
        setState((){
          statusChange = true;
        });
        Timer(const Duration(seconds: 1), () {
          Navigator.pop(context);
        });
        
    }

    return Scaffold(
      backgroundColor: Color(0xFFFFB35E),
      body: GestureDetector(
        onTap: (){
          FocusScope.of(context).unfocus();
        },
        child: Center(
              child: Form(
                key: _formkey,
                child: SingleChildScrollView(

                  child: IntrinsicHeight(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        changeAnimation(),
                        buildEmail(),
                        buildTokkenField(),
                        continueButton(_manager),
                      ],
                    ),
                  ),
                ),
              ),
            ),
      ),
        );
  }


  Widget buildTokkenField(){
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 0),
      child: TextFormField(
        controller: token,
        obscureText: _tokenVisible,
        decoration: InputDecoration(
          icon: const Icon(Icons.lock),
          hintText: 'ABCFDW234546GYRE',
          labelText: "Token Unico",
          suffixIcon: GestureDetector(
            onTap: (){
              setState((){
                _tokenVisible = !_tokenVisible;
              });
            },
            child: Icon(_tokenVisible ? Icons.visibility_off : Icons.visibility),
          ),
        ),
        validator: (String? value){
          if (value == null || value.isEmpty){
            return "Por favor, ingresa el token unico";
          } else if(value.length < 8){
            return "El token debe tener al menos 8 caracteres";
          }
          return null;
        },
      ),
    );
  }


  Widget continueButton(manager){
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        elevation: 10,
        padding: const EdgeInsets.symmetric(
            horizontal: 70, vertical: 20),
        primary: Color(0xFFF29C0B),
        ),
        onPressed: () {
          if(_formkey.currentState!.validate()) {
            setState((){
              if(statusChange == true){
                statusChange = false;
              }
            });
            _manager.subScribeTopicAdmin();
            manager.publishAdmin(email.text,token.text);
            FocusScope.of(context).unfocus();
            buildShowDialog(context);

          }
        } ,
        child: const Text(
          'Continuar'
        ),
    );
  }

  Widget buildEmail(){
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 0),
      child: TextFormField(
        controller: email,
        decoration: const InputDecoration(
          hintText: 'ejemplo@emial.com',
          hintStyle: TextStyle(fontSize: 15, color: Colors.white),
          icon: Icon(Icons.email),
          labelText: 'Correo electronico',
        ),
        validator: (String? value) {
          if (value == null || value.isEmpty) {
            return 'Por favor, ingresa el correo electronico';
          }else if (!RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(value)) {
            return 'Ingresa un correo electronico valido';
          } else {
            return null;
          }
        },
      ),
    );
  }

  buildShowDialog(BuildContext context) {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        });
  }

  Widget changeAnimation(){
    if (ayuda == "correcto"){
      return Lottie.asset ('images/correct.json',width: 200);
    } else if (ayuda == "incorrecto"){
      return Lottie.asset("images/bouncy-fail.json",width: 200);
    } else{
      return Lottie.asset('images/waiting.json',width: 200);
    }
  }

}
