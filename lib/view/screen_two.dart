import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:photo_view/photo_view.dart';
import 'package:provider/provider.dart';
import 'package:seru_tech_test/model/user_model.dart';
import 'package:seru_tech_test/provider/screen_two_provider.dart';
import 'package:seru_tech_test/shared/shared_method.dart';
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
  // VALIADASI FORM KOSONG
  bool validate() {
    if (Provider.of<ScreenTwoProvider>(context, listen: false).selfieImage ==
            null ||
        Provider.of<ScreenTwoProvider>(context, listen: false).ktpImage ==
            null ||
        Provider.of<ScreenTwoProvider>(context, listen: false).freeImage ==
            null) {
      return false;
    }
    return true;
  }

  // NAVIGASI KE HALAMAN FULLSCREEN GAMBAR
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
              if (validate()) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ScreenThree(
                      data: widget.data.copyWith(
                        selfieUrl: Provider.of<ScreenTwoProvider>(context,
                                listen: false)
                            .selfieImage
                            ?.path,
                        ktpUrl: Provider.of<ScreenTwoProvider>(context,
                                listen: false)
                            .ktpImage
                            ?.path,
                        fotobebasUrl: Provider.of<ScreenTwoProvider>(context,
                                listen: false)
                            .freeImage
                            ?.path,
                        nik: Provider.of<ScreenTwoProvider>(context,
                                listen: false)
                            .nik,
                      ),
                    ),
                  ),
                );
              } else {
                showCustomSnackbar(context, 'Semua Field Harus Diisi');
              }
            },
          ),
          const SizedBox(
            height: 50,
          ),
        ],
      ),
    );
  }

  // IMAGE PREVIEW WIDGET
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
              onTap: () => provider.getImage(ImageSource.gallery, type),
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
                          onTap: () =>
                              provider.getImage(ImageSource.gallery, type),
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

// HALAMAN FULLSCREEN GAMBAR & FITUR ZOOM IN/ZOOM OUT
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
