import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:presence/app/controllers/page_index_controller.dart';
import 'package:presence/app/style/app_color.dart';

class CustomBottomNavigationBar extends GetView<PageIndexController> {
  final Map<String, dynamic> user;

  CustomBottomNavigationBar(this.user);

  @override
  Widget build(BuildContext context) {
    // log(user['role']);
    return Container(
        height: 97,
        width: MediaQuery.of(context).size.width,
        color: Colors.transparent,
        child: Obx(
          () => Stack(
            alignment: new FractionalOffset(.5, 1.0),
            children: [
              Positioned(
                bottom: 0,
                child: Container(
                  height: 65,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    border: Border(
                      top: BorderSide(
                          color: AppColor.secondaryExtraSoft, width: 1),
                    ),
                  ),
                  child: BottomAppBar(
                    color: AppColor.navigationColor,
                    shape: CircularNotchedRectangle(),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Expanded(
                          child: InkWell(
                            onTap: () => controller.changePage(0),
                            child: Container(
                              height: 65,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    child: (controller.pageIndex.value == 0)
                                        ? SvgPicture.asset(
                                            'assets/icons/home-active.svg',
                                            color: AppColor.primary,
                                          )
                                        : SvgPicture.asset(
                                            'assets/icons/home.svg',
                                            color: AppColor.whiteColor,
                                          ),
                                    margin: EdgeInsets.only(bottom: 4),
                                  ),
                                  Text("Home",
                                      style: controller.pageIndex.value == 0
                                          ? TextStyle(
                                              fontSize: 10,
                                              fontWeight: FontWeight.bold,
                                              color: AppColor.primary,
                                            )
                                          : TextStyle(
                                              fontSize: 10,
                                              color: AppColor.whiteColor,
                                            )),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width / 4,
                          margin: EdgeInsets.only(top: 24),
                          alignment: Alignment.center,
                        ),
                        Expanded(
                          child: InkWell(
                            onTap: () => controller.changePage(2),
                            child: Container(
                              height: 65,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    child: (controller.pageIndex.value == 2)
                                        ? SvgPicture.asset(
                                            'assets/icons/profile-active.svg',
                                            color: AppColor.primary,
                                          )
                                        : SvgPicture.asset(
                                            'assets/icons/profile.svg',
                                            color: AppColor.whiteColor,
                                          ),
                                    margin: EdgeInsets.only(bottom: 4),
                                  ),
                                  Text("Profile",
                                      style: controller.pageIndex.value == 2
                                          ? TextStyle(
                                              fontSize: 10,
                                              fontWeight: FontWeight.bold,
                                              color: AppColor.primary,
                                            )
                                          : TextStyle(
                                              fontSize: 10,
                                              color: AppColor.whiteColor,
                                            )),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              if (controller.role.value != "admin")
                Positioned(
                    bottom: 32,
                    child: Obx(
                      () => SizedBox(
                        width: 64,
                        height: 64,
                        child: FloatingActionButton(
                          backgroundColor: AppColor.primary,
                          onPressed: () => controller.changePage(1),
                          elevation: 0,
                          child:
                              (controller.presenceController.isLoading.isFalse)
                                  ? Icon(
                                      Icons.camera_alt,
                                      size: 30,
                                    )
                                  : Center(
                                      child: CircularProgressIndicator(
                                        color: Colors.white,
                                      ),
                                    ),
                        ),
                      ),
                    ))
            ],
          ),
        ));
  }
}
