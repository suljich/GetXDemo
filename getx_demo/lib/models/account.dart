import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

import 'package:getx_demo/models/transaction.dart';

enum LoanDecisionRules {
  uninitiated,
  approved,
  declined,
  waiting,
}

class Account extends GetxController {
  final transactions = <Transaction>[].obs;

  var uidGen = const Uuid();

  var balance = 10000.00.obs;

  var hasLoan = false.obs;
  var loanDecision = LoanDecisionRules.uninitiated.obs;
  var loanAmount = 0.0.obs;

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
    return transactions
        .where(
          (element) =>
              element.dateTime.day == DateTime.now().day - 1 &&
              element.dateTime.month == DateTime.now().month &&
              element.dateTime.year == DateTime.now().year,
        )
        .toList();
  }
}
