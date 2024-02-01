import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:seru_tech_test/model/user_model.dart';
import 'package:seru_tech_test/provider/screen_one_provider.dart';
import 'package:seru_tech_test/shared/shared_method.dart';
import 'package:seru_tech_test/shared/theme.dart';
import 'package:seru_tech_test/view/screen_two.dart';
import 'package:seru_tech_test/widgets/buttons.dart';
import 'package:seru_tech_test/widgets/form.dart';

class ScreenOne extends StatefulWidget {
  const ScreenOne({Key? key}) : super(key: key);

  @override
  State<ScreenOne> createState() => _ScreenOneState();
}

class _ScreenOneState extends State<ScreenOne> {
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController biodataController = TextEditingController();

  String _selectedProvince = '';
  String _selectedDistrict = '';
  String _selectedSubDistrict = '';
  String _selectedVillage = '';

  //VALIDASI FORM KOSONG
  bool validate() {
    if (firstNameController.text.isEmpty ||
        lastNameController.text.isEmpty ||
        biodataController.text.isEmpty ||
        _selectedProvince.isEmpty ||
        _selectedDistrict.isEmpty ||
        _selectedSubDistrict.isEmpty ||
        _selectedVillage.isEmpty) {
      return false;
    }
    return true;
  }

  @override
  void initState() {
    super.initState();
    Provider.of<ScreenOneProvider>(context, listen: false).fetchProvinces();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ScreenOneProvider>(builder: (context, provider, _) {
      return Scaffold(
        appBar: AppBar(
          title: const Text("Screen 1"),
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
                children: [
                  CustomFormField(
                    title: 'First Name',
                    controller: firstNameController,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  CustomFormField(
                    title: 'Last Name',
                    controller: lastNameController,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  CustomFormField(
                    title: 'Biodata',
                    keyType: TextInputType.multiline,
                    minLines: 6,
                    controller: biodataController,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  CustomDropDownSearchForm(
                    title: 'Provinsi',
                    items: provider.provinceNames,
                    selectedItem: _selectedProvince,
                    onChanged: (value) {
                      setState(() {
                        _selectedProvince = value.toString();
                        int? provinceId = provider.provinceData.firstWhere(
                          (province) => province['name'] == _selectedProvince,
                        )['id'];
                        if (provinceId != null) {
                          Provider.of<ScreenOneProvider>(context, listen: false)
                              .fetchDistricts(provinceId);
                        }
                      });
                    },
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  CustomDropDownSearchForm(
                    title: 'Kabupaten/Kota',
                    items: provider.districtNames,
                    selectedItem: _selectedDistrict,
                    onChanged: (value) {
                      setState(
                        () {
                          _selectedDistrict = value.toString();
                          int? districtId = provider.districtData.firstWhere(
                            (district) => district['name'] == _selectedDistrict,
                          )['id'];
                          if (districtId != null) {
                            Provider.of<ScreenOneProvider>(context,
                                    listen: false)
                                .fetchSubdistricts(districtId);
                          }
                        },
                      );
                    },
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  CustomDropDownSearchForm(
                    title: 'Kecamatan',
                    items: provider.subdistrictNames,
                    selectedItem: _selectedSubDistrict,
                    onChanged: (value) {
                      setState(() {
                        _selectedSubDistrict = value.toString();
                        int? subDistrictId =
                            provider.subdistrictData.firstWhere(
                          (subdistrictData) =>
                              subdistrictData['name'] == _selectedSubDistrict,
                        )['id'];
                        if (subDistrictId != null) {
                          Provider.of<ScreenOneProvider>(context, listen: false)
                              .fetchVillages(subDistrictId);
                        }
                      });
                    },
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  CustomDropDownSearchForm(
                    title: 'Kelurahan',
                    items: provider.villageNames,
                    selectedItem: _selectedVillage,
                    onChanged: (value) {
                      setState(() {
                        _selectedVillage = value.toString();
                      });
                    },
                  ),
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
                  UserModel userData = UserModel(
                    firstName: firstNameController.text,
                    lastName: lastNameController.text,
                    biodata: biodataController.text,
                    province: _selectedProvince,
                    district: _selectedDistrict,
                    subDistrict: _selectedSubDistrict,
                    village: _selectedVillage,
                  );
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ScreenTwo(
                        data: userData,
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
    });
  }
}
