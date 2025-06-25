import 'package:get/get.dart';

class ReviewOrderDetailsController extends GetxController {
  var steps = ['Review', 'Payment', 'Confirm'].obs;
  var currentStep = 0.obs;

  // This flag controls whether Review is done
  var isReviewDone = false.obs;

  void completeReview() {
    isReviewDone.value = true;
  }

  void nextStep() {
    if (canGoToStep(currentStep.value + 1)) {
      currentStep++;
    }
  }

  void previousStep() {
    if (currentStep > 0) currentStep--;
  }

  void goToStep(int index) {
    if (canGoToStep(index)) {
      currentStep.value = index;
    }
  }

  bool canGoToStep(int index) {
    if (index == 1 || index == 2) {
      return isReviewDone.value;
    }
    return index <= steps.length - 1;
  }
}
