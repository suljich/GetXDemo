import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:getx_demo/screens/top_up_confirmation_screen.dart';
import 'package:getx_demo/widgets/my_app_bar.dart';
import 'package:getx_demo/widgets/my_virtual_keyboard.dart';

class TopUpScreen extends StatelessWidget {
  const TopUpScreen({
    super.key,
  });

  static const route = '/top-up-screen';

  @override
  Widget build(BuildContext context) {
    var wholeValue = ''.obs;
    var decimalValue = ''.obs;
    var isDecimalMode = false.obs;
    var height = MediaQuery.of(
          context,
        ).size.height /
        60;
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: const MyAppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'How much?',
              textAlign: TextAlign.center,
              style: TextStyle(
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
                const Text(
                  '£',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                  ),
                ),
                Obx(
                  () => Text(
                    wholeValue.value,
                    textAlign: TextAlign.start,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 50,
                    ),
                  ),
                ),
                Obx(
                  () => Text(
                    decimalValue.value,
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
                  callbackWhole: (s) {
                    if (s == '0' && wholeValue.value == '0') {
                      return;
                    }
                    wholeValue.value += s;
                  },
                  callbackDecimal: (s) {
                    if (s == '.' && wholeValue.value.isEmpty) {
                      return;
                    }
                    decimalValue.value += s;
                  },
                  isDecimalMode: isDecimalMode.value,
                  setDecimalMode: () {
                    isDecimalMode.value = !isDecimalMode.value;
                  },
                  backspace: () {
                    if (isDecimalMode.value) {
                      if (decimalValue.value.isNotEmpty) {
                        if (decimalValue.value.length == 1) {
                          isDecimalMode.value = false;
                        }
                        decimalValue.value = decimalValue.value.substring(
                          0,
                          decimalValue.value.length - 1,
                        );
                      }
                    } else {
                      if (wholeValue.value.isNotEmpty) {
                        wholeValue.value = wholeValue.value.substring(
                          0,
                          wholeValue.value.length - 1,
                        );
                      }
                    }
                  },
                  isEmpty: wholeValue.isEmpty,
                ),
              ),
            ),
            SizedBox(
              width: MediaQuery.of(
                    context,
                  ).size.width /
                  2,
              height: MediaQuery.of(
                    context,
                  ).size.height /
                  15,
              child: Obx(
                () => ElevatedButton(
                  style: const ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(
                      Colors.white54,
                    ),
                  ),
                  onPressed: wholeValue.value.isEmpty ||
                          double.parse(wholeValue.value + decimalValue.value) ==
                              0
                      ? null
                      : () {
                          Get.to(
                            TopUpConfirmationScreen(
                              value: double.parse(
                                wholeValue.value + decimalValue.value,
                              ),
                            ),
                          );
                        },
                  child: const Text(
                    'Next',
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
