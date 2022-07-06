import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:presence/app/style/app_color.dart';

class AppButton extends StatelessWidget {
  AppButton(
      {this.onPressed,
      this.text,
      this.color = AppColor.backgroundColor,
      this.icon = const Icon(
        Icons.add,
        color: Colors.white,
      )});
  final Function onPressed;
  final String text;
  final Icon icon;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        height: 40,
        decoration: BoxDecoration(
          color: color,
        ),
        alignment: Alignment.center,
        width: Get.width,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              text,
              style: TextStyle(
                  color: Colors.white, fontFamily: "Poppins", fontSize: 16),
            ),
            SizedBox(
              width: 10,
            ),
            icon
          ],
        ),
      ),
    );
  }
}
