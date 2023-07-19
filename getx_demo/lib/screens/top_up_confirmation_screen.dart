import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_demo/screens/transactions_screen.dart';
import 'package:http/http.dart' as http;

import 'package:getx_demo/models/account.dart';
import 'package:getx_demo/models/transaction.dart';
import 'package:getx_demo/widgets/my_app_bar.dart';

class TopUpConfirmationScreen extends StatelessWidget {
  const TopUpConfirmationScreen({
    super.key,
    required this.value,
  });

  static const route = '/pay-confirmation-screen';

  final double value;

  @override
  Widget build(BuildContext context) {
    Account account = Get.find();
    var name = ''.obs;
    var height = MediaQuery.of(
          context,
        ).size.height /
        7;
    return Scaffold(
      backgroundColor: Theme.of(
        context,
      ).primaryColor,
      appBar: const MyAppBar(),
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
              width: MediaQuery.of(
                    context,
                  ).size.width /
                  1.5,
              child: TextField(
                decoration: const InputDecoration(
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.white,
                    ),
                  ),
                ),
                onChanged: (value) {
                  name.value = value;
                },
              ),
            ),
            SizedBox(
              height: height,
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
                  onPressed: name.value.isEmpty
                      ? null
                      : () async {
                          account.balance.value += value;
                          account.transactions.add(
                            Transaction(
                              title: name.value,
                              amount: value,
                              type: TransactionType.topup,
                              dateTime: DateTime.now(),
                              id: account.uidGen.v1(),
                            ),
                          );
                          name.value = '';
                          if (account.loanDecision.value ==
                                  LoanDecisionRules.waiting &&
                              account.balance.value > 1000) {
                            final response = await http.get(
                              Uri.parse(
                                'http://www.randomnumberapi.com/api/v1.0/randomredditnumber?min=0&max=100&count=1',
                              ),
                            );
                            if (json.decode(response.body)[0] > 50) {
                              account.loanDecision.value =
                                  LoanDecisionRules.approved;
                              account.transactions.add(
                                Transaction(
                                  title: 'Loan',
                                  amount: account.loanAmount.value,
                                  type: TransactionType.loan,
                                  dateTime: DateTime.now(),
                                  id: account.uidGen.v1(),
                                ),
                              );
                              Get.defaultDialog(
                                title:
                                    'Yeeeyyy !! Congrats. Your application has been approved. Don\'t tell your friends you have money!',
                                content: ElevatedButton(
                                  onPressed: () => Get.offAndToNamed(
                                      TransactionsScreen.route),
                                  child: const Text(
                                    'Go back',
                                  ),
                                ),
                              );
                            }
                          }
                          Get.offAllNamed(TransactionsScreen.route);
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
