import 'package:app_settings/app_settings.dart';
import 'package:epic_skies/core/error_handling/error_messages.dart';
import 'package:epic_skies/extensions/widget_extensions.dart';
import 'package:epic_skies/features/current_weather_forecast/cubit/current_weather_cubit.dart';
import 'package:epic_skies/features/location/bloc/location_bloc.dart';
import 'package:epic_skies/features/location/remote_location/models/remote_location/remote_location_model.dart';
import 'package:epic_skies/global/local_constants.dart';
import 'package:epic_skies/services/view_controllers/color_cubit/color_cubit.dart';
import 'package:epic_skies/view/widgets/containers/containers.dart';
import 'package:epic_skies/view/widgets/weather_info_display/unit_widgets.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_handler/permission_handler.dart';

const double _fontSize = 19;

class CurrentWeatherRow extends StatelessWidget {
  const CurrentWeatherRow({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ColorCubit, ColorState>(
      builder: (context, colorState) {
        return RoundedContainer(
          color: colorState.theme.homeContainerColor,
          height: 230,
          child: Stack(
            children: [
              _TempColumn(colorState),
              _LocationWidget(colorState),
            ],
          ).paddingSymmetric(vertical: 5),
        );
      },
    );
  }
}

class _LocationWidget extends StatelessWidget {
  const _LocationWidget(this.colorState);

  final ColorState colorState;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocationBloc, LocationState>(
      builder: (context, state) {
        if (!state.searchIsLocal) {
          return _RemoteLocationColumn(colorState);
        }

        if (state.status.isError) {
          final noNetwork = state.errorModel == Errors.noNetworkErrorModel;
          return Positioned(
            right: 0,
            top: noNetwork ? 55 : 25,
            child: Column(
              children: [
                Text(
                  state.errorModel!.title,
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.w400,
                    color: colorState.theme.bgImageTextColor,
                  ),
                ).paddingSymmetric(horizontal: 10, vertical: 10),
                if (!noNetwork) ...[
                  Text(
                    'Restart to try',
                    style: TextStyle(
                      fontSize: 25,
                      color: colorState.theme.bgImageTextColor,
                    ),
                  ),
                  Text(
                    'again or use search',
                    style: TextStyle(
                      fontSize: 25,
                      color: colorState.theme.bgImageTextColor,
                    ),
                  ),
                ],
              ],
            ),
          );
        }

        final locationDisabled = state.status.isNoLocationPermission ||
            state.status.isLocationDisabled;

        return locationDisabled
            ? _LocationDisabledWidget(status: state.status)
            : _AddressColumn(locationState: state, colorState: colorState);
      },
    );
  }
}

class _AddressColumn extends StatelessWidget {
  const _AddressColumn({
    required this.colorState,
    required this.locationState,
  });

  final ColorState colorState;
  final LocationState locationState;

  @override
  Widget build(BuildContext context) {
    final multiCityName = locationState.localData.longNameList.isNotEmpty;
    final longSingleName = locationState.localData.subLocality.length > 10;
    return Positioned(
      height: 215,
      right: 10,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (multiCityName)
            _MultiWordCityWidget(
              wordList: locationState.localData.longNameList,
              colorState: colorState,
              isCountry: false,
            )
          else
            Text(
              locationState.localData.subLocality,
              style: TextStyle(
                fontSize: longSingleName ? 40 : 43,
                fontWeight: FontWeight.w400,
                color: colorState.theme.bgImageTextColor,
              ),
            ).paddingSymmetric(horizontal: 10),
          Text(
            locationState.localData.administrativeArea,
            style: TextStyle(
              fontSize: 25,
              color: colorState.theme.bgImageTextColor,
            ),
          ).paddingOnly(top: 2.5),
        ],
      ).paddingOnly(right: multiCityName ? 3 : 0),
    );
  }
}

class _RemoteLocationColumn extends StatelessWidget {
  const _RemoteLocationColumn(
    this.colorState,
  );

  final ColorState colorState;
  bool _addMorePadding(RemoteLocationModel data) {
    if (data.longNameList.isEmpty) {
      return data.city.length <= 8;
    }

    for (final word in data.longNameList) {
      if (word.length > 8) {
        return false;
      }
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocationBloc, LocationState>(
      builder: (context, state) {
        final multiCityName = state.remoteLocationData.longNameList.isNotEmpty;
        final addPadding = _addMorePadding(state.remoteLocationData);
        final countryWordList = state.remoteLocationData.country.split(' ');
        final threeWordCountry = countryWordList.length == 3;

        return Positioned(
          height: 164,
          top: 20,
          right: addPadding ? 20 : 10,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (multiCityName)
                _MultiWordCityWidget(
                  wordList: state.remoteLocationData.longNameList,
                  colorState: colorState,
                  isCountry: false,
                )
              else
                Text(
                  state.remoteLocationData.city,
                  style: TextStyle(
                    fontSize: addPadding ? 40 : 32,
                    fontWeight: FontWeight.w500,
                    color: colorState.theme.bgImageTextColor,
                  ),
                ).paddingOnly(right: 5),
              const SizedBox(height: 5),
              Row(
                children: [
                  if (state.remoteLocationData.state == '')
                    const SizedBox()
                  else
                    Text(
                      '${state.remoteLocationData.state}, ',
                      style: TextStyle(
                        fontSize: addPadding ? 25 : _fontSize,
                        color: colorState.theme.bgImageTextColor,
                      ),
                    ),
                  if (threeWordCountry)
                    _MultiWordCityWidget(
                      wordList: countryWordList,
                      colorState: colorState,
                      isCountry: true,
                    )
                  else
                    Text(
                      '${state.remoteLocationData.country} ',
                      style: TextStyle(
                        fontSize: addPadding ? 24 : 22,
                        color: colorState.theme.bgImageTextColor,
                      ),
                    ),
                ],
              ).paddingOnly(bottom: 8),
            ],
          ).paddingOnly(right: multiCityName ? 3 : 5),
        );
      },
    );
  }
}

