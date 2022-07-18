import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:presence/app/style/app_color.dart';
import 'package:presence/app/widgets/perizinan_tile.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../controllers/perizinan_controller.dart';

class PerizinanView extends GetView<PerizinanController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppColor.navigationColor,
        title: Text(
          'Riwayat Perizinan',
          style: TextStyle(
              fontFamily: 'inter', fontSize: 14, fontWeight: FontWeight.w500),
        ),
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: SvgPicture.asset(
            'assets/icons/arrow-left.svg',
            color: AppColor.whiteColor,
          ),
        ),
        elevation: 0,
        centerTitle: true,
        // actions: [
        //   Container(
        //     width: 44,
        //     height: 44,
        //     margin: EdgeInsets.only(bottom: 8, top: 8, right: 8),
        //     child: ElevatedButton(
        //       onPressed: () {
        //         Get.dialog(
        //           Dialog(
        //             child: Container(
        //               height: 372,
        //               child: SfDateRangePicker(
        //                 headerHeight: 50,
        //                 headerStyle: DateRangePickerHeaderStyle(
        //                     textAlign: TextAlign.center),
        //                 initialSelectedDate: controller.dateDb,
        //                 monthViewSettings: DateRangePickerMonthViewSettings(
        //                     firstDayOfWeek: 1,
        //                     viewHeaderStyle: DateRangePickerViewHeaderStyle(
        //                         backgroundColor: AppColor.primaryExtraSoft,
        //                         textStyle: TextStyle(
        //                             fontFamily: 'poppins',
        //                             fontWeight: FontWeight.w500,
        //                             color: AppColor.navigationColor)),
        //                     weekendDays: <int>[DateTime.sunday]),
        //                 selectionMode: DateRangePickerSelectionMode.single,
        //                 maxDate: DateTime.now(),
        //                 todayHighlightColor: AppColor.backgroundColor,
        //                 showNavigationArrow: true,
        //                 minDate: DateTime(2022, 6),
        //                 selectionColor: AppColor.primary,
        //                 selectionShape: DateRangePickerSelectionShape.rectangle,
        //                 rangeSelectionColor: AppColor.primary.withOpacity(0.2),
        //                 viewSpacing: 10,
        //                 showActionButtons: true,
        //                 onCancel: () => Get.back(),
        //                 onSubmit: (data) {
        //                   // if (data != null) {
        //                   //   print('INI DATA DARI PICKER :  $data');
        //                   //   DateTime formatedDate = DateTime.parse(
        //                   //       DateFormat('EEEE, d MMMM yyyy', 'id_ID')
        //                   //           .format(data)
        //                   //           .toString());

        //                   //   print(formatedDate);
        //                   //   controller.pickDate(formatedDate);
        //                   // } else {
        //                   //   Container(
        //                   //       alignment: Alignment.center,
        //                   //       child: Icon(Icons.date_range));
        //                   // }
        //                   print(data);
        //                   controller.pickDate(data);
        //                   // //else skip
        //                 },
        //               ),
        //             ),
        //           ),
        //         );
        //       },
        //       child: SvgPicture.asset('assets/icons/filter.svg'),
        //       style: ElevatedButton.styleFrom(
        //         elevation: 0,
        //         padding: EdgeInsets.zero,
        //         shape: RoundedRectangleBorder(
        //           borderRadius: BorderRadius.circular(8),
        //         ),
        //       ),
        //     ),
        //   )
        // ],
      ),
      body: GetBuilder<PerizinanController>(
        builder: (con) {
          return FutureBuilder<QuerySnapshot>(
            future: controller.getPerizinan(),
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                  return Center(
                      child: CircularProgressIndicator(
                          color: AppColor.navigationColor));
                case ConnectionState.active:
                case ConnectionState.done:
                  var listPerizinan = snapshot.data.docs;
                  print(listPerizinan);
                  return Container(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          // Container(
                          //   alignment: Alignment.center,
                          //   width: Get.width,
                          //   padding: EdgeInsets.all(15),
                          //   margin:
                          //       EdgeInsets.only(left: 50, right: 50, top: 10),
                          //   decoration: BoxDecoration(
                          //     color: AppColor.primary.withOpacity(0.8),
                          //     borderRadius: BorderRadius.circular(8),
                          //     border: Border.all(
                          //         width: 1, color: AppColor.primaryExtraSoft),
                          //   ),
                          //   child: Text(
                          //     '${controller.today}',
                          //     style: TextStyle(
                          //         color: AppColor.whiteColor,
                          //         fontWeight: FontWeight.bold),
                          //   ),
                          // ),
                          ListView.separated(
                            itemCount: listPerizinan.length,
                            shrinkWrap: true,
                            physics: BouncingScrollPhysics(),
                            padding: EdgeInsets.all(20),
                            separatorBuilder: (context, index) =>
                                SizedBox(height: 16),
                            itemBuilder: (context, index) {
                              var perizinanData = listPerizinan[index].data();
                              print(perizinanData["uid"]);
                              return StreamBuilder<DocumentSnapshot>(
                                  stream: FirebaseFirestore.instance
                                      .collection('employee')
                                      .doc(perizinanData['idUser'])
                                      .snapshots(),
                                  builder: (context, snapshotUser) {
                                    switch (snapshot.connectionState) {
                                      case ConnectionState.active:
                                      case ConnectionState.done:
                                        var dataUser = {
                                          "address": "",
                                          "role": "employee",
                                          "employee_id": "",
                                          "name": "",
                                          "created_at": "",
                                          "avatar": "",
                                          "position": {
                                            "latitude": "",
                                            "longitude": ""
                                          },
                                          "job": "",
                                          "email": ""
                                        };
                                        String name = "";
                                        if (snapshotUser.data != null) {
                                          print(snapshotUser.data.data());
                                          dataUser = snapshotUser.data.data();
                                        }
                                        return PerizinanTile(
                                          perizinanData: perizinanData,
                                          dataUser: dataUser,
                                        );
                                      case ConnectionState.waiting:
                                        return Center(
                                            child: CircularProgressIndicator());
                                      default:
                                        return Center(child: Text("Error"));
                                    }
                                  });
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                default:
                  return SizedBox();
              }
            },
          );
        },
      ),
    );
  }
}
