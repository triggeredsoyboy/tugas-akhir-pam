import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RegisterController extends GetxController {
  RxBool isLoading = false.obs;
  TextEditingController nameCon = TextEditingController();
  TextEditingController addressCon = TextEditingController();
  TextEditingController emailCon = TextEditingController();
  TextEditingController passCon = TextEditingController();
  TextEditingController passAdminCon = TextEditingController();
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  // RxBool isLoadingAdmin = false.obs;

  Future<void> register() async {
    if (nameCon.text.isNotEmpty &&
        addressCon.text.isNotEmpty &&
        emailCon.text.isNotEmpty &&
        passCon.text.isNotEmpty) {
      isLoading.value = true;
      try {
        UserCredential userCredential =
            await auth.createUserWithEmailAndPassword(
          email: emailCon.text,
          password: passCon.text,
        );
        if (userCredential.user != null) {
          String uid = userCredential.user!.uid;
          await firestore.collection("user").doc(uid).set({
            "uid": uid,
            "name": nameCon.text,
            "address": addressCon.text,
            "email": emailCon.text,
            "password": passCon.text.hashCode,
            "createdAt": DateTime.now().toIso8601String(),
          });
          await userCredential.user!.sendEmailVerification();
          await auth.signOut();
          Get.back();
          Get.snackbar(
              "Yeay! Berhasil mendaftar akun.", "Cek email kamu sekarang.");
        }
        isLoading.value = false;
      } on FirebaseAuthException catch (e) {
        isLoading.value = false;
        if (e.code == 'weak-password') {
          Get.snackbar("Ups!", "Password terlalu lemah.");
        } else if (e.code == 'email-already-in-use') {
          Get.snackbar("Ups!", "Email sudah digunakan.");
        } else {
          Get.snackbar("Error", "${e.code}");
        }
      } catch (e) {
        isLoading.value = false;
        Get.snackbar("Yah :(", "Tidak bisa mendaftar akun.");
      }
    } else {
      isLoading.value = false;
      Get.snackbar("Ups!", "Form harus diisi!");
    }
  }

  // Future<void> register() async {
  //   if (nameCon.text.isNotEmpty &&
  //       addressCon.text.isNotEmpty &&
  //       emailCon.text.isNotEmpty &&
  //       passCon.text.isNotEmpty) {
  //     isLoading.value = true;
  //     Get.defaultDialog(
  //       title: "Admin Validate",
  //       content: Column(
  //         children: [
  //           Text("Enter your admin validation password"),
  //           SizedBox(height: 10),
  //           TextField(
  //             obscureText: true,
  //             controller: passAdminCon,
  //             decoration: InputDecoration(
  //               labelText: "Enter password",
  //               border: OutlineInputBorder(),
  //             ),
  //           ),
  //         ],
  //       ),
  //       actions: [
  //         OutlinedButton(
  //           onPressed: () {
  //             isLoading.value = false;
  //             Get.back();
  //           },
  //           child: Text("Cancel"),
  //         ),
  //         Obx(
  //           () => ElevatedButton(
  //             onPressed: () async {
  //               if (isLoadingAdmin.isFalse) {
  //                 await registerProcess();
  //               }
  //               isLoading.value = false;
  //             },
  //             child: Text(
  //                 isLoadingAdmin.isFalse ? "Add Mahasiswa" : "Please wait ..."),
  //           ),
  //         ),
  //       ],
  //     );
  //   } else {
  //     Get.snackbar("Error", "NIM, nama, dan email harus diisi.");
  //   }
  // }
}
