import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:presence/app/style/app_color.dart';

class ProfileListItem extends StatelessWidget {
  final IconData icon;
  final String text;
  final bool hasNavigation;

  const ProfileListItem({
    Key key,
    this.icon,
    this.text,
    this.hasNavigation = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.height / 13,
      margin: EdgeInsets.symmetric(horizontal: 12),
      padding: EdgeInsets.symmetric(
        horizontal: 12,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: AppColor.navigationColor.withOpacity(0.9),
      ),
      child: Row(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(7),
            decoration: BoxDecoration(
                color: AppColor.primaryExtraSoft, shape: BoxShape.circle),
            child: Icon(
              this.icon,
              size: 10 * 2.5,
              color: AppColor.primary,
            ),
          ),
          SizedBox(width: 10 * 1.5),
          Text(
            this.text,
            style: TextStyle(
              fontFamily: "poppins",
              fontWeight: FontWeight.w500,
              fontSize: 12,
              color: AppColor.whiteColor,
            ),
          ),
          Spacer(),
          if (this.hasNavigation)
            Icon(
              Icons.arrow_right,
              size: 10 * 2.5,
              color: AppColor.whiteColor,
            ),
        ],
      ),
    );
  }
}
