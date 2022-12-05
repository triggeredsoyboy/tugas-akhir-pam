import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:my_presence/app/controllers/page_index_controller.dart';
import 'package:my_presence/app/routes/app_pages.dart';

import '../../../constants/colors.dart';
import '../../../constants/size_config.dart';
import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  final pageCon = Get.find<PageIndexController>();
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        centerTitle: true,
      ),
      body: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
        stream: controller.dataUser(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.hasData) {
            Map<String, dynamic> user = snapshot.data!.data()!;
            String defaultPicture =
                "https://ui-avatars.com/api/?name=${user['name']}";
            return ListView(
              padding: EdgeInsets.all(20),
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ClipOval(
                      child: Container(
                        width: 125,
                        height: 125,
                        child: Image.network(
                          user["picture"] != null
                              ? user["picture"] != ""
                                  ? user["picture"]
                                  : defaultPicture
                              : defaultPicture,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Text(
                  "${user['name']}",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  "${user['address']}",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  "${user['email']}",
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 20),
                ListTile(
                  onTap: () => Get.toNamed(
                    Routes.UPDATE_PROFILE,
                    arguments: user,
                  ),
                  leading: Icon(
                    Icons.person,
                    color: kPrimaryColor,
                  ),
                  title: Text("Ubah Profile"),
                ),
                ListTile(
                  onTap: () => Get.toNamed(Routes.UPDATE_PASSWORD),
                  leading: Icon(
                    Icons.key,
                    color: kPrimaryColor,
                  ),
                  title: Text("Ganti Password"),
                ),
                ListTile(
                  onTap: () => controller.logout(),
                  leading: Icon(
                    Icons.logout,
                    color: kPrimaryColor,
                  ),
                  title: Text("Keluar"),
                ),
              ],
            );
          } else {
            return Center(
              child: Text("Tidak bisa memuat data"),
            );
          }
        },
      ),
      bottomNavigationBar: Obx(
        () => ConvexAppBar(
          style: TabStyle.fixedCircle,
          items: [
            TabItem(icon: Icons.home, title: 'Home'),
            TabItem(icon: Icons.warehouse, title: 'Shipping'),
            TabItem(icon: Icons.person, title: 'Profile'),
          ],
          initialActiveIndex: pageCon.pageIndex.value,
          onTap: (int i) => pageCon.changePage(i),
          backgroundColor: kPrimaryColor,
          height: SizeConfig.screenHeight * 0.07,
        ),
      ),
    );
  }
}
