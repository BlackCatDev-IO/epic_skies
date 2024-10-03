import 'package:epic_skies/features/hourly_forecast/models/hourly_forecast_model/hourly_forecast_model.dart';
import 'package:epic_skies/features/main_weather/bloc/weather_bloc.dart';
import 'package:epic_skies/global/local_constants.dart';
import 'package:epic_skies/services/register_services.dart';
import 'package:epic_skies/services/ticker_controllers/tab_navigation_controller.dart';
import 'package:epic_skies/utils/formatters/date_time_formatter.dart';
import 'package:epic_skies/view/widgets/weather_info_display/temp_widgets/temp_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HourlySummaryColumn extends StatelessWidget {
  const HourlySummaryColumn({
    required this.model,
    required this.prevTemp,
    required this.nextTemp,
    required this.minTemp,
    required this.maxTemp,
    super.key,
  });

  final HourlyForecastModel model;
  final int prevTemp;
  final int nextTemp;
  final int minTemp;
  final int maxTemp;

  static const _fontSize = 17.0;
  static const _height = 20.0;
  static const _iconSize = 40.0;

  (String, String, Color) _getIconAndLabel() {
    final isSunrise = model.isSunrise ?? false;

    if (isSunrise) {
      return (clearDayIcon, 'Sunrise', const Color.fromARGB(188, 232, 255, 59));
    }
    return (clearNightIcon, 'Sunset', Colors.blueAccent[100]!);
  }

  /// Used as a helper to align the sunrise/sunset icons with the temperature line
  double _getSuntimeIconBottomPadding(double previousPosition) {
    if (previousPosition < 10) {
      return 20;
    }
    if (previousPosition < 15) {
      return 5;
    }

    return 0;
  }

  @override
  Widget build(BuildContext context) {
    final timeIn24Hrs =
        context.read<WeatherBloc>().state.unitSettings.timeIn24Hrs;
    final range = maxTemp - minTemp;
    final yPos = _height - (model.temp - minTemp) / range * _height;

    final isSunriseTime = model.suntime != null;

    final (icon, suntimeLabel, suntimeLabelColor) = _getIconAndLabel();

    final formattedTime = DateTimeFormatter.formatTime(
      time: isSunriseTime ? model.suntime! : model.time,
      timeIn24Hrs: timeIn24Hrs,
      roundToHour: !isSunriseTime,
    );

    final bottomText =
        isSunriseTime ? suntimeLabel : ' ${model.precipitationProbability}%';

    /// Calculating the Y position for the current, previous, and next temperatures
    final prevYPos = _height - (prevTemp - minTemp) / range * _height;
    final nextYPos = _height - (nextTemp - minTemp) / range * _height;

    final width = isSunriseTime ? 95.0 : 60.0;

    final bottomTextColor = isSunriseTime ? suntimeLabelColor : Colors.white54;

    return GestureDetector(
      onTap: () => getIt<TabNavigationController>().jumpToTab(index: 1),
      behavior: HitTestBehavior.translucent,
      child: SizedBox(
        width: width,
        child: Column(
          children: [
            const SizedBox(height: 10),
            Text(
              formattedTime,
              style: TextStyle(
                fontSize: _fontSize,
                color: Colors.blueAccent[100],
              ),
            ),
            const Spacer(),
            if (!isSunriseTime) TempWidget(temp: model.temp),
            const Spacer(),
            if (isSunriseTime) ...[
              Image(
                image: AssetImage(icon),
                width: _iconSize,
                height: _iconSize,
              ),
              SizedBox(height: _getSuntimeIconBottomPadding(prevYPos)),
            ] else
              SizedBox(
                height: _height,
                width: width,
                child: CustomPaint(
                  painter: _TemperatureLinePainter(
                    startY: (prevYPos + yPos) / 2,
                    endY: (yPos + nextYPos) / 2,
                  ),
                ),
              ),
            const Spacer(flex: 2),
            if (!isSunriseTime)
              Image(
                image: AssetImage(model.iconPath),
                height: _iconSize,
                width: _iconSize,
              ),
            const Spacer(),
            Text(
              bottomText,
              style: TextStyle(
                fontSize: _fontSize,
                fontWeight: isSunriseTime ? FontWeight.w500 : null,
                color: bottomTextColor,
              ),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}

class _TemperatureLinePainter extends CustomPainter {
  _TemperatureLinePainter({
    required this.startY,
    required this.endY,
  });

  final double startY;
  final double endY;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color.fromARGB(161, 255, 235, 59)
      ..strokeWidth = 3.5;

    canvas.drawLine(
      Offset(0, startY),
      Offset(size.width, endY),
      paint,
    );

    // Calculate the center point of the line
    final centerX = size.width / 2;
    final centerY = (startY + endY) / 2;

    // Create a paint object for the dot
    final dotPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    final glowPaint = Paint()
      ..color = Colors.white.withOpacity(0.5)
      ..style = PaintingStyle.fill
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 3);

    canvas
      ..drawCircle(Offset(centerX, centerY), 4, glowPaint)
      ..drawCircle(Offset(centerX, centerY), 2, dotPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
