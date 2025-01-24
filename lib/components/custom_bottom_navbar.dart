import 'package:flutter/material.dart';


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
      backgroundColor: const Color.fromARGB(255, 234, 236, 243),
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
          icon: Icon(Icons.home),
          label: 'Anasayfa',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.search),
          label: 'Arama',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.notifications),
          label: 'Bildirimler',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Hesabım',
        ),
      ],
    );
  }
}
