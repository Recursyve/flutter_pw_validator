import 'package:flutter/material.dart';
import 'package:flutter_pw_validator/Utilities/SizeConfig.dart';
import 'package:flutter_svg/svg.dart';

/// ValidationTextWidget that represent style of each one of them and shows as list of condition that you want to the app user
class ValidationTextWidget extends StatelessWidget {
  final Color color;
  final String text;
  final int? value;
  final bool? isCheck;
  final Widget? checkedIcon; // isCheck must not be null
  final Widget? uncheckIcon; // isCheck must not be null
  Widget? bulletPoint;

  ValidationTextWidget({
    required this.color,
    required this.text,
    required this.value,
    required this.bulletPoint,
    this.isCheck,
    this.uncheckIcon,
    this.checkedIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: SizeConfig.width! * 0.03,
          height: SizeConfig.width! * 0.03,
          child: _buildBulletPoint(bulletPoint, isCheck, uncheckIcon, checkedIcon),
        ),
        Padding(
          padding: EdgeInsets.only(left: SizeConfig.width! * 0.03),
          child: Flexible(
            child: Text(
              text.replaceFirst("-", value.toString()),
              style: TextStyle(
                fontSize: SizeConfig.width! * 0.04,
                color: color,
              ),
            ),
          ),
        )
      ],
    );
  }

  Widget _buildBulletPoint(Widget? bulletPoint, bool? isCheck, Widget? uncheckIcon, Widget? checkedIcon) {
    if (checkedIcon != null && uncheckIcon != null && isCheck != null) {
      return isCheck ? checkedIcon : uncheckIcon;
    } else if (bulletPoint != null && bulletPoint is Image || bulletPoint is SvgPicture) return bulletPoint!;
    return CircleAvatar(
      backgroundColor: color,
    );
  }
}
