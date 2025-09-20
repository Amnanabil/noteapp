import 'package:flutter/material.dart';
import 'package:noteapp/core/constans/colors.dart';
import 'package:noteapp/model/notemodel.dart';

class Noteview extends StatelessWidget {
  final Notemodel note;
  const Noteview({super.key, required this.note});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Appcolors.background,
      appBar: AppBar(title: Text(note.title), centerTitle: true),
      body: Center(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(note.content),
              SizedBox(height: 10),
              Text(note.Date + " " + note.Time),
            ],
          ),
        ),
      ),
    );
  }
}
