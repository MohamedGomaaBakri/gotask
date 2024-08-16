import 'package:flutter/material.dart';
import 'package:todo/color.dart';

class CheckBox extends StatelessWidget {
  const CheckBox({super.key, required this.isChecked, required this.onChanged});
  final bool isChecked ;
  final ValueChanged<bool> onChanged;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onChanged(!isChecked),
      child: AnimatedContainer(
        clipBehavior: Clip.antiAlias,
        width: 24,
          height: 24,
          duration: const Duration(milliseconds: 100),
          decoration: BoxDecoration(
            color:isChecked ? AppColor.primaryColor : Colors.white,
            border: Border.all(
              color: const Color(0xFFDCDEDE),
              width: 2,
            ),
            borderRadius: BorderRadius.circular(8),
          ) ,
          child:isChecked ?  const Icon(
            size: 16,
            Icons.check,
            color: Colors.white,
          ): const SizedBox(),
      ),
    );
  }
}
