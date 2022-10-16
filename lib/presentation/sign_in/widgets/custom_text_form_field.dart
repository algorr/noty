import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    Key? key,
    required this.hinText,
    required this.prefixIcon,
    required this.keyboardType,
    required this.obscureText,
  }) : super(key: key);

  final String hinText;
  final IconData prefixIcon;
  final TextInputType keyboardType;
  final bool obscureText;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obscureText,
      keyboardType: keyboardType,
      decoration: InputDecoration(
          prefixIcon: Icon(prefixIcon),
          hintText: hinText,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20))),
    );
  }
}
