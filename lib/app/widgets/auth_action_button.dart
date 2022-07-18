import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:presence/app/controllers/page_index_controller.dart';
import 'package:presence/app/controllers/presence_controller.dart';
import 'package:presence/app/modules/home/controllers/home_controller.dart';
import 'package:presence/app/routes/app_pages.dart';
import 'package:presence/app/services/database_services.dart';
import 'package:presence/app/services/facenet_services.dart';
import 'package:presence/app/services/shared_preferences.dart';
import 'package:presence/app/style/app_color.dart';

import 'dialog/custom_alert_dialog.dart';
import 'toast/custom_toast.dart';

class AuthActionButton extends StatefulWidget {
  AuthActionButton(this._initializeControllerFuture,
      {Key key, @required this.onPressed, this.reload, this.isLogin});
  final Future _initializeControllerFuture;
  final Function onPressed;
  final bool isLogin;
  final Function reload;
  @override
  _AuthActionButtonState createState() => _AuthActionButtonState();
}

class _AuthActionButtonState extends State<AuthActionButton> {
  final presenceC = Get.find<PresenceController>();

  final homeC = Get.find<HomeController>();

  String auth = FirebaseAuth.instance.currentUser.uid;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  PageIndexController pageIndexC = Get.find<PageIndexController>();

  /// service injection
  final FaceNetService _faceNetService = FaceNetService();
  final DataBaseService _dataBaseService = DataBaseService();

  Future _signUp() async {
    /// gets predicted data from facenet service (user face detected)
    List modelData = _faceNetService.predictedData;

    /// creates a new user in the 'database'
    await _dataBaseService.saveData(auth, modelData);

    /// resets the face stored in the face net sevice
    this._faceNetService.setPredictedData(null);
  }

  Future _signIn() async {
    var userIdFromDb = _predictUser();
    if (this.auth == userIdFromDb) {
      return presenceC.presence();
    } else {
      // print('ABSEN GAGAL');
      await CustomToast.errorToast('Error', 'Wajah tidak dikenali  !');
      await Timer(Duration(seconds: 3), () {
        pageIndexC.changePage(0);
      });
      return null;
    }
  }

  String _predictUser() {
    String userData = _faceNetService.predict();
    print(userData);
    return userData ?? null;
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        try {
          // Ensure that the camera is initialized.
          await widget._initializeControllerFuture;
          // onShot event (takes the image and predict output)
          bool faceDetected = await widget.onPressed();
          print(faceDetected);
          if (faceDetected) {
            if (widget.isLogin) {
              var userAndPass = _predictUser();
            }
            if (widget.isLogin && auth != null) {
              CustomAlertDialog.showPresenceAlert(
                  title: 'Konfirmasi',
                  message: 'Yakin sudah tidak ada revisi ?',
                  onCancel: () {
                    pageIndexC.changePage(0);
                  },
                  onConfirm: () async {
                    Get.back();
                    Get.defaultDialog(
                      actions: null,
                      title: "Mohon Tunggu",
                      content: Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                    await _signIn();
                  });
            } else {
              CustomAlertDialog.showPresenceAlert(
                  title: 'Konfirmasi',
                  message: 'Yakin sudah tidak ada revisi ?',
                  onCancel: () {
                    Get.back();
                    Get.back();
                  },
                  onConfirm: () async {
                    Get.back();
                    Get.defaultDialog(
                      actions: null,
                      title: "Mohon Tunggu",
                      titleStyle: TextStyle(
                        fontFamily: 'poppins',
                        fontSize: 12,
                        color: AppColor.navigationColor,
                      ),
                      content: Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                    await _signUp();
                    PreferenceService.setFirst("untrue");
                    Get.offNamed(Routes.BRIDGE);
                  });
            }
            // PersistentBottomSheetController bottomSheetController =
            //     Scaffold.of(context).showBottomSheet((context) => signSheet());

            // bottomSheetController.closed.whenComplete(() => widget.reload());
            // signSheet(context);
          }
        } catch (e) {
          // If an error occurs, log the error to the console.
          print(e);
        }
      },
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          // borderRadius: BorderRadius.circular(10),
          color: AppColor.backgroundColor,
          // boxShadow: <BoxShadow>[
          //   BoxShadow(
          //     color: Colors.blue.withOpacity(0.1),
          //     blurRadius: 1,
          //     offset: Offset(0, 2),
          //   ),
          // ],
        ),
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(vertical: 14, horizontal: 16),
        height: 60,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [Icon(Icons.photo_camera, color: Colors.white)],
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
