// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_application_1/controller/location_provider.dart';
import 'package:flutter_application_1/controller/weather_provider.dart';
import 'package:flutter_application_1/screens/weather_details_screen.dart';
import 'package:flutter_application_1/utils/apptext.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    final locationProvider =
        Provider.of<LocationProvider>(context, listen: false);
    locationProvider.determinePosition().then((_) {
      if (locationProvider.currentLocationName != null) {
        var city = locationProvider.currentLocationName!.locality;
        if (city != null) {
          Provider.of<WeatherService>(context, listen: false)
              .fetchWeatherCity(city);
        }
      }
    });

    super.initState();
  }

  TextEditingController cityController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final weatherProvider = Provider.of<WeatherService>(context);

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: Container(
        padding: EdgeInsets.only(top: 65, left: 20, right: 20, bottom: 20),
        height: size.height,
        width: size.width,
        decoration: BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(
                  "https://tse2.mm.bing.net/th?id=OIP.Kop7opj2bU3SLuusnrcclwHaE8&pid=Api&P=0&h=180",
                ))),
        child: Stack(
          children: [
            Container(
              height: 50,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.location_pin,
                        color: Colors.red,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Consumer<LocationProvider>(
                        builder: (context, place, child) => Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AppText(
                              text: place.currentLocationName?.street ??
                                  'loading',
                              color: Colors.white,
                              fw: FontWeight.w700,
                              size: 18,
                            ),
                            AppText(
                              text: "Morning",
                              color: Colors.white,
                              fw: FontWeight.w400,
                              size: 14,
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment(0, -0.7),
              child: Image.asset(
                "assets/img/clouds.png",
              ),
            ),
            Align(
              alignment: Alignment(0, 0),
              child: Container(
                height: 150,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AppText(
                      text:
                          "${weatherProvider.weather?.main?.temp?.toStringAsFixed(0)}\u00b0C",
                      color: Colors.white,
                      fw: FontWeight.bold,
                      size: 32,
                    ),
                    AppText(
                      text: weatherProvider.weather?.weather![0].main ?? "N/A",
                      color: Colors.white,
                      fw: FontWeight.w600,
                      size: 20,
                    ),
                    AppText(
                      text: weatherProvider.weather?.name ?? "N/A",
                      color: Colors.white,
                      fw: FontWeight.w600,
                      size: 20,
                    ),
                    AppText(
                      text: DateFormat('hh:mm a').format(DateTime.now()),
                      color: Colors.white,
                    )
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment(0.0, 0.75),
              child: WeatherDetails(),
            ),
            Positioned(
              top: 40,
              left: 20,
              right: 20,
              child: SizedBox(
                height: 45,
                child: Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: cityController,
                        style: const TextStyle(color: Colors.white),
                        decoration: const InputDecoration(
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        Provider.of<WeatherService>(context, listen: false)
                            .fetchWeatherCity(cityController.text.toString());
                      },
                      icon: Icon(
                        Icons.search,
                        size: 40,
                        color: Colors.white,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
