import 'package:get/get.dart';

import '../modules/loan_application/bindings/loan_application_binding.dart';
import '../modules/loan_application/views/loan_application_view.dart';
import '../modules/pay/bindings/pay_binding.dart';
import '../modules/pay/views/pay_view.dart';
import '../modules/top_up/bindings/top_up_binding.dart';
import '../modules/top_up/views/top_up_view.dart';
import '../modules/transaction_details/bindings/transaction_details_binding.dart';
import '../modules/transaction_details/views/transaction_details_view.dart';
import '../modules/transactions/bindings/transactions_binding.dart';
import '../modules/transactions/views/transactions_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  // ignore: constant_identifier_names
  static const INITIAL = Routes.TRANSACTIONS;

  static final routes = [
    GetPage(
      name: _Paths.TRANSACTIONS,
      page: () => const TransactionsView(),
      binding: TransactionsBinding(),
    ),
    GetPage(
      name: _Paths.TRANSACTION_DETAILS,
      page: () => const TransactionDetailsView(),
      binding: TransactionDetailsBinding(),
    ),
    GetPage(
      name: _Paths.LOAN_APPLICATION,
      page: () => const LoanApplicationView(),
      binding: LoanApplicationBinding(),
    ),
    GetPage(
      name: _Paths.PAY,
      page: () => const PayView(),
      binding: PayBinding(),
    ),
    GetPage(
      name: _Paths.TOP_UP,
      page: () => const TopUpView(),
      binding: TopUpBinding(),
    ),
  ];
}
