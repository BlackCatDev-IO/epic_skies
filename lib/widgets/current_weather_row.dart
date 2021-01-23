import 'package:black_cat_lib/black_cat_lib.dart';
import 'package:charcode/html_entity.dart';
import 'package:epic_skies/services/utils/location_controller.dart';
import 'package:epic_skies/services/weather/weather_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CurrentWeatherRow extends StatelessWidget {
  const CurrentWeatherRow();
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: const [
        TempColumn(),
        AddressColumn(),
        // const WeatherIcon(),
      ],
    );
  }
}

class TempColumn extends StatelessWidget {
  const TempColumn();
  @override
  Widget build(BuildContext context) {
    final deg = String.fromCharCode($deg);

    return GetBuilder<WeatherController>(
      builder: (weatherController) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  weatherController.currentTemp.toString(),
                  style: kGoogleFontOpenSansCondensed.copyWith(
                      color: Colors.white54, fontSize: 80),
                ),
                Column(
                  children: [
                    sizedBox10High,
                    Text(
                      deg,
                      style: kGoogleFontOpenSansCondensed.copyWith(
                          color: Colors.white54, fontSize: 40),
                    ),
                  ],
                ),
              ],
            ),
            Text(
              weatherController.currentCondition,
              style: kGoogleFontOpenSansCondensed.copyWith(
                  color: Colors.blueGrey[300], fontSize: 25),
            ),
            Row(
              children: [
                Text(
                  'Feels Like: ',
                  style: kGoogleFontOpenSansCondensed.copyWith(
                      color: Colors.blueGrey[300], fontSize: 18),
                ),
                Text(
                  weatherController.feelsLike.toString(),
                  style: kGoogleFontOpenSansCondensed.copyWith(
                      color: Colors.blueGrey, fontSize: 18),
                ),
                Text(
                  deg,
                  style: kGoogleFontOpenSansCondensed.copyWith(
                      color: Colors.blueGrey, fontSize: 20),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}

class AddressColumn extends StatelessWidget {
  const AddressColumn({
    Key key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetBuilder<LocationController>(
      builder: (locationController) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  locationController.street,
                  style: kGoogleFontOpenSansCondensed.copyWith(
                      color: Colors.white70, fontSize: 15),
                ),
              ],
            ).paddingOnly(bottom: 8),
            Row(
              children: [
                Text(
                  locationController.subLocality,
                  style: kGoogleFontOpenSansCondensed.copyWith(
                      color: Colors.white54, fontSize: 50, height: 0.999),
                  // color: Colors.blueGrey[500], fontSize: 50, height: 0.999),
                ),
              ],
            ).paddingSymmetric(horizontal: 6, vertical: 5),
            Row(
              children: [
                Text(
                  locationController.administrativeArea,
                  style: kGoogleFontOpenSansCondensed.copyWith(
                      color: Colors.white70, fontSize: 18, height: 0.94),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
