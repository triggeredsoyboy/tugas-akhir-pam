import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_presence/app/controllers/page_index_controller.dart';
import 'app/routes/app_pages.dart';
import 'package:my_presence/app/constants/theme.dart';
import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  final pageCon = Get.put(PageIndexController(), permanent: true);

  runApp(
    StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return MaterialApp(
            home: Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            ),
          );
        }
        print(snapshot.data);
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: "MyOngkir",
          theme: theme(),
          initialRoute: snapshot.data != null ? Routes.HOME : Routes.LOGIN,
          getPages: AppPages.routes,
        );
      },
    ),
  );
}
