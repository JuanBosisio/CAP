import 'package:cap/config/responsive.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class WelcomePage3 extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive.of(context);

    return SafeArea(
      child: Center(
        child: Column(
          children: [
            SizedBox(height: responsive.hp(4),),
            Lottie.asset('images/registration.json',
                height: responsive.hp(50)),
            SizedBox(height: responsive.hp(7),),
            Text(
              "Por donde empezamos?",
              style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: responsive.dp(2.5),
              ),
            ),
            SizedBox(height: responsive.hp(2),),
            Text(
              "Pulsa DONE para registrarte",
              style: TextStyle(
                fontWeight: FontWeight.w300,
                fontSize: responsive.dp(1.8),
              ),
              textAlign: TextAlign.center,
            ),

          ],
        ),
      ),
    );
  }
}
