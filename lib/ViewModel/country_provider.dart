// *ViewModel: Handles the presentation logic and interacts with the model.

// *Provider for managing the state of country data

import 'dart:io';

import 'package:countries/Model/model.dart';
import 'package:countries/View/api_service.dart';
import 'package:flutter/material.dart';

class CountryProvider extends ChangeNotifier {
  late List<Country> _countries = [];

  List<Country> get countries => _countries;

  void fetchCountries() async {
    try {
      _countries = await ApiService().fetchCountries();
      notifyListeners();
    } on Exception catch (e) {
      stdout.write('Error fetching countries: $e');
      // Show a snackbar to inform the user about the error
      // Get.snackbar('No Internat Connection', 'Connect your Internet');
    }
  }

  // Function to filter countries by name
  List<Country> filterCountriesByName(String query) {
    return _countries
        .where((country) =>
            country.name.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }
}
