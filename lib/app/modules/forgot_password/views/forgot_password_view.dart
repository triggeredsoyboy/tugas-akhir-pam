import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:my_presence/app/constants/button.dart';

import '../../../constants/size_config.dart';
import '../controllers/forgot_password_controller.dart';

class ForgotPasswordView extends GetView<ForgotPasswordController> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Reset Password'),
      ),
      body: ListView(
        padding: EdgeInsets.all(20),
        children: [
          TextField(
            controller: controller.emailCon,
            decoration: InputDecoration(
              labelText: "Email",
              hintText: "Masukkan email",
            ),
          ),
          SizedBox(height: 20),
          Obx(
            () => DefaultButton(
              press: () {
                if (controller.isLoading.isFalse) {
                  controller.sendEmail();
                }
              },
              text: controller.isLoading.isFalse
                  ? "Reset Password"
                  : "Mohon tunggu...",
            ),
          ),
        ],
      ),
    );
  }
}
