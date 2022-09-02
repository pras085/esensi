import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:presence/app/routes/app_pages.dart';
import 'package:presence/app/style/app_color.dart';

class PresenceTodayTile extends StatelessWidget {
  // finahl Map<String, dynamic> presenceData;
  final Map<String, dynamic> dataUser;

  PresenceTodayTile({this.dataUser});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Get.toNamed(
        Routes.RIWAYAT_PRESENCE_CHOSEN,
        arguments: dataUser['uid'],
      ),
      borderRadius: BorderRadius.circular(8),
      child: Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            width: 1,
            color: AppColor.primaryExtraSoft,
          ),
        ),
        padding: EdgeInsets.only(left: 10, top: 20, right: 10, bottom: 20),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                      style: BorderStyle.solid,
                      color: AppColor.navigationColor,
                      width: 2)),
              child: ClipOval(
                child: Container(
                  width: 40,
                  height: 40,
                  child: Image.network(
                    (dataUser["avatar"] == null || dataUser['avatar'] == "")
                        ? "https://ui-avatars.com/api/?name=${dataUser['name']}/"
                        : dataUser['avatar'],
                    fit: BoxFit.cover,
                  ),
                  // child: Image.network(user['avatar'] != null ? ),
                ),
              ),
            ),
            SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  (dataUser["name"] == null) ? "-" : dataUser["name"],
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  (dataUser["email"] == null) ? "-" : dataUser["email"],
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
            Spacer(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  (dataUser["employee_id"] == null)
                      ? "-"
                      : dataUser["employee_id"],
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  (dataUser["job"] == null) ? "-" : dataUser["job"],
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
