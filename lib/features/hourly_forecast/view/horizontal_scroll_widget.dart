import 'dart:math';

import 'package:epic_skies/extensions/widget_extensions.dart';
import 'package:epic_skies/features/hourly_forecast/models/hourly_forecast_model/hourly_forecast_model.dart';
import 'package:epic_skies/features/hourly_forecast/view/hourly_summary_column.dart';
import 'package:epic_skies/features/main_weather/bloc/weather_bloc.dart';
import 'package:epic_skies/features/settings/unit_settings/unit_settings_model.dart';
import 'package:epic_skies/services/register_services.dart';
import 'package:epic_skies/services/ticker_controllers/tab_navigation_controller.dart';
import 'package:epic_skies/services/view_controllers/color_cubit/color_cubit.dart';
import 'package:epic_skies/view/widgets/containers/custom_card.dart';
import 'package:epic_skies/view/widgets/containers/partial_rounded_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HorizontalScrollWidget extends StatelessWidget {
  HorizontalScrollWidget({
    required this.forecasts,
    required this.layeredCard,
    required this.header,
    super.key,
  });

  final List<HourlyForecastModel> forecasts;
  final bool layeredCard;
  final Widget header;

  final _scrollController = ScrollController();

  List<HourlySummaryColumn> _createHourlyForecastWidgets(
    List<HourlyForecastModel> forecasts,
  ) {
    return List.generate(forecasts.length, (index) {
      final prevTemp =
          index > 0 ? forecasts[index - 1].temp : forecasts[index].temp;
      final nextTemp = index < forecasts.length - 1
          ? forecasts[index + 1].temp
          : forecasts[index].temp;

      return HourlySummaryColumn(
        model: forecasts[index],
        prevTemp: prevTemp,
        nextTemp: nextTemp,
        minTemp: forecasts.map((model) => model.temp).reduce(min),
        maxTemp: forecasts.map((model) => model.temp).reduce(max),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => getIt<TabNavigationController>().jumpToTab(index: 1),
      child: CustomCard(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            header,
            BlocBuilder<ColorCubit, ColorState>(
              builder: (context, state) {
                return PartialRoundedContainer(
                  height: 240,
                  color: layeredCard
                      ? state.theme.layeredCardColor
                      : state.theme.soloCardColor,
                  bottomLeft: 10,
                  bottomRight: 10,
                  child: Theme(
                    data: ThemeData(
                      highlightColor: Colors.grey,
                      platform: TargetPlatform.android,
                    ),
                    child: MediaQuery(
                      data: MediaQuery.of(context)
                          .removePadding(removeBottom: true),
                      child: Scrollbar(
                        thumbVisibility: true,
                        controller: _scrollController,
                        thickness: 2,
                        child: BlocSelector<WeatherBloc, WeatherState,
                            UnitSettings>(
                          selector: (state) => state.unitSettings,
                          builder: (context, state) {
                            final widgetList =
                                _createHourlyForecastWidgets(forecasts);

                            return ListView.builder(
                              controller: _scrollController,
                              scrollDirection: Axis.horizontal,
                              itemCount: forecasts.length,
                              itemBuilder: (context, index) {
                                return widgetList[index];
                              },
                            );
                          },
                        ),
                      ).paddingSymmetric(horizontal: 5),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
