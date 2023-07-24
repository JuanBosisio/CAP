import 'dart:async';

import 'package:cap/Screens/AdminHomeScreen.dart';
import 'package:cap/config/responsive.dart';
import 'package:cap/managers/firebase.dart';
import 'package:flutter/material.dart';

class AdminInformationRegister extends StatefulWidget {
  const AdminInformationRegister({Key? key}) : super(key: key);

  @override
  State<AdminInformationRegister> createState() => _AdminInformationRegisterState();
}

class _AdminInformationRegisterState extends State<AdminInformationRegister> {


  TextEditingController name = TextEditingController();
  TextEditingController lastname = TextEditingController();
  TextEditingController streetNum = TextEditingController();
  TextEditingController street = TextEditingController();
  TextEditingController countryPlace = TextEditingController();
  TextEditingController city = TextEditingController();
  TextEditingController state = TextEditingController();
  String dropdownValue = 'Tipo de establecimiento';
  final _formkey = GlobalKey<FormState>();
  bool streetBool = false;
  bool streetNumber = false;
  bool countryName = false;
  final Database firebase = Database();

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive.of(context);

    return Scaffold(
      backgroundColor: Color(0xFFFFB35E),
      body: SafeArea(
        child: GestureDetector(
          onTap: (){
            FocusScope.of(context).unfocus();
          },
          child: Center(

              child: SingleChildScrollView(
                child: IntrinsicHeight(
                  child: Form(
                    key: _formkey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      buildName(responsive),
                      SizedBox(height: responsive.hp(5),),
                      buildLastName(responsive),
                      SizedBox(height: responsive.hp(5),),
                      buildTypePlaceField(responsive),
                      SizedBox(height: responsive.hp(5),),
                      buildCity(responsive),
                      SizedBox(height: responsive.hp(5),),
                      buildState(responsive),
                      SizedBox(height: responsive.hp(5),),
                      buildNameField(responsive),
                      SizedBox(height: responsive.hp(5),),
                      buildPlaceStreet(responsive),
                      SizedBox(height: responsive.hp(5),),
                      buildPlaceNumberStreet(responsive),
                      SizedBox(height: responsive.hp(5),),
                      continueButton(responsive),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildTypePlaceField(Responsive responsive){
    return SizedBox(
      width: responsive.wp(70),
      height: responsive.hp(7),
      child: Theme(
        data: Theme.of(context).copyWith(
          canvasColor: Colors.amber.shade200,
        ),


        child: DropdownButton<String>(
          isExpanded: true,
          value: dropdownValue,
          icon: const Icon(Icons.arrow_downward),
          elevation: 10,
          style: const TextStyle(
            color: Colors.white
          ),
          underline: Container(
            height: 2,
            color: Colors.white,
          ),
          onChanged: (String? newValue){
            if(newValue == 'Country' || newValue == 'Local' || newValue == 'Industria'){
                setState((){
                  countryName = true;
                  streetBool = true;
                  streetNumber = true;
                  dropdownValue = newValue!;
                });
                }
            else if(newValue == 'Tipo de establecimiento'){
              setState((){
                countryName = false;
                streetBool = false;
                streetNumber = false;
                dropdownValue = newValue!;
              });
            }
            else{
                setState((){
                  countryName = false;
                  streetNumber = true;
                  streetBool = true;
                  dropdownValue = newValue!;
                });
            }
          },
          items: <String>[
            'Tipo de establecimiento',
            'Country',
            'Local',
            'Oficina',
            'Casa',
            'Departamento',
            'Industria'
          ].map<DropdownMenuItem<String>>((String value){
            return DropdownMenuItem<String>(
                value: value,
                child: Text(value,
                  style: TextStyle(
                  fontSize: responsive.dp(2),
                  ),)
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget buildPlaceStreet(Responsive responsive){
    return Container(
      padding: EdgeInsets.symmetric(horizontal: responsive.wp(10), vertical: 0),
      child: TextFormField(
        enabled: streetBool,
        controller: street,
        decoration: InputDecoration(
          hintText: '48',
          hintStyle: TextStyle(fontSize: responsive.dp(2), color: Colors.white),
          icon: Icon(Icons.place),
          labelText: 'Calle',
        ),
        validator: (String? value) {
          if (value == null || value.isEmpty) {
            return 'Por favor, ingresa una calle';
          } else {
            return null;
          }
        },
      ),
    );
  }

  Widget buildState(Responsive responsive){
    return Container(
      padding: EdgeInsets.symmetric(horizontal: responsive.wp(10), vertical: 0),
      child: TextFormField(
        controller: state,
        decoration:  InputDecoration(
          hintText: 'Buenos Aires',
          hintStyle: TextStyle(fontSize: responsive.dp(2), color: Colors.white),
          icon: Icon(Icons.location_city),
          labelText: 'Provincia',
        ),
        validator: (String? value) {
          if (value == null || value.isEmpty) {
            return 'Por favor, ingresa una provincia';
          } else {
            return null;
          }
        },
      ),
    );
  }

  Widget buildPlaceNumberStreet(Responsive responsive){
    return Container(
      padding: EdgeInsets.symmetric(horizontal: responsive.wp(10), vertical: 0),
      child: TextFormField(
        enabled: streetNumber,
        controller: streetNum,
        decoration: InputDecoration(
          hintText: '1623',
          hintStyle: TextStyle(fontSize: responsive.dp(2), color: Colors.white),
          icon: Icon(Icons.place),
          labelText: 'Numero',
        ),
        validator: (String? value) {
          if (value == null || value.isEmpty) {
            return 'Por favor, ingresa una zona';
          } else {
            return null;
          }
        },
      ),
    );
  }

  Widget buildCity(Responsive responsive){
    return Container(
      padding: EdgeInsets.symmetric(horizontal: responsive.wp(10), vertical: 0),
      child: TextFormField(
        controller: city,
        decoration: InputDecoration(
          hintText: 'La Plata',
          hintStyle: TextStyle(fontSize: responsive.dp(2), color: Colors.white),
          icon: Icon(Icons.location_city),
          labelText: 'Localidad',
        ),
        validator: (String? value) {
          if (value == null || value.isEmpty) {
            return 'Por favor, ingresa una localidad';
          } else {
            return null;
          }
        },
      ),
    );
  }

  Widget buildNameField(Responsive responsive){
    return Container(
      padding: EdgeInsets.symmetric(horizontal: responsive.wp(10), vertical: 0),
      child: TextFormField(
        enabled: countryName,
        controller: countryPlace,
        decoration: InputDecoration(
          hintText: 'Tortugas Country Club',
          hintStyle: TextStyle(fontSize: responsive.dp(2), color: Colors.white),
          icon: Icon(Icons.place),
          labelText: 'Nombre de establecimiento',
        ),
        validator: (String? value) {
          if (value == null || value.isEmpty) {
            return 'Por favor, ingresa una zona';
          } else {
            return null;
          }
        },
      ),
    );
  }

  Widget buildName(Responsive responsive){
    return Container(
      padding: EdgeInsets.symmetric(horizontal: responsive.wp(10), vertical: responsive.hp(2)),
      child: TextFormField(
        controller: name,
        decoration: InputDecoration(
          hintText: 'Pablo',
          hintStyle: TextStyle(fontSize: responsive.dp(2), color: Colors.white),
          icon: Icon(Icons.person),
          labelText: 'Tu nombre',
        ),
        validator: (String? value) {
          if (value == null || value.isEmpty) {
            return 'Por favor, ingresa tu nombre';
          } else {
            return null;
          }
        },
      ),
    );
  }

  Widget buildLastName(Responsive responsive){
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 0),
      child: TextFormField(
        controller: lastname,
        decoration: InputDecoration(
          hintText: 'Gomez',
          hintStyle: TextStyle(fontSize: responsive.dp(2), color: Colors.white),
          icon: Icon(Icons.person),
          labelText: 'Tu apellido',
        ),
        validator: (String? value) {
          if (value == null || value.isEmpty) {
            return 'Por favor, ingresa tu apellido';
          } else {
            return null;
          }
        },
      ),
    );
  }

  Widget continueButton(Responsive responsive){
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        elevation: 10,
        padding: const EdgeInsets.symmetric(
            horizontal: 70, vertical: 20),
        primary: Color(0xFFF29C0B),
      ),
      onPressed: () {
        if(_formkey.currentState!.validate()) {
          FocusScope.of(context).unfocus();

          buildShowDialog(context);


          if(dropdownValue == 'Country' || dropdownValue == 'Local' || dropdownValue == 'Industria'){
            Timer(const Duration(seconds: 4),(){
              firebase.initializeAdmin();
            });
            firebase.addAdminPlaceWithName(city.text,state.text, streetNum.text, street.text, dropdownValue, countryPlace.text);

            Timer(const Duration(seconds: 2),(){
              Navigator.pushAndRemoveUntil(context,
                  MaterialPageRoute(builder: (context){return const AdminHomeScreen();}),
                      (route) => false);
            });
          } else if(dropdownValue == 'Tipo de establecimiento'){
            print('Por favor, selecciona un tipo de establecimiento.');
          } else {
            ;
            firebase.addAdminPlace(city.text,state.text, streetNum.text, street.text, dropdownValue);

            Timer(const Duration(seconds: 3),(){
              Navigator.pushAndRemoveUntil(context,
                  MaterialPageRoute(builder: (context){return const AdminHomeScreen();}),
                      (route) => false);
            });
          }

        }
      } ,
      child: const Text(
          'Continuar'
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

}
