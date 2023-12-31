import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:getx_demo/app/modules/top_up/views/top_up_confirmation_view.dart';
import 'package:getx_demo/widgets/my_app_bar.dart';
import 'package:getx_demo/app/modules/top_up/controllers/top_up_controller.dart';
import 'package:getx_demo/widgets/my_virtual_keyboard.dart';

class TopUpView extends GetView<TopUpController> {
  const TopUpView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height / 60;
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: MyAppBar(
        title: 'title'.tr,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'how_much'.tr,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: height,
            ),
            Row(
              textBaseline: TextBaseline.alphabetic,
              crossAxisAlignment: CrossAxisAlignment.baseline,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'currency'.tr,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                  ),
                ),
                Obx(
                  () => Text(
                    controller.wholeValue.value,
                    textAlign: TextAlign.start,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 50,
                    ),
                  ),
                ),
                Obx(
                  () => Text(
                    controller.decimalValue.value,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                    ),
                  ),
                )
              ],
            ),
            SizedBox(
              height: height,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 20,
              ),
              child: Obx(
                () => MyVirtualKeyboard(
                  callbackWhole: (s) => controller.callbackWhole(s),
                  callbackDecimal: (s) => controller.callbackDecimal(s),
                  isDecimalMode: controller.isDecimalMode.value,
                  setDecimalMode: () => controller.isDecimalMode.value =
                      !controller.isDecimalMode.value,
                  backspace: controller.backspace,
                  isEmpty: controller.wholeValue.isEmpty,
                ),
              ),
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
                  onPressed: controller.wholeValue.value.isEmpty ||
                          double.parse(controller.wholeValue.value +
                                  controller.decimalValue.value) ==
                              0
                      ? null
                      : () => Get.to(
                            const TopUpConfirmationView(),
                          ),
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
