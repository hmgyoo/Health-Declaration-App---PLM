import 'package:get/get.dart';
import 'package:ihdplm_new/src/authentication/controllers/submit_controller.dart';

class MyBindings implements Bindings {
  @override
  void dependencies() {
    Get.put(SubmitController());
  }
}
