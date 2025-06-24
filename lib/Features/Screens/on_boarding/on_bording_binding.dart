import 'package:get/get.dart';
import 'package:juyelari/Features/Screens/on_boarding/on_boarding_screen_controller.dart';

class OnBoardingScreen extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OnBoardingScreenController>(
      () => OnBoardingScreenController(),
    );
  }
}