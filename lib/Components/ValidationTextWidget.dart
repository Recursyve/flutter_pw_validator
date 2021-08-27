import 'package:flutter/material.dart';
import 'package:flutter_pw_validator/Utilities/SizeConfig.dart';
import 'package:flutter_svg/svg.dart';

/// ValidationTextWidget that represent style of each one of them and shows as list of condition that you want to the app user
class ValidationTextWidget extends StatelessWidget {
  final Color color;
  final String text;
  final int? value;
  Widget? bulletPoint;

  ValidationTextWidget({required this.color, required this.text, required this.value, required this.bulletPoint});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: SizeConfig.width! * 0.03,
          height: SizeConfig.width! * 0.03,
          child: (this.bulletPoint != null && this.bulletPoint is Image || this.bulletPoint is SvgPicture)
              ? this.bulletPoint
              : CircleAvatar(
                  backgroundColor: color,
                ),
        ),
        Padding(
          padding: EdgeInsets.only(left: SizeConfig.width! * 0.03),
          child: Text(
            text.replaceFirst("-", value.toString()),
            style: TextStyle(fontSize: SizeConfig.width! * 0.04, color: color),
          ),
        )
      ],
    );
  }
}
