import 'package:get/get.dart';

class RandomNumberDataSource extends GetConnect implements GetxService {
  @override
  void onInit() {
    httpClient.baseUrl = 'http://www.randomnumberapi.com/api/v1.0';
  }

  Future<int> get randomNumber async {
    final response = await get(
      '/randomredditnumber',
      // contentType: 'List<int>',
      contentType: 'application/x-www-form-urlencoded',
      query: {
        'min': 0,
        'max': 100,
        'count': 1,
      },
    );
    return response.body![0];
  }
}
