import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:getx_demo/app/modules/transactions/controllers/transactions_controller.dart';
import 'package:getx_demo/app/routes/app_pages.dart';

class OptionsView extends GetView<TransactionsController> {
  const OptionsView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 8,
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.symmetric(
        horizontal: 10,
      ),
      child: Card(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            customButton(
              'pay'.tr,
              SizedBox(
                width: 60,
                height: 50,
                child: Stack(
                  children: [
                    const Align(
                      alignment: Alignment.center,
                      child: Icon(
                        Icons.phone_iphone_outlined,
                        size: 45,
                      ),
                    ),
                    Align(
                      alignment: const Alignment(
                        0,
                        -0.2,
                      ),
                      child: Icon(
                        Icons.attach_money,
                        size: 20,
                        color: Theme.of(
                          context,
                        ).primaryColor,
                      ),
                    ),
                    Align(
                      alignment: const Alignment(
                        0.5,
                        -0.2,
                      ),
                      child: Icon(
                        Icons.arrow_right_alt_sharp,
                        size: 20,
                        color: Theme.of(
                          context,
                        ).primaryColor,
                      ),
                    ),
                  ],
                ),
              ),
              () => Get.toNamed(Routes.PAY),
            ),
            customButton(
              'top up'.tr,
              SizedBox(
                width: 50,
                height: 50,
                child: Stack(
                  children: [
                    const Align(
                      alignment: Alignment.center,
                      child: Icon(
                        Icons.wallet_sharp,
                        size: 50,
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                            15,
                          ),
                          color: Colors.white,
                          border: Border.all(
                            color: Theme.of(
                              context,
                            ).primaryColor,
                          ),
                        ),
                        child: Icon(
                          Icons.add,
                          color: Theme.of(
                            context,
                          ).primaryColor,
                          size: 18,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              () => Get.toNamed(Routes.TOP_UP),
            ),
            customButton(
              'loan'.tr,
              SizedBox(
                width: 50,
                height: 50,
                child: Stack(
                  children: [
                    const Align(
                      alignment: Alignment.center,
                      child: Icon(
                        Icons.money,
                        size: 50,
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                            15,
                          ),
                          color: Colors.white,
                        ),
                        child: Icon(
                          Icons.check,
                          color: Theme.of(
                            context,
                          ).primaryColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              () => controller.loanButtonPress(context),
            ),
          ],
        ),
      ),
    );
  }

  GestureDetector customButton(
    String option,
    Widget icon,
    Function onPressed,
  ) {
    return GestureDetector(
      onTap: () => onPressed(),
      child: Container(
        margin: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 5,
        ),
        child: FittedBox(
          child: Column(
            children: [
              icon,
              Padding(
                padding: const EdgeInsets.only(
                  top: 8,
                ),
                child: Text(
                  option,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
