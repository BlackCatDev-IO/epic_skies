import 'package:black_cat_lib/black_cat_lib.dart';
import 'package:epic_skies/extensions/widget_extensions.dart';
import 'package:epic_skies/features/hourly_forecast/models/hourly_forecast_model/hourly_forecast_model.dart';
import 'package:epic_skies/features/main_weather/bloc/weather_bloc.dart';
import 'package:epic_skies/global/local_constants.dart';
import 'package:epic_skies/services/asset_controllers/icon_controller.dart';
import 'package:epic_skies/services/view_controllers/color_cubit/color_cubit.dart';
import 'package:epic_skies/utils/formatters/date_time_formatter.dart';
import 'package:epic_skies/view/widgets/weather_info_display/unit_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';

class HoulyForecastRow extends StatelessWidget {
  const HoulyForecastRow({
    required this.model,
    super.key,
  });

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
              Image(
                image: AssetImage(model.iconPath),
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
                model: model,
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

  final DateTime time;

  @override
  Widget build(BuildContext context) {
    final timeIn24Hrs =
        context.read<WeatherBloc>().state.unitSettings.timeIn24Hrs;
    final formattedTime = DateTimeFormatter.formatTimeToHour(
      time: time,
      timeIn24hrs: timeIn24Hrs,
    );
    return RoundedContainer(
      width: 50,
      height: 22,
      color: Colors.blueGrey[300],
      child: MyTextWidget(
        text: formattedTime,
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

  static const _fontSize = 16.0;
  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        style: TextStyle(
          fontSize: _fontSize,
          color: HexColor('ffc288'),
          fontWeight: FontWeight.w300,
        ),
        text: 'Feels Like ',
        children: [
          TextSpan(
            text: temp,
            style: const TextStyle(
              fontSize: _fontSize,
              color: Colors.white70,
            ),
          ),
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
        Text('$temp$degreeSymbol'),
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
          Text(
            word,
            style: TextStyle(
              color: Colors.blue[300],
            ),
            textAlign: TextAlign.center,
          ),
        const SizedBox(height: 10),
        Row(
          children: [
            Text(windSpeed),
            const SizedBox(width: 5),
            const SpeedUnitWidget(),
          ],
        ),
      ],
    );
  }
}

class _PrecipitationWidget extends StatelessWidget {
  const _PrecipitationWidget({required this.model});

  final HourlyForecastModel model;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          '${model.precipitationProbability}%',
        ),
        if (model.precipitationProbability == 0)
          const SizedBox()
        else
          Column(
            children: [
              Image(
                image: AssetImage(
                  IconController.getPrecipIconPath(
                    precipType: model.precipitationType,
                  ),
                ),
                height: 15.75,
                width: 15.75,
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Text(
                    '${model.precipitationAmount} ',
                    style: const TextStyle(
                      fontSize: 14,
                    ),
                  ),
                  const PrecipUnitWidget(
                    textStyle: TextStyle(
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ],
          ).paddingOnly(top: 10),
      ],
    );
  }
}
