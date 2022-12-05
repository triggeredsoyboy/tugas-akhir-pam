// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
// import 'package:intl/intl.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:dio/dio.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:my_presence/app/constants/button.dart';
import 'package:my_presence/app/constants/colors.dart';
import '../../../constants/size_config.dart';
import '../controllers/home_controller.dart';
// import 'package:my_presence/app/routes/app_pages.dart';
import '../../../controllers/page_index_controller.dart';
import '../../../data/models/province_model.dart';
import '../../../data/models/city_model.dart';

class HomeView extends GetView<HomeController> {
  final pageCon = Get.find<PageIndexController>();
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('MyOngkir'),
      ),
      body: ListView(
        padding: EdgeInsets.all(20),
        children: [
          DropdownSearch<Province>(
            dropdownDecoratorProps: DropDownDecoratorProps(
              dropdownSearchDecoration: InputDecoration(
                labelText: "Provinsi Asal",
                hintText: "Pilih Provinsi Asal",
              ),
            ),
            clearButtonProps: ClearButtonProps(
              isVisible: true,
            ),
            popupProps: PopupProps.dialog(
              showSearchBox: true,
              searchFieldProps: TextFieldProps(
                decoration: InputDecoration(
                  hintText: "Cari provinsi...",
                ),
              ),
              itemBuilder: (context, item, isSelected) => ListTile(
                title: Text("${item.province}"),
              ),
            ),
            asyncItems: (text) async {
              var response = await Dio().get(
                "https://api.rajaongkir.com/starter/province",
                queryParameters: {
                  "key": "524727c5f5fad7cc51348fe4b8e7d74c",
                },
              );
              return Province.fromJsonList(
                  response.data["rajaongkir"]["results"]);
            },
            onChanged: (value) =>
                controller.provAsalId.value = value?.provinceId ?? "0",
          ),
          SizedBox(height: 12),
          DropdownSearch<City>(
            dropdownDecoratorProps: DropDownDecoratorProps(
              dropdownSearchDecoration: InputDecoration(
                labelText: "Kota/Kabupaten Asal",
                hintText: "Pilih Kota/Kabupaten Asal",
              ),
            ),
            clearButtonProps: ClearButtonProps(
              isVisible: true,
            ),
            popupProps: PopupProps.dialog(
              showSearchBox: true,
              searchFieldProps: TextFieldProps(
                decoration: InputDecoration(
                  hintText: "Cari kota...",
                ),
              ),
              itemBuilder: (context, item, isSelected) => ListTile(
                title: Text("${item.type} ${item.cityName}"),
              ),
            ),
            asyncItems: (text) async {
              var response = await Dio().get(
                "https://api.rajaongkir.com/starter/city?province=${controller.provAsalId}",
                queryParameters: {
                  "key": "524727c5f5fad7cc51348fe4b8e7d74c",
                },
              );
              return City.fromJsonList(response.data["rajaongkir"]["results"]);
            },
            onChanged: (value) =>
                controller.cityAsalId.value = value?.cityId ?? "0",
          ),
          SizedBox(height: 32),
          DropdownSearch<Province>(
            dropdownDecoratorProps: DropDownDecoratorProps(
              dropdownSearchDecoration: InputDecoration(
                  labelText: "Provinsi Tujuan",
                  hintText: "Pilih Provinsi Tujuan"),
            ),
            clearButtonProps: ClearButtonProps(
              isVisible: true,
            ),
            popupProps: PopupProps.dialog(
              showSearchBox: true,
              searchFieldProps: TextFieldProps(
                decoration: InputDecoration(
                  hintText: "Cari Provinsi ...",
                ),
              ),
              itemBuilder: (context, item, isSelected) => ListTile(
                title: Text("${item.province}"),
              ),
            ),
            asyncItems: (text) async {
              var response = await Dio().get(
                "https://api.rajaongkir.com/starter/province",
                queryParameters: {
                  "key": "524727c5f5fad7cc51348fe4b8e7d74c",
                },
              );
              return Province.fromJsonList(
                  response.data["rajaongkir"]["results"]);
            },
            onChanged: (value) =>
                controller.provTujuanId.value = value?.provinceId ?? "0",
          ),
          SizedBox(height: 12),
          DropdownSearch<City>(
            dropdownDecoratorProps: DropDownDecoratorProps(
              dropdownSearchDecoration: InputDecoration(
                  labelText: "Kota/Kabupaten Tujuan",
                  hintText: "Pilih Kota/Kabupaten Tujuan"),
            ),
            clearButtonProps: ClearButtonProps(
              isVisible: true,
            ),
            popupProps: PopupProps.dialog(
              showSearchBox: true,
              searchFieldProps: TextFieldProps(
                decoration: InputDecoration(
                  hintText: "Cari Kota ...",
                ),
              ),
              itemBuilder: (context, item, isSelected) => ListTile(
                title: Text("${item.type} ${item.cityName}"),
              ),
            ),
            asyncItems: (text) async {
              var response = await Dio().get(
                "https://api.rajaongkir.com/starter/city?province=${controller.provTujuanId}",
                queryParameters: {
                  "key": "524727c5f5fad7cc51348fe4b8e7d74c",
                },
              );
              return City.fromJsonList(response.data["rajaongkir"]["results"]);
            },
            onChanged: (value) =>
                controller.cityTujuanId.value = value?.cityId ?? "0",
          ),
          SizedBox(height: 32),
          TextField(
            controller: controller.weightCon,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: "Berat Paket",
              hintText: "Masukkan berat paket dalam gram",
            ),
          ),
          SizedBox(height: 12),
          DropdownSearch<Map<String, dynamic>>(
            items: [
              {
                "code": "jne",
                "name": "JNE",
              },
              {
                "code": "pos",
                "name": "Pos Indonesia",
              },
              {
                "code": "tiki",
                "name": "TIKI",
              },
            ],
            dropdownDecoratorProps: DropDownDecoratorProps(
              dropdownSearchDecoration: InputDecoration(
                labelText: "Kurir",
              ),
            ),
            clearButtonProps: ClearButtonProps(
              isVisible: true,
            ),
            popupProps: PopupProps.menu(
              itemBuilder: (context, item, isSelected) => ListTile(
                title: Text("${item['name']}"),
              ),
            ),
            dropdownBuilder: (context, selectedItem) =>
                Text("${selectedItem?['name'] ?? "Pilih Kurir"}"),
            onChanged: (value) =>
                controller.kurirCode.value = value?['code'] ?? "",
          ),
          SizedBox(height: 32),
          Obx(
            () => DefaultButton(
              press: () async {
                if (controller.isLoading.isFalse) {
                  await controller.cekOngkir();
                }
              },
              text: controller.isLoading.isFalse
                  ? "Cek Ongkos Kirim"
                  : "Mohon tunggu ...",
            ),
          ),
        ],
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
