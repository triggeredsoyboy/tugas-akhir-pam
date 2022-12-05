import 'dart:io';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:my_presence/app/constants/button.dart';

import '../../../constants/size_config.dart';
import '../controllers/update_profile_controller.dart';

class UpdateProfileView extends GetView<UpdateProfileController> {
  final Map<String, dynamic> user = Get.arguments;
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    controller.nameCon.text = user["name"];
    controller.addressCon.text = user["address"];
    controller.emailCon.text = user["email"];
    return Scaffold(
      appBar: AppBar(
        title: Text('Update Profil'),
        centerTitle: true,
      ),
      body: ListView(
        padding: EdgeInsets.all(20),
        children: [
          TextField(
            controller: controller.nameCon,
            decoration: InputDecoration(
              labelText: "Nama",
            ),
          ),
          SizedBox(height: 20),
          TextField(
            controller: controller.addressCon,
            decoration: InputDecoration(
              labelText: "Alamat",
            ),
          ),
          SizedBox(height: 20),
          TextField(
            enabled: false,
            controller: controller.emailCon,
            decoration: InputDecoration(
              labelText: "Email",
            ),
          ),
          SizedBox(height: 20),
          Text(
            "Foto Profil",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 15,
            ),
          ),
          SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GetBuilder<UpdateProfileController>(
                builder: (c) {
                  if (c.image != null) {
                    return ClipOval(
                      child: Container(
                        height: 100,
                        width: 100,
                        child: Image.file(
                          File(c.image!.path),
                          fit: BoxFit.cover,
                        ),
                      ),
                    );
                  } else {
                    if (user["picture"] != null) {
                      return Column(
                        children: [
                          ClipOval(
                            child: Container(
                              height: 100,
                              width: 100,
                              child: Image.network(
                                user["picture"],
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              controller.deleteProfile(user["uid"]);
                            },
                            child: Text("Hapus foto"),
                          ),
                        ],
                      );
                    } else {
                      return Text("Belum ada foto");
                    }
                  }
                },
              ),
              TextButton(
                onPressed: () {
                  controller.pickImage();
                },
                child: Text("Pilih gambar"),
              ),
            ],
          ),
          SizedBox(height: 20),
          Obx(
            () => DefaultButton(
              press: () async {
                if (controller.isLoading.isFalse) {
                  await controller.updateProfile(user["uid"]);
                }
              },
              text: controller.isLoading.isFalse
                  ? "Update Profil"
                  : "Mohon tunggu...",
            ),
          ),
        ],
      ),
    );
  }
}