class _LocationDisabledWidget extends StatelessWidget {
  const _LocationDisabledWidget({
    required this.status,
  });

  final LocationStatus status;

  Future<void> _openLocationSettings() async {
    await AppSettings.openAppSettings(
      type: AppSettingsType.location,
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Positioned(
      top: screenSize.height * 0.03,
      right: screenSize.width * 0.025,
      child: SizedBox(
        width: screenSize.width * 0.5,
        child: Column(
          children: [
            Wrap(
              children: [
                Text(
                  status.isNoLocationPermission
                      ? 'Location Permission Denied'
                      : 'Location disabled',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 15),
            Wrap(
              children: [
                Text.rich(
                  textAlign: TextAlign.center,
                  TextSpan(
                    children: [
                      TextSpan(
                        text: status.isNoLocationPermission
                            ? 'Allow location access'
                            : 'Turn on location',
                        recognizer: TapGestureRecognizer()
                          ..onTap = status.isNoLocationPermission
                              ? openAppSettings
                              : _openLocationSettings,
                        style: const TextStyle(
                          color: Colors.blue,
                          fontSize: 19,
                          fontWeight: FontWeight.w600,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                      const TextSpan(
                        text: '''
 to fetch local weather or use the search functionality''',
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 19,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _MultiWordCityWidget extends StatelessWidget {
  const _MultiWordCityWidget({
    required this.wordList,
    required this.colorState,
    required this.isCountry,
  });

  final List<String> wordList;
  final ColorState colorState;
  final bool isCountry;

  List<String> firstTwoWords() {
    final firstTwoWords = <String>[];
    for (var i = 0; i < wordList.length; i++) {
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
    final fontSize = isCountry ? 16.0 : 33.0;
    return wordList.length > 2
        ? Column(
            children: [
              Row(
                children: [
                  for (final word in firstTwoWords())
                    Text(
                      word,
                      style: TextStyle(
                        fontSize: fontSize,
                        fontWeight: FontWeight.w400,
                        color: colorState.theme.bgImageTextColor,
                      ),
                    ),
                ],
              ),
              for (final word in lastWords())
                Text(
                  word,
                  style: TextStyle(
                    fontSize: fontSize,
                    fontWeight: FontWeight.w400,
                    color: colorState.theme.bgImageTextColor,
                  ),
                ),
            ],
          )
        : Column(
            children: [
              for (final word in wordList)
                Text(
                  word,
                  style: TextStyle(
                    fontSize: fontSize,
                    fontWeight: FontWeight.w400,
                    color: colorState.theme.bgImageTextColor,
                  ),
                ),
            ],
          ).paddingOnly(bottom: 1.5);
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
        // just to add more fontweight for when the text in contrast to
        // earthFromSpace image
        final fontWeight = colorState.heavyFont ? FontWeight.w500 : null;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SizedBox(height: 10),
            _MainCurrentTempWidget(),
            Text(
              state.data!.condition,
              style: TextStyle(
                fontSize: 23,
                fontWeight: fontWeight,
                color: colorState.theme.conditionColor,
              ),
            ),
            _FeelsLikeRow(),
            Row(
              children: [
                Text(
                  'Wind Speed: ',
                  style: TextStyle(
                    fontSize: _fontSize,
                    fontWeight: fontWeight,
                    color: colorState.theme.bgImageParamColor,
                  ),
                ),
                Text(
                  '${state.data!.windSpeed} ',
                  style: TextStyle(
                    fontSize: _fontSize,
                    fontWeight: fontWeight,
                    color: colorState.theme.paramValueColor,
                  ),
                ),
                SpeedUnitWidget(
                  textStyle: TextStyle(
                    fontSize: _fontSize,
                    fontWeight: fontWeight,
                    color: colorState.theme.paramValueColor,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 5),
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
            Text(
              state.data!.temp.toString(),
              style: TextStyle(
                fontSize: 70,
                fontWeight: FontWeight.bold,
                color: context.read<ColorCubit>().state.theme.bgImageTextColor,
              ),
            ).paddingSymmetric(vertical: 5),
            Column(
              children: [
                const SizedBox(height: 10),
                Text(
                  degreeSymbol,
                  style: TextStyle(
                    fontSize: 30,
                    color:
                        context.read<ColorCubit>().state.theme.bgImageTextColor,
                  ),
                ),
              ],
            ),
            TempUnitWidget(
              textStyle: TextStyle(
                height: 0.9,
                fontSize: 14,
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
        Text(
          'Feels Like: ',
          style: TextStyle(
            fontSize: _fontSize,
            fontWeight: fontWeight,
            color: context.read<ColorCubit>().state.theme.bgImageParamColor,
          ),
        ),
        Text(
          '${context.read<CurrentWeatherCubit>().state.data!.feelsLike}',
          style: TextStyle(
            fontSize: _fontSize,
            fontWeight: fontWeight,
            color: context.read<ColorCubit>().state.theme.paramValueColor,
          ),
        ),
        Text(
          degreeSymbol,
          style: TextStyle(
            fontSize: _fontSize,
            fontWeight: fontWeight,
            color: context.read<ColorCubit>().state.theme.conditionColor,
          ),
        ),
      ],
    );
  }
}
