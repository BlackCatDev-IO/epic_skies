import 'package:epic_skies/extensions/widget_extensions.dart';
import 'package:epic_skies/features/hourly_forecast/cubit/hourly_forecast_cubit.dart';
import 'package:epic_skies/services/register_services.dart';
import 'package:epic_skies/services/ticker_controllers/tab_navigation_controller.dart';
import 'package:epic_skies/view/widgets/containers/partial_rounded_container.dart';
import 'package:epic_skies/view/widgets/labels/section_header.dart';
import 'package:epic_skies/view/widgets/weather_info_display/hourly_widgets/horizontal_scroll_widget.dart';
import 'package:epic_skies/view/widgets/weather_info_display/hourly_widgets/hourly_scroll_widget_column.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HourlyForecastRow extends StatelessWidget {
  const HourlyForecastRow({super.key});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => getIt<TabNavigationController>().jumpToTab(index: 1),
      child: BlocBuilder<HourlyForecastCubit, HourlyForecastState>(
        builder: (context, state) {
          final widgetList = state.next24Hours
              .map(
                (model) => HourlyScrollWidgetColumn(
                  model: model,
                ),
              )
              .toList();
          return HorizontalScrollWidget(
            list: widgetList,
            header: const SectionHeader(label: 'Next 24 Hours'),
            layeredCard: false,
          );
        },
      ),
    ).paddingSymmetric(vertical: 5);
  }
}

class HourlyHeader extends StatelessWidget {
  const HourlyHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return PartialRoundedContainer(
      topLeft: 10,
      topRight: 10,
      color: Colors.black87,
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Hourly',
            style: TextStyle(
              color: Colors.white54,
              fontSize: 18,
              letterSpacing: 5,
            ),
          ),
        ],
      ).paddingSymmetric(vertical: 2),
    );
  }
}
