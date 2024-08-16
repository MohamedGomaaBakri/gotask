import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomSocialContainer extends StatelessWidget {
  const CustomSocialContainer({super.key, required this.image, required this.onTap});
  final String image ;
  final void Function() onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container
        (
        height: 75,
        width: 75,
        decoration: BoxDecoration
          (
          color: Colors.grey.withOpacity(0.3),
          borderRadius: BorderRadius.circular(10),

        ),
        child: Center(
          child: SvgPicture.asset(
            image ,
            width: 40,
            height: 40,

          ),
        ),
      ),
    );
  }
}
