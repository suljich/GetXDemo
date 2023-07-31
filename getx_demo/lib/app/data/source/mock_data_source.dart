import 'package:getx_demo/app/data/model/account.dart';
import 'package:getx_demo/app/data/model/transaction.dart';
import 'package:getx_demo/app/data/source/data_source.dart';

class MockDataSource extends DataSource {
  @override
  Account getMyAccount() => Account();

  @override
  List<Transaction> getTransactionsForAccount(Account account) =>
      account.transactions;
}
