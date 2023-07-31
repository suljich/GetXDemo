import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import 'package:getx_demo/app/routes/app_pages.dart';
import 'package:getx_demo/app/data/model/account.dart';
import 'package:getx_demo/app/data/model/transaction.dart';
import 'package:getx_demo/app/data/repository/account_repository.dart';
import 'package:getx_demo/app/modules/pay/views/pay_confirmation_view.dart';

class PayController extends GetxController {
  final accountRepository = Get.find<AccountRepository>();
  Account get account => accountRepository.getMyAccount();

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

  void nextButtonPress(BuildContext context) {
    double val = double.parse(wholeValue.value + decimalValue.value);
    if (val > account.balance.value) {
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          content: Text(
            'insufficient funds'.tr,
          ),
        ),
      );
    } else {
      Get.to(
        const PayConfirmationView(),
      );
    }
  }

  Future<void> payFunction() async {
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
      final response = await http.get(
        Uri.parse(
          'http://www.randomnumberapi.com/api/v1.0/randomredditnumber?min=0&max=100&count=1',
        ),
      );
      if (json.decode(response.body)[0] > 50) {
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
          title: 'loan accepted message'.tr,
          content: ElevatedButton(
            onPressed: () => Get.offAllNamed(Routes.TRANSACTIONS),
            child: Text(
              'go back'.tr,
            ),
          ),
        );
      }
    }
    Get.offAllNamed(Routes.TRANSACTIONS);
  }
}
