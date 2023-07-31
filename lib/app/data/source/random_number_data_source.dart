import 'package:get/get.dart';

class RandomNumberDataSource extends GetConnect implements GetxService {
  Future<int> get randomNumber async {
    final response = await get(
      'http://www.randomnumberapi.com/api/v1.0/randomredditnumber?min=0&max=100&count=1',
      contentType: 'List<int>',
    );
    return response.body![0];
  }
}
