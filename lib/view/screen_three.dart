import 'package:flutter/material.dart';
import 'package:seru_tech_test/model/user_model.dart';
import 'package:seru_tech_test/shared/theme.dart';

class ScreenThree extends StatefulWidget {
  final UserModel data;
  const ScreenThree({super.key, required this.data});

  @override
  State<ScreenThree> createState() => _ScreenThreeState();
}

class _ScreenThreeState extends State<ScreenThree> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Screen Three"),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        children: [
          const SizedBox(
            height: 30.0,
          ),
          Container(
            padding: const EdgeInsets.all(22.0),
            decoration: BoxDecoration(
              color: lightBackgroundColor,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'First Name : ${widget.data.firstName!}',
                  style: blackTextStyle.copyWith(
                    fontSize: 18,
                    fontWeight: semibold,
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                Text(
                  'Last Name : ${widget.data.lastName!}',
                  style: blackTextStyle.copyWith(
                    fontSize: 18,
                    fontWeight: semibold,
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                Text(
                  'Biodata : ${widget.data.biodata!}',
                  style: blackTextStyle.copyWith(
                    fontSize: 18,
                    fontWeight: semibold,
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                Text(
                  'Provinsi : ${widget.data.province!}',
                  style: blackTextStyle.copyWith(
                    fontSize: 18,
                    fontWeight: semibold,
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                Text(
                  'Kabupaten/Kota : ${widget.data.district!}',
                  style: blackTextStyle.copyWith(
                    fontSize: 18,
                    fontWeight: semibold,
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                Text(
                  'Kecamatan : ${widget.data.subDistrict!}',
                  style: blackTextStyle.copyWith(
                    fontSize: 18,
                    fontWeight: semibold,
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                Text(
                  'Kelurahan : ${widget.data.village!}',
                  style: blackTextStyle.copyWith(
                    fontSize: 18,
                    fontWeight: semibold,
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                Text(
                  'NIK : ${widget.data.nik!}',
                  style: blackTextStyle.copyWith(
                    fontSize: 18,
                    fontWeight: semibold,
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                Text(
                  'Url Foto Selfie : ${widget.data.selfieUrl!}',
                  style: blackTextStyle.copyWith(
                    fontSize: 18,
                    fontWeight: semibold,
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                Text(
                  'Url Foto KTP : ${widget.data.ktpUrl!}',
                  style: blackTextStyle.copyWith(
                    fontSize: 18,
                    fontWeight: semibold,
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                Text(
                  'Url Foto Bebas : ${widget.data.fotobebasUrl!}',
                  style: blackTextStyle.copyWith(
                    fontSize: 18,
                    fontWeight: semibold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
