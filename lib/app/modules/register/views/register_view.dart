import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:my_presence/app/constants/button.dart';

import '../../../constants/size_config.dart';
import '../controllers/register_controller.dart';

class RegisterView extends GetView<RegisterController> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Daftar'),
      ),
      body: ListView(
        padding: EdgeInsets.all(20),
        children: [
          TextField(
            controller: controller.nameCon,
            decoration: InputDecoration(
              labelText: "Nama",
              hintText: "Masukkan nama",
            ),
          ),
          SizedBox(height: 20),
          TextField(
            controller: controller.addressCon,
            decoration: InputDecoration(
              labelText: "Alamat",
              hintText: "Masukkan alamat rumah atau kantor",
            ),
          ),
          SizedBox(height: 20),
          TextField(
            controller: controller.emailCon,
            decoration: InputDecoration(
              labelText: "Email",
              hintText: "Masukkan email",
            ),
          ),
          SizedBox(height: 20),
          TextField(
            obscureText: true,
            controller: controller.passCon,
            decoration: InputDecoration(
              labelText: "Password",
              hintText: "Buat password",
            ),
          ),
          SizedBox(height: 20),
          Obx(
            () => DefaultButton(
              press: () async {
                if (controller.isLoading.isFalse) {
                  await controller.register();
                }
              },
              text: controller.isLoading.isFalse ? "Daftar" : "Mohon tunggu...",
            ),
          ),
        ],
      ),
    );
  }
}
