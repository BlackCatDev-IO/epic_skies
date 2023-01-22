import 'package:black_cat_lib/black_cat_lib.dart';
import 'package:epic_skies/extensions/widget_extensions.dart';
import 'package:epic_skies/features/current_weather_forecast/cubit/current_weather_cubit.dart';
import 'package:epic_skies/global/local_constants.dart';
import 'package:epic_skies/services/view_controllers/color_cubit/color_cubit.dart';
import 'package:epic_skies/utils/logging/app_debug_log.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

import '../../../../features/location/bloc/location_bloc.dart';
import '../../../../features/location/remote_location/models/remote_location/remote_location_model.dart';
import '../../../../features/main_weather/bloc/weather_bloc.dart';

class CurrentWeatherRow extends StatelessWidget {
  const CurrentWeatherRow();
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ColorCubit, ColorState>(
      builder: (context, colorState) {
        return RoundedContainer(
          color: colorState.theme.homeContainerColor,
          height: 26.h,
          child: BlocBuilder<WeatherBloc, WeatherState>(
            builder: (context, state) {
              return Stack(
                children: [
                  _TempColumn(colorState),
                  if (state.searchIsLocal)
                    _AddressColumn(colorState)
                  else
                    _RemoteLocationColumn(colorState),
                ],
              ).paddingSymmetric(vertical: 5);
            },
          ),
        );
      },
    ).paddingSymmetric(horizontal: 2);
  }
}

class _AddressColumn extends StatelessWidget {
  const _AddressColumn(this.colorState);

  final ColorState colorState;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      height: 24.h,
      right: 10,
      child: BlocBuilder<LocationBloc, LocationState>(
        builder: (context, state) {
          final multiCityName = state.data.longNameList != null;
          final longSingleName = state.data.subLocality.length > 10;
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (multiCityName)
                _MultiWordCityWidget(
                  wordList: state.data.longNameList!,
                  colorState: colorState,
                )
              else
                MyTextWidget(
                  text: state.data.subLocality,
                  fontSize: longSingleName ? 23.sp : 28.sp,
                  fontWeight: FontWeight.w400,
                  color: colorState.theme.bgImageTextColor,
                ).paddingSymmetric(horizontal: 10),
              MyTextWidget(
                text: state.data.administrativeArea,
                fontSize: 15.sp,
                color: colorState.theme.bgImageTextColor,
              ),
            ],
          ).paddingOnly(right: multiCityName ? 3.w : 0);
        },
      ),
    );
  }
}

class _RemoteLocationColumn extends StatelessWidget {
  const _RemoteLocationColumn(
    this.colorState,
  );

  final ColorState colorState;
  bool _addMorePadding(RemoteLocationModel data) {
    if (data.longNameList == null) {
      return data.city.length <= 8;
    } else {
      for (final word in data.longNameList!) {
        if (word.length > 8) {
          return false;
        }
      }
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocationBloc, LocationState>(
      builder: (context, state) {
        final multiCityName = state.remoteLocationData.longNameList != null;

        final addPadding = _addMorePadding(state.remoteLocationData);

        return Positioned(
          height: 24.h,
          right: addPadding ? 20 : 10,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (multiCityName)
                _MultiWordCityWidget(
                  wordList: state.remoteLocationData.longNameList!,
                  colorState: colorState,
                )
              else
                MyTextWidget(
                  text: state.remoteLocationData.city,
                  fontSize: addPadding ? 30.sp : 25.sp,
                  fontWeight: FontWeight.w500,
                  color: colorState.theme.bgImageTextColor,
                ).paddingOnly(right: 5),
              sizedBox5High,
              Row(
                children: [
                  if (state.remoteLocationData.state == '')
                    const SizedBox()
                  else
                    MyTextWidget(
                      text: '${state.remoteLocationData.state}, ',
                      fontSize: addPadding ? 17.sp : 15.sp,
                      color: colorState.theme.bgImageTextColor,
                    ),
                  MyTextWidget(
                    text: '${state.remoteLocationData.country} ',
                    fontSize: addPadding ? 17.sp : 15.sp,
                    color: colorState.theme.bgImageTextColor,
                  ),
                ],
              ).paddingOnly(bottom: 8),
            ],
          ).paddingOnly(right: multiCityName ? 3.w : 5),
        );
      },
    );
  }
}

class _MultiWordCityWidget extends StatelessWidget {
  const _MultiWordCityWidget({
    required this.wordList,
    required this.colorState,
  });

  final List<String> wordList;
  final ColorState colorState;

