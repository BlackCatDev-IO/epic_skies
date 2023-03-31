import 'package:black_cat_lib/black_cat_lib.dart';
import 'package:epic_skies/extensions/widget_extensions.dart';
import 'package:epic_skies/features/location/bloc/location_bloc.dart';
import 'package:epic_skies/features/main_weather/models/local_weather_button_model.dart';
import 'package:epic_skies/features/main_weather/view/cubit/local_weather_button_cubit.dart';
import 'package:epic_skies/global/local_constants.dart';
import 'package:epic_skies/services/asset_controllers/icon_controller.dart';
import 'package:epic_skies/services/ticker_controllers/tab_navigation_controller.dart';
import 'package:epic_skies/services/view_controllers/color_cubit/color_cubit.dart';
import 'package:epic_skies/view/widgets/weather_info_display/unit_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class LocalWeatherButton extends StatelessWidget {
  const LocalWeatherButton({
    super.key,
    required this.isSearchPage,
  });

  final bool isSearchPage;

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
            GetIt.instance<TabNavigationController>().jumpToTab(index: 0);
            context.read<LocationBloc>().add(LocationUpdateLocal());
          },
          child: BlocBuilder<ColorCubit, ColorState>(
            builder: (context, state) {
              return Container(
                color: isSearchPage ? Colors.black54 : state.theme.appBarColor,
                height: 65,
                width: double.infinity,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    _TempWidget(
                      temp: buttonState.temp,
                    ),
                    const _LocationWidget(),
                    _ConditionIcon(iconPath: iconPath),
                  ],
                ),
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
            MyTextWidget(
              text: temp.toString(),
              fontSize: 25,
              fontWeight: FontWeight.bold,
              color: context.read<ColorCubit>().state.theme.bgImageTextColor,
            ),
            Column(
              children: [
                MyTextWidget(
                  text: degreeSymbol,
                  fontSize: 23,
                  color:
                      context.read<ColorCubit>().state.theme.bgImageTextColor,
                ),
              ],
            ),
            TempUnitWidget(
              textStyle: TextStyle(
                fontSize: 16,
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
  const _LocationWidget();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        BlocBuilder<LocationBloc, LocationState>(
          builder: (context, state) {
            final fontSize =
                state.data.subLocality.length > 19 ? 12.5 : 13.toDouble();
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (state.data.longNameList != null)
                  _LongNameWidget(
                    longNameList: state.data.longNameList!,
                  )
                else
                  MyTextWidget(
                    text: state.data.subLocality,
                    fontSize: fontSize,
                    fontWeight: FontWeight.w500,
                  ),
                MyTextWidget(
                  text: state.data.administrativeArea,
                  fontSize: 10,
                  fontWeight: FontWeight.w400,
                ),
                sizedBox10High,
                const _CurrentLocationIndicator()
              ],
            );
          },
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
      children:
          longNameList.map((word) => MyTextWidget(text: '$word ')).toList(),
    );
  }
}

class _CurrentLocationIndicator extends StatelessWidget {
  const _CurrentLocationIndicator();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          Icons.near_me,
          color: Colors.blue[100],
          size: 12,
        ).paddingOnly(top: 3),
        sizedBox5Wide,
        const MyTextWidget(
          text: 'Your location',
          fontSize: 10.5,
          fontWeight: FontWeight.w500,
          color: Colors.blue,
        )
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
      child: MyAssetImage(
        height: 5,
        path: iconPath,
      ),
    );
  }
}
