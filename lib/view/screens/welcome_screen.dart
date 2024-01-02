import 'package:black_cat_lib/extensions/extensions.dart';
import 'package:black_cat_lib/widgets/containers_cards.dart';
import 'package:black_cat_lib/widgets/text_widgets.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:epic_skies/extensions/widget_extensions.dart';
import 'package:epic_skies/features/bg_image/bloc/bg_image_bloc.dart';
import 'package:epic_skies/features/location/bloc/location_bloc.dart';
import 'package:epic_skies/features/main_weather/bloc/weather_bloc.dart';
import 'package:epic_skies/global/app_bloc/app_bloc.dart';
import 'package:epic_skies/global/local_constants.dart';
import 'package:epic_skies/services/view_controllers/color_cubit/color_cubit.dart';
import 'package:epic_skies/utils/timezone/timezone_util.dart';
import 'package:epic_skies/utils/ui_updater/ui_updater.dart';
import 'package:epic_skies/view/dialogs/error_dialogs.dart';
import 'package:epic_skies/view/dialogs/location_error_dialogs.dart';
import 'package:epic_skies/view/screens/tab_screens/home_tab_view.dart';
import 'package:epic_skies/view/widgets/general/loading_indicator.dart';
import 'package:epic_skies/view/widgets/image_widget_containers/weather_image_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});
  static const id = '/location_refresh_screen';

  static const _fetchingLocation = '''
Fetching your current location. This may take a bit longer on the first install''';

  static const _fetchingWeather = 'Fetching your local weather data!';

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final locationState = context.read<LocationBloc>().state;

      final isErrorState = locationState.status.isError ||
          locationState.status.isNoLocationPermission ||
          locationState.status.isLocationDisabled;

      if (isErrorState) {
        Navigator.of(context).pushReplacementNamed(HomeTabView.id);
        context.read<AppBloc>().add(AppNotifyNotLoading());
      }
    });

    final timezoneUtil = GetIt.I<TimeZoneUtil>();
    return MultiBlocListener(
      listeners: [
        BlocListener<LocationBloc, LocationState>(
          listener: (context, state) {
            final weatherBloc = context.read<WeatherBloc>();
            switch (state.status) {
              case LocationStatus.initial:
              case LocationStatus.loading:
                return;

              case LocationStatus.success:
                final coordinates = state.coordinates!;
                timezoneUtil.setTimeZoneOffset(
                  lat: coordinates.lat,
                  long: coordinates.long,
                );

                weatherBloc.add(
                  WeatherUpdate(
                    lat: state.coordinates!.lat,
                    long: state.coordinates!.long,
                    searchIsLocal: state.searchIsLocal,
                    timezone: timezoneUtil.timezone,
                    countryCode: state.countryCode,
                    languageCode: state.languageCode,
                  ),
                );
                break;

              case LocationStatus.error:
              case LocationStatus.noLocationPermission:
              case LocationStatus.locationDisabled:
                if (state.status.isError) {
                  LocationDialogs.showNoAddressInfoFoundDialog(
                    context,
                    state.errorModel!,
                  );
                }

                context.read<ColorCubit>().updateThemeColors(
                      path: earthFromSpace,
                      isBackupApi: weatherBloc.state.useBackupApi,
                    );

                Navigator.of(context).pushReplacementNamed(HomeTabView.id);
            }
          },
        ),
        BlocListener<WeatherBloc, WeatherState>(
          listener: (context, state) {
            if (state.status.isSuccess) {
              UiUpdater.refreshUI(context);
            }

            if (state.status.isError) {
              Navigator.of(context).pushReplacementNamed(HomeTabView.id);
              ErrorDialogs.showDialog(context, state.errorModel!);
            }
          },
        ),
        BlocListener<BgImageBloc, BgImageState>(
          listener: (context, state) async {
            if (state.status.isLoaded || state.status.isError) {
              final navigator = Navigator.of(context);

              if (state.status.isLoaded) {
                final startingBgImage =
                    CachedNetworkImageProvider(state.bgImagePath);

                await precacheImage(
                  startingBgImage,
                  navigator.context,
                );
              }

              await navigator.pushReplacementNamed(HomeTabView.id);
            }
          },
        ),
      ],
      child: Scaffold(
        body: EarthFromSpaceBGContainer(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 5),
              BlocBuilder<LocationBloc, LocationState>(
                builder: (context, state) {
                  final statusString = state.status.isSuccess
                      ? WelcomeScreen._fetchingWeather
                      : WelcomeScreen._fetchingLocation;
                  return RoundedContainer(
                    radius: 8,
                    color: const Color.fromRGBO(0, 0, 0, 0.7),
                    child: MyTextWidget(
                      text: statusString,
                      fontSize: 21,
                      color: Colors.white,
                      fontWeight: FontWeight.w200,
                    )
                        .paddingSymmetric(
                          vertical: 15,
                          horizontal: 20,
                        )
                        .center(),
                  );
                },
              ),
              const SizedBox(height: 45),
              const Loader(),
            ],
          ).paddingSymmetric(horizontal: 10),
        ),
      ),
    );
  }
}
