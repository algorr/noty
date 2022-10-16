import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    Key? key,
    required this.hinText,
    required this.prefixIcon,
    required this.keyboardType,
    required this.obscureText,
    required this.onChanged,
    required this.validator,
  }) : super(key: key);

  final String hinText;
  final IconData prefixIcon;
  final TextInputType keyboardType;
  final bool obscureText;
  final Function onChanged;
  final Function validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obscureText,
      keyboardType: keyboardType,
      decoration: InputDecoration(
          prefixIcon: Icon(prefixIcon),
          hintText: hinText,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20))),
          onChanged: (value){
            onChanged;
          },
          validator: (value) {
            validator;
            
          },
    );
  }
}
