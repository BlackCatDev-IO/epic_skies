import 'package:black_cat_lib/black_cat_lib.dart';
import 'package:epic_skies/extensions/string_extensions.dart';
import 'package:epic_skies/extensions/widget_extensions.dart';
import 'package:epic_skies/features/daily_forecast/models/daily_forecast_model.dart';
import 'package:epic_skies/features/hourly_forecast/cubit/hourly_forecast_cubit.dart';
import 'package:epic_skies/features/hourly_forecast/models/hourly_forecast_model/hourly_forecast_model.dart';
import 'package:epic_skies/global/local_constants.dart';
import 'package:epic_skies/services/view_controllers/color_cubit/color_cubit.dart';
import 'package:epic_skies/view/widgets/weather_info_display/hourly_widgets/horizontal_scroll_widget.dart';
import 'package:epic_skies/view/widgets/weather_info_display/hourly_widgets/hourly_forecast_row.dart';
import 'package:epic_skies/view/widgets/weather_info_display/hourly_widgets/hourly_scroll_widget_column.dart';
import 'package:epic_skies/view/widgets/weather_info_display/unit_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DailyForecastWidget extends StatelessWidget {
  const DailyForecastWidget({
    required this.model,
    super.key,
  });
  final DailyForecastModel model;

  static const _unitFontSize = 18.0;

  @override
  Widget build(BuildContext context) {
    final displayCondition = model.condition.capitalizeFirst;

    /// fullDetail is for a the extended hourly forecast. There is only 108
    /// available hours so this prevents the widget from trying to build
    /// the _ExtendedHourlyForecastRow when no data is available
    final fullDetail = model.extendedHourlyList.isNotEmpty;

    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      color: Colors.transparent,
      margin: const EdgeInsets.only(left: 2, right: 2, bottom: 5),
      child: BlocBuilder<ColorCubit, ColorState>(
        builder: (context, state) {
          final tempWidget = TempUnitWidget(
            textStyle: TextStyle(
              fontSize: _unitFontSize,
              color: Colors.blue[200],
              fontWeight: FontWeight.w300,
            ),
          );
          return RoundedContainer(
            color: state.theme.soloCardColor,
            height: fullDetail ? 784 : 550,
            borderColor: Colors.black,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                sizedBox10High,
                _DateLabel(
                  day: model.day,
                  month: model.month,
                  date: model.date.toString(),
                  year: model.year,
                ),
                _DetailWidgetHeaderRow(
                  condition: displayCondition,
                  iconPath: model.iconPath,
                  temp: model.dailyTemp,
                ),
                const Divider(color: Colors.white, indent: 10, endIndent: 10),
                _DetailRow(
                  category: 'Feels Like: ',
                  value: '${model.feelsLikeDay}$degreeSymbol ',
                  unitWidget: tempWidget,
                ),
                _DetailRow(
                  category: 'Wind Speed: ',
                  value: '${model.windSpeed} ',
                  unitWidget: SpeedUnitWidget(
                    textStyle: TextStyle(
                      fontSize: _unitFontSize,
                      color: Colors.blue[300],
                    ),
                  ),
                ),
                _DetailRow(
                  category: 'Precipitation: ',
                  precipType: model.precipitationType,
                  value: '${model.precipitationProbability}%',
                  iconPath: model.precipIconPath,
                ),
                _DetailRow(
                  category: 'Total Precip: ',
                  value: '${model.precipitationAmount} ',
                  unitWidget: PrecipUnitWidget(
                    textStyle: TextStyle(
                      fontSize: _unitFontSize,
                      color: Colors.blue[300],
                    ),
                  ),
                ),
                _DetailRow(
                  category: 'Sunrise: ',
                  value: model.suntime.sunriseString,
                ),
                _DetailRow(
                  category: 'Sunset: ',
                  value: model.suntime.sunsetString,
                ),
                if (fullDetail)
                  _ExtendedHourlyForecastRow(
                    hourlyModelList: model.extendedHourlyList,
                    highTemp: model.highTemp!,
                    lowTemp: model.lowTemp!,
                    tempWidget: tempWidget,
                  )
                else
                  const SizedBox(),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _ExtendedHourlyForecastRow extends StatelessWidget {
  const _ExtendedHourlyForecastRow({
    required this.highTemp,
    required this.lowTemp,
    required this.tempWidget,
    required this.hourlyModelList,
  });

  final int highTemp;
  final int lowTemp;
  final TempUnitWidget tempWidget;
  final List<HourlyForecastModel> hourlyModelList;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _DetailRow(
          category: 'High Temp: ',
          value: '$highTemp$degreeSymbol ',
          unitWidget: tempWidget,
        ),
        _DetailRow(
          category: 'Low Temp: ',
          value: '$lowTemp$degreeSymbol ',
          unitWidget: tempWidget,
        ),
        BlocBuilder<HourlyForecastCubit, HourlyForecastState>(
          builder: (context, state) {
            final widgetList = hourlyModelList
                .map(
                  (model) => HourlyScrollWidgetColumn(
                    model: model,
                  ),
                )
                .toList();
            return HorizontalScrollWidget(
              list: widgetList,
              layeredCard: true,
              header: const HourlyHeader(),
            ).paddingSymmetric(horizontal: 2.5, vertical: 10);
          },
        ),
      ],
    );
  }
}

class _DateLabel extends StatelessWidget {
  const _DateLabel({
    required this.day,
    required this.month,
    required this.date,
    required this.year,
  });

  final String day;
  final String month;
  final String date;
  final String year;

  @override
  Widget build(BuildContext context) {
    return RoundedContainer(
      color: Colors.blueGrey[300],
      child: Text(
        '$day $month $date, $year',
        style: const TextStyle(
          color: Colors.black,
          fontSize: 18,
        ),
      ).paddingSymmetric(horizontal: 15, vertical: 1),
    );
  }
}

class _DetailRow extends StatelessWidget {
  const _DetailRow({
    required this.category,
    required this.value,
    this.iconPath,
    this.precipType,
    this.unitWidget,
  });
  final String category;
  final String value;
  final String? iconPath;
  final String? precipType;
  final Widget? unitWidget;

  static const _fontSize = 18.0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            if (precipType != null)
              Row(
                children: [
                  Text(
                    category,
                    style: const TextStyle(
                      fontSize: _fontSize,
                    ),
                  ),
                  Text(
                    precipType!,
                    style: TextStyle(
                      fontSize: _fontSize,
                      color: Colors.blue[300],
                    ),
                  ),
                ],
              )
            else
              Text(
                category,
                style: const TextStyle(
                  fontSize: _fontSize,
                ),
              ),
            if (iconPath != null && precipType != 'none')
              Row(
                children: [
                  Image(
                    image: AssetImage(iconPath!),
                    width: 13,
                    height: 13,
                  ),
                  Text(
                    value,
                    style: TextStyle(
                      fontSize: _fontSize,
                      color: Colors.blue[200],
                    ),
                  ).paddingOnly(left: 5),
                ],
              )
            else
              Row(
                children: [
                  Text(
                    value,
                    style: TextStyle(
                      fontSize: _fontSize,
                      color: Colors.blue[200],
                    ),
                  ),
                  unitWidget ?? const SizedBox(),
                ],
              ),
          ],
        ).paddingSymmetric(horizontal: 15),
        const Divider(color: Colors.white, indent: 10, endIndent: 10),
      ],
    );
  }
}

