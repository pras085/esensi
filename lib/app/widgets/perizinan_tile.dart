import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:presence/app/routes/app_pages.dart';
import 'package:presence/app/style/app_color.dart';

class PerizinanTile extends StatelessWidget {
  final Map<String, dynamic> perizinanData;
  final Map<String, dynamic> dataUser;

  PerizinanTile({this.perizinanData, this.dataUser});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.toNamed(Routes.DETAIL_PERIZINAN,
          arguments: {"izin": perizinanData, "user": dataUser}),
      child: Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: (perizinanData["status"] == "waiting")
              ? AppColor.primary.withOpacity(0.4)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            width: 1,
            color: (perizinanData["status"] == "true")
                ? AppColor.success
                : (perizinanData["status"] == "false")
                    ? AppColor.error
                    : AppColor.primary,
          ),
        ),
        padding: EdgeInsets.all(10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              (dataUser["name"] == null) ? "-" : dataUser["name"],
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
              textWidthBasis: TextWidthBasis.longestLine,
            ),
            Spacer(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Status",
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 6),
                Icon(
                  (perizinanData["status"] == "true")
                      ? Icons.verified
                      : (perizinanData["status"] == "false")
                          ? Icons.do_disturb_outlined
                          : Icons.update_outlined,
                  color: (perizinanData["status"] == "true")
                      ? AppColor.success
                      : (perizinanData["status"] == "false")
                          ? AppColor.error.withOpacity(0.8)
                          : AppColor.navigationColor,
                  size: 30,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
