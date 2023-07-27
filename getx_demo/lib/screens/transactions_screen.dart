import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:styled_text/styled_text.dart';

import 'package:getx_demo/models/account.dart';
import 'package:getx_demo/widgets/my_app_bar.dart';
import 'package:getx_demo/widgets/options_widget.dart';
import 'package:getx_demo/widgets/recent_activity_widget.dart';

class TransactionsScreen extends StatelessWidget {
  const TransactionsScreen({
    super.key,
  });

  static const route = '/transactions-screen';

  @override
  Widget build(BuildContext context) {
    final Account account = Get.put(
      Account(),
    );
    String decimalPart =
        ((account.balance.value - account.balance.value.truncate()) * 100)
                    .truncate() ==
                0
            ? '00'
            : ((account.balance.value - account.balance.value.truncate()) * 100)
                .truncate()
                .toString();
    return Scaffold(
      appBar: const MyAppBar(
        title: 'MoneyApp',
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
                              '<small>£</small><large>${account.balance.value.truncate()}</large>.<small>$decimalPart</small>',
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
                  child: RecentActivity(),
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
                const OptionsWidget(),
              ],
            )
          ],
        ),
      ),
    );
  }
}
