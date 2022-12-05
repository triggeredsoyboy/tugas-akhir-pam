import 'package:get/get.dart';

import 'package:my_presence/app/modules/forgot_password/bindings/forgot_password_binding.dart';
import 'package:my_presence/app/modules/forgot_password/views/forgot_password_view.dart';
import 'package:my_presence/app/modules/home/bindings/home_binding.dart';
import 'package:my_presence/app/modules/home/views/home_view.dart';
import 'package:my_presence/app/modules/login/bindings/login_binding.dart';
import 'package:my_presence/app/modules/login/views/login_view.dart';
import 'package:my_presence/app/modules/new_password/bindings/new_password_binding.dart';
import 'package:my_presence/app/modules/new_password/views/new_password_view.dart';
import 'package:my_presence/app/modules/profile/bindings/profile_binding.dart';
import 'package:my_presence/app/modules/profile/views/profile_view.dart';
import 'package:my_presence/app/modules/register/bindings/register_binding.dart';
import 'package:my_presence/app/modules/register/views/register_view.dart';
import 'package:my_presence/app/modules/update_password/bindings/update_password_binding.dart';
import 'package:my_presence/app/modules/update_password/views/update_password_view.dart';
import 'package:my_presence/app/modules/update_profile/bindings/update_profile_binding.dart';
import 'package:my_presence/app/modules/update_profile/views/update_profile_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: _Paths.REGISTER,
      page: () => RegisterView(),
      binding: RegisterBinding(),
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
      name: _Paths.UPDATE_PROFILE,
      page: () => UpdateProfileView(),
      binding: UpdateProfileBinding(),
    ),
    GetPage(
      name: _Paths.UPDATE_PASSWORD,
      page: () => UpdatePasswordView(),
      binding: UpdatePasswordBinding(),
    ),
  ];
}
