import 'package:flutter/material.dart';
import 'package:noteapp/core/constans/colors.dart';
import 'package:noteapp/core/shared/Custumtextfomfeild.dart';
import 'package:noteapp/core/shared/custumgeneralbutton.dart';

class Editnotenew extends StatelessWidget {
  const Editnotenew({super.key, required this.onPressed});
  final Function onPressed;
  static TextEditingController title = TextEditingController();
  static TextEditingController content = TextEditingController();
  static GlobalKey<FormState> formkey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Form(
      key: formkey,
      child: Container(
        child: Padding(
          padding: const EdgeInsets.only(top: 5.0),
          child: Column(
            children: [
              Center(
                child: Text(
                  'New Note',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
              ),
              SizedBox(height: 20),

              // مربع نص صغير
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50),
                child: Column(
                  children: [
                    Custumtextfomfeild(
                      controller: title,
                      name: 'Title',
                      num: 1,
                    ),

                    SizedBox(height: 10),
                    Custumtextfomfeild(
                      controller: content,
                      name: 'content',
                      num: 5,
                    ),
                    SizedBox(height: 10),
                    custumGenralButton(
                      onPressed: () {
                        if (formkey.currentState!.validate()) {}
                        onPressed(title.text, content.text);

                        title.clear();
                        content.clear();
                        Navigator.pop(context);
                      },
                      name: 'Edit Note',
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
