import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:pine_admin_panel/common/widgets/containers/rounded_container.dart';
import 'package:pine_admin_panel/features/media/controllers/media_controller.dart';

import '../../../../../common/widgets/images/p_rounded_image.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/enums.dart';
import '../../../../../utils/constants/image_strings.dart';
import '../../../../../utils/constants/sizes.dart';
import 'folder_dropdown.dart';

class MediaContent extends StatelessWidget {
  const MediaContent({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = MediaController.instance;
    return PRoundedContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Media Images Header
          Row(
            children: [
              Text('Chọn tệp', style: Theme.of(context).textTheme.headlineSmall),
              const SizedBox(width: PSizes.spaceBtwItems),
              MediaFolderDropdown(onChanged: (MediaCategory? newValue) {
                if (newValue != null) {
                  controller.selectedPath.value = newValue;
                }
              }),
            ],
          ),
          const SizedBox(height: PSizes.spaceBtwSections),

          /// Show Media
          const Wrap(
            alignment: WrapAlignment.start,
            spacing: PSizes.spaceBtwItems / 2,
            runSpacing: PSizes.spaceBtwItems / 2,
            children: [
              PRoundedImage(
                width: 90,
                height: 90,
                padding: PSizes.sm,
                imageType: ImageType.asset,
                image: PImages.lightAppLogo,
                backgroundColor: PColors.primaryBackground,
              ),
              PRoundedImage(
                width: 90,
                height: 90,
                padding: PSizes.sm,
                imageType: ImageType.asset,
                image: PImages.lightAppLogo,
                backgroundColor: PColors.primaryBackground,
              ),
              PRoundedImage(
                width: 90,
                height: 90,
                padding: PSizes.sm,
                imageType: ImageType.asset,
                image: PImages.lightAppLogo,
                backgroundColor: PColors.primaryBackground,
              ),
              PRoundedImage(
                width: 90,
                height: 90,
                padding: PSizes.sm,
                imageType: ImageType.asset,
                image: PImages.lightAppLogo,
                backgroundColor: PColors.primaryBackground,
              ),
              PRoundedImage(
                width: 90,
                height: 90,
                padding: PSizes.sm,
                imageType: ImageType.asset,
                image: PImages.lightAppLogo,
                backgroundColor: PColors.primaryBackground,
              ),
            ],
          ),

          /// Load More Media Button
          Padding(
            padding: const EdgeInsets.symmetric(vertical: PSizes.spaceBtwSections),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: PSizes.buttonWidth,
                  child: ElevatedButton.icon(
                      onPressed: () {}, 
                      label: const Text('Tải thêm'),
                      icon: const Icon(Iconsax.arrow_down),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
