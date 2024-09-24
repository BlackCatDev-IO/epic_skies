import 'package:epic_skies/extensions/widget_extensions.dart';
import 'package:epic_skies/features/hourly_forecast/models/hourly_forecast_model/hourly_forecast_model.dart';
import 'package:epic_skies/features/main_weather/bloc/weather_bloc.dart';
import 'package:epic_skies/services/register_services.dart';
import 'package:epic_skies/services/ticker_controllers/tab_navigation_controller.dart';
import 'package:epic_skies/utils/formatters/date_time_formatter.dart';
import 'package:epic_skies/view/widgets/weather_info_display/suntimes/suntime_widget.dart';
import 'package:epic_skies/view/widgets/weather_info_display/temp_widgets/temp_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HourlyScrollWidgetColumn extends StatelessWidget {
  const HourlyScrollWidgetColumn({
    required this.model,
    super.key,
  });
  final HourlyForecastModel model;

  static const fontSize = 17.0;

  @override
  Widget build(BuildContext context) {
    final timeIn24Hrs =
        context.read<WeatherBloc>().state.unitSettings.timeIn24Hrs;
    final formattedTime = DateTimeFormatter.formatTimeToHour(
      time: model.time,
      timeIn24hrs: timeIn24Hrs,
    );
    return model.suntimeString == null
        ? GestureDetector(
            onTap: () => getIt<TabNavigationController>().jumpToTab(index: 1),
            behavior: HitTestBehavior.translucent,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  formattedTime,
                  style: TextStyle(
                    fontSize: fontSize,
                    color: Colors.blueAccent[100],
                  ),
                ),
                TempWidget(temp: model.temp),
                Image(
                  image: AssetImage(
                    model.iconPath,
                  ),
                  width: 40,
                ),
                Text(
                  ' ${model.precipitationProbability}%',
                  style: const TextStyle(
                    fontSize: fontSize,
                    color: Colors.white54,
                  ),
                ),
              ],
            ).paddingSymmetric(horizontal: 9),
          )
        : SuntimeWidget(
            time: model.suntimeString!,
            isSunrise: model.isSunrise!,
          );
  }
}
