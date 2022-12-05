import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UpdatePasswordController extends GetxController {
  RxBool isLoading = false.obs;
  TextEditingController currentCon = TextEditingController();
  TextEditingController newPassCon = TextEditingController();
  TextEditingController confNewPassCon = TextEditingController();

  FirebaseAuth auth = FirebaseAuth.instance;

  void updatePassword() async {
    if (currentCon.text.isNotEmpty &&
        newPassCon.text.isNotEmpty &&
        confNewPassCon.text.isNotEmpty) {
      if (newPassCon.text == confNewPassCon.text) {
        isLoading.value = true;
        try {
          String emailUser = auth.currentUser!.email!;
          await auth.signInWithEmailAndPassword(
              email: emailUser, password: currentCon.text);
          await auth.currentUser!.updatePassword(newPassCon.text);
          Get.back();
          Get.snackbar("Yeay!", "Password berhasil diganti!");
        } on FirebaseAuthException catch (e) {
          if (e.code == "wrong-password") {
            Get.snackbar("Ups!", "Password salah!");
          } else {
            Get.snackbar("Error", "${e.code.toUpperCase()}");
          }
        } catch (e) {
          Get.snackbar("Yah :(", "Tidak bisa mengganti password");
        } finally {
          isLoading.value = false;
        }
      } else {
        Get.snackbar("Ups!", "Password tidak cocok!");
      }
    } else {
      Get.snackbar("Ups!", "Form harus diisi!");
    }
  }
}
