// ignore_for_file: unused_local_variable

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/model/weather_response_model.dart';
import 'package:flutter_application_1/secrets/api.dart';
import 'package:http/http.dart' as http;

class WeatherService extends ChangeNotifier {
  WeatherModel? _weather;
  WeatherModel? get weather => _weather;
  bool isLoading = false;
  Future<void> fetchWeatherCity(String city) async {
    isLoading = true;
    String error;

    try {
      final String apiUrl =
          "${APIEndPoints().baseUrl}$city&appid=${APIEndPoints().apikey}";
      final response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        _weather = WeatherModel.fromJson(data);
        notifyListeners();
      } else {}
    } catch (e) {
      error = 'failed to load $e';
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
