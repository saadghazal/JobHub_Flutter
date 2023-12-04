import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jobhub/constants/app_constants.dart';
import 'package:uuid/uuid.dart';

class ImageUploader extends ChangeNotifier {
  var uuid = Uuid();
  final ImagePicker _picker = ImagePicker();

  String? imageUrl;
  String? imagePath;

  List<String> imageFil = [];

  void pickImage() async {
    XFile? _imageFile = await _picker.pickImage(source: ImageSource.gallery);

    _imageFile = await cropImage(imageFile: _imageFile!);
    if (_imageFile != null) {
      imageFil.add(_imageFile.path);
      await imageUpload(uploadedImage: _imageFile);
      imagePath = _imageFile.path;
    } else {
      return;
    }
  }

  Future<XFile?> cropImage({required XFile imageFile}) async {
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

  Future<String?> imageUpload({required XFile uploadedImage}) async {
    File image = File(uploadedImage.path);
    try {
      final ref = FirebaseStorage.instance
          .ref()
          .child('jobhub')
          .child('${uuid.v1()}.jpg');

      await ref.putFile(image);
      imageUrl = await ref.getDownloadURL();

      print(imageUrl);
      return imageUrl;
    } catch (e) {
      print(e);
      return null;
    }
  }
}
