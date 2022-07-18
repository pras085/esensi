// ignore_for_file: deprecated_member_use

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:launch_review/launch_review.dart';
import 'package:presence/app/controllers/page_index_controller.dart';
import 'package:presence/app/routes/app_pages.dart';
import 'package:presence/app/style/app_color.dart';
import 'package:presence/app/widgets/custom_bottom_navigation_bar.dart';
import 'package:presence/app/widgets/dialog/custom_alert_dialog.dart';
import 'package:presence/app/widgets/profile_list_item.dart';
import 'package:url_launcher/url_launcher.dart';

import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  final pageIndexController = Get.find<PageIndexController>();
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: Scaffold(
          backgroundColor: AppColor.secondaryExtraSoft,
          extendBody: true,
          bottomNavigationBar: CustomBottomNavigationBar(),
          body: StreamBuilder<DocumentSnapshot>(
            stream: controller.streamUser(),
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                  return Center(
                      child: CircularProgressIndicator(
                          color: AppColor.navigationColor));
                case ConnectionState.active:
                case ConnectionState.done:
                  Map<String, dynamic> userData = snapshot.data.data();
                  return ListView(
                    shrinkWrap: true,
                    physics: BouncingScrollPhysics(),
                    padding: EdgeInsets.symmetric(vertical: 36),
                    children: [
                      SizedBox(height: 16),
                      // section 1 - profile
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          ClipOval(
                            // clipBehavior: Clip.antiAlias,
                            child: Container(
                              width: Get.width / 3,
                              height: Get.height / 7,
                              decoration: BoxDecoration(
                                border: Border.all(
                                    width: 6, color: AppColor.backgroundColor),
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                    image: NetworkImage(
                                      (userData["avatar"] == null ||
                                              userData['avatar'] == "")
                                          ? "https://ui-avatars.com/api/?name=${userData['name']}/"
                                          : userData['avatar'],
                                    ),
                                    fit: BoxFit.cover),
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 16),
                            child: Text(
                              userData["name"],
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Text(
                            userData["job"],
                            style: TextStyle(color: AppColor.secondarySoft),
                          ),
                        ],
                      ),
                      // section 2 - menu
                      Container(
                        width: MediaQuery.of(context).size.width,
                        margin: EdgeInsets.only(top: 35),
                        child: Column(
                          children: [
                            (userData["role"] == "admin")
                                ? GestureDetector(
                                    onTap: () =>
                                        Get.toNamed(Routes.DAFTAR_KARYAWAN),
                                    child: ProfileListItem(
                                      icon: Icons.person_add_alt_1,
                                      text: 'Daftar Karyawan',
                                    ),
                                  )
                                : SizedBox(),
                            Divider(thickness: 1),
                            GestureDetector(
                              onTap: () => Get.toNamed(Routes.UPDATE_POFILE,
                                  arguments: userData),
                              child: ProfileListItem(
                                icon: Icons.perm_contact_cal,
                                text: 'Update Profil',
                              ),
                            ),
                            Divider(thickness: 1),
                            GestureDetector(
                              onTap: () {
                                Get.toNamed(Routes.INFO_APP);
                              },
                              child: ProfileListItem(
                                icon: Icons.info,
                                text: 'Tentang Aplikasi',
                              ),
                            ),
                            Divider(thickness: 1),
                            GestureDetector(
                              onTap: () {
                                CustomAlertDialog.showPresenceAlert(
                                    onCancel: () => Get.back(),
                                    onConfirm: () => controller.logout(),
                                    title: 'Konfirmasi',
                                    message: 'Yakin ingin keluar ?');
                              },
                              child: ProfileListItem(
                                icon: Icons.logout,
                                text: 'Keluar',
                              ),
                            ),
                            Divider(thickness: 1),
                            SizedBox(
                              height: 25,
                            )
                          ],
                        ),
                      ),
                    ],
                  );
                default:
                  return SizedBox();
              }
            },
          ),
        ));
  }
}

void openWA() async {
  var noWA = "+6285737777778";
  var waURL = "whatsapp://send?phone=" + noWA + "&text=Hallo";
  if (await canLaunch(waURL)) {
    await launch(waURL);
  } else {
    Get.snackbar('Error', 'Anda belum menginstall WhatsApp');
  }
}

class MenuTile extends StatelessWidget {
  final String title;
  final Widget icon;
  final void Function() onTap;
  final bool isDanger;
  MenuTile({
    this.title,
    this.icon,
    this.onTap,
    this.isDanger = false,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(
              color: AppColor.secondaryExtraSoft,
              width: 1,
            ),
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 42,
              height: 42,
              margin: EdgeInsets.only(right: 24),
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: AppColor.primaryExtraSoft,
                borderRadius: BorderRadius.circular(100),
              ),
              child: icon,
            ),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color:
                      (isDanger == false) ? AppColor.secondary : AppColor.error,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 24),
              child: SvgPicture.asset(
                'assets/icons/arrow-right.svg',
                color:
                    (isDanger == false) ? AppColor.secondary : AppColor.error,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
