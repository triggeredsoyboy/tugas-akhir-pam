import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as uploadPic;

class UpdateProfileController extends GetxController {
  RxBool isLoading = false.obs;
  TextEditingController nameCon = TextEditingController();
  TextEditingController addressCon = TextEditingController();
  TextEditingController emailCon = TextEditingController();

  FirebaseFirestore firestore = FirebaseFirestore.instance;
  uploadPic.FirebaseStorage storage = uploadPic.FirebaseStorage.instance;

  final ImagePicker picker = ImagePicker();
  XFile? image;

  void pickImage() async {
    image = await picker.pickImage(source: ImageSource.gallery);
    update();
  }

  Future<void> updateProfile(String uid) async {
    if (nameCon.text.isNotEmpty && addressCon.text.isNotEmpty) {
      isLoading.value = true;
      try {
        Map<String, dynamic> data = {
          "name": nameCon.text,
          "address": addressCon.text,
        };
        if (image != null) {
          File file = File(image!.path);
          String ext = image!.name.split(".").last;
          await storage.ref('$uid/picture.$ext').putFile(file);
          String urlImage =
              await storage.ref('$uid/picture.$ext').getDownloadURL();
          data.addAll({"picture": urlImage});
        }
        await firestore.collection("user").doc(uid).update(data);
        image = null;
        Get.snackbar("Yeay!", "Profile berhasil diubah");
      } catch (e) {
        Get.snackbar("Yah :(", "Tidak bisa ubah profil");
      } finally {
        isLoading.value = false;
      }
    }
  }

  void deleteProfile(String uid) async {
    try {
      await firestore.collection("user").doc(uid).update({
        "profile": FieldValue.delete(),
      });
      Get.back();
      Get.snackbar("Yeay!", "Foto berhasil dihapus");
    } catch (e) {
      Get.snackbar("Yah :(", "Tidak dapat menghapus foto");
    } finally {
      update();
    }
  }
}
