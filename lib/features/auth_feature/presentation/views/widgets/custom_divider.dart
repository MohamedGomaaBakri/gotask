import 'package:flutter/material.dart';
import 'package:todo/color.dart';

class CustomDivider extends StatelessWidget {
  const CustomDivider({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        Expanded(
          child: Padding(
            padding: EdgeInsets.only(right: 20),
            child: Divider(),
          ),
        ),
        Padding(
          padding: EdgeInsets.all(4),
          child: Text(
            'Or',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: AppColor.primaryColor,
              fontSize: 16,
            ),
          ),
        ),
        Expanded(
            child: Padding(
              padding: EdgeInsets.only(left: 20),
              child: Divider(),
            )),
      ],
    );
  }
}
