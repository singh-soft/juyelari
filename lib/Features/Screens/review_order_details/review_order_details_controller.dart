import 'package:get/get.dart';

class ReviewOrderDetailsController extends GetxController {
  var steps = ['Review', 'Payment', 'Order Placed'].obs;
  var currentStep = 0.obs;
  var selectedIndex = 0.obs;
  final List<Map<String, String>> products = [
    {
      'title': 'Classic Gold Bangle with Leaf Design',
      'price': '₹ 1749',
      'image': 'assets/images/necklacepic.png',
      'size': 'Free Size',
      'qty': '1',
      'return': 'All Issue easy returns'
    },
    {
      'title': 'Gold Ring Elegant Style',
      'price': '₹ 899',
      'image': 'assets/images/thumbring.png',
      'size': '6',
      'qty': '1',
      'return': '7-Day Returns'
    },
    {
      'title': 'Gold Ring Elegant Style',
      'price': '₹ 899',
      'image': 'assets/images/picjumka.jpg',
      'size': '6',
      'qty': '1',
      'return': '7-Day Returns'
    },
    {
      'title': 'Gold Ring Elegant Style',
      'price': '₹ 899',
      'image': 'assets/images/picjumka.jpg',
      'size': '6',
      'qty': '1',
      'return': '7-Day Returns'
    },
  ];

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