  List<String> firstTwoWords() {
    final firstTwoWords = <String>[];
    for (int i = 0; i < wordList.length; i++) {
      if (i <= 1) {
        // adding space after first word
        final word = i == 0 ? '${wordList[i]} ' : wordList[i];
        firstTwoWords.add(word);
      }
    }
    return firstTwoWords;
  }

  List<String> lastWords() {
    final lastWords = <String>[];
    for (var i = 0; i < wordList.length; i++) {
      if (i > 1) {
        // adding space after all words except last word
        final word = i == wordList.length ? wordList[i] : '${wordList[i]} ';
        lastWords.add(word);
      }
    }
    return lastWords;
  }

  @override
  Widget build(BuildContext context) {
    return wordList.length > 2
        ? Column(
            children: [
              Row(
                children: [
                  for (final word in firstTwoWords())
                    MyTextWidget(
                      text: word,
                      fontSize: 22.sp,
                      // fontSize: 22.sp,
                      fontWeight: FontWeight.w400,
                      color: colorState.theme.bgImageTextColor,
                    ),
                ],
              ),
              for (final word in lastWords())
                MyTextWidget(
                  text: word,
                  fontSize: 22.sp,
                  fontWeight: FontWeight.w400,
                  color: colorState.theme.bgImageTextColor,
                ),
            ],
          )
        : Column(
            children: [
              for (final word in wordList)
                MyTextWidget(
                  text: word,
                  fontSize: 22.sp,
                  fontWeight: FontWeight.w400,
                  color: colorState.theme.bgImageTextColor,
                ),
            ],
          ).paddingOnly(bottom: 1.5.h);
  }
}

class _TempColumn extends StatelessWidget {
  const _TempColumn(
    this.colorState,
  );

  final ColorState colorState;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CurrentWeatherCubit, CurrentWeatherState>(
      buildWhen: (previous, current) => previous.data != current.data,
      builder: (context, state) {
        AppDebug.log('CurrentWeatherCubit build');

        // just to add more fontweight for when the text in contrast to earthFromSpace image
        final fontWeight = colorState.heavyFont ? FontWeight.w500 : null;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            sizedBox10High,
            _MainCurrentTempWidget(),
            MyTextWidget(
              text: state.data!.condition,
              fontSize: 14.sp,
              fontWeight: fontWeight,
              color: colorState.theme.conditionColor,
            ),
            _FeelsLikeRow(),
            Row(
              children: [
                MyTextWidget(
                  text: 'Wind Speed: ',
                  fontSize: 12.sp,
                  fontWeight: fontWeight,
                  color: colorState.theme.bgImageParamColor,
                ),
                MyTextWidget(
                  text: '${state.data!.windSpeed} ${state.data!.speedUnit}',
                  fontSize: 12.sp,
                  fontWeight: fontWeight,
                  color: colorState.theme.paramValueColor,
                ),
              ],
            ),
            sizedBox5High
          ],
        );
      },
    ).paddingOnly(left: 10, bottom: 5);
  }
}

class _MainCurrentTempWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CurrentWeatherCubit, CurrentWeatherState>(
      builder: (context, state) {
        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MyTextWidget(
              text: state.data!.temp.toString(),
              fontSize: 45.sp,
              fontWeight: FontWeight.bold,
              color: context.read<ColorCubit>().state.theme.bgImageTextColor,
            ).paddingSymmetric(vertical: 5),
            Column(
              children: [
                sizedBox10High,
                MyTextWidget(
                  text: degreeSymbol,
                  fontSize: 30.sp,
                  color:
                      context.read<ColorCubit>().state.theme.bgImageTextColor,
                ),
              ],
            ),
            MyTextWidget(
              text: state.data!.tempUnit,
              textStyle: TextStyle(
                height: 0.9,
                fontSize: 14.sp,
                color: context.read<ColorCubit>().state.theme.bgImageTextColor,
              ),
            ).paddingOnly(top: 20, left: 2.5),
          ],
        );
      },
    );
  }
}

class _FeelsLikeRow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final fontWeight =
        context.read<ColorCubit>().state.heavyFont ? FontWeight.w500 : null;
    return Row(
      children: [
        MyTextWidget(
          text: 'Feels Like: ',
          fontSize: 12.sp,
          fontWeight: fontWeight,
          color: context.read<ColorCubit>().state.theme.bgImageParamColor,
        ),
        MyTextWidget(
          text: '${context.read<CurrentWeatherCubit>().state.data!.feelsLike}',
          fontSize: 12.sp,
          fontWeight: fontWeight,
          color: context.read<ColorCubit>().state.theme.paramValueColor,
        ),
        MyTextWidget(
          text: degreeSymbol,
          fontSize: 12.sp,
          fontWeight: fontWeight,
          color: context.read<ColorCubit>().state.theme.conditionColor,
        ),
      ],
    );
  }
}
