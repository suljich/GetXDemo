import 'package:get/get.dart';
import 'package:getx_demo/app/data/model/account.dart';
import 'package:getx_demo/app/data/model/transaction.dart';
import 'package:getx_demo/app/data/source/data_source.dart';

abstract class AccountRepository {
  Account getMyAccount();
  List<Transaction> getTransactionsForAccount(Account account);
}

class AccountRepositoryImpl extends AccountRepository {
  final dataSource = Get.find<DataSource>();

  Account? myAccount;

  @override
  Account getMyAccount() =>
      myAccount ?? (myAccount = dataSource.getMyAccount());

  @override
  List<Transaction> getTransactionsForAccount(Account account) =>
      dataSource.getTransactionsForAccount(account);
}
