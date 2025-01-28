import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:tatli_sozluk/components/custom_colors.dart';

class CustomTextButton {
  List<String> buttonLabels = ['bugün', 'gündem', 'tarihte bugün', 'takip'];

  List<Widget> createButtons(void Function(String label) onPressedCallback) {
    return buttonLabels.map((label) {
      return TextButton(
        onPressed: () {
          onPressedCallback(label); 
        },
        child: Text(
          label,
          style: TextStyle(color: CustomColors().appBarTextButtonColor),
        ),
      );
    }).toList();
  }
}

class CustomIconButton {
  IconButton notificationButton = IconButton(onPressed: (){}, icon: const Icon(Iconsax.notification), color: CustomColors().entryIconButtonColor);
  IconButton sortButton = IconButton(onPressed: (){}, icon: const Icon(Iconsax.sort), color: CustomColors().entryIconButtonColor);
  IconButton searchButton = IconButton(onPressed: (){}, icon: const Icon(Iconsax.search_normal4), color:CustomColors().entryIconButtonColor);
  IconButton shareButton = IconButton(onPressed: (){}, icon: const Icon(Iconsax.share), color: CustomColors().entryIconButtonColor);
}

