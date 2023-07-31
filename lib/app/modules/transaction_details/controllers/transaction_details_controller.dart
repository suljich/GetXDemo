import 'package:get/get.dart';

import 'package:getx_demo/app/data/model/account.dart';
import 'package:getx_demo/app/data/model/transaction.dart';
import 'package:getx_demo/app/data/repository/account_repository.dart';

class TransactionDetailsController extends GetxController {
  final Transaction transaction = Get.arguments;

  final _accountRepository = Get.find<AccountRepository>();
  Account get account => _accountRepository.getMyAccount();

  String get decimalPart =>
      ((transaction.amount - transaction.amount.truncate()) * 100).truncate() ==
              0
          ? '00'
          : ((transaction.amount - transaction.amount.truncate()) * 100)
              .truncate()
              .toString();
}
