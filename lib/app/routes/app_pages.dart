import 'package:camera_platform_interface/src/types/camera_description.dart';
import 'package:get/get.dart';

import 'package:presence/app/modules/bridge/bindings/bridge_binding.dart';
import 'package:presence/app/modules/bridge/views/bridge_view.dart';
import 'package:presence/app/modules/daftar_karyawan/bindings/daftar_karyawan_binding.dart';
import 'package:presence/app/modules/daftar_karyawan/views/daftar_karyawan_view.dart';
import 'package:presence/app/modules/detail_perizinan/views/detail_perizinan_view.dart';
import 'package:presence/app/modules/perizinan_admin/views/perizinan_admin_view.dart';
import 'package:presence/app/modules/presensi_today/bindings/presensi_today_binding.dart';
import 'package:presence/app/modules/presensi_today/views/presensi_today_view.dart';
import 'package:presence/app/modules/riwayat_perizinan/bindings/riwayat_perizinan_binding.dart';
import 'package:presence/app/modules/riwayat_perizinan/views/riwayat_perizinan_view.dart';
import 'package:presence/app/modules/tamba_perizinan/bindings/tamba_perizinan_binding.dart';
import 'package:presence/app/modules/tamba_perizinan/views/tamba_perizinan_view.dart';

import '../modules/add_employee/bindings/add_employee_binding.dart';
import '../modules/add_employee/views/add_employee_view.dart';
import '../modules/all_presence/bindings/all_presence_binding.dart';
import '../modules/all_presence/views/all_presence_view.dart';
import '../modules/change_password/bindings/change_password_binding.dart';
import '../modules/change_password/views/change_password_view.dart';
import '../modules/detail_presence/bindings/detail_presence_binding.dart';
import '../modules/detail_presence/views/detail_presence_view.dart';
import '../modules/forgot_password/bindings/forgot_password_binding.dart';
import '../modules/forgot_password/views/forgot_password_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/new_password/bindings/new_password_binding.dart';
import '../modules/new_password/views/new_password_view.dart';
import '../modules/onboard/bindings/onboard_binding.dart';
import '../modules/onboard/views/onboard_view.dart';
import '../modules/perizinan/bindings/perizinan_binding.dart';
import '../modules/perizinan/views/perizinan_view.dart';
import '../modules/perizinan_admin/bindings/perizinan_admin_binding.dart';
import '../modules/presence/views/presence_view.dart';
import '../modules/profile/bindings/profile_binding.dart';
import '../modules/profile/views/profile_view.dart';
import '../modules/sign-up/views/sign_up_view.dart';
import '../modules/update_pofile/bindings/update_pofile_binding.dart';
import '../modules/update_pofile/views/update_pofile_view.dart';

part 'app_routes.dart';

CameraDescription cameraDescription;

class AppPages {
  AppPages._();

  static const INITIAL = Routes.BRIDGE;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.NEW_PASSWORD,
      page: () => NewPasswordView(),
      binding: NewPasswordBinding(),
    ),
    GetPage(
      name: _Paths.FORGOT_PASSWORD,
      page: () => ForgotPasswordView(),
      binding: ForgotPasswordBinding(),
    ),
    GetPage(
      name: _Paths.PROFILE,
      page: () => ProfileView(),
      binding: ProfileBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: _Paths.UPDATE_POFILE,
      page: () => UpdatePofileView(),
      binding: UpdatePofileBinding(),
    ),
    GetPage(
      name: _Paths.DETAIL_PRESENCE,
      page: () => DetailPresenceView(),
      binding: DetailPresenceBinding(),
    ),
    GetPage(
      name: _Paths.DETAIL_PERIZINAN,
      page: () => DetailPerizinanView(),
      binding: DetailPresenceBinding(),
    ),
    GetPage(
      name: _Paths.ADD_EMPLOYEE,
      page: () => AddEmployeeView(),
      binding: AddEmployeeBinding(),
    ),
    GetPage(
      name: _Paths.CHANGE_PASSWORD,
      page: () => ChangePasswordView(),
      binding: ChangePasswordBinding(),
    ),
    GetPage(
      name: _Paths.ALL_PRESENCE,
      page: () => AllPresenceView(),
      binding: AllPresenceBinding(),
    ),
    GetPage(
      name: _Paths.ONBOARD,
      page: () => OnboardView(),
      binding: OnboardBinding(),
    ),
    GetPage(
      name: _Paths.SIGN_UP,
      page: () => SignUpView(cameraDescription: cameraDescription),
    ),
    GetPage(
      name: _Paths.PRESENCE,
      page: () => PresenceView(
        cameraDescription: cameraDescription,
      ),
    ),
    GetPage(
      name: _Paths.PERIZINAN,
      page: () => PerizinanView(),
      binding: PerizinanBinding(),
    ),
    GetPage(
      name: _Paths.PERIZINAN_ADMIN,
      page: () => PerizinanAdminView(),
      binding: PerizinanAdminBinding(),
    ),
    GetPage(
      name: _Paths.BRIDGE,
      page: () => BridgeView(),
      binding: BridgeBinding(),
    ),
    GetPage(
      name: _Paths.PRESENSI_TODAY,
      page: () => PresensiTodayView(),
      binding: PresensiTodayBinding(),
    ),
    GetPage(
      name: _Paths.RIWAYAT_PERIZINAN,
      page: () => RiwayatPerizinanView(),
      binding: RiwayatPerizinanBinding(),
    ),
    GetPage(
      name: _Paths.DAFTAR_KARYAWAN,
      page: () => DaftarKaryawanView(),
      binding: DaftarKaryawanBinding(),
    ),
    GetPage(
      name: _Paths.TAMBA_PERIZINAN,
      page: () => TambaPerizinanView(),
      binding: TambaPerizinanBinding(),
    ),
  ];
}
