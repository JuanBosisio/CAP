
import 'package:cap/managers/MQTTManager.dart';
import 'package:cap/widgets/widget_class.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:rive/rive.dart';

class GateControlScreen extends StatefulWidget {
  const GateControlScreen({Key? key}) : super(key: key);

  @override
  State<GateControlScreen> createState() => _GateControlScreenState();
}

class _GateControlScreenState extends State<GateControlScreen> {
  late MQTTManager _manager;
  bool securitySelector = false;
  bool muteSelector = false;
  int currentIndex = 0;

  SMIInput<bool>? openCloseInput;
  Artboard? _openCloseArtboard;

  void openCloseAnimation(){
    if(openCloseInput?.value == false &&
        openCloseInput?.controller.isActive == false &&
        (_manager.state == 'Abriendo porton' || _manager.state == 'Porton abierto')){
      openCloseInput?.value = true;
    } else if (openCloseInput?.value == true &&
      openCloseInput?.controller.isActive == false &&
        (_manager.state == 'Cerrando porton' ||
            _manager.state == "Porton cerrado" ||
            _manager.state == "Cierre de seguridad")){
      openCloseInput?.value = false;
    }
  }

  @override
  void initState() {
    super.initState();
    rootBundle.load('images/gate_control.riv').then((data) {
      final file = RiveFile.import(data);
      final artboard = file.mainArtboard;
      var controller = StateMachineController.fromArtboard(
          artboard,
          'Abrir/Cerrar'
      );
      if(controller != null){
        artboard.addController(controller);
        openCloseInput = controller.findInput('abrir');
      }
      setState(
          () => _openCloseArtboard = artboard,
      );
    });
  }


  @override
  Widget build(BuildContext context) {
    _manager = Provider.of<MQTTManager>(context);

    if(_manager.state == "Abriendo porton" ||
        _manager.state == "Cerrando porton" ||
        _manager.state == "Cierre de seguridad" ||
        _manager.state == "Porton abierto" ||
        _manager.state == "Porton cerrado"){
      openCloseAnimation();
    }

    return Container(
      child: Scaffold(
        backgroundColor: Color(0xFFFFB35E),
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.black), onPressed: () { return Navigator.pop(context); },
          ),
        ),
        body: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  CloseSecurity(),
                  WidgetClass().StatusBox(_manager.state),
                  MuteButton(),
                ],
              ),
              _openCloseArtboard == null ? SizedBox():
              SizedBox(
                height: 300,
                width: 350,
                child: Rive(artboard: _openCloseArtboard!,
                            fit: BoxFit.fitWidth,),
              ),
              Container(
                height: 100,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    OpenButton(_manager),
                    CloseButton(_manager),
                    StopButton(_manager),
                  ],
                ),
              )
            ],
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: const Color(0xFFF29C0B),
          unselectedItemColor: Colors.white,
          selectedItemColor: Colors.black,
          currentIndex: currentIndex,
          onTap: (index) => setState(() => currentIndex = index),
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.home,color:Colors.white),
              label: "Home"

            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.garage,color:Colors.white),
                label: "Porton"
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.admin_panel_settings,color:Colors.white),
              label: "Admin"

            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.supervised_user_circle,color:Colors.white),
              label: "Userario"
            ),
          ],

        ),
      ),
    );
  }




  Widget OpenButton(MQTTManager manager){
    return Column(
      children: [
        ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: const Color(0xFFF29C0B),
              onPrimary: Colors.green,
              fixedSize: const Size(30,60),
              elevation: 10,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(100)
              )
            ),
            onPressed: (){
              if(manager.state == "Desconectado"){
                manager.connect();
              } else {
                if(securitySelector == true){
                  manager.publish("abrirs");
                } else {
                  manager.publish("abrir");
                }
              }
            },
            child: const Icon(Icons.lock_open,color:Colors.white)),
        const Text("Abrir",)
      ],
    );
  }

  Widget CloseButton(MQTTManager manager){
    return Column(
      children: [
        ElevatedButton(
            style: ElevatedButton.styleFrom(
                primary: const Color(0xFFF29C0B),
                onPrimary: Colors.redAccent,
                fixedSize: const Size(30,60),
                elevation: 10,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100)
                )
            ),
            onPressed: (){
              if(manager.state == "Desconectado") {
                manager.connect();
              }
              manager.publish("cerrar");
            },
            child: const Icon(Icons.lock,color:Colors.white)),
        const Text("Cerrar",)
      ],
    );
  }

  Widget StopButton(MQTTManager manager){
    return Column(
      children: [
        ElevatedButton(
            style: ElevatedButton.styleFrom(
                primary: const Color(0xFFF29C0B),
                onPrimary: Colors.red,
                fixedSize: const Size(30,60),
                elevation: 10,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100)
                ),

            ),
            onPressed: (){
              manager.publish("parar");
            },
            child: const Icon(Icons.stop_circle,color:Colors.white,)),
        const Text("Parar",)
      ],
    );
  }

  Widget MuteButton(){
    return
        ChoiceChip(
          padding: const EdgeInsets.fromLTRB(5, 11, 5, 11),
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          elevation: 10,
          label: const Icon(
            Icons.volume_mute),
          selected: muteSelector,
          onSelected: (newBoolValue){
            setState((){
              muteSelector = newBoolValue;
            });
          },
          selectedColor: Colors.redAccent,
          backgroundColor: Colors.white,

    );
  }

  Widget CloseSecurity(){
    return ChoiceChip(
      padding: const EdgeInsets.fromLTRB(5, 11, 5, 11),
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      elevation: 10,
      label: Icon(
          Icons.security),
          selected: securitySelector,
          onSelected: (newBoolValue){
            setState((){
              securitySelector = newBoolValue;
            });
          },
      selectedColor: Colors.cyanAccent,
      backgroundColor: Colors.white,
    );
  }

}
