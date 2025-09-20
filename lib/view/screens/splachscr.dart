import 'dart:async' show Timer;

import 'package:flutter/material.dart';
import 'package:noteapp/core/constans/colors.dart';
import 'package:noteapp/view/screens/HomePage.dart';

class SplachScr extends StatefulWidget {
  const SplachScr({super.key});

  @override
  State<SplachScr> createState() => _SplachScrState();
}

class _SplachScrState extends State<SplachScr> {
  @override
  void initState() {
    super.initState();
    // الانتقال بعد 3 ثواني
    Future.delayed(Duration(seconds: 3), () {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => Homepage()),
        (Route<dynamic> route) => false,
      );
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Appcolors.background,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Center(child: Image.asset('assets/images/note.png', height: 100)),
          SizedBox(height: MediaQuery.of(context).size.height / 2.5),
          Padding(
            padding: const EdgeInsets.only(bottom: 10.0),
            child: Text('Amna Nabil', style: TextStyle(fontSize: 15)),
          ),
        ],
      ),
    );
  }
}
