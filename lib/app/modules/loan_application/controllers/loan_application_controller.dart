import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:getx_demo/app/data/model/account.dart';
import 'package:getx_demo/app/data/model/transaction.dart';
import 'package:getx_demo/app/data/repository/account_repository.dart';
import 'package:getx_demo/app/data/repository/random_number_repository.dart';
import 'package:getx_demo/app/routes/app_pages.dart';

class LoanApplicationController extends GetxController {
  final _accountRepository = Get.find<AccountRepository>();
  Account get account => _accountRepository.getMyAccount();

  final accepted = false.obs;
  final isLoading = false.obs;

  final salaryController = TextEditingController();
  final expensesController = TextEditingController();
  final loanAmountController = TextEditingController();
  final termController = TextEditingController();

  void applyForLoan() async {
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
            'please_complete_the_form'.tr,
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
            'you_have_to_accept_the_terms_and_conditions'.tr,
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
    final randomNumberRepository = Get.find<RandomNumberRepository>();
    final randomNumber = await randomNumberRepository.randomNumber;
    isLoading.value = false;
    if (randomNumber > 50) {
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
        title: 'loan_accepted_message'.tr,
        content: ElevatedButton(
          onPressed: () => Get.offAllNamed(Routes.TRANSACTIONS),
          child: Text(
            'go_back'.tr,
          ),
        ),
      );
    } else {
      Get.defaultDialog(
        title: 'loan_declined_message'.tr,
        content: ElevatedButton(
          onPressed: () => Get.offAllNamed(Routes.TRANSACTIONS),
          child: Text(
            'go_back'.tr,
          ),
        ),
      );
      account.loanDecision.value = LoanDecisionRules.waiting;
    }
  }
}
