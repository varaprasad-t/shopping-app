import 'package:flutter/material.dart';
import 'package:shopping_app/pages/home.dart';
import 'package:shopping_app/widgets/shopping_app_frontscreen.dart';
import 'package:lottie/lottie.dart';

class Splash extends StatefulWidget {
  Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  bool isExpanded = false;
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: 300), () {
      setState(() {
        isExpanded = true;
      });
    });

    // Navigate to Home after 2.5 seconds
    Future.delayed(Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => ShoppingApp()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isExpanded
          ? Center(child: Lottie.asset('assets/animations/Chocolate.json'))
          : Text(''),
    );
  }
}
