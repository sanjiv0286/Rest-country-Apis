// Service class to fetch data from the REST Countries API
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import 'package:countries/Model/model.dart';

class ApiService {
  Future<List<Country>> fetchCountries() async {
    try {
      final response =
          await http.get(Uri.parse('https://restcountries.com/v3.1/all'));

      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        return data.map((json) => Country.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load countries');
      }
    } on SocketException {
      throw Exception('No internet connection');
    } catch (e) {
      throw Exception('Failed to fetch data: $e');
    }
  }
}
