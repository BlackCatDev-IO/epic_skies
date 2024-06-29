import 'package:app_settings/app_settings.dart';
import 'package:epic_skies/extensions/widget_extensions.dart';
import 'package:epic_skies/features/location/bloc/location_bloc.dart';
import 'package:epic_skies/features/main_weather/models/local_weather_button_model/local_weather_button_model.dart';
import 'package:epic_skies/features/main_weather/view/cubit/local_weather_button_cubit.dart';
import 'package:epic_skies/global/local_constants.dart';
import 'package:epic_skies/l10n/l10n.dart';
import 'package:epic_skies/services/asset_controllers/icon_controller.dart';
import 'package:epic_skies/services/register_services.dart';
import 'package:epic_skies/services/ticker_controllers/tab_navigation_controller.dart';
import 'package:epic_skies/services/view_controllers/color_cubit/color_cubit.dart';
import 'package:epic_skies/view/widgets/weather_info_display/unit_widgets.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_handler/permission_handler.dart';

class LocalWeatherButton extends StatelessWidget {
  const LocalWeatherButton({
    required this.isSearchPage,
    super.key,
  });

  final bool isSearchPage;

  Future<void> _openLocationSettings() async {
    await AppSettings.openAppSettings(type: AppSettingsType.location);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocalWeatherButtonCubit, LocalWeatherButtonModel>(
      builder: (context, buttonState) {
        final iconPath = IconController.getIconImagePath(
          temp: buttonState.temp,
          condition: buttonState.condition,
          isDay: buttonState.isDay,
          tempUnitsMetric: buttonState.tempUnitsMetric,
        );
        return GestureDetector(
          onTap: () {
            getIt<TabNavigationController>().jumpToTab(index: 0);
            context.read<LocationBloc>().add(LocationUpdateLocal());
          },
          child: BlocBuilder<ColorCubit, ColorState>(
            builder: (context, state) {
              return BlocBuilder<LocationBloc, LocationState>(
                builder: (context, locationstate) {
                  return Container(
                    color:
                        isSearchPage ? Colors.black54 : state.theme.appBarColor,
                    height: 95,
                    width: double.infinity,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        if (locationstate.status.isNoLocationPermission ||
                            locationstate.status.isLocationDisabled)
                          Column(
                            children: [
                              const SizedBox(height: 15),
                              Wrap(
                                children: [
                                  Text(
                                    locationstate.status.isNoLocationPermission
                                        ? 'Location Permission Denied'
                                        : 'Location Disabled',
                                    style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),
                              Wrap(
                                children: [
                                  RichText(
                                    textAlign: TextAlign.center,
                                    text: TextSpan(
                                      children: [
                                        TextSpan(
                                          text: locationstate
                                                  .status.isNoLocationPermission
                                              ? 'Allow location access'
                                              : 'Enable location services',
                                          recognizer: TapGestureRecognizer()
                                            ..onTap = locationstate.status
                                                    .isNoLocationPermission
                                                ? openAppSettings
                                                : _openLocationSettings,
                                          style: const TextStyle(
                                            color: Colors.blue,
                                            fontSize: 19,
                                            fontWeight: FontWeight.w600,
                                            decoration:
                                                TextDecoration.underline,
                                          ),
                                        ),
                                        const TextSpan(
                                          text: ' to fetch local weather',
                                          style: TextStyle(
                                            color: Colors.white70,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          )
                        else ...[
                          _TempWidget(
                            temp: buttonState.temp,
                          ),
                          _LocationWidget(locationstate),
                          _ConditionIcon(iconPath: iconPath),
                        ],
                      ],
                    ),
                  );
                },
              );
            },
          ),
        );
      },
    );
  }
}

class _TempWidget extends StatelessWidget {
  const _TempWidget({required this.temp});

  final int temp;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              temp.toString(),
              style: TextStyle(
                fontSize: 35,
                fontWeight: FontWeight.bold,
                color: context.read<ColorCubit>().state.theme.bgImageTextColor,
              ),
            ),
            Column(
              children: [
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
                fontSize: 18,
                fontWeight: FontWeight.w400,
                color: context.read<ColorCubit>().state.theme.bgImageTextColor,
              ),
            ).paddingOnly(top: 3),
          ],
        ),
      ],
    ).paddingOnly(left: 10);
  }
}

class _LocationWidget extends StatelessWidget {
  const _LocationWidget(this.locationState);

  final LocationState locationState;

  @override
  Widget build(BuildContext context) {
    final fontSize =
        locationState.localData.subLocality.length > 9 ? 22.5 : 23.toDouble();
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (locationState.localData.longNameList.isNotEmpty)
              _LongNameWidget(
                longNameList: locationState.localData.longNameList,
              )
            else
              Text(
                locationState.localData.subLocality,
                style: TextStyle(
                  fontSize: fontSize,
                  fontWeight: FontWeight.w500,
                ),
              ),
            Text(
              locationState.localData.administrativeArea,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(height: 10),
            const _CurrentLocationIndicator(),
          ],
        ),
      ],
    );
  }
}

class _LongNameWidget extends StatelessWidget {
  const _LongNameWidget({required this.longNameList});
  final List<String> longNameList;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: longNameList.map((word) => Text('$word ')).toList(),
    );
  }
}

class _CurrentLocationIndicator extends StatelessWidget {
  const _CurrentLocationIndicator();

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Row(
      children: [
        Icon(
          Icons.near_me,
          color: Colors.blue[100],
          size: 17,
        ).paddingOnly(top: 3),
        const SizedBox(width: 5),
        Text(
          l10n.yourLocation,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Colors.blue,
          ),
        ),
      ],
    ).paddingOnly(right: 4);
  }
}

class _ConditionIcon extends StatelessWidget {
  const _ConditionIcon({required this.iconPath});
  final String iconPath;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: 3,
      child: Image(
        image: AssetImage(iconPath),
        height: 45,
      ),
    );
  }
}
