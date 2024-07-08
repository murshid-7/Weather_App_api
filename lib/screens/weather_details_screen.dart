import 'package:flutter/material.dart';
import 'package:flutter_application_1/controller/weather_provider.dart';
import 'package:flutter_application_1/utils/apptext.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class WeatherDetails extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final weatherProvider = Provider.of<WeatherService>(context);

    int sunrise = weatherProvider.weather?.sys?.sunrise ?? 0;
    int sunset = weatherProvider.weather?.sys?.sunset ?? 0;
    DateTime sunriseTime = DateTime.fromMillisecondsSinceEpoch(sunrise * 1000);
    DateTime sunsetTime = DateTime.fromMillisecondsSinceEpoch(sunset * 1000);
    String formattedSunrise = DateFormat.Hm().format(sunriseTime);
    String formattedSunset = DateFormat.Hm().format(sunsetTime);

    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.black.withOpacity(0.4)),
      height: 180,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  Image.asset(
                    'assets/img/temperature-high.png',
                    height: 55,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppText(
                        text:
                            "${weatherProvider.weather?.main!.tempMax!.toStringAsFixed(0)}\u00b0 C",
                        color: Colors.white,
                        size: 14,
                        fw: FontWeight.w600,
                      ),
                      AppText(
                        text:
                            "${weatherProvider.weather?.main!.tempMin!.toStringAsFixed(0)}\u00b0 C",
                        color: Colors.white,
                        size: 14,
                        fw: FontWeight.w600,
                      )
                    ],
                  )
                ],
              ),
              const SizedBox(
                width: 20,
              ),
              Row(
                children: [
                  Image.asset(
                    'assets/img/temperature-low.png',
                    height: 55,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppText(
                        text:
                            "${weatherProvider.weather?.main?.tempMax?.toStringAsFixed(0)}\u00b0C",
                        color: Colors.white,
                        size: 14,
                        fw: FontWeight.w600,
                      ),
                      AppText(
                        text:
                            "${weatherProvider.weather?.main?.tempMin?.toStringAsFixed(0)}\u00b0C",
                        color: Colors.white,
                        size: 14,
                        fw: FontWeight.w600,
                      )
                    ],
                  ),
                ],
              ),
            ],
          ),
          const Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  Image.asset(
                    'assets/img/sun.png',
                    height: 55,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppText(
                        text: "Sunrise",
                        color: Colors.white,
                        size: 14,
                        fw: FontWeight.w600,
                      ),
                      AppText(
                        text: "$formattedSunrise AM",
                        color: Colors.white,
                        size: 14,
                        fw: FontWeight.w600,
                      )
                    ],
                  )
                ],
              ),
              const SizedBox(
                width: 20,
              ),
              Row(
                children: [
                  Image.asset(
                    'assets/img/moon.png',
                    height: 55,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppText(
                        text: "Sunset",
                        color: Colors.white,
                        size: 14,
                        fw: FontWeight.w600,
                      ),
                      AppText(
                        text: "$formattedSunset AM",
                        color: Colors.white,
                        size: 14,
                        fw: FontWeight.w600,
                      )
                    ],
                  )
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
