import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String? hintText;
  final IconData? icon;
  final TextInputType keyboardType;
  final bool obscureText;

  const CustomTextField({
    super.key,
    this.controller,
    this.hintText,
    this.icon,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      obscureText: obscureText,
      decoration: InputDecoration(
        hintText: hintText,
        prefixIcon: icon != null ? Icon(icon) : null,
        filled: true,
        fillColor: Colors.grey[200],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
        contentPadding:
            const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
      ),
      style: const TextStyle(color: Colors.black),
    );
  }
}
