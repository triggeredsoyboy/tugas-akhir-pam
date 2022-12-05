import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_presence/app/routes/app_pages.dart';
import 'package:my_presence/app/constants/button.dart';
import 'package:my_presence/app/constants/size_config.dart';
import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: screenWidth(20)),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: SizeConfig.screenHeight * 0.02),
                Text(
                  "Selamat Datang",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: screenWidth(28),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text("Masuk dengan email dan password"),
                SizedBox(height: SizeConfig.screenHeight * 0.02),
                Image.asset(
                  "assets/images/login.gif",
                  width: screenWidth(260),
                  height: screenHeight(270),
                ),
                SizedBox(height: screenHeight(20)),
                TextField(
                  controller: controller.emailCon,
                  decoration: InputDecoration(
                    labelText: "Email",
                    hintText: "Masukkan email",
                  ),
                ),
                SizedBox(height: screenHeight(20)),
                TextField(
                  obscureText: true,
                  controller: controller.passwordCon,
                  decoration: InputDecoration(
                    labelText: "Password",
                    hintText: "Masukkan password",
                  ),
                ),
                SizedBox(height: screenHeight(20)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap: () => Get.toNamed(Routes.FORGOT_PASSWORD),
                      child: Text(
                        "Lupa Password?",
                        style: TextStyle(decoration: TextDecoration.underline),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: screenHeight(20)),
                Obx(
                  () => DefaultButton(
                    press: () async {
                      if (controller.isLoading.isFalse) {
                        await controller.login();
                      }
                    },
                    text: controller.isLoading.isFalse
                        ? "Masuk"
                        : "Mohon tunggu...",
                  ),
                ),
                TextButton(
                  onPressed: () => Get.toNamed(Routes.REGISTER),
                  child: Text("Daftar"),
                ),
                SizedBox(height: SizeConfig.screenHeight * 0.02),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
