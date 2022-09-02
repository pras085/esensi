import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:presence/app/modules/daftar_karyawan/controllers/daftar_karyawan_controller.dart';
import 'package:presence/app/style/app_color.dart';

class TodayTile extends StatelessWidget {
  final Map<String, dynamic> karyawanData;
  final Map<String, dynamic> presenceData;
  TodayTile({
    this.karyawanData,
    this.presenceData,
  });
  DateTime jamMasuk;
  DateTime jamKeluar;
  DateTime jamMasukKantor = DateTime(0, 0, 0, 8, 00);
  DateTime jamKeluarKantor = DateTime(0, 0, 0, 17, 00);
  @override
  Widget build(BuildContext context) {
    // log('${karyawanData['uid']}');
    // log('${presenceData}');

    return (presenceData == null)
        ? SizedBox()
        : Container(
            margin: EdgeInsets.only(bottom: 5),
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
              crossAxisAlignment: CrossAxisAlignment.center,
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                        (karyawanData['avatar'] == null ||
                                karyawanData['avatar'] == "")
                            ? "https://ui-avatars.com/api/?name=${karyawanData['name']}/"
                            : karyawanData['avatar'],
                        fit: BoxFit.cover,
                      ),
                      // child: Image.network(user['avatar'] != null ? ),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          (karyawanData["name"] == null)
                              ? "-"
                              : karyawanData["name"],
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          (karyawanData["job"] == null)
                              ? "-"
                              : '- ${karyawanData["job"]}',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text((presenceData['masuk'] != null)
                            ? "Masuk  ${DateFormat.jm('id_ID').format(DateTime.tryParse(presenceData['masuk']['date']))}"
                            : "Masuk  -"),
                        SizedBox(width: 5),
                        cekStatusMasuk(),
                      ],
                    ),
                    presenceData['keluar'] != null
                        ? Row(
                            children: [
                              if (presenceData['keluar'] != null)
                                cekStatusKeluar()
                            ],
                          )
                        : Text('Keluar -')
                  ],
                ),
              ],
            ),
          );
  }

  cekStatusMasuk() {
    var status;
    jamMasuk = DateTime.parse(presenceData['masuk']["date"]);
    if (jamMasuk.hour.isGreaterThan(jamMasukKantor.hour)) {
      status = 'Terlambat';
    }
    return Text('($status)');
  }

  cekStatusKeluar() {
    var status;
    jamKeluar = DateTime.parse(presenceData['keluar']["date"]);
    if (jamKeluar.hour.isGreaterThan(jamKeluarKantor.hour)) {
      status = 'Terlambat';
    }
    return Text('($status)');
  }
}
