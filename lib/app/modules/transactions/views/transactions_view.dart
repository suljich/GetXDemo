import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:getx_demo/app/modules/transactions/views/options_view.dart';
import 'package:styled_text/styled_text.dart';

import 'package:getx_demo/app/modules/transactions/views/recent_activity_view.dart';
import 'package:getx_demo/widgets/my_app_bar.dart';
import 'package:getx_demo/app/modules/transactions/controllers/transactions_controller.dart';

class TransactionsView extends GetView<TransactionsController> {
  const TransactionsView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        title: 'title'.tr,
      ),
      body: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            Column(
              children: [
                Container(
                  color: Theme.of(context).primaryColor,
                  height: MediaQuery.of(context).size.height / 5,
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Obx(
                        () => StyledText(
                          text:
                              '<small>${'currency'.tr}</small><large>${controller.account.balance.truncate()}</large>.<small>${controller.decimalPart}</small>',
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 30,
                          ),
                          tags: {
                            'large': StyledTextTag(
                              style: const TextStyle(
                                fontSize: 40,
                              ),
                            ),
                            'small': StyledTextTag(
                              style: const TextStyle(
                                fontSize: 20,
                              ),
                            )
                          },
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 8 / 2,
                      )
                    ],
                  ),
                ),
                const Expanded(
                  child: RecentActivityView(),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height / 5 -
                      MediaQuery.of(context).size.height / 8 / 2,
                ),
                const OptionsView(),
              ],
            )
          ],
        ),
      ),
    );
  }
}
