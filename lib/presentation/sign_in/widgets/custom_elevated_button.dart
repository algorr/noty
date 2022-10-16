import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
  const CustomElevatedButton({
    Key? key,required this.func, required this.title
  }) : super(key: key);

  final VoidCallback func;
  final String title;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(onPressed: func, child: Text(title));
  }
}