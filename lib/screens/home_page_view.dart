import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/instance_manager.dart';
import 'package:tatli_sozluk/components/custom_bottom_navbar.dart';
import 'package:tatli_sozluk/viewModel/bottom_navigation_controller.dart';

class HomePageView extends StatefulWidget {
  const HomePageView({super.key});

  @override
  State<HomePageView> createState() => _HomePageViewState();
}

class _HomePageViewState extends State<HomePageView> {
  final BottomNavigationController itemController = Get.put(BottomNavigationController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Anasayfa'),
        backgroundColor: Theme.of(context).colorScheme.primary,
        ),
      body:  Column(children: [

      ],),
      bottomNavigationBar: Obx( () => CustomBottomNavigationBar(
        selectedIndex: itemController.selectedIndex.value,
        onItemTapped : (index) => itemController.onItemTapped(index),
      )),
    );
  }
}