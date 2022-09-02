import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:presence/app/routes/app_pages.dart';
import 'package:presence/app/style/app_color.dart';
import 'package:presence/app/widgets/custom_bottom_navigation_bar.dart';
import 'package:presence/app/widgets/hari_ini_tile.dart';
import 'package:presence/app/widgets/presence_card.dart';
import 'package:presence/app/widgets/presence_tile.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  HomeController controller = Get.put(HomeController());
  Map<String, dynamic> user;
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        bottomNavigationBar: CustomBottomNavigationBar(user = user),
        extendBody: true,
        body: body(),
      ),
    );
  }

  StreamBuilder<DocumentSnapshot> body() {
    return StreamBuilder<DocumentSnapshot>(
        stream: controller.streamUser(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.active:
            case ConnectionState.done:
              user = snapshot.data.data();
              return Column(
                children: [
                  PreferredSize(
                    preferredSize: Size(Get.width, Get.statusBarHeight + 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 30,
                          color: AppColor.navigationColor,
                        ),
                        Container(
                          height: 100,
                          width: Get.width,
                          decoration: BoxDecoration(
                              color: AppColor.navigationColor,
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(15),
                                bottomRight: Radius.circular(15),
                              )),
                          child: Stack(
                            alignment: Alignment.topCenter,
                            children: [
                              SvgPicture.asset(
                                'assets/vector/lampu_atas.svg',
                                color: Colors.blueGrey[900],
                                height: 85,
                              ),
                              Positioned(
                                left: 0,
                                top: 0,
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 5),
                                  width: Get.width,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Container(
                                            height: 50,
                                            width: 50,
                                            decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                border: Border.all(
                                                    style: BorderStyle.solid,
                                                    color: AppColor.whiteColor,
                                                    width: 2)),
                                            child: ClipOval(
                                              child: Container(
                                                width: 50,
                                                height: 50,
                                                child: Image.network(
                                                  (user["avatar"] == null ||
                                                          user['avatar'] == "")
                                                      ? "https://ui-avatars.com/api/?name=${user['name']}/"
                                                      : user['avatar'],
                                                  fit: BoxFit.cover,
                                                ),
                                                // child: Image.network(user['avatar'] != null ? ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(width: 10),
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'Welcome',
                                                style: TextStyle(
                                                  fontFamily: 'Poppins',
                                                  fontSize: 14,
                                                  color: AppColor.whiteColor,
                                                  fontWeight: FontWeight.normal,
                                                ),
                                              ),
                                              Text(
                                                user["name"],
                                                style: TextStyle(
                                                  color: AppColor.whiteColor,
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily: 'poppins',
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      Container(
                                        padding:
                                            EdgeInsets.symmetric(vertical: 10),
                                        decoration: BoxDecoration(
                                            shape: BoxShape.rectangle,
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: Row(children: [
                                          Container(
                                            padding: EdgeInsets.all(3),
                                            decoration: BoxDecoration(
                                                shape: BoxShape.rectangle,
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                color:
                                                    AppColor.backgroundColor),
                                            child: Center(
                                              child: Icon(
                                                Icons.alarm_rounded,
                                                color: AppColor.whiteColor,
                                                size: 20,
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          Text(
                                            "08:00 & 17:00",
                                            style: TextStyle(
                                              fontFamily: 'Poppins',
                                              fontSize: 12,
                                              color: AppColor.whiteColor,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          SizedBox(width: 15),
                                          Obx(() => Container(
                                                padding: EdgeInsets.all(3),
                                                decoration: BoxDecoration(
                                                  shape: BoxShape.rectangle,
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  color: controller
                                                          .inRadius.value
                                                      ? AppColor.backgroundColor
                                                      : Colors.red,
                                                ),
                                                child: Center(
                                                  child: Icon(
                                                    Icons.gps_fixed,
                                                    color: AppColor.whiteColor,
                                                    size: 20,
                                                  ),
                                                ),
                                              )),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          Obx(() => Text(
                                                controller.inRadius.value
                                                    ? 'Berada di Kantor'
                                                    : 'Di luar jangkauan',
                                                style: TextStyle(
                                                  fontFamily: 'Poppins',
                                                  fontSize: 12,
                                                  color: AppColor.whiteColor,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              )),
                                        ]),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: RefreshIndicator(
                      color: AppColor.navigationColor,
                      onRefresh: () {
                        HapticFeedback.lightImpact();
                        return controller.onRefresh();
                      },
                      child: ListView(
                        shrinkWrap: true,
                        physics: BouncingScrollPhysics(
                            parent: AlwaysScrollableScrollPhysics()),
                        padding: EdgeInsets.only(
                            bottom: 100, top: 10, right: 20, left: 20),
                        children: [
                          // section 1 -
                          //  card
                          user["role"] == "admin"
                              ? SizedBox(
                                  height: 30,
                                )
                              : user['address'] != null
                                  ? StreamBuilder<DocumentSnapshot>(
                                      stream: controller.streamTodayPresence(),
                                      builder: (context, snapshot) {
                                        // #TODO: make skeleton
                                        switch (snapshot.connectionState) {
                                          case ConnectionState.waiting:
                                            return Center(
                                                child:
                                                    CircularProgressIndicator(
                                              color: AppColor.navigationColor,
                                            ));
                                          case ConnectionState.active:
                                          case ConnectionState.done:
                                            var todayPresenceData =
                                                snapshot.data.data();
                                            return PresenceCard(
                                              userData: user,
                                              todayPresenceData:
                                                  todayPresenceData,
                                            );
                                          default:
                                            return SizedBox();
                                        }
                                      })
                                  : SizedBox(),
                          // last location
                          user["role"] == "admin"
                              ? SizedBox()
                              : Container(
                                  margin: EdgeInsets.only(
                                      top: 12, bottom: 24, left: 4),
                                  child: Text(
                                    (user["address"] != null)
                                        ? "${user['address']}"
                                        : "Belum ada lokasi",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: AppColor.secondarySoft,
                                    ),
                                  ),
                                ),
                          // section 3 distance & map
                          Container(
                            width: MediaQuery.of(context).size.width,
                            margin: EdgeInsets.only(bottom: 10),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    height: 84,
                                    decoration: BoxDecoration(
                                      color: AppColor.navigationColor,
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Container(
                                          margin: EdgeInsets.only(bottom: 6),
                                          child: Text(
                                            'Distance from office',
                                            style: TextStyle(
                                                fontSize: 11,
                                                fontFamily: 'poppins',
                                                color: AppColor.whiteColor
                                                    .withOpacity(0.6),
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ),
                                        Obx(
                                          () => Text(
                                            '${controller.officeDistance.value}',
                                            style: TextStyle(
                                              fontSize: 24,
                                              color: AppColor.whiteColor,
                                              fontFamily: 'poppins',
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(width: 16),
                                Expanded(
                                  child: GestureDetector(
                                    onTap: controller.launchOfficeOnMap,
                                    child: Container(
                                      height: 84,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        color: AppColor.primaryExtraSoft,
                                        borderRadius: BorderRadius.circular(8),
                                        image: DecorationImage(
                                          image: AssetImage(
                                              'assets/vector/maps.png'),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      child: Text(
                                        'Open in maps',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          // Section 4 - Menu
                          Container(
                            width: MediaQuery.of(context).size.width,
                            margin: EdgeInsets.only(bottom: 10),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Menu',
                                  style: TextStyle(
                                    fontFamily: 'poppins',
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                SizedBox(height: 8),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    //BUtton 1

                                    Expanded(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                              Get.toNamed(Routes.ALL_PRESENCE);
                                            },
                                            child: Container(
                                              alignment: Alignment.center,
                                              height: Get.height / 15,
                                              padding: EdgeInsets.all(5),
                                              decoration: BoxDecoration(
                                                color:
                                                    AppColor.secondaryExtraSoft,
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                              ),
                                              child: Icon(Icons.date_range,
                                                  size: 30,
                                                  color:
                                                      AppColor.navigationColor),
                                            ),
                                          ),
                                          SizedBox(height: 5),
                                          Text(
                                            'Riwayat Presensi',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    //ADMIN
                                    SizedBox(width: 15),
                                    (user["role"] == "admin")
                                        ? Expanded(
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                GestureDetector(
                                                  onTap: () {
                                                    Get.toNamed(
                                                        Routes.PRESENSI_TODAY);
                                                  },
                                                  child: Container(
                                                    alignment: Alignment.center,
                                                    height: Get.height / 15,
                                                    padding: EdgeInsets.all(5),
                                                    decoration: BoxDecoration(
                                                      image: DecorationImage(
                                                        image: AssetImage(
                                                            'assets/images/pattern-1.png'),
                                                        fit: BoxFit.cover,
                                                      ),
                                                      color: AppColor
                                                          .secondaryExtraSoft,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8),
                                                    ),
                                                    child: Icon(
                                                        Icons.history_outlined,
                                                        size: 30,
                                                        color: AppColor
                                                            .navigationColor),
                                                  ),
                                                ),
                                                SizedBox(height: 5),
                                                Text(
                                                  'Presensi\nKaryawan',
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                )
                                              ],
                                            ),
                                          )
                                        : SizedBox(),
                                    if ((user["role"] == "admin"))
                                      SizedBox(width: 15),
                                    (user["role"] == "admin")
                                        ? Expanded(
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                GestureDetector(
                                                  onTap: () {
                                                    Get.toNamed(
                                                        Routes.PERIZINAN);
                                                  },
                                                  child: Container(
                                                    alignment: Alignment.center,
                                                    height: Get.height / 15,
                                                    padding: EdgeInsets.all(5),
                                                    decoration: BoxDecoration(
                                                      color: AppColor
                                                          .secondaryExtraSoft,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8),
                                                    ),
                                                    child: Icon(
                                                        Icons
                                                            .published_with_changes,
                                                        size: 30,
                                                        color: AppColor
                                                            .navigationColor),
                                                  ),
                                                ),
                                                SizedBox(height: 5),
                                                Text(
                                                  'Riwayat Approval',
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                )
                                              ],
                                            ),
                                          )
                                        : SizedBox(),
                                    if ((user["role"] == "admin"))
                                      SizedBox(width: 15),

                                    Expanded(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                              (user["role"] == "admin")
                                                  ? Get.toNamed(
                                                      Routes.PERIZINAN_ADMIN)
                                                  : Get.toNamed(
                                                      Routes.RIWAYAT_PERIZINAN);
                                            },
                                            child: Container(
                                              alignment: Alignment.center,
                                              height: Get.height / 15,
                                              padding: EdgeInsets.all(5),
                                              decoration: BoxDecoration(
                                                color:
                                                    AppColor.secondaryExtraSoft,
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                              ),
                                              child: Icon(Icons.approval,
                                                  size: 30,
                                                  color:
                                                      AppColor.navigationColor),
                                            ),
                                          ),
                                          SizedBox(height: 5),
                                          Text(
                                            (user["role"] == "admin")
                                                ? 'Approval\nPerizinan'
                                                : 'Perizinan',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          // Section 5 - Presence History
                          user["role"] == "admin"
                              ? SizedBox()
                              : Container(
                                  margin: EdgeInsets.symmetric(vertical: 12),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        "3 Hari Terakhir",
                                        style: TextStyle(
                                            fontFamily: "poppins",
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ],
                                  ),
                                ),
                          user["role"] == "admin"
                              ? Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Presensi Hari Ini',
                                      style: TextStyle(
                                          fontFamily: "poppins",
                                          fontWeight: FontWeight.w600),
                                    ),
                                    FutureBuilder<QuerySnapshot>(
                                        future: controller.getAllUser(),
                                        builder: (context, snapshot) {
                                          switch (snapshot.connectionState) {
                                            case ConnectionState.waiting:
                                              return Center(
                                                  child:
                                                      CircularProgressIndicator(
                                                color: AppColor.navigationColor,
                                              ));
                                            case ConnectionState.active:
                                            case ConnectionState.done:
                                              List<QueryDocumentSnapshot>
                                                  allUser = snapshot.data?.docs;

                                              return Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Container(
                                                    child: ListView.builder(
                                                      itemCount: allUser.length,
                                                      shrinkWrap: true,
                                                      physics:
                                                          NeverScrollableScrollPhysics(),
                                                      scrollDirection:
                                                          Axis.vertical,
                                                      itemBuilder:
                                                          (context, index) {
                                                        Map<String, dynamic>
                                                            user =
                                                            allUser[index]
                                                                .data();
                                                        String todayDocId =
                                                            DateFormat.yMd()
                                                                .format(DateTime
                                                                    .now())
                                                                .replaceAll(
                                                                    "/", "-");
                                                        return Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            StreamBuilder<
                                                                    DocumentSnapshot>(
                                                                stream: FirebaseFirestore
                                                                    .instance
                                                                    .collection(
                                                                        'employee')
                                                                    .doc(allUser[
                                                                            index]
                                                                        ['uid'])
                                                                    .collection(
                                                                        "presence")
                                                                    .doc(
                                                                        todayDocId)
                                                                    .snapshots(),
                                                                builder: (context,
                                                                    snapshotUser) {
                                                                  var pp;
                                                                  switch (snapshot
                                                                      .connectionState) {
                                                                    case ConnectionState
                                                                        .waiting:
                                                                      return Center(
                                                                          child:
                                                                              CircularProgressIndicator(
                                                                        color: AppColor
                                                                            .navigationColor,
                                                                      ));
                                                                    case ConnectionState
                                                                        .active:
                                                                    case ConnectionState
                                                                        .done:
                                                                      if (snapshotUser
                                                                              .data !=
                                                                          null) {
                                                                        var pp = snapshotUser
                                                                            .data
                                                                            .data();
                                                                        return TodayTile(
                                                                          karyawanData:
                                                                              user,
                                                                          presenceData:
                                                                              pp,
                                                                        );
                                                                        // return Column(
                                                                        //   mainAxisAlignment:
                                                                        //       MainAxisAlignment.start,
                                                                        //   crossAxisAlignment:
                                                                        //       CrossAxisAlignment.start,
                                                                        //   children: [
                                                                        //     Text(allUser[index]['name'].toString()),
                                                                        //     Text("Masuk : ${snapshotUser.data['masuk']['date']}"),
                                                                        //     pp['keluar'] == null
                                                                        //         ? Text("Keluar : -")
                                                                        //         : Text("Keluar : ${snapshotUser.data['keluar']['date']}"),
                                                                        //   ],
                                                                        // );
                                                                      } else {
                                                                        return SizedBox();
                                                                      }
                                                                      return null;
                                                                    default:
                                                                      return SizedBox();
                                                                  }
                                                                }),
                                                          ],
                                                        );
                                                      },
                                                    ),
                                                  ),
                                                ],
                                              );
                                            default:
                                              return SizedBox();
                                          }
                                        }),
                                  ],
                                )
                              : StreamBuilder<QuerySnapshot>(
                                  stream: controller.streamLastPresence(),
                                  builder: (context, snapshot) {
                                    switch (snapshot.connectionState) {
                                      case ConnectionState.waiting:
                                        return Center(
                                            child: CircularProgressIndicator(
                                          color: AppColor.navigationColor,
                                        ));
                                      case ConnectionState.active:
                                      case ConnectionState.done:
                                        List<QueryDocumentSnapshot>
                                            listPresence = snapshot.data?.docs;

                                        return ListView.separated(
                                          // itemCount: snapshot.data.docs.length > 0
                                          //     ? snapshot.data.docs.length
                                          //     : 0,
                                          itemCount: snapshot.data.docs.length,
                                          shrinkWrap: true,
                                          physics:
                                              NeverScrollableScrollPhysics(),
                                          padding: EdgeInsets.zero,
                                          separatorBuilder: (context, index) =>
                                              SizedBox(height: 16),
                                          itemBuilder: (context, index) {
                                            Map<String, dynamic> presenceData =
                                                listPresence[index].data();
                                            return PresenceTile(
                                              presenceData: presenceData,
                                            );
                                          },
                                        );
                                      default:
                                        return SizedBox();
                                    }
                                  }),
                        ],
                      ),
                    ),
                  ),
                ],
              );

            case ConnectionState.waiting:
              return Center(
                  child: CircularProgressIndicator(
                      color: AppColor.navigationColor));
            default:
              return Center(child: Text("Error"));
          }
        });
  }
}
