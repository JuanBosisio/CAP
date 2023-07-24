
import 'dart:html';

import 'package:cap/Screens/GateControlScreen.dart';
import 'package:cap/managers/MQTTManager.dart';
import 'package:cap/widgets/widget_class.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AdminHomeScreen extends StatefulWidget {
  const AdminHomeScreen({Key? key}) : super(key: key);


  @override
  State<AdminHomeScreen> createState() => _AdminHomeScreenState();
}

class _AdminHomeScreenState extends State<AdminHomeScreen> {
  late MQTTManager _manager;

  @override
  void initState(){
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
     _manager = Provider.of<MQTTManager>(context);

     if (_manager.state == "Desconectado"){
       _manager.connect();
    }

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Container(
          width: 80,
          child: Image.asset("images/capLogo.png"),
        ),
        centerTitle: true,
      ),
      body: BuildContainer(_manager)
    );
  }
      Widget BuildContainer(MQTTManager manager){

      return Container(
        decoration: const BoxDecoration(
            color:Color(0xFFFFB35E),
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(50),
                topRight: Radius.circular(50)
            )
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget> [
            WidgetClass().StatusBox(manager.state),
            SizedBox(height:50,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ControlButton(),
                InformationButton(),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                AdminConfigurationButton(),
                UsersConfigurationButton(),
              ],
            ),
            SizedBox(height:100,),
            ReportButton(),
          ],
        ),
      );

  }

  Widget ControlButton(){
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        fixedSize: const Size(150,90),
        elevation: 10,
        primary: Color(0xFFF29C0B),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12)
        )
      ),
      onPressed: () {
        Navigator.push(
            context,
            MaterialPageRoute(builder: (context){
              return GateControlScreen();
            })
        );
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Icon(Icons.garage),
          Text("Control Porton",textAlign: TextAlign.center,)
        ],
      ),
    );
  }

  Widget InformationButton(){
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          fixedSize: const Size(150,90),
          elevation: 10,
          primary: Color(0xFFF29C0B),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12)
          )
      ),
      onPressed: () {
        Navigator.push(
            context,
            MaterialPageRoute(builder: (context){
              return GateControlScreen();
            })
        );
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Icon(Icons.app_registration),
          Text("Registro",textAlign: TextAlign.center,)
        ],
      ),
    );
  }

  Widget AdminConfigurationButton(){
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          fixedSize: const Size(150,90),
          elevation: 10,
          primary: Color(0xFFF29C0B),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12)
          )
      ),
      onPressed: () {
        Navigator.push(
            context,
            MaterialPageRoute(builder: (context){
              return GateControlScreen();
            })
        );
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Icon(Icons.admin_panel_settings),
          Text("Configuracion Administrador",textAlign: TextAlign.center,)
        ],
      ),
    );
  }

  Widget UsersConfigurationButton(){
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          fixedSize: const Size(150,90),
          elevation: 10,
          primary: Color(0xFFF29C0B),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12)
          )
      ),
      onPressed: () {
        Navigator.push(
            context,
            MaterialPageRoute(builder: (context){
              return GateControlScreen();
            })
        );
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Icon(Icons.supervised_user_circle),
          Text("Configuracion Usuarios",textAlign: TextAlign.center,)
        ],
      ),
    );
  }


  Widget ReportButton(){
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          fixedSize: const Size(230,60),
          elevation: 10,
          primary: Colors.cyanAccent,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50)
          )
      ),
      onPressed: () {
        Navigator.push(
            context,
            MaterialPageRoute(builder: (context){
              return const GateControlScreen();
            })
        );
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: const [
          Icon(Icons.report,color: Colors.black,),
          Text("Reportar Problema",textAlign: TextAlign.center,style: TextStyle(
            color: Colors.black
          ),)
        ],
      ),
    );
  }



}
