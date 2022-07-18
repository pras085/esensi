import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:presence/app/widgets/dialog/custom_alert_dialog.dart';
import 'package:presence/app/widgets/toast/custom_toast.dart';
import 'package:presence/company_data.dart';

class AddEmployeeController extends GetxController {
  @override
  onClose() {
    idC.dispose();
    nameC.dispose();
    emailC.dispose();
    adminPassC.dispose();
  }

  RxBool isLoading = false.obs;
  RxBool isLoadingCreatePegawai = false.obs;

  TextEditingController idC = TextEditingController();
  TextEditingController nameC = TextEditingController();
  TextEditingController emailC = TextEditingController();
  TextEditingController jobC = TextEditingController();
  TextEditingController adminPassC = TextEditingController();

  String selectedJabatan;

  // var jabatanChoose = ''.obs;
  var jabatanDataList = <String>['IT', 'Sales', 'Supervisor', 'Admin'];

  @override
  void onInit() {
    super.onInit();
  }

  void setSelected(String value) {
    selectedJabatan = value;
    update();
    log('$selectedJabatan');
    // changeJabatan(selectedJabatan);
  }
  //  changeJabatan(String jabatanChosen) {switch (selectedJabatan) {
  //    case 'IT':
  //      Get.updateLocale(l)
  //      break;
  //    default:
  //  }}

  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  String getDefaultPassword() {
    return CompanyData.defaultPassword;
  }

  String getDefaultRole() {
    return CompanyData.defaultRole;
  }

  Future<void> addEmployee() async {
    if (idC.text.isNotEmpty &&
        nameC.text.isNotEmpty &&
        emailC.text.isNotEmpty &&
        selectedJabatan.isNotEmpty) {
      isLoading.value = true;
      CustomAlertDialog.confirmAdmin(
        title: 'Konfirmasi Admin',
        message:
            'Masukan password admin agar sistem dapat melakukan konfirmasi',
        onCancel: () {
          isLoading.value = false;
          Get.back();
        },
        onConfirm: () async {
          if (isLoadingCreatePegawai.isFalse) {
            await createEmployeeData();
            isLoading.value = false;
          }
        },
        controller: adminPassC,
      );
    } else {
      isLoading.value = false;
      CustomToast.errorToast('Error', 'Semua form harus diisi');
    }
  }

  createEmployeeData() async {
    if (adminPassC.text.isNotEmpty) {
      isLoadingCreatePegawai.value = true;
      String adminEmail = auth.currentUser.email;
      try {
        //checking if the pass is match
        await auth.signInWithEmailAndPassword(
            email: adminEmail, password: adminPassC.text);
        //get default password
        String defaultPassword = getDefaultPassword();
        String defaultRole = getDefaultRole();
        // if the password is match, then continue the create user process
        UserCredential employeeCredential =
            await auth.createUserWithEmailAndPassword(
          email: emailC.text,
          password: defaultPassword,
        );

        if (employeeCredential.user != null) {
          String uid = employeeCredential.user.uid;
          DocumentReference employee =
              firestore.collection("employee").doc(uid);
          await employee.set({
            "employee_id": idC.text,
            "name": nameC.text,
            "email": emailC.text,
            "role": defaultRole,
            "job": selectedJabatan,
            "created_at": DateTime.now().toIso8601String(),
            "uid": uid,
          });

          await employeeCredential.user.sendEmailVerification();

          //need to logout because the current user is changed after adding new user
          auth.signOut();
          // need to relogin to admin account
          await auth.signInWithEmailAndPassword(
              email: adminEmail, password: adminPassC.text);

          // clear form

          Get.back(); //close dialog
          Get.back(); //close form screen
          CustomToast.successToast('Success', 'Sukses menambahkan karyawan');

          isLoadingCreatePegawai.value = false;
        }
      } on FirebaseAuthException catch (e) {
        isLoadingCreatePegawai.value = false;
        if (e.code == 'weak-password') {
          print('Password terlalu lemah .');
          CustomToast.errorToast('Error', 'Kata sandi terlalu lemah');
        } else if (e.code == 'email-already-in-use') {
          print('Akun sudah didaftarkan.');
          CustomToast.errorToast('Error', 'Akun sudah didaftarkan');
        } else if (e.code == 'wrong-password') {
          CustomToast.errorToast(
              'Error', 'Password admin yang diinputkan salah');
        } else {
          CustomToast.errorToast('Error', 'error : ${e.code}');
        }
      } catch (e) {
        isLoadingCreatePegawai.value = false;
        CustomToast.errorToast('Error', 'error : ${e.toString()}');
      }
    } else {
      CustomToast.errorToast('Error', 'Anda harus mengisi field password');
    }
  }
}
