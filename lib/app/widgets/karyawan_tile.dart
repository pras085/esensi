import 'package:flutter/material.dart';
import 'package:presence/app/style/app_color.dart';

class KaryawanTile extends StatelessWidget {
  final Map<String, dynamic> karyawanData;
  KaryawanTile({this.karyawanData});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          width: 1,
          color: AppColor.primaryExtraSoft,
        ),
      ),
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
                color: AppColor.backgroundColor, shape: BoxShape.circle),
            child: Icon(
              Icons.person_pin,
              color: AppColor.whiteColor,
            ),
          ),
          SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                (karyawanData["name"] == null) ? "-" : karyawanData["name"],
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                (karyawanData["email"] == null) ? "-" : karyawanData["email"],
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
                (karyawanData["employee_id"] == null)
                    ? "-"
                    : karyawanData["employee_id"],
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                (karyawanData["job"] == null) ? "-" : karyawanData["job"],
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
