import 'dart:typed_data';
import 'package:universal_html/html.dart' as html;

import 'package:flutter_dropzone/flutter_dropzone.dart';
import 'package:get/get.dart';
import 'package:pine_admin_panel/utils/constants/enums.dart';

import '../models/image_model.dart';

class MediaController extends GetxController {
  static MediaController get instance => Get.find();

  late DropzoneViewController dropzoneController;
  final RxBool showImagesUploaderSection = false.obs;
  final Rx<MediaCategory> selectedPath = MediaCategory.folders.obs;
  final RxList<ImageModel> selectedImagesToUpload = <ImageModel>[].obs;


  /// Select Local Images on Button Press
  Future<void> selectLocalImages() async {
    final files = await dropzoneController.pickFiles(multiple: true, mime: ['image/jpeg', 'image/png']);
    if (files.isNotEmpty) {
      for (var file in files) {
        // Retrieve file data as Uint8List
        final bytes = await dropzoneController.getFileData(file);
        // Extract file metadata
        final filename = await dropzoneController.getFilename(file);
        final mimeType = await dropzoneController.getFileMIME(file);
        final image = ImageModel(
          url: '',
          folder: '',
          filename: filename,
          contentType: mimeType,
          localImageToDisplay: Uint8List.fromList(bytes),
        );
        selectedImagesToUpload.add(image);
      }
    }
  }
}