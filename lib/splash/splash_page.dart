import 'package:flutter/material.dart';
import 'package:quiztholic/core/core.dart';
import 'package:quiztholic/home/home_page.dart';

class SplashPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 2)).then(
      (value) => Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => HomePage())),
    );
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(gradient: AppGradients.linear),
        child: Center(child: Image.asset(AppImages.logo)),
      ),
    );
  }
}
