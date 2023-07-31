import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

part 'transaction.freezed.dart';
// part 'transaction.g.dart';

enum TransactionType {
  topup,
  expense,
  loan,
}

@unfreezed
class Transaction with _$Transaction {
  factory Transaction({
    required final String title,
    required double amount,
    required final TransactionType type,
    required final DateTime dateTime,
    required final String id,
  }) = _Transaction;

  Transaction._();

  final isRepeating = false.obs;
  final isSplit = false.obs;

  static const icons = {
    TransactionType.topup: Icons.add_circle,
    TransactionType.expense: Icons.shopping_bag,
    TransactionType.loan: Icons.money,
  };
}

extension DateTimeFormating on DateTime {
  String get toStandardFormat =>
      DateFormat('dd MMMM yyyy').add_jm().format(this).toUpperCase();
}

// class Transaction {
//   final String title;
//   double amount;
//   final TransactionType type;
//   final DateTime dateTime;
//   final String id;
//   final isRepeating = false.obs;
//   var isSplit = false;

//   Transaction({
//     required this.title,
//     required this.type,
//     required this.dateTime,
//     required this.id,
//     required this.amount,
//   });
// }