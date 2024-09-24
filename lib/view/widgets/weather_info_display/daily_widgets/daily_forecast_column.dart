import 'package:epic_skies/extensions/widget_extensions.dart';
import 'package:epic_skies/features/daily_forecast/cubit/daily_forecast_cubit.dart';
import 'package:epic_skies/features/daily_forecast/models/daily_forecast_model.dart';
import 'package:epic_skies/global/local_constants.dart';
import 'package:epic_skies/services/register_services.dart';
import 'package:epic_skies/services/ticker_controllers/tab_navigation_controller.dart';
import 'package:epic_skies/services/view_controllers/color_cubit/color_cubit.dart';
import 'package:epic_skies/view/widgets/containers/rounded_container.dart';
import 'package:epic_skies/view/widgets/labels/section_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DailyForecastColumn extends StatelessWidget {
  const DailyForecastColumn({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DailyForecastCubit, DailyForecastState>(
      builder: (context, state) {
        final widgetList = state.dailyForecastModelList
            .map(
              (model) => _DailyPreviewRow(
                dailyModel: model,
              ),
            )
            .toList();

        return Column(
          children: [
            const SectionHeader(
              label: 'Daily Forecast',
              isPartiallyRounded: false,
            ),
            const SizedBox(height: 5),
            ListView.builder(
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              physics: const ScrollPhysics(),
              itemCount: widgetList.length,
              itemBuilder: (context, index) {
                return widgetList[index];
              },
            ),
          ],
        );
      },
    );
  }
}

class _DailyPreviewRow extends StatelessWidget {
  const _DailyPreviewRow({
    required this.dailyModel,
  });

  final DailyForecastModel dailyModel;

  void _navToDailyDetailTab(BuildContext context) {
    getIt<TabNavigationController>().jumpToTab(index: 2);
    context.read<DailyForecastCubit>().updatedSelectedDay(
          dailyModel.date,
          autoScroll: true,
        );
  }

  @override
  Widget build(BuildContext context) {
    final bgColor = context.read<ColorCubit>().state.theme.soloCardColor;

    return GestureDetector(
      onTap: () => _navToDailyDetailTab(context),
      child: RoundedContainer(
        color: bgColor,
        padding: const EdgeInsets.all(10),
        child: Row(
          children: [
            _DateColumn(dailyModel),
            const Spacer(),
            _IconColumn(dailyModel),
            const Spacer(),
            _TemperatureRangeLine(dailyModel),
            const Icon(
              Icons.arrow_forward_ios,
              size: 15,
              color: Color.fromARGB(181, 158, 158, 158),
            ),
          ],
        ),
      ).paddingOnly(bottom: 2),
    );
  }
}

class _DateColumn extends StatelessWidget {
  const _DateColumn(
    this.dailyModel,
  );

  final DailyForecastModel dailyModel;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          dailyModel.day,
          style: const TextStyle(fontSize: 15),
        ),
        const SizedBox(height: 7),
        RoundedContainer(
          width: 30,
          height: 30,
          radius: 20,
          color: Colors.blueGrey[300],
          child: Text(
            dailyModel.date.toString(),
            style: const TextStyle(
              color: Colors.black,
              fontSize: 13,
              fontWeight: FontWeight.w400,
            ),
          ).center(),
        ),
      ],
    );
  }
}

class _IconColumn extends StatelessWidget {
  const _IconColumn(this.model);

  final DailyForecastModel model;

  @override
  Widget build(BuildContext context) {
    final precipProbablity = model.precipitationProbability.toString();
    final zeroPrecip = precipProbablity.startsWith('0');
    return Column(
      children: [
        Image(
          image: AssetImage(model.iconPath),
          height: 30,
        ),
        const SizedBox(height: 5),
        if (!zeroPrecip)
          Text(
            '$precipProbablity %',
            style: const TextStyle(fontSize: 14),
          ),
      ],
    );
  }
}

class _TemperatureRangeLine extends StatelessWidget {
  const _TemperatureRangeLine(this.model);

  final DailyForecastModel model;

  static const _bottomScale = 0.5;
  static const _topScale = 0.9;

  (double width, double lineStart, double lineWidth) _calcDynamicTempRangeLine(
    BuildContext context,
  ) {
    final width = MediaQuery.of(context).size.width * 0.34;
    final (minTemp, maxTemp) =
        context.read<DailyForecastCubit>().state.minAndMaxTemps;
    final totalRange = maxTemp - minTemp;
    final lowTempPosition =
        (model.lowTemp! - minTemp) / totalRange * _bottomScale;
    final highTempPosition =
        (model.highTemp! - minTemp) / totalRange * _topScale;
    final lineStart = width * lowTempPosition;
    final lineWidth = (highTempPosition - lowTempPosition) * width;

    return (width, lineStart, lineWidth);
  }

  @override
  Widget build(BuildContext context) {
    final (width, lineStart, lineWidth) = _calcDynamicTempRangeLine(context);

    return Expanded(
      flex: 5,
      child: Row(
        children: [
          Text('${model.lowTemp}$degreeSymbol'),
          Stack(
            children: [
              // Background track
              Container(
                width: width,
                height: 6,
                decoration: BoxDecoration(
                  color: Colors.blue.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              // Dynamic range line
              Positioned(
                left: lineStart,
                child: Container(
                  width: lineWidth,
                  height: 6,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.blue.shade400,
                        Colors.green.shade300,
                      ],
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ],
          ).paddingSymmetric(horizontal: 10),
          Text('${model.highTemp}$degreeSymbol'),
        ],
      ),
    );
  }
}
