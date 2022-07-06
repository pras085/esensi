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
  // final pageIndexController = Get.find<PageIndexController>();
  final presenceC = Get.find<PresenceController>();

  final homeC = Get.find<HomeController>();

  String auth = FirebaseAuth.instance.currentUser.uid;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

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
    if (homeC.inRadius != false.obs) {
      if (this.auth == userIdFromDb) {
        await presenceC.presence();
      } else {
        print('ABSEN GAGAL');
        Get.snackbar('Terjadi Kesalahan', 'Wajah tidak dikenali',
            colorText: AppColor.whiteColor);
      }
    } else {
      Get.snackbar('Terjadi Kesalahan', 'Anda berada di luar radius kantor',
          colorText: AppColor.whiteColor);
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
                    Get.back();
                    Get.back();
                  },
                  onConfirm: () async {
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
                    await _signUp();
                    PreferenceService.setFirst("untrue");
                    Get.offNamed(Routes.HOME);
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
