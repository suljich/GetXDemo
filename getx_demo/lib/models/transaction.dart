import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

enum TransactionType {
  topup,
  expense,
  loan,
}

class Transaction extends GetxController {
  final String title;
  double amount;
  final TransactionType type;
  final DateTime dateTime;
  final String id;
  var isRepeating = false.obs;
  var isSplit = false;

  Transaction({
    required this.title,
    required this.type,
    required this.dateTime,
    required this.id,
    required this.amount,
  });

  static const icons = {
    TransactionType.topup: Icons.add_circle,
    TransactionType.expense: Icons.shopping_bag,
    TransactionType.loan: Icons.money,
  };
}

extension DateTimeFormating on DateTime {
  String get toStandardFormat => DateFormat('dd MMMM yyyy')
      .add_jm()
      .format(
        this,
      )
      .toUpperCase();
}
