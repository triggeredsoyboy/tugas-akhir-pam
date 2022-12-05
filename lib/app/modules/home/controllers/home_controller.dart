import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../../data/models/shipping_model.dart';

class HomeController extends GetxController {
  RxBool isLoading = false.obs;

  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Stream<DocumentSnapshot<Map<String, dynamic>>> streamUser() async* {
    String uid = auth.currentUser!.uid;

    yield* firestore.collection("mahasiswa").doc(uid).snapshots();
  }

  TextEditingController weightCon = TextEditingController();

  List<Shipping> shippingData = [];

  RxString provAsalId = "0".obs;
  RxString cityAsalId = "0".obs;
  RxString provTujuanId = "0".obs;
  RxString cityTujuanId = "0".obs;

  RxString kurirCode = "".obs;

  Future<void> cekOngkir() async {
    if (provAsalId != "0" &&
        provTujuanId != "0" &&
        cityAsalId != "0" &&
        cityTujuanId != "0" &&
        weightCon.text != "" &&
        kurirCode != "") {
      isLoading.value = true;
      try {
        var response = await http.post(
          Uri.parse("https://api.rajaongkir.com/starter/cost"),
          headers: {
            "content-type": "application/x-www-form-urlencoded",
            "key": "524727c5f5fad7cc51348fe4b8e7d74c",
          },
          body: {
            "origin": cityAsalId.value,
            "destination": cityTujuanId.value,
            "weight": weightCon.text,
            "courier": kurirCode.value,
          },
        );
        List results = json.decode(response.body)["rajaongkir"]["results"][0]
            ["costs"] as List;
        shippingData = Shipping.fromJsonList(results);
        Get.defaultDialog(
          title: "Biaya Pengiriman",
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: shippingData
                .map(
                  (e) => ListTile(
                    title: Text("${e.service!.toUpperCase()}"),
                    subtitle: Text("Rp${e.cost![0].value}"),
                  ),
                )
                .toList(),
          ),
        );
        isLoading.value = false;
      } catch (e) {
        isLoading.value = false;
        Get.defaultDialog(
          title: "Error",
          middleText: "Tidak dapat mengecek ongkos kirim",
        );
      }
    } else {
      Get.defaultDialog(
        title: "Error",
        middleText: "Data input tidak lengkap",
      );
    }
  }
}
