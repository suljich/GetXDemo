import 'package:getx_demo/app/data/model/transaction.dart';

import '../model/account.dart';

abstract class DataSource {
  Account getMyAccount();

  List<Transaction> getTransactionsForAccount(Account account);
}
