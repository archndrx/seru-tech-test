import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_tesseract_ocr/android_ios.dart';
import 'package:image_picker/image_picker.dart';
import 'package:photo_view/photo_view.dart';
import 'package:provider/provider.dart';
import 'package:seru_tech_test/model/user_model.dart';
import 'package:seru_tech_test/provider/screen_two_provider.dart';
import 'package:seru_tech_test/shared/theme.dart';
import 'package:seru_tech_test/view/screen_three.dart';
import 'package:seru_tech_test/widgets/buttons.dart';

class ScreenTwo extends StatefulWidget {
  final UserModel data;
  const ScreenTwo({Key? key, required this.data}) : super(key: key);

  @override
  _ScreenTwoState createState() => _ScreenTwoState();
}

class _ScreenTwoState extends State<ScreenTwo> {
  String nik = '';

  Future<void> _showFullScreenImage(File? imageFile) async {
    if (imageFile != null) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => FullScreenImage(imageFile: imageFile),
        ),
      );
    }
  }

  Future<void> _getImage(ImageSource source, String type) async {
    final pickedFile = await ImagePicker().pickImage(source: source);

    if (pickedFile != null) {
      File imageFile = File(pickedFile.path);
      Provider.of<ScreenTwoProvider>(context, listen: false)
          .setImage(imageFile, type);

      // Read text from KTP after setting the image
      if (type == 'ktp') {
        await _readTextFromKtp(imageFile);
      }
    }
  }

  Future<void> _readTextFromKtp(File imageFile) async {
    try {
      String result = await FlutterTesseractOcr.extractText(imageFile.path);

      // Proses untuk mengekstrak NIK dari teks yang sudah ada
      String nikCleaned = _extractNikFromText(result);

      if (nikCleaned.isNotEmpty) {
        nik = nikCleaned;
        setState(() {});
      } else {}
    } catch (e) {
      rethrow;
    }
  }

  String _extractNikFromText(String text) {
    // Mencari pola NIK yang terdiri dari 16 digit
    RegExp nikRegExp = RegExp(r'\b\d{16}\b');
    Match? nikMatch = nikRegExp.firstMatch(text);

    if (nikMatch != null) {
      return nikMatch.group(0) ?? ''; // Mengambil nilai yang cocok
    } else {
      return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Screen 2"),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(
          horizontal: 24,
        ),
        children: [
          const SizedBox(
            height: 30,
          ),
          Container(
            padding: const EdgeInsets.all(22),
            decoration: BoxDecoration(
              color: lightBackgroundColor,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildImagePreview("Selfie", 'selfie'),
                _buildImagePreview("KTP", 'ktp'),
                _buildImagePreview("Foto Bebas", 'free'),
              ],
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          CustomFilledButton(
            title: 'Continue',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ScreenThree(
                    data: widget.data.copyWith(
                      selfieUrl:
                          Provider.of<ScreenTwoProvider>(context, listen: false)
                              .selfieImage
                              ?.path,
                      ktpUrl:
                          Provider.of<ScreenTwoProvider>(context, listen: false)
                              .ktpImage
                              ?.path,
                      fotobebasUrl:
                          Provider.of<ScreenTwoProvider>(context, listen: false)
                              .freeImage
                              ?.path,
                      nik: nik,
                    ),
                  ),
                ),
              );
            },
          ),
          const SizedBox(
            height: 50,
          ),
        ],
      ),
    );
  }

  Widget _buildImagePreview(String title, String type) {
    return Consumer<ScreenTwoProvider>(
      builder: (context, provider, child) {
        File? imageFile;
        switch (type) {
          case 'selfie':
            imageFile = provider.selfieImage;
            break;
          case 'ktp':
            imageFile = provider.ktpImage;
            break;
          case 'free':
            imageFile = provider.freeImage;
            break;
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: blackTextStyle.copyWith(
                fontSize: 18,
                fontWeight: semibold,
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            GestureDetector(
              onTap: () => _getImage(
                ImageSource.gallery,
                type,
              ),
              child: Container(
                height: 200,
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: blackColor,
                  ),
                  borderRadius: BorderRadius.circular(
                    10,
                  ),
                ),
                child: GestureDetector(
                  onTap: () => _showFullScreenImage(
                    imageFile,
                  ),
                  child: imageFile != null
                      ? Stack(
                          fit: StackFit.expand,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(
                                10,
                              ),
                              child: Image.file(
                                imageFile,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Align(
                              alignment: Alignment.bottomRight,
                              child: IconButton(
                                onPressed: () {
                                  Provider.of<ScreenTwoProvider>(context,
                                          listen: false)
                                      .deleteImage(type);
                                },
                                icon: const Icon(
                                  Icons.delete,
                                  size: 30,
                                  color: Colors.red,
                                ),
                              ),
                            ),
                          ],
                        )
                      : GestureDetector(
                          onTap: () => _getImage(ImageSource.gallery, type),
                          child: Icon(Icons.add, size: 50, color: blackColor),
                        ),
                ),
              ),
            ),
            const SizedBox(height: 16),
          ],
        );
      },
    );
  }
}

class FullScreenImage extends StatelessWidget {
  final File imageFile;

  const FullScreenImage({Key? key, required this.imageFile}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Full Screen Image"),
      ),
      body: Center(
        child: PhotoView(
          imageProvider: FileImage(imageFile),
          minScale: PhotoViewComputedScale.contained,
          maxScale: PhotoViewComputedScale.covered * 2,
          enableRotation: false,
          backgroundDecoration: const BoxDecoration(
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
