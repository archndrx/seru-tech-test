import 'dart:io';
import 'package:flutter_tesseract_ocr/android_ios.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ScreenTwoProvider extends ChangeNotifier {
  String _nik = '';
  File? selfieImage;
  File? ktpImage;
  File? freeImage;

  String get nik => _nik;

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

  Future<void> getImage(ImageSource source, String type) async {
    final pickedFile = await ImagePicker().pickImage(source: source);

    if (pickedFile != null) {
      File imageFile = File(pickedFile.path);
      setImage(imageFile, type);

      // MEMBACA TEXT DARI IMAGE KTP
      if (type == 'ktp') {
        await readTextFromKtp(imageFile);
      }
    }
  }

  Future<void> readTextFromKtp(File imageFile) async {
    try {
      String result = await FlutterTesseractOcr.extractText(imageFile.path);

      // EKSTRAK NIK DARI TEKS YANG ADA
      String nikCleaned = extractNikFromText(result);

      if (nikCleaned.isNotEmpty) {
        _nik = nikCleaned;
      } else {}
    } catch (e) {
      rethrow;
    }
  }

  String extractNikFromText(String text) {
    // MENCARI POLA NIK 16 DIGIT
    RegExp nikRegExp = RegExp(r'\b\d{16}\b');
    Match? nikMatch = nikRegExp.firstMatch(text);

    if (nikMatch != null) {
      return nikMatch.group(0) ?? ''; // MENYESUAIKAN VALUE YANG COCOK
    } else {
      return '';
    }
  }
}
