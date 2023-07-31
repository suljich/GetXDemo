import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:getx_demo/app/data/model/account.dart';
import 'package:getx_demo/app/data/model/transaction.dart';
import 'package:getx_demo/app/data/repository/account_repository.dart';
import 'package:getx_demo/app/routes/app_pages.dart';
import 'package:http/http.dart' as http;

class LoanApplicationController extends GetxController {
  final accountRepository = Get.find<AccountRepository>();
  Account get account => accountRepository.getMyAccount();

  final accepted = false.obs;
  final isLoading = false.obs;

  final salaryController = TextEditingController();
  final expensesController = TextEditingController();
  final loanAmountController = TextEditingController();
  final termController = TextEditingController();

  Future<void> loanLogic() async {
    if (salaryController.text.isEmpty ||
        expensesController.text.isEmpty ||
        loanAmountController.text.isEmpty ||
        termController.text.isEmpty) {
      Get.showSnackbar(
        GetSnackBar(
          duration: const Duration(
            seconds: 3,
          ),
          messageText: Text(
            'please complete the form'.tr,
            style: const TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      );
      return;
    } else if (!accepted.value) {
      Get.showSnackbar(
        GetSnackBar(
          duration: const Duration(
            seconds: 3,
          ),
          messageText: Text(
            'you have to accept the terms and conditions'.tr,
            style: const TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      );
      return;
    }
    account.loanAmount.value = double.parse(loanAmountController.text);
    if (account.balance.value <= 1000) {
      account.loanDecision.value = LoanDecisionRules.waiting;
      return;
    }
    double salary = double.parse(salaryController.text);
    if (account.hasLoan.value ||
        salary <= 1000 ||
        double.parse(expensesController.text) >= salary / 3 ||
        !accepted.value) {
      account.loanDecision.value = LoanDecisionRules.declined;
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
      account.loanDecision.value = LoanDecisionRules.approved;
      account.balance.value += double.parse(loanAmountController.text);
      account.transactions.add(
        Transaction(
          title: 'loan'.tr,
          amount: account.loanAmount.value,
          type: TransactionType.loan,
          dateTime: DateTime.now(),
          id: account.uidGen.v1(),
        ),
      );
      Get.defaultDialog(
        title: 'loan accepted message'.tr,
        content: ElevatedButton(
          onPressed: () => Get.offAllNamed(Routes.TRANSACTIONS),
          child: Text(
            'go back'.tr,
          ),
        ),
      );
    } else {
      Get.defaultDialog(
        title: 'loan declined message'.tr,
        content: ElevatedButton(
          onPressed: () => Get.offAllNamed(Routes.TRANSACTIONS),
          child: Text(
            'go back'.tr,
          ),
        ),
      );
      account.loanDecision.value = LoanDecisionRules.waiting;
    }
  }
}
