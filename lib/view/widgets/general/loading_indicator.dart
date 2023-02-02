import 'package:black_cat_lib/extensions/widget_extensions.dart';
import 'package:epic_skies/global/app_bloc/app_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoadingIndicator extends StatelessWidget {
  const LoadingIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppBloc, AppState>(
      builder: (context, state) {
        return state is AppLoading
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