class _DetailWidgetHeaderRow extends StatelessWidget {
  const _DetailWidgetHeaderRow({
    required this.condition,
    required this.iconPath,
    required this.temp,
  });

  final String condition;
  final String iconPath;

  final int temp;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: 15,
          left: 5,
          child: Text(
            condition,
            style: const TextStyle(
              fontSize: 24,
            ),
          ),
        ),
        Align(
          child: Image(
            image: AssetImage(iconPath),
            height: 80,
          ),
        ),
        Positioned(
          top: 15,
          right: 5,
          child: _TempDisplayWidget(temp: '  $temp'),
        ),
      ],
    ).paddingSymmetric(horizontal: 10, vertical: 10);
  }
}

class _TempDisplayWidget extends StatelessWidget {
  const _TempDisplayWidget({required this.temp});

  final String temp;

  static const _fontSize = 22.0;
  static const style = TextStyle(
    fontSize: _fontSize,
  );

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          temp,
          style: style,
        ),
        const SizedBox(width: 1),
        Text(
          degreeSymbol,
          style: style,
        ),
        const SizedBox(width: 3),
        const TempUnitWidget(
          textStyle: TextStyle(
            fontSize: _fontSize,
            color: Colors.white70,
          ),
        ),
      ],
    ).paddingOnly(top: 5);
  }
}
