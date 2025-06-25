import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:juyelari/Features/Custom_widgets/custom_widgets.dart';
import 'package:juyelari/Features/Screens/review_order_details/review_order_details_controller.dart';

class ReviewOrderDetailsScreen extends StatelessWidget {
  const ReviewOrderDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ReviewOrderDetailsController controller =
        Get.put(ReviewOrderDetailsController());

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomWidgets().customAppBar(
        title: 'Review Your Order',
        leadingIcon: Icons.arrow_back_ios,
        onLeadingPressed: () => Get.back(),
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 20),
            color: Colors.white,
            child: Obx(() => Row(
                  children: List.generate(
                    controller.steps.length * 2 - 1,
                    (index) {
                      if (index.isOdd) {
                        return const Expanded(
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 4),
                            child: DottedLine(
                              dashLength: 5,
                              dashColor: Colors.grey,
                              lineThickness: 2,
                            ),
                          ),
                        );
                      } else {
                        int stepIndex = index ~/ 2;
                        bool isDone = controller.currentStep.value > stepIndex;
                        bool isActive =
                            controller.currentStep.value == stepIndex;

                        return Column(
                          children: [
                            GestureDetector(
                              onTap: () {
                                if (controller.canGoToStep(stepIndex)) {
                                  controller.goToStep(stepIndex);
                                }
                              },
                              child: CircleAvatar(
                                radius: 18,
                                backgroundColor: isDone
                                    ? Colors.green
                                    : isActive
                                        ? Colors.blue
                                        : Colors.grey[300],
                                child: isDone
                                    ? const Icon(Icons.check,
                                        color: Colors.white, size: 18)
                                    : Text(
                                        "${stepIndex + 1}",
                                        style: TextStyle(
                                          color: isActive
                                              ? Colors.white
                                              : Colors.black,
                                        ),
                                      ),
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              controller.steps[stepIndex],
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: isActive
                                    ? FontWeight.bold
                                    : FontWeight.normal,
                                color:
                                    isActive ? Colors.blue : Colors.black,
                              ),
                            ),
                          ],
                        );
                      }
                    },
                  ),
                )),
          ),

          const SizedBox(height: 20),

          /// Step content
          Obx(() {
            int step = controller.currentStep.value;
            String title = controller.steps[step];

            return Column(
              children: [
                Text(
                  "Current Step: $title",
                  style: const TextStyle(fontSize: 18),
                ),
                const SizedBox(height: 10),
                if (step == 0 && !controller.isReviewDone.value)
                  ElevatedButton(
                    onPressed: controller.completeReview,
                    child: const Text("Mark Review as Done"),
                  ),
              ],
            );
          }),

       

          Obx((){
            if(!controller.isReviewDone.value){
              return const SizedBox.shrink();
            }
            return  Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                    onPressed: controller.currentStep.value > 0
                        ? controller.previousStep
                        : null,
                    child: const Text('Back'),
                  ),
                  ElevatedButton(
                    onPressed: controller.currentStep.value <
                                controller.steps.length - 1 &&
                            controller.canGoToStep(
                                controller.currentStep.value + 1)
                        ? controller.nextStep
                        : null,
                    child: const Text('Next'),
                  ),
                ],
              );}),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
