import 'package:flutter/cupertino.dart';

import 'check_box.dart';

class TermsAndConditionWidget extends StatefulWidget {
  const TermsAndConditionWidget({super.key, required this.onChanged});
  final ValueChanged<bool> onChanged;
  @override
  State<TermsAndConditionWidget> createState() => _TermsAndConditionWidgetState();
}

class _TermsAndConditionWidgetState extends State<TermsAndConditionWidget> {
   bool isAccepted = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CheckBox(
            isChecked: isAccepted,
            onChanged: (value) {
              setState(() {
                isAccepted = value;
                widget.onChanged(value);
              });
            },
        ),
        const SizedBox(
          width: 16,
        ),
        const Expanded(
          child: Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: 'I have read and agree to the ',
                  style: TextStyle(
                    color: Color(0xFF949D9E),
                    fontSize: 13,
                    fontFamily: 'Cairo',
                    fontWeight: FontWeight.w600,
                  ),
                ),
                TextSpan(
                  text: 'Terms and Conditions',
                  style: TextStyle(
                    color: Color(0xFF2D9F5D),
                    fontSize: 13,
                    fontFamily: 'Cairo',
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ),

    ],
    );
  }
}
