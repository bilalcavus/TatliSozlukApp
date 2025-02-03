import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/instance_manager.dart';
import 'package:tatli_sozluk/components/custom_bottom_navbar.dart';
import 'package:tatli_sozluk/components/custom_colors.dart';
import 'package:tatli_sozluk/controller/bottom_navigation_controller.dart';
import 'package:tatli_sozluk/controller/title_op_controller.dart';
import 'package:tatli_sozluk/widgets/title_stream_widget.dart';

class HomePageView extends StatefulWidget {
  const HomePageView({super.key});
  @override
  State<HomePageView> createState() => _HomePageViewState();
}
class _HomePageViewState extends State<HomePageView> {
  final TitleOpController controller = Get.put(TitleOpController());
  final BottomNavigationController itemController = Get.put(BottomNavigationController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(onPressed: (){}, child: Text('bugün', style: TextStyle(color: CustomColors().floatingActionButtonColor))),
          TextButton(onPressed: (){}, child: Text('gündem',style: TextStyle(color: CustomColors().floatingActionButtonColor))),
          TextButton(onPressed: (){}, child: Text('tarihte bugün',style: TextStyle(color: CustomColors().floatingActionButtonColor))),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilderContent(controller: controller))]),
      bottomNavigationBar: Obx( () => CustomBottomNavigationBar(
        selectedIndex: itemController.selectedIndex.value,
        onItemTapped : (index) => itemController.onItemTapped(index),
      )),
    );
  }
}

