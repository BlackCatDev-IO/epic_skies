import 'package:black_cat_lib/black_cat_lib.dart';
import 'package:epic_skies/global/local_constants.dart';
import 'package:epic_skies/services/asset_controllers/bg_image/bloc/bg_image_bloc.dart';
import 'package:epic_skies/view/screens/tab_screens/home_tab_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:sizer/sizer.dart';

import '../../features/current_weather_forecast/cubit/current_weather_cubit.dart';
import '../../features/location/bloc/location_bloc.dart';
import '../../features/main_weather/bloc/weather_bloc.dart';
import '../../utils/ui_updater/ui_updater.dart';

class WelcomeScreen extends StatelessWidget {
  static const id = '/location_refresh_screen';
  const WelcomeScreen();

  static const _fetchingLocation =
      'Fetching your current location. This may take a bit longer on the first install';

  static const _fetchingWeather = 'Fetching your local weather data!';

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<LocationBloc, LocationState>(
          listener: (context, state) {
            if (state.status.isSuccess) {
              context.read<WeatherBloc>().add(
                    WeatherUpdate(
                      lat: state.coordinates!.lat,
                      long: state.coordinates!.long,
                      searchIsLocal: state.searchIsLocal,
                    ),
                  );
            }
          },
        ),
        BlocListener<WeatherBloc, WeatherState>(
          listener: (context, state) {
            if (state.status.isSuccess) {
              context
                  .read<CurrentWeatherCubit>()
                  .refreshCurrentWeatherData(weatherState: state);

              context
                  .read<BgImageBloc>()
                  .add(BgImageUpdateOnRefresh(weatherState: state));

              UiUpdater.refreshUI(state);
              Navigator.of(context).pushReplacementNamed(HomeTabView.id);
            }
          },
        ),
      ],
      child: NotchDependentSafeArea(
        child: Scaffold(
          body: MyImageContainer(
            width: double.infinity,
            imagePath: earthFromSpace,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 5.h),
                BlocBuilder<LocationBloc, LocationState>(
                  builder: (context, state) {
                    final statusString = state.status.isSuccess
                        ? _fetchingWeather
                        : _fetchingLocation;
                    return RoundedContainer(
                      radius: 8,
                      color: const Color.fromRGBO(0, 0, 0, 0.7),
                      child: MyTextWidget(
                        text: statusString,
                        fontSize: 15.sp,
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
                SizedBox(height: 4.h),
                const CircularProgressIndicator(
                  backgroundColor: Colors.transparent,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ).center(),
              ],
            ).paddingSymmetric(horizontal: 10),
          ),
        ),
      ),
    );
  }
}
