import 'dart:io';

import 'package:flutter/material.dart';

class ScreenTwoProvider extends ChangeNotifier {
  File? selfieImage;
  File? ktpImage;
  File? freeImage;

  void setImage(File? image, String type) {
    switch (type) {
      case 'selfie':
        selfieImage = image;
        break;
      case 'ktp':
        ktpImage = image;
        break;
      case 'free':
        freeImage = image;
        break;
    }
    notifyListeners();
  }

  void deleteImage(String type) {
    switch (type) {
      case 'selfie':
        selfieImage = null;
        break;
      case 'ktp':
        ktpImage = null;
        break;
      case 'free':
        freeImage = null;
        break;
    }
    notifyListeners();
  }
}
