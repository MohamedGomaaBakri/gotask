import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField(
      {super.key,
      required this.textInputType,
      required this.hintText,
      this.suffixIcon,
     required this.onSaved, this.obscureText = false, this.initialValue
        ,});
  final TextInputType textInputType;
  final String hintText;
  final Widget? suffixIcon;
  final String? initialValue;
  final void Function(String?) onSaved;
 final bool obscureText ;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 17),
      child: SizedBox(
        height: 56,
        width: double.infinity,
        child: TextFormField(
          initialValue: initialValue,
          obscureText: obscureText,
          onSaved: onSaved,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'this field is required';
            }
            return null;
          },
          keyboardType: textInputType,
          cursorColor: Colors.black,
          decoration: InputDecoration(
            suffixIcon: suffixIcon,
            fillColor: const Color(0xFFF9FAFA),
            hintText: hintText,
            hintStyle: const TextStyle(
              color: Color(0xFF949D9E),
              fontSize: 16,
              fontFamily: 'Cairo',
              fontWeight: FontWeight.bold,
            ),
            border: buildBorder(),
            enabledBorder: buildBorder(),
            focusedBorder: buildBorder(),
          ),
        ),
      ),
    );
  }

  OutlineInputBorder buildBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(4),
      borderSide: const BorderSide(
        strokeAlign: BorderSide.strokeAlignCenter,
        width: 1,
        color: Color(0xFFE6E9E9),
      ),
    );
  }
}
