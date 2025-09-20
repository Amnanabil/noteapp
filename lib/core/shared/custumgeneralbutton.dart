import 'package:flutter/material.dart';
import 'package:noteapp/core/constans/colors.dart';

class custumGenralButton extends StatelessWidget {
  const custumGenralButton({
    super.key,
    required this.onPressed,
    required this.name,
  });
  final Function() onPressed;
  final String name;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      child: Text(name),
      color: Appcolors.primary,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10), // حواف مدورة
      ),
      textColor: Appcolors.secondry,
    );
  }
}
