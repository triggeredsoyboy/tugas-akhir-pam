import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ForgotPasswordController extends GetxController {
  RxBool isLoading = false.obs;
  TextEditingController emailCon = TextEditingController();

  FirebaseAuth auth = FirebaseAuth.instance;

  void sendEmail() async {
    if (emailCon.text.isNotEmpty) {
      isLoading.value = true;
      try {
        await auth.sendPasswordResetEmail(email: emailCon.text);
        Get.back();
        Get.snackbar("Success!", "Email terkirim.");
      } catch (e) {
        Get.snackbar("Yah :(", "Tidak bisa mengirim email.");
      } finally {
        isLoading.value = false;
      }
    } else {
      Get.snackbar("Ups!", "Form harus diisi!");
    }
  }
}
