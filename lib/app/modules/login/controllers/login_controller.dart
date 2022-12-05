import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_presence/app/routes/app_pages.dart';

class LoginController extends GetxController {
  RxBool isLoading = false.obs;
  TextEditingController emailCon = TextEditingController();
  TextEditingController passwordCon = TextEditingController();

  FirebaseAuth auth = FirebaseAuth.instance;

  Future<void> login() async {
    if (emailCon.text.isNotEmpty && passwordCon.text.isNotEmpty) {
      isLoading.value = true;
      try {
        UserCredential userCredential = await auth.signInWithEmailAndPassword(
          email: emailCon.text,
          password: passwordCon.text,
        );

        if (userCredential.user != null) {
          if (userCredential.user!.emailVerified == true) {
            isLoading.value = false;
            Get.offAllNamed(Routes.HOME);
          } else {
            Get.defaultDialog(
              title: "Akun belum terverifikasi",
              middleText:
                  "Kamu belum verifikasi akun ini.\nCek kotak masuk pada email kamu untuk proses verifikasi",
              actions: [
                OutlinedButton(
                  onPressed: () {
                    isLoading.value = false;
                    Get.back();
                  },
                  child: Text("Oke"),
                ),
                ElevatedButton(
                  onPressed: () async {
                    try {
                      await userCredential.user!.sendEmailVerification();
                      Get.back();
                      Get.snackbar(
                          "Yeay!", "Email terkirim, cek kotak masuk kamu.");
                      isLoading.value = false;
                    } catch (e) {
                      isLoading.value = false;
                      Get.snackbar("Yah :(", "Tidak bisa mengirim email");
                    }
                  },
                  child: Text("Kirim email"),
                ),
              ],
            );
          }
        }
        isLoading.value = false;
      } on FirebaseAuthException catch (e) {
        isLoading.value = false;
        if (e.code == 'user-not-found') {
          Get.snackbar("Ups!", "Pengguna tidak ditemukan");
        } else if (e.code == 'wrong-password') {
          Get.snackbar("Ups!", "Password salah");
        }
      } catch (e) {
        Get.snackbar("Error", "Cannot login.");
        isLoading.value = false;
      }
    } else {
      Get.snackbar("Ups!", "Email dan password harus diisi!");
    }
  }
}
