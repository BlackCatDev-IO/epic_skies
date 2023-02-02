import 'package:black_cat_lib/black_cat_lib.dart';
import 'package:epic_skies/extensions/widget_extensions.dart';
import 'package:epic_skies/features/location/bloc/location_bloc.dart';
import 'package:epic_skies/features/main_weather/bloc/weather_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RemoteLocationLabel extends StatelessWidget {
  const RemoteLocationLabel({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WeatherBloc, WeatherState>(
      builder: (context, state) {
        final data = context.read<LocationBloc>().state.remoteLocationData;
        return !state.searchIsLocal
            ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RoundedContainer(
                    color: Colors.white70,
                    child: Text(
                      '${data.city}, ${data.country}',
                    ).paddingSymmetric(horizontal: 10, vertical: 2.5).center(),
                  ).paddingOnly(top: 2.5, bottom: 5),
                ],
              )
            : const SizedBox();
      },
    );
  }
}
