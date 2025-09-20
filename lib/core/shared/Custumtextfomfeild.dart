import 'package:flutter/material.dart';
import 'package:noteapp/core/constans/colors.dart';

class Custumtextfomfeild extends StatelessWidget {
  const Custumtextfomfeild({
    super.key,
    required this.controller,
    required this.name,
    required this.num,
  });

  final TextEditingController controller;

  final String name;
  final int num;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (value) {
        if (value!.isEmpty) return 'You must enter value';
      },
      controller: controller,
      maxLines: num,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Appcolors.primary),
        ),
        labelText: name,
        hint: Text('Title'),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Appcolors.error),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Appcolors.inverseprimary),
        ),
      ),
    );
  }
}
