import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:presence/app/style/app_color.dart';
import 'package:presence/app/widgets/custom_input.dart';

import '../controllers/add_employee_controller.dart';

class AddEmployeeView extends GetView<AddEmployeeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Tambah Karyawan',
          style: TextStyle(
            color: AppColor.whiteColor,
            fontSize: 16,
            fontFamily: 'poppins',
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: SvgPicture.asset(
            'assets/icons/arrow-left.svg',
            color: AppColor.whiteColor,
          ),
        ),
        backgroundColor: AppColor.navigationColor,
        elevation: 0,
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(1),
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: 1,
            color: AppColor.secondaryExtraSoft,
          ),
        ),
      ),
      body: ListView(
        shrinkWrap: true,
        physics: BouncingScrollPhysics(),
        padding: EdgeInsets.all(20),
        children: [
          CustomInput(
            controller: controller.idC,
            label: 'ID Karyawan',
            hint: '201',
          ),
          CustomInput(
            controller: controller.nameC,
            label: 'Nama Lengkap',
            hint: 'Syoifudin Makmur',
          ),
          CustomInput(
            controller: controller.emailC,
            label: 'Email',
            hint: 'youremail@email.com',
          ),
          CustomInput(
            controller: controller.jobC,
            label: 'Jabatan',
            hint: 'IT',
          ),
          SizedBox(height: 8),
          Container(
            width: MediaQuery.of(context).size.width,
            child: Obx(
              () => ElevatedButton(
                onPressed: () {
                  if (controller.isLoading.isFalse) {
                    controller.addEmployee();
                  }
                },
                child: Text(
                  (controller.isLoading.isFalse) ? 'Tambah' : 'Loading...',
                  style: TextStyle(
                    fontSize: 14,
                    fontFamily: 'poppins',
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  primary: AppColor.primary,
                  padding: EdgeInsets.symmetric(vertical: 18),
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
