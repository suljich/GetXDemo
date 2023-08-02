import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:getx_demo/app/data/repository/random_number_repository.dart';
import 'package:getx_demo/app/routes/app_pages.dart';
import 'package:getx_demo/app/data/model/account.dart';
import 'package:getx_demo/app/data/model/transaction.dart';
import 'package:getx_demo/app/data/repository/account_repository.dart';
import 'package:getx_demo/app/modules/pay/views/pay_confirmation_view.dart';

class PayController extends GetxController {
  final _accountRepository = Get.find<AccountRepository>();
  Account get account => _accountRepository.getMyAccount();

  final wholeValue = ''.obs;
  final decimalValue = ''.obs;
  final isDecimalMode = false.obs;

  final name = ''.obs;

  void backspace() {
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
  }

  void callbackWhole(String s) {
    if (s == '0' && wholeValue.value == '0') {
      return;
    }
    wholeValue.value += s;
  }

  void callbackDecimal(String s) {
    if (s == '.' && wholeValue.value.isEmpty) {
      return;
    }
    decimalValue.value += s;
  }

  void nextButtonPress() {
    double val = double.parse(wholeValue.value + decimalValue.value);
    if (val > account.balance.value) {
      showDialog(
        context: Get.context!,
        builder: (_) => AlertDialog(
          content: Text(
            'insufficient_funds'.tr,
          ),
        ),
      );
    } else {
      Get.to(
        const PayConfirmationView(),
      );
    }
  }

  void pay() async {
    final value = double.parse(wholeValue.value + decimalValue.value);
    account.balance.value -= value;
    account.transactions.add(
      Transaction(
        title: name.value,
        amount: value,
        type: TransactionType.expense,
        dateTime: DateTime.now(),
        id: account.uidGen.v1(),
      ),
    );
    if (account.loanDecision.value == LoanDecisionRules.waiting &&
        account.balance.value > 1000) {
      final randomNumberRepository = Get.find<RandomNumberRepository>();
      final randomNumber = await randomNumberRepository.randomNumber;
      if (randomNumber > 50) {
        account.loanDecision.value = LoanDecisionRules.approved;
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
      }
    }
    Get.offAllNamed(Routes.TRANSACTIONS);
  }
}
