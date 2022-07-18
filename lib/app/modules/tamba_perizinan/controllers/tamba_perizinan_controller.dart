import 'package:get/get.dart';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:presence/app/style/app_color.dart';
import 'package:presence/app/widgets/toast/custom_toast.dart';
import 'package:uuid/uuid.dart';

class TambaPerizinanController extends GetxController {
  String imagepath = "";
  final _picker = ImagePicker();
  var izinStatus = "waiting";

  TextEditingController alasanC = TextEditingController();
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  // s.FirebaseStorage storage = s.FirebaseStorage.instance;

  FirebaseAuth auth = FirebaseAuth.instance;
  @override
  void onInit() {
    super.onInit();
  }

  Future<void> pickCamera() async {
    final pickedImage =
        await _picker.pickImage(source: ImageSource.camera, imageQuality: 25);
    if (pickedImage != null) {
      imagepath = pickedImage.path;
      print(imagepath);
      update();
    }
  }

  Future<void> pickGallery() async {
    final pickedImage =
        await _picker.pickImage(source: ImageSource.gallery, imageQuality: 25);
    if (pickedImage != null) {
      imagepath = pickedImage.path;
      print(imagepath);
      update();
    }
  }

  Future<void> deleteData() async {
    imagepath = '';
    alasanC.clear();
    update();
  }

  Future<void> openImagePicker() async {
    Get.bottomSheet(
      Container(
        height: Get.height / 6,
        width: Get.width,
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        decoration: BoxDecoration(
          color: AppColor.whiteColor,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Pilih metode',
              style: TextStyle(
                fontFamily: 'poppins',
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 15),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Column(
                  children: [
                    GestureDetector(
                      onTap: () async {
                        // print('Camera');
                        await pickCamera();
                        Get.back();
                        // Get.back();
                      },
                      child: Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            color: AppColor.navigationColor,
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.circular(15)),
                        child: Icon(Icons.camera, color: AppColor.whiteColor),
                      ),
                    ),
                    Text(
                      'Kamera',
                      style: TextStyle(fontFamily: 'poppins', fontSize: 11),
                    )
                  ],
                ),
                SizedBox(
                  width: 20,
                ),
                Column(
                  children: [
                    GestureDetector(
                      onTap: () async {
                        // print('Galeri');
                        await pickGallery();
                        Get.back();
                        // Get.back();

                        // Get.back();
                      },
                      child: Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            color: AppColor.navigationColor,
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.circular(15)),
                        child:
                            Icon(Icons.photo_album, color: AppColor.whiteColor),
                      ),
                    ),
                    Text(
                      'Galeri',
                      style: TextStyle(fontFamily: 'poppins', fontSize: 11),
                    )
                  ],
                )
              ],
            ),
          ],
        ),
      ),
      isDismissible: false,
      enableDrag: true,
      // persistent: true,
    );
  }

  Future<void> uploadPerizinan() async {
    File imageFile = File(imagepath);
    if (imagepath != '' || alasanC.text.isEmpty) {
      print(imagepath);
      print(alasanC);

      Uint8List imagebytes = await imageFile.readAsBytes(); //convert to bytes
      String encImg = base64Encode(imagebytes); //convert bytes to base64 string
      String uid = auth.currentUser.uid;
      // String todayDocId =
      //     DateFormat.yMd().format(DateTime.now()).replaceAll("/", "-");
      var uuid = Uuid();
      var idIzin = (uuid.v4().toString());

      DocumentReference perizinanCol =
          await firestore.collection("perizinan").doc(idIzin);

      try {
        await perizinanCol.set({
          "uid": idIzin,
          "idUser": uid,
          "date": DateTime.now().toIso8601String(),
          "alasan": alasanC.text,
          "bukti_foto": encImg.toString(),
          "status": izinStatus.toString(),
        });
        Get.back();
        CustomToast.successToast('Success', 'Perizinan sedang diproses');
      } catch (e) {
        print(e);
        CustomToast.errorToast('Error', 'Tidak dapat melakukan perizinan');
      }
    } else {
      CustomToast.errorToast('Error', 'Harap masukan bukti foto');
    }
  }
}
