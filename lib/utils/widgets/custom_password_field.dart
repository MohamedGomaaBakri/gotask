import 'package:flutter/material.dart';

import 'custom_text_form_field.dart';

class CustomPasswordField extends StatefulWidget {
  const CustomPasswordField({super.key, required this.onSaved,});
  final void Function(String?) onSaved;

  @override
  State<CustomPasswordField> createState() => _CustomPasswordFieldState();
}

class _CustomPasswordFieldState extends State<CustomPasswordField> {
  bool obscureText = true;
  @override
  Widget build(BuildContext context) {
    return  CustomTextFormField(
      obscureText: obscureText,
      onSaved: widget.onSaved,
      hintText: 'Enter Password',
      textInputType: TextInputType.visiblePassword,
      suffixIcon:  Padding(
        padding: const EdgeInsets.only(left: 40),
        child: GestureDetector(
          onTap: ()
          {
            obscureText = !obscureText;
            setState(() {

            });
          },
          child: obscureText ?  const Icon(
            Icons.remove_red_eye,
            color: Color(0xffc9cecf),
          ): const Icon(
            Icons.visibility_off,
            color: Color(0xffc9cecf),
          ),
        ),
      ),
    );
  }
}
