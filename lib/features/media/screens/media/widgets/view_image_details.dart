import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:pine_admin_panel/common/widgets/containers/rounded_container.dart';
import 'package:pine_admin_panel/common/widgets/images/p_rounded_image.dart';
import 'package:pine_admin_panel/features/media/controllers/media_controller.dart';
import 'package:pine_admin_panel/features/media/models/image_model.dart';
import 'package:pine_admin_panel/utils/constants/colors.dart';
import 'package:pine_admin_panel/utils/constants/enums.dart';
import 'package:pine_admin_panel/utils/constants/sizes.dart';
import 'package:pine_admin_panel/utils/device/device_utility.dart';
import 'package:pine_admin_panel/utils/popups/loaders.dart';

class ImagePopup extends StatelessWidget {
  // The image model to display detailed information about
  final ImageModel image;

  // Constructor for the ImagePopup class
  const ImagePopup({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Dialog(
        // Define the shape of the dialog
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(PSizes.borderRadiusLg)),
        child: PRoundedContainer(
          // Set the width of the rounded container based on the screen size
          width: PDeviceUtils.isDesktopScreen(context) ? MediaQuery.of(context).size.width * 0.4 : double.infinity,
          padding: const EdgeInsets.all(PSizes.spaceBtwItems),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Display the image with an option to close the dialog
              SizedBox(
                child: Stack(
                  children: [
                    // Display the image with rounded container
                    PRoundedContainer(
                      backgroundColor: PColors.primaryBackground,
                      child: PRoundedImage(
                        image: image.url,
                          applyImageRadius: true,
                          height: MediaQuery.of(context).size.height * 0.4,
                          width: PDeviceUtils.isDesktopScreen(context) ? MediaQuery.of(context).size.width * 0.4 : double.infinity,
                          imageType: ImageType.network,
                      ),
                    ),

                    // Close icon button positioned at the top-right corner
                    Positioned(top: 0, right: 0, child: IconButton(onPressed: () => Get.back(), icon: const Icon(Iconsax.close_circle)))
                  ],
                ),
              ),
              const Divider(),
              const SizedBox(height: PSizes.spaceBtwItems),
              
              // Display various metadata about the image
              // Includes image name, path, type size, creation and modification dates, and URL
              // Also provides an option to copy the image URL
              Row(
                children: [
                  Expanded(child: Text('Tên ảnh', style: Theme.of(context).textTheme.bodyLarge)),
                  Expanded(flex: 3, child: Text(image.filename, style: Theme.of(context).textTheme.titleLarge)),
                ],
              ),

              // Display the image URL with an option to copy it
              Row(
                children: [
                  Expanded(child: Text('Image URL:', style: Theme.of(context).textTheme.bodyLarge)),
                  Expanded(
                    flex: 2,
                    child: Text(image.url, style: Theme.of(context).textTheme.titleLarge, maxLines: 1, overflow: TextOverflow.ellipsis),
                  ),
                  Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      FlutterClipboard.copy(image.url).then((value) => PLoaders.customToast(message: 'URL copied'));
                    },
                    child: const Text('Copy URL'),
                  ),
                  ),
                ],
              ),
              const SizedBox(height: PSizes.spaceBtwSections),

              // Display a button to delete the image
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 300,
                    child: TextButton(
                        onPressed: () => MediaController.instance.removeCloudImageConfirmation(image),
                        child: const Text('Xóa ảnh', style: TextStyle(color: Colors.red)),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
