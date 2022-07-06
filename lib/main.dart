import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:presence/app/controllers/page_index_controller.dart';
import 'package:presence/app/style/app_color.dart';

import 'app/controllers/presence_controller.dart';
import 'app/routes/app_pages.dart';
import 'app/services/shared_preferences.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await PreferenceService.init();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await initializeDateFormatting('id_ID', null);
  // debugPaintSizeEnabled = true;
  runApp(
    StreamBuilder<User>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return MaterialApp(
            home: Scaffold(
              body: Center(
                child: CircularProgressIndicator(
                  color: AppColor.navigationColor,
                  value: 0.20,
                ),
              ),
            ),
          );
        }
        return GetMaterialApp(
          title: "ESensi",
          debugShowCheckedModeBanner: false,
          // initialRoute: snapshot.data != null ? Routes.HOME : Routes.LOGIN,
          getPages: AppPages.routes,
          // initialRoute: Routes.FORGOT_PASSWORD,
          initialRoute: PreferenceService.getFirst() != "untrue"
              ? Routes.ONBOARD
              : PreferenceService.getStatus() != "logged"
                  ? Routes.LOGIN
                  : Routes.BRIDGE,
          defaultTransition: Transition.cupertino,
          theme: ThemeData(
            scaffoldBackgroundColor: Colors.white,
            fontFamily: 'inter',
          ),
        );
      },
    ),
  );
}
