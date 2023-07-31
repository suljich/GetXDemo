import 'package:get/get.dart';
import 'package:getx_demo/app/data/source/random_number_data_source.dart';

class RandomNumberRepository {
  final dataSource = Get.find<RandomNumberDataSource>();

  Future<int> get randomNumber async => await dataSource.randomNumber;
}
