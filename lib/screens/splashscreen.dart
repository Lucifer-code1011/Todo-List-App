import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/home.dart';
import 'package:lottie/lottie.dart';
import 'package:page_transition/page_transition.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
        duration: 3000,
        splash: Lottie.asset(
          'assets/images/astronaut.json',
        ),
        splashIconSize: 150,
        nextScreen: const Home(),
        splashTransition: SplashTransition.fadeTransition,
        pageTransitionType: PageTransitionType.theme,
        backgroundColor: Colors.white);
  }
}
