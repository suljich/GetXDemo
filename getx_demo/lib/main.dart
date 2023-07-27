import 'package:flutter/material.dart';

import 'package:get/get_navigation/get_navigation.dart';

import 'package:getx_demo/screens/loan_application_screen.dart';
import 'package:getx_demo/screens/pay_screen.dart';
import 'package:getx_demo/screens/top_up_screen.dart';
import 'package:getx_demo/screens/transactions_screen.dart';

void main() {
  runApp(
    GetMaterialApp(
      routes: {
        TransactionsScreen.route: (_) => const TransactionsScreen(),
        // TransactionDetailsScreen.route:(_) => const TransactionDetailsScreen(transaction: transaction,)
        TopUpScreen.route: (_) => const TopUpScreen(),
        PayScreen.route: (_) => const PayScreen(),
        // PayConfirmationScreen.route:(_) => const PayConfirmationScreen(value: ,),
        LoanApplicationScreen.route: (_) => LoanApplicationScreen(),
      },
      home: const TransactionsScreen(),
      theme: ThemeData(
        primaryColor: const Color(
          0xFFC0028B,
        ),
        appBarTheme: const AppBarTheme(
          color: Color(
            0xFFC0028B,
          ),
        ),
        elevatedButtonTheme: const ElevatedButtonThemeData(
          style: ButtonStyle(
            backgroundColor: MaterialStatePropertyAll(
              Color(
                0xFFC0028B,
              ),
            ),
          ),
        ),
        fontFamily: 'Montserrat',
      ),
    ),
  );
}
