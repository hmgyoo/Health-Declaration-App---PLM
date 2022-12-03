import 'package:get/get.dart';
import 'package:ihdplm_new/controllers/submit_controller.dart';

class MyBindings implements Bindings {
  @override
  void dependencies() {
    Get.put(SubmitController());
  }
}
