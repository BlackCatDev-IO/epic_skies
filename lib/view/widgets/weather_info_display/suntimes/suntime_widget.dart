import 'package:black_cat_lib/black_cat_lib.dart';
import 'package:epic_skies/extensions/widget_extensions.dart';
import 'package:epic_skies/global/local_constants.dart';
import 'package:flutter/material.dart';

class SuntimeWidget extends StatelessWidget {
  const SuntimeWidget({
    super.key,
    required this.time,
    required this.isSunrise,
  });

  final String time;
  final bool isSunrise;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          MyTextWidget(
            text: time,
            fontSize: 10.5,
            color: Colors.blueAccent[100],
          ).paddingOnly(top: 2),
          Icon(isSunrise ? Icons.north : Icons.south, color: Colors.yellow),
          const Image(
            width: 4,
            image: AssetImage(sunriseIcon),
          ),
          const SizedBox(height: 15)
        ],
      ),
    );
  }
}
