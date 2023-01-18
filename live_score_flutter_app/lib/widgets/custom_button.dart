import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  String? title;
  Color? color;
  Color? textColor;
  VoidCallback? onTap;
  CustomButton({this.title, this.color, this.onTap, this.textColor});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      highlightElevation: 0,
      elevation: 0,
      minWidth: 200,
      height: 50,
      shape: RoundedRectangleBorder(
        borderRadius: const BorderRadius.all(Radius.circular(50)),
        side: BorderSide(color: textColor ?? Colors.black),
      ),
      color: color,
      onPressed: onTap,
      child: Text(
        title ?? '',
        style: TextStyle(color: textColor, fontSize: 25),
      ),
    );
  }
}
