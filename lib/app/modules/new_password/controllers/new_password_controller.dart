import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_presence/app/routes/app_pages.dart';

class NewPasswordController extends GetxController {
  TextEditingController newPasswordCon = TextEditingController();
  FirebaseAuth auth = FirebaseAuth.instance;

  void newPassword() async {
    if (newPasswordCon.text.isNotEmpty) {
      if (newPasswordCon.text != "password") {
        try {
          await auth.currentUser!.updatePassword(newPasswordCon.text);

          String email = auth.currentUser!.email!;

          await auth.signOut();

          await auth.signInWithEmailAndPassword(
            email: email,
            password: newPasswordCon.text,
          );

          Get.offAllNamed(Routes.HOME);
        } on FirebaseAuthException catch (e) {
          if (e.code == 'weak-password') {
            Get.snackbar("Error", "Password is too weak.");
          }
        } catch (e) {
          Get.snackbar("Error", "Cannot change password");
        }
      } else {
        Get.snackbar("Error", "Password must be changed");
      }
    } else {
      Get.snackbar("Error", "New password must be filled");
    }
  }
}
