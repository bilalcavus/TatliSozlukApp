import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';


class CustomBottomNavigationBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemTapped;

  const CustomBottomNavigationBar({
    super.key,
    required this.selectedIndex,
    required this.onItemTapped,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      selectedItemColor: Color.fromARGB(255, 221, 185, 95),
      backgroundColor: Colors.black,
      currentIndex: selectedIndex,
      onTap: (int index) {  
        onItemTapped(index);
        switch (index) {
          case 0:
            Navigator.pushNamed(context, "/homePage");
            break;
          case 1:
            Navigator.pushNamed(context, "/searchPage");
            break;
          case 2:
            Navigator.pushNamed(context, "/notificationPage");
            break;
          case 3:
            Navigator.pushNamed(context, "/profilePage");
            break;
        }
      },
      type: BottomNavigationBarType.fixed,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Iconsax.home),
          label: 'Anasayfa',
        ),
        BottomNavigationBarItem(
          icon: Icon(Iconsax.search_normal_1),
          label: 'Arama',
        ),
        BottomNavigationBarItem(
          icon: Icon(Iconsax.notification4),
          label: 'Bildirimler',
        ),
        BottomNavigationBarItem(
          icon: Icon(Iconsax.user4),
          label: 'Hesabım',
        ),
      ],
    );
  }
}
