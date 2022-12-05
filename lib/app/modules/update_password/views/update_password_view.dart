import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:my_presence/app/constants/button.dart';

import '../../../constants/size_config.dart';
import '../controllers/update_password_controller.dart';

class UpdatePasswordView extends GetView<UpdatePasswordController> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Ganti Password'),
      ),
      body: Center(
        child: ListView(
          padding: EdgeInsets.all(20),
          children: [
            TextField(
              controller: controller.currentCon,
              obscureText: true,
              decoration: InputDecoration(
                labelText: "Password Sekarang",
                hintText: "Masukkan password lama",
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: controller.newPassCon,
              obscureText: true,
              decoration: InputDecoration(
                labelText: "Password Baru",
                hintText: "Buat password baru",
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: controller.confNewPassCon,
              obscureText: true,
              decoration: InputDecoration(
                labelText: "Konfirmasi Password Baru",
                hintText: "Konfirmasi password baru",
              ),
            ),
            SizedBox(height: 20),
            Obx(
              () => DefaultButton(
                press: () {
                  if (controller.isLoading.isFalse) {
                    controller.updatePassword();
                  }
                },
                text: controller.isLoading.isFalse
                    ? "Ganti Password"
                    : "Mohon tunggu...",
              ),
            ),
          ],
        ),
      ),
    );
  }
}
