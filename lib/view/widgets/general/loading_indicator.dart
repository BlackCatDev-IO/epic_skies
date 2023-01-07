import 'package:black_cat_lib/extensions/widget_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../features/main_weather/bloc/weather_bloc.dart';

class LoadingIndicator extends StatelessWidget {
  const LoadingIndicator();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WeatherBloc, WeatherState>(
      builder: (context, state) {
        return state.status.isLoading
            ? Container(
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white60,
                ),
                height: 55,
                width: 55,
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color?>(Colors.blue[900]),
                ).center(),
              )
            : const SizedBox();
      },
    ).center();
  }
}
