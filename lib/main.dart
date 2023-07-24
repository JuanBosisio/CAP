import 'package:cap/Screens/AdminHomeScreen.dart';
import 'package:cap/Screens/GateControlScreen.dart';
import 'package:cap/Screens/IntroScreen.dart';
import 'package:cap/Screens/login_screen.dart';
import 'package:cap/Screens/RegisterScreens/AdminRegister/admin_token_register.dart';
import 'package:cap/Screens/RegisterScreens/RegisterSelection.dart';
import 'package:cap/Screens/WelcomeScreen.dart';
import 'package:cap/config/notification_config.dart';
import 'package:cap/managers/MQTTManager.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'Screens/SplashScreen.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyApp createState() => _MyApp();
}


class _MyApp extends State<MyApp>{ // This widget is the root of your application.

  @override
  void initState(){
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    NotificationApi.init();
    listenNotifications();
  }

  void listenNotifications() =>
      NotificationApi.onNotifications.stream.listen(onClickedNotification);

  void onClickedNotification (String? payload) =>
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => GateControlScreen()));

  @override
  Widget build(BuildContext context) {



    return ChangeNotifierProvider<MQTTManager>(

      create: (context) => MQTTManager(),
      child: MaterialApp(

        title: 'Flutter Demo',
        theme: ThemeData(
          textTheme: GoogleFonts.openSansTextTheme(Theme.of(context).textTheme),
          primarySwatch: Colors.blue,
        ),
        initialRoute: "splash",
        routes:{
          "splash" : (_) => SplashScreen(),
          "welocome": (_) => WelcomeScreen(),
          "intro": (_) => IntroScreen(),
          "login": (_) => LogInScreen(),
          "register": (_) =>RegisterSelection(),
          "admin_register": (_) => AdminRegister(),
          "admin_screen": (_) => AdminHomeScreen(),
        },
      ),
    );
  }

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    throw UnimplementedError();
  }


}
