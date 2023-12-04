import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jobhub/constants/app_constants.dart';

class ImageUploader extends ChangeNotifier {
  final ImagePicker _picker = ImagePicker();

  String? imageUrl;
  String? imagePath;

  List<String> imageFil = [];

  void pickImage() async {
    XFile? _imageFile = await _picker.pickImage(source: ImageSource.gallery);

    _imageFile = await cropImage(imageFile: _imageFile!);
    if (_imageFile != null) {
      imageFil.add(_imageFile.path);
      imagePath = _imageFile.path;
    } else {
      return;
    }
  }

  cropImage({required XFile imageFile}) async {
    CroppedFile? croppedFile = await ImageCropper.platform.cropImage(
      sourcePath: imageFile.path,
      compressQuality: 70,
      cropStyle: CropStyle.rectangle,
      aspectRatioPresets: [CropAspectRatioPreset.ratio5x4],
      uiSettings: [
        AndroidUiSettings(
          toolbarTitle: 'JobHub',
          toolbarColor: Color(kLightBlue.value),
          toolbarWidgetColor: Color(kLight.value),
          initAspectRatio: CropAspectRatioPreset.ratio5x4,
          lockAspectRatio: true,
        ),
        IOSUiSettings(title: 'JobHub'),
      ],
    );
    if (croppedFile != null) {
      notifyListeners();
      return XFile(croppedFile.path);
    }
    return null;
  }
}
