import 'dart:typed_data';
import 'package:image_picker/image_picker.dart';

mixin ImagePickerMixin {
  final ImagePicker _imagePicker = ImagePicker();

  Future<Uint8List?> pickImageFromGallery({
    double maxWidth = 1920,
    double maxHeight = 1080,
    int imageQuality = 85,
  }) async {
    try {
      final XFile? pickedFile = await _imagePicker.pickImage(
        source: ImageSource.gallery,
        maxWidth: maxWidth,
        maxHeight: maxHeight,
        imageQuality: imageQuality,
      );

      if (pickedFile != null) {
        return await pickedFile.readAsBytes();
      }
      return null;
    } catch (_) {
      rethrow;
    }
  }

  Future<Uint8List?> pickImageFromCamera({
    double maxWidth = 1920,
    double maxHeight = 1080,
    int imageQuality = 85,
  }) async {
    try {
      final XFile? pickedFile = await _imagePicker.pickImage(
        source: ImageSource.camera,
        maxWidth: maxWidth,
        maxHeight: maxHeight,
        imageQuality: imageQuality,
      );

      if (pickedFile != null) {
        return await pickedFile.readAsBytes();
      }
      return null;
    } catch (_) {
      rethrow;
    }
  }
}
