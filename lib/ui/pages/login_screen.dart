import 'package:align_positioned/align_positioned.dart';
import 'package:flutter/material.dart';
import 'package:nano/ui/theme/palette.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Column(
        children: [
          logoWidget(height, width),
          Container(
            height: height / 2,
            width: width,
            color: Colors.green,
            child: Column(
              children: [

              ],
            ),
          ),
        ],
      ),
    );
  }

  Container logoWidget(double height, double width) {
    return Container(
          height: height / 2,
          width: width,
          decoration: const BoxDecoration(
            gradient: LinearGradient(colors: [
              Palette.dark_blue,
              Palette.light_blue,
            ]),
          ),
          child: Stack(
            children: [
              Center(
                child: Image.asset(
                  'assets/nano.png',
                  width: 200,
                  height: 200,
                  fit: BoxFit.contain,
                ),
              ),
              const AlignPositioned(
                alignment: Alignment.bottomCenter,
                dx: -110,
                dy: -20,
                child: Text(
                  'Log In',
                  style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'SF Pro Display',
                      fontSize: 34,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        );
  }
}


