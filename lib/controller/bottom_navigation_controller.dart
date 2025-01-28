// Kontrolör sınıfı
import 'package:get/state_manager.dart';

class BottomNavigationController extends GetxController {
  var selectedIndex = 0.obs;
  void onItemTapped(int index) {
    selectedIndex.value = index;
  }
}
