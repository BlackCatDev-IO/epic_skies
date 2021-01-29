import 'package:epic_skies/services/utils/network.dart';
import 'package:epic_skies/widgets/weather_image_container.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:black_cat_lib/black_cat_lib.dart';

class LocationSearchPage extends SearchDelegate<Suggestion> {
  LocationSearchPage(this.sessionToken);

  final networkController = Get.find<NetworkController>();

  final sessionToken;

  // @override
  // ThemeData appBarTheme(BuildContext context) {
  //   return super.appBarTheme(context).copyWith(
        // primaryColor: Colors.black38);
        // primaryColorBrightness: Brightness.dark,
        // backgroundColor: Colors.transparent,
  //       scaffoldBackgroundColor: Colors.transparent);
  // }

  @override
  List<Widget> buildActions(BuildContext context) {


    return [
      IconButton(
        tooltip: 'Clear',
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      tooltip: 'Back',
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return null;
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return WeatherImageContainer(
      child: FutureBuilder(
        future: query == ""
            ? null
            : networkController.fetchSuggestions(
                input: query,
                lang: Localizations.localeOf(context).languageCode),
        builder: (context, snapshot) => query == ''
            ? Scaffold(
                body: Container(
                  padding: EdgeInsets.all(16.0),
                  child: MyTextWidget(text: 'Enter a city'),
                ).center(),
              )
            : snapshot.hasData
                ? Container(
                    child: ListView.builder(
                      itemBuilder: (context, index) => RoundedContainer(
                        color: Colors.black54,
                        radius: 7,
                        child: ListTile(
                          title: MyTextWidget(
                              text: (snapshot.data[index] as Suggestion)
                                  .description,
                              fontSize: 18),
                          onTap: () {
                            close(context, snapshot.data[index] as Suggestion);
                          },
                        ),
                      ).paddingSymmetric(vertical: 2, horizontal: 5),
                      itemCount: snapshot.data.length,
                    ),
                  )
                : Scaffold(
                    body: Container(
                      child: MyTextWidget(text: 'Loading...').center(),
                    ),
                  ),
      ),
    );
  }
}

class Place {
  String street;
  String city;
  String zipCode;

  Place({
    this.street,
    this.city,
    this.zipCode,
  });

  @override
  String toString() {
    return 'Place(streetNumber:  street: $street, city: $city, zipCode: $zipCode)';
  }
}
