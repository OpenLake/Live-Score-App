import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    this.hideText = false,
    required this.textController,
    required this.placeholderText,
    this.icon,
    this.maxLength=20,
  });

  final bool hideText;
  final TextEditingController textController;
  final String placeholderText;
  final IconData? icon;
    final int maxLength;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: SizedBox(
        width: 0.75 * size.width,
        child: TextFormField(
          controller: textController,
          obscureText: hideText,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          validator: (value) =>
              value != null &&(value.isEmpty || value.length>=maxLength)? 'Enter min 1 character and max $maxLength':null,
          decoration: InputDecoration(
            prefixIcon:Icon(icon),
            border: const OutlineInputBorder(borderRadius:BorderRadius.all(Radius.circular(30.0))),
            labelText: placeholderText,
          ),
        ),
      ),
    );
  }
}