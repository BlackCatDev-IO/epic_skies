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
    required this.model,
    super.key,
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
          height: 90,
          child: Row(
            children: [
              const Spacer(),
              _TimeWidget(time: model.time),
              const Spacer(flex: 3),
              _TempColumn(
                temp: model.temp,
                feelsLike: '${model.feelsLike}',
                precip: precip,
              ),
              const Spacer(flex: 2),
              MyAssetImage(
                path: model.iconPath,
                height: 34.5,
                width: 34.5,
              ).paddingOnly(right: 5),
              const Spacer(flex: 3),
              _ConditionAndWindWidget(
                condition: model.condition,
                windSpeed: '${model.windSpeed}',
                precipitationProbability: model.precipitationProbability,
              ),
              const Spacer(flex: 3),
              _PrecipitationWidget(
                precipitationProbability: model.precipitationProbability,
                precipitationType: model.precipitationType,
              ),
              const Spacer(),
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
      width: 50,
      height: 22,
      color: Colors.blueGrey[300],
      child: MyTextWidget(
        text: time,
        color: Colors.black,
        fontSize: 14,
        fontWeight: FontWeight.w400,
      ).center(),
    );
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
          fontSize: 15,
          color: HexColor('ffc288'),
          fontWeight: FontWeight.w300,
        ),
        text: 'Feels Like ',
        children: [
          TextSpan(
            text: temp,
            style: const TextStyle(fontSize: 15, color: Colors.white70),
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
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        MyTextWidget(text: '$temp$degreeSymbol', fontSize: 16),
        sizedBox10High,
        _FeelsLikeWidget(temp: feelsLike, precip: precip),
      ],
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
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (final word in condition.splitWordList())
          MyTextWidget(
            text: word,
            color: Colors.blue[300],
            fontSize: 15,
            textAlign: TextAlign.center,
          ),
        sizedBox10High,
        Row(
          children: [
            MyTextWidget(
              text: windSpeed,
              fontSize: 15,
              fontWeight: FontWeight.w300,
            ),
            const SizedBox(width: 5),
            const SpeedUnitWidget(
              textStyle: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w300,
                color: Colors.white70,
              ),
            )
          ],
        ),
      ],
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
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        MyTextWidget(
          text: '$precipitationProbability%',
          fontSize: 15,
        ),
        if (precipitationProbability == 0)
          const SizedBox()
        else
          MyAssetImage(
            path: IconController.getPrecipIconPath(
              precipType: precipitationType,
            ),
            height: 15.75,
            width: 15.75,
          ).paddingOnly(top: 10),
      ],
    );
  }
}
