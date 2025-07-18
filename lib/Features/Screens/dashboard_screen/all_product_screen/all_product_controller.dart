
import 'package:get/get.dart';

class AllProductController extends GetxController {
  final RxMap<int, RxBool> favouriteMap = <int, RxBool>{}.obs;

  void toggleFavourite(int productId) {
    if (!favouriteMap.containsKey(productId)) {
      favouriteMap[productId] = false.obs;
    }
    favouriteMap[productId]!.value = !favouriteMap[productId]!.value;
    // Optionally call API to update server
  }
}