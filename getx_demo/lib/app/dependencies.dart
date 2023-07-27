import 'package:get/get.dart';
import 'package:getx_demo/app/data/repository/account_repository.dart';
import 'package:getx_demo/app/data/source/data_source.dart';
import 'package:getx_demo/app/data/source/mock_data_source.dart';

void injectDependencies() {
  Get.put<DataSource>(MockDataSource());
  Get.put<AccountRepository>(AccountRepositoryImpl());
}
