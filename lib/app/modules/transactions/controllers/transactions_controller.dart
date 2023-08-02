import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:getx_demo/app/data/model/account.dart';
import 'package:getx_demo/app/data/repository/account_repository.dart';
import 'package:getx_demo/app/routes/app_pages.dart';

class TransactionsController extends GetxController {
  final _accountRepository = Get.find<AccountRepository>();

  Account get account => _accountRepository.getMyAccount();

  String get decimalPart =>
      ((account.balance.value - account.balance.value.truncate()) * 100)
                  .truncate() ==
              0
          ? '00'
          : ((account.balance.value - account.balance.value.truncate()) * 100)
              .truncate()
              .toString();

  void loanButtonPress() {
    if (account.loanDecision.value == LoanDecisionRules.uninitiated) {
      Get.toNamed(Routes.LOAN_APPLICATION);
    } else {
      showDialog(
        context: Get.context!,
        builder: (_) => const AlertDialog(
          content: Text(
            'Ooopsss, you applied before. Wait for a notification from us',
          ),
        ),
      );
    }
  }
}
