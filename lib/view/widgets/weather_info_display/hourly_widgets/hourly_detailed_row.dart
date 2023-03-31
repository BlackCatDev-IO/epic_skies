import 'package:black_cat_lib/black_cat_lib.dart';
import 'package:epic_skies/extensions/widget_extensions.dart';
import 'package:epic_skies/features/hourly_forecast/models/hourly_forecast_model/hourly_forecast_model.dart';
import 'package:epic_skies/global/local_constants.dart';
import 'package:epic_skies/services/asset_controllers/icon_controller.dart';
import 'package:epic_skies/services/view_controllers/color_cubit/color_cubit.dart';
import 'package:epic_skies/view/widgets/weather_info_display/unit_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';

/// Displays each hourly forecast in `HourlyForecastPage`
class HoulyForecastRow extends StatelessWidget {
  /// All displayed data is based on the HourlyForecastModel
  const HoulyForecastRow({
    super.key,
    required this.model,
  });

  /// All displayed data builds off this passed in model
  final HourlyForecastModel model;
  @override
  Widget build(BuildContext context) {
    final precip =
        '${model.precipitationProbability}% ${model.precipitationType}';
    return BlocBuilder<ColorCubit, ColorState>(
      builder: (context, state) {
        return Container(
          color: state.theme.soloCardColor,
          height: 10,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _TimeWidget(time: model.time),
              _TempColumn(
                temp: model.temp,
                feelsLike: '${model.feelsLike}',
                precip: precip,
              ),
              MyAssetImage(path: model.iconPath, height: 4.5, width: 4.5)
                  .paddingOnly(right: 5),
              _ConditionAndWindWidget(
                condition: model.condition,
                windSpeed: '$model.windSpeed ',
                precipitationProbability: model.precipitationProbability,
              ),
              _PrecipitationWidget(
                precipitationProbability: model.precipitationProbability,
                precipitationType: model.precipitationType,
              ),
            ],
          ).paddingSymmetric(horizontal: 3),
        );
      },
    );
  }
}

class _TimeWidget extends StatelessWidget {
  const _TimeWidget({required this.time});

  final String time;

  @override
  Widget build(BuildContext context) {
    return RoundedContainer(
      width: 13,
      height: 2.5,
      color: Colors.blueGrey[300],
      child: MyTextWidget(
        text: time,
        color: Colors.black,
        fontSize: 8.5,
        fontWeight: FontWeight.w400,
      ).center(),
    ).paddingOnly(right: 2);
  }
}

class _FeelsLikeWidget extends StatelessWidget {
  const _FeelsLikeWidget({required this.temp, required this.precip});
  final String temp;
  final String precip;
  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        style: TextStyle(
          fontSize: 11,
          color: HexColor('ffc288'),
          fontWeight: FontWeight.w300,
        ),
        text: 'Feels Like ',
        children: [
          TextSpan(
            text: temp,
            style: const TextStyle(fontSize: 11, color: Colors.white70),
          )
        ],
      ),
    );
  }
}

class _TempColumn extends StatelessWidget {
  const _TempColumn({
    required this.temp,
    required this.feelsLike,
    required this.precip,
  });

  final int temp;
  final String feelsLike;
  final String precip;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 26,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          MyTextWidget(text: '$temp$degreeSymbol', fontSize: 12),
          sizedBox10High,
          _FeelsLikeWidget(temp: feelsLike, precip: precip),
        ],
      ),
    );
  }
}

class _ConditionAndWindWidget extends StatelessWidget {
  const _ConditionAndWindWidget({
    required this.condition,
    required this.windSpeed,
    required this.precipitationProbability,
  });

  final String condition;
  final String windSpeed;

  final num precipitationProbability;
  @override
  Widget build(BuildContext context) {
    final leftPadding = precipitationProbability <= 9 ? 5 : 0;
    return SizedBox(
      width: 15,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (final word in condition.splitWordList())
            MyTextWidget(
              text: word,
              color: Colors.blue[300],
              fontSize: 10,
              textAlign: TextAlign.center,
            ),
          sizedBox10High,
          Row(
            children: [
              MyTextWidget(
                text: windSpeed,
                fontSize: 10,
                fontWeight: FontWeight.w300,
              ),
              const SpeedUnitWidget(
                textStyle: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w300,
                  color: Colors.white70,
                ),
              )
            ],
          ),
        ],
      ).paddingOnly(left: leftPadding.toDouble()),
    );
  }
}

class _PrecipitationWidget extends StatelessWidget {
  const _PrecipitationWidget({
    required this.precipitationProbability,
    required this.precipitationType,
  });

  final num? precipitationProbability;
  final String precipitationType;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: precipitationProbability == 100 ? 9 : 7,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          MyTextWidget(
            text: '$precipitationProbability%',
            fontSize: 10,
          ),
          if (precipitationProbability == 0)
            const SizedBox()
          else
            MyAssetImage(
              path: IconController.getPrecipIconPath(
                precipType: precipitationType,
              ),
              height: 1.75,
              width: 1.75,
            ).paddingOnly(top: 10),
        ],
      ),
    );
  }
}
