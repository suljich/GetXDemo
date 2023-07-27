import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import 'package:getx_demo/screens/transactions_screen.dart';
import 'package:getx_demo/models/transaction.dart';
import 'package:getx_demo/models/account.dart';
import 'package:getx_demo/widgets/my_app_bar.dart';

class LoanApplicationScreen extends StatelessWidget {
  LoanApplicationScreen({
    super.key,
  });

  static const route = '/loan-application-screen';

  final salaryController = TextEditingController().obs;
  final expensesController = TextEditingController().obs;
  final loanAmountController = TextEditingController().obs;
  final termController = TextEditingController().obs;

  @override
  Widget build(BuildContext context) {
    final Account account = Get.find();
    var accepted = false.obs;
    var isLoading = false.obs;
    return Scaffold(
      appBar: const MyAppBar(
        title: 'Loan application',
      ),
      body: Obx(() {
        return Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.fromLTRB(
                    8,
                    8,
                    8,
                    0,
                  ),
                  child: Text(
                    'Terms and Conditions',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 40,
                ),
                const Padding(
                  padding: EdgeInsets.fromLTRB(
                    8,
                    0,
                    8,
                    8,
                  ),
                  child: Text(
                    'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nam elementum enim non neque luctus, nec blandit ipsum sagittis. Sed fringilla blandit nibh, sit amet suscipit massa sollicitudin lacinia. Donec cursus, odio sit amet tincidunt sodales, odio nisl hendrerit sem, tempor tincidunt ligula nisl nec ante. Nulla aliquet aliquam justo, ac bibendum orci rhoncus non. Nullam quis ex elementum, pharetra ligula eleifend, convallis nulla. Nulla sit amet nisi viverra, semper nunc eu, posuere dui. Donec at metus ut eros rhoncus vestibulum vitae at lacus. Etiam imperdiet, nulla ac condimentum aliquam, enim lacus fringilla leo, vel hendrerit mi ipsum et ante. Vivamus finibus mauris eget diam sodales, eget efficitur orci laoreet. Sed feugiat odio quis mattis tristique. Mauris sit amet sem mauris.',
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                      color: Color(
                        0xFF3A3B3C,
                      ),
                      fontSize: 10,
                      fontWeight: FontWeight.w400,
                      height: 1.4,
                      letterSpacing: -0.24,
                    ),
                  ),
                ),
                Container(
                  color: Colors.white,
                  margin: const EdgeInsets.fromLTRB(
                    16,
                    14,
                    0,
                    14,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Accept Terms & Conditions',
                        style: TextStyle(
                          fontSize: 15,
                        ),
                      ),
                      Obx(
                        () => Switch(
                          value: accepted.value,
                          onChanged: (value) => accepted.value = value,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 50,
                ),
                const Padding(
                  padding: EdgeInsets.only(
                    left: 16,
                  ),
                  child: Text(
                    'ABOUT YOU',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                myTextField(
                  context,
                  salaryController,
                  'Monthly salary',
                  'Enter your salary',
                ),
                myTextField(
                  context,
                  expensesController,
                  'Monthly Expenses',
                  'Enter your estimated monthly expenses',
                ),
                const Padding(
                  padding: EdgeInsets.fromLTRB(
                    16,
                    14,
                    0,
                    0,
                  ),
                  child: Text(
                    'LOAN',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                myTextField(
                  context,
                  loanAmountController,
                  'Amount',
                  'Enter the loan amount',
                ),
                myTextField(
                  context,
                  termController,
                  'Term',
                  'Enter the term',
                  true,
                ),
                Expanded(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          padding: const EdgeInsets.only(
                            bottom: 10,
                          ),
                          height: 60,
                          width: 200,
                          child: ElevatedButton(
                            onPressed: () async {
                              if (salaryController.value.text.isEmpty ||
                                  expensesController.value.text.isEmpty ||
                                  loanAmountController.value.text.isEmpty ||
                                  termController.value.text.isEmpty) {
                                Get.showSnackbar(
                                  const GetSnackBar(
                                    duration: Duration(
                                      seconds: 3,
                                    ),
                                    messageText: Text(
                                      'Please complete the form',
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                );
                                return;
                              } else if (!accepted.value) {
                                Get.showSnackbar(
                                  const GetSnackBar(
                                    duration: Duration(
                                      seconds: 3,
                                    ),
                                    messageText: Text(
                                      'You have to accept the terms & conditions',
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                );
                                return;
                              }
                              account.loanAmount.value =
                                  double.parse(loanAmountController.value.text);
                              if (account.balance.value <= 1000) {
                                account.loanDecision.value =
                                    LoanDecisionRules.waiting;
                                return;
                              }
                              double salary =
                                  double.parse(salaryController.value.text);
                              if (account.hasLoan.value ||
                                  salary <= 1000 ||
                                  double.parse(expensesController.value.text) >=
                                      salary / 3 ||
                                  !accepted.value) {
                                account.loanDecision.value =
                                    LoanDecisionRules.declined;
                                return;
                              }
                              isLoading.value = true;
                              final response = await http.get(
                                Uri.parse(
                                  'http://www.randomnumberapi.com/api/v1.0/randomredditnumber?min=0&max=100&count=1',
                                ),
                              );
                              isLoading.value = false;
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
                              } else {
                                Get.defaultDialog(
                                  title:
                                      'Ooopsss. Your application has been declined. It\'s not your fault, it\'s a financial crisis.',
                                  content: ElevatedButton(
                                    onPressed: () {
                                      Get.back();
                                      Get.back();
                                    },
                                    child: const Text(
                                      'Go back',
                                    ),
                                  ),
                                );
                                account.loanDecision.value =
                                    LoanDecisionRules.waiting;
                              }
                            },
                            child: const Text(
                              'Apply for loan',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            if (isLoading.value)
              const ModalBarrier(
                dismissible: false,
                color: Colors.black38,
              ),
            if (isLoading.value)
              const Center(
                child: CircularProgressIndicator(),
              ),
          ],
        );
      }),
    );
  }

  Widget myTextField(
    BuildContext context,
    Rx<TextEditingController> controller,
    String title,
    String hintText, [
    bool isTerm = false,
  ]) {
    return Container(
      padding: const EdgeInsets.all(
        14,
      ),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Colors.grey,
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height / 200,
          ),
          Row(
            children: [
              if (!isTerm)
                const Text(
                  '£',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              if (!isTerm)
                SizedBox(
                  width: MediaQuery.of(context).size.width / 50,
                ),
              Obx(
                () => Expanded(
                  child: TextField(
                    keyboardType: TextInputType.number,
                    controller: controller.value,
                    style: const TextStyle(
                      fontSize: 16,
                    ),
                    decoration: InputDecoration.collapsed(
                      hintText: hintText,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
