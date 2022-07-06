import 'package:camera/camera.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:presence/app/controllers/presence_controller.dart';
import 'package:presence/app/modules/home/controllers/home_controller.dart';
import 'package:presence/app/modules/presence/views/presence_view.dart';
import 'package:presence/app/routes/app_pages.dart';
import 'package:presence/app/services/database_services.dart';
import 'package:presence/app/services/facenet_services.dart';
import 'package:presence/app/services/ml_kit_services.dart';
import 'package:presence/app/widgets/toast/custom_toast.dart';

class PageIndexController extends GetxController {
  PresenceController presenceController = Get.find();
  HomeController homeC = Get.put(HomeController(), permanent: true);
  RxInt pageIndex = 0.obs;
  RxBool isLoading = false.obs;
  final FaceNetService _faceNetService = FaceNetService();
  final MLKitService _mlKitService = MLKitService();
  final DataBaseService _dataBaseService = DataBaseService();
  CameraDescription cameraDescription;

  bool loading = false;
  @override
  void onInit() async {
    super.onInit();
    await _startUp();
  }

  static Future<bool> todayExist() async {
    String auth = FirebaseAuth.instance.currentUser.uid;

    FirebaseFirestore firestore = FirebaseFirestore.instance;

    String todayDocId =
        DateFormat.yMd().format(DateTime.now()).replaceAll("/", "-");
    //Database
    CollectionReference presenceCollection =
        await firestore.collection("employee").doc(auth).collection("presence");
    DocumentSnapshot todayDoc = await presenceCollection.doc(todayDocId).get();

    if (todayDoc.exists) {
      Map<String, dynamic> dataPresenceToday = todayDoc.data();
      print(dataPresenceToday["keluar"]);
      if (dataPresenceToday["keluar"] != null) {
        return Future<bool>.value(true);
      } else {
        return Future<bool>.value(false);
      }
    } else {
      return Future<bool>.value(false);
    }
  }

  void changePage(int index) async {
    pageIndex.value = index;

    bool today = await todayExist();

    print(pageIndex);
    switch (index) {
      case 1:
        print('Presensi');
        if (homeC.inRadius.value == false) {
          CustomToast.errorToast('Error', 'Anda berada di luar jangkauan');
          break;
        }
        if (today) {
          CustomToast.successToast(
              "Success", "you already check in and check out");
        } else {
          Get.to(() => PresenceView(cameraDescription: cameraDescription));
        }
        // presenceController.presence();
        break;
      case 2:
        print('Profil');
        Get.offAllNamed(Routes.PROFILE);
        break;
      default:
        print('Home');
        Get.offAllNamed(Routes.HOME);
        break;
    }
  }

  _setLoading(bool value) {
    loading = value;
  }

  _startUp() async {
    _setLoading(true);
    List<CameraDescription> cameras = await availableCameras();

    /// takes the front camera
    cameraDescription = cameras.firstWhere(
      (CameraDescription camera) =>
          camera.lensDirection == CameraLensDirection.front,
    );

    // start the services
    await _faceNetService.loadModel();
    await _dataBaseService.loadDB();
    await _mlKitService.initialize();

    // shows or hides the circular progress indicator
    _setLoading(false);
  }
}
