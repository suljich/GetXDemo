import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:getx_demo/app/modules/top_up/controllers/top_up_controller.dart';

import 'package:getx_demo/widgets/my_app_bar.dart';

class TopUpConfirmationView extends GetView<TopUpController> {
  const TopUpConfirmationView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height / 7;
    return Scaffold(
      backgroundColor: Theme.of(
        context,
      ).primaryColor,
      appBar: MyAppBar(
        title: 'title'.tr,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'What is the source?',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
              ),
            ),
            SizedBox(
              height: height,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width / 1.5,
              child: TextField(
                decoration: const InputDecoration(
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.white,
                    ),
                  ),
                ),
                onChanged: (value) {
                  controller.name.value = value;
                },
              ),
            ),
            SizedBox(
              height: height,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width / 2,
              height: MediaQuery.of(context).size.height / 15,
              child: Obx(
                () => ElevatedButton(
                  style: const ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(
                      Colors.white54,
                    ),
                  ),
                  onPressed: controller.name.value.isEmpty
                      ? null
                      : () => Get.to(const TopUpConfirmationView()),
                  child: Text(
                    'next'.tr,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
