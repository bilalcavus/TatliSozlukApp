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
  @override
  Widget build(BuildContext context) {
      final TitleOpController controller = Get.put(TitleOpController());
      final BottomNavigationController itemController = Get.put(BottomNavigationController());
  void openTitleBox() {
      showDialog(context: context, builder: (context) => AlertDialog(
        content: TextField(
          controller: controller.textEditingController,
          decoration: const InputDecoration(
            hintText: 'Başlık giriniz',
            labelText: 'Başlık',
          ),
        ),
        actions: [
          ElevatedButton(onPressed: (){
            controller.firestoreService.addTitle(controller.textEditingController.text);
            controller.textEditingController.clear();
            Navigator.of(context).pop();
          },
          child: Text('Ekle')
          )
        ],
      ));
    }
    return Scaffold(
      backgroundColor: CustomColors().scaffoldColor,
      appBar: AppBar(
        actions: [
          TextButton(onPressed: (){}, child: Text('bugün'))
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilderContent(controller: controller))]),
      floatingActionButton: FloatingActionButton(
        backgroundColor: CustomColors().floatingActionButtonColor,
        foregroundColor: Colors.black,
        onPressed: openTitleBox,
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: Obx( () => CustomBottomNavigationBar(
        selectedIndex: itemController.selectedIndex.value,
        onItemTapped : (index) => itemController.onItemTapped(index),
      )),
    );
  }
}

