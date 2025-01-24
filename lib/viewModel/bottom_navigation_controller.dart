// Kontrolör sınıfı
import 'package:get/state_manager.dart';

class BottomNavigationController extends GetxController {
  // Reaktif bir değişken tanımlıyoruz
  var selectedIndex = 0.obs;

  // Seçim değiştirme metodu
  void onItemTapped(int index) {
    selectedIndex.value = index;
  }
}
