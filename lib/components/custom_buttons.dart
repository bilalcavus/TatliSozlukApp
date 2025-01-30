import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:tatli_sozluk/components/custom_colors.dart';



class CustomIconButton {
  IconButton notificationButton = IconButton(onPressed: (){}, icon: const Icon(Iconsax.notification), color: CustomColors().entryIconButtonColor);
  IconButton sortButton = IconButton(onPressed: (){}, icon: const Icon(Iconsax.sort), color: CustomColors().entryIconButtonColor);
  IconButton searchButton = IconButton(onPressed: (){}, icon: const Icon(Iconsax.search_normal4), color:CustomColors().entryIconButtonColor);
  IconButton shareButton = IconButton(onPressed: (){}, icon: const Icon(Iconsax.share), color: CustomColors().entryIconButtonColor);
}

