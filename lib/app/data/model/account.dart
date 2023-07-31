import 'package:flutter/foundation.dart';

import 'package:get/get.dart';
import 'package:uuid/uuid.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:getx_demo/app/data/model/transaction.dart';

part 'account.freezed.dart';

enum LoanDecisionRules {
  uninitiated,
  approved,
  declined,
  waiting,
}

@unfreezed
class Account with _$Account {
  factory Account() = _Account;

  Account._();

  final transactions = <Transaction>[].obs;

  final uidGen = const Uuid();

  final balance = 10000.00.obs;

  final hasLoan = false.obs;
  final loanDecision = LoanDecisionRules.uninitiated.obs;
  final loanAmount = 0.0.obs;

  List<Transaction> get transactionsMadeToday {
    return transactions
        .where(
          (element) =>
              element.dateTime.day == DateTime.now().day &&
              element.dateTime.month == DateTime.now().month &&
              element.dateTime.year == DateTime.now().year,
        )
        .toList();
  }

  List<Transaction> get transactionsMadeYesterday {
    return transactions.where(
      (element) {
        final yesterday = DateTime.now().subtract(const Duration(days: 1));
        return element.dateTime.day == yesterday.day &&
            element.dateTime.month == yesterday.month &&
            element.dateTime.year == yesterday.year;
      },
    ).toList();
  }
}
