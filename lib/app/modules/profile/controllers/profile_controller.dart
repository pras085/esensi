import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:presence/app/routes/app_pages.dart';
import 'package:presence/app/services/shared_preferences.dart';
import 'package:presence/app/widgets/toast/custom_toast.dart';

class ProfileController extends GetxController {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Stream<DocumentSnapshot> streamUser() async* {
    print("called");
    String uid = auth.currentUser.uid;
    yield* firestore.collection("employee").doc(uid).snapshots();
  }

  Future<void> logout() async {
    await PreferenceService.setStatus("unlog");
    try {
      await auth.signOut().then((value) {
        Get.offAllNamed(Routes.LOGIN);
        dispose();
      });
    } catch (e) {
      CustomToast.errorToast('Error', 'Gagal logout .. ');
    }
    print(PreferenceService.getStatus().toString());
  }
}
