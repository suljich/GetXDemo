import 'package:get/get.dart';

import '../controllers/loan_application_controller.dart';

class LoanApplicationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LoanApplicationController>(
      () => LoanApplicationController(),
    );
  }
}
