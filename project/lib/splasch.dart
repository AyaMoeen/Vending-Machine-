import 'package:flutter/material.dart';
import 'package:another_flutter_splash_screen/another_flutter_splash_screen.dart';
import 'package:project/login.dart';
import 'home_page.dart';

class MySplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FlutterSplashScreen.fadeIn(
        backgroundColor: Color.fromARGB(255, 202, 92, 18),
        onInit: () {
          debugPrint("On Init");
        },
        onEnd: () {
          debugPrint("On End");
        },
        childWidget: SizedBox(
          height: 400,
          width: 400,
          child: Image.asset("images/icon/splashaa.png"),
        ),
        onAnimationEnd: () => debugPrint("On Fade In End"),
        nextScreen: LoginScreen(),
      ),
    );
  }
}
