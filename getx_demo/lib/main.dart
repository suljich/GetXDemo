import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:getx_demo/app/data/model/localization.dart';
import 'package:getx_demo/app/dependencies.dart';
import 'package:getx_demo/app/routes/app_pages.dart';

void main() {
  injectDependencies();
  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      translations: Localization(),
      locale: Get.deviceLocale,
      fallbackLocale: const Locale('en', 'UK'),
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      theme: ThemeData(
        primaryColor: const Color(
          0xFFC0028B,
        ),
        appBarTheme: const AppBarTheme(
          color: Color(
            0xFFC0028B,
          ),
        ),
        elevatedButtonTheme: const ElevatedButtonThemeData(
          style: ButtonStyle(
            backgroundColor: MaterialStatePropertyAll(
              Color(
                0xFFC0028B,
              ),
            ),
          ),
        ),
        fontFamily: 'Montserrat',
      ),
    ),
  );
}
