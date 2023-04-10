import 'package:black_cat_lib/extensions/widget_extensions.dart';
import 'package:epic_skies/global/app_bloc/app_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class LoadingIndicator extends StatelessWidget {
  const LoadingIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppBloc, AppState>(
      builder: (context, state) {
        return state is AppLoading ? const Loader() : const SizedBox();
      },
    ).center();
  }
}

class Loader extends StatelessWidget {
  const Loader({super.key});

  @override
  Widget build(BuildContext context) {
    return LoadingAnimationWidget.threeArchedCircle(
      color: const Color.fromARGB(174, 255, 255, 255),
      size: 60,
    ).center();
  }
}
