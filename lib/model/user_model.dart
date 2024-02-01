class UserModel {
  final String? firstName;
  final String? lastName;
  final String? biodata;
  final String? province;
  final String? district;
  final String? subDistrict;
  final String? village;
  final String? nik;
  final String? selfieUrl;
  final String? ktpUrl;
  final String? fotobebasUrl;

  UserModel({
    this.firstName,
    this.lastName,
    this.biodata,
    this.province,
    this.district,
    this.subDistrict,
    this.village,
    this.nik,
    this.selfieUrl,
    this.ktpUrl,
    this.fotobebasUrl,
  });

  Map<String, dynamic> toJson() {
    return {
      'first_name': firstName,
      'last_name': lastName,
      'biodata': biodata,
      'province': province,
      'district': district,
      'sub_district': subDistrict,
      'village': village,
      'nik': nik,
      'sselfie_url': selfieUrl,
      'ktp_url': ktpUrl,
      'foto_bebas_url': fotobebasUrl,
    };
  }

  UserModel copyWith(
          {String? selfieUrl,
          String? ktpUrl,
          String? fotobebasUrl,
          String? nik}) =>
      UserModel(
        firstName: firstName,
        lastName: lastName,
        biodata: biodata,
        province: province,
        district: district,
        subDistrict: subDistrict,
        village: village,
        nik: nik ?? this.nik,
        selfieUrl: selfieUrl ?? this.selfieUrl,
        ktpUrl: ktpUrl ?? this.ktpUrl,
        fotobebasUrl: fotobebasUrl ?? this.fotobebasUrl,
      );
}
