import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:seru_tech_test/shared/shared_values.dart';

class ScreenOneProvider extends ChangeNotifier {
  List<Map<String, dynamic>> _provinceData = [];
  List<String> _provinceNames = [];

  List<Map<String, dynamic>> _districtData = [];
  List<String> _districtNames = [];

  List<Map<String, dynamic>> _subdistrictData = [];
  List<String> _subdistrictNames = [];

  List<Map<String, dynamic>> _villageData = [];
  List<String> _villageNames = [];

  List<Map<String, dynamic>> get provinceData => _provinceData;
  List<String> get provinceNames => _provinceNames;

  List<Map<String, dynamic>> get districtData => _districtData;
  List<String> get districtNames => _districtNames;

  List<Map<String, dynamic>> get subdistrictData => _subdistrictData;
  List<String> get subdistrictNames => _subdistrictNames;

  List<Map<String, dynamic>> get villageData => _villageData;
  List<String> get villageNames => _villageNames;

  Future<void> fetchProvinces() async {
    final response = await http.get(Uri.parse('$baseUrl/provinces'));
    if (response.statusCode == 200) {
      final List<dynamic> provincesData = json.decode(response.body);
      _provinceData = provincesData.cast<Map<String, dynamic>>();
      _provinceNames =
          provincesData.map((province) => province['name'].toString()).toList();
      notifyListeners();
    } else {
      throw Exception('Failed to load provinces');
    }
  }

  Future<void> fetchDistricts(int provinceId) async {
    final response =
        await http.get(Uri.parse('$baseUrl/districts?province_id=$provinceId'));
    if (response.statusCode == 200) {
      final List<dynamic> districtsData = json.decode(response.body);
      _districtData = districtsData.cast<Map<String, dynamic>>();
      _districtNames =
          districtsData.map((district) => district['name'].toString()).toList();
      notifyListeners();
    } else {
      throw Exception('Failed to load districts');
    }
  }

  Future<void> fetchSubdistricts(int districtId) async {
    final response = await http
        .get(Uri.parse('$baseUrl/subdistricts?district_id=$districtId'));
    if (response.statusCode == 200) {
      final List<dynamic> subdistrictsData = json.decode(response.body);
      _subdistrictData = subdistrictsData.cast<Map<String, dynamic>>();
      _subdistrictNames = subdistrictsData
          .map((subdistrict) => subdistrict['name'].toString())
          .toList();
      notifyListeners();
    } else {
      throw Exception('Failed to load subdistricts');
    }
  }

  Future<void> fetchVillages(int subdistrictId) async {
    final response = await http
        .get(Uri.parse('$baseUrl/villages?subdistrict_id=$subdistrictId'));
    if (response.statusCode == 200) {
      final List<dynamic> villagesData = json.decode(response.body);
      _villageData = villagesData.cast<Map<String, dynamic>>();
      _villageNames =
          villagesData.map((village) => village['name'].toString()).toList();
      notifyListeners();
    } else {
      throw Exception('Failed to load villages');
    }
  }
}
