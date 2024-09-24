part of 'daily_forecast_page.dart';

class _DailyNavButton extends StatelessWidget {
  const _DailyNavButton({
    required this.model,
    required this.onTap,
  });

  final void Function() onTap;

  final DailyNavButtonModel model;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DailyForecastCubit, DailyForecastState>(
      buildWhen: (previous, current) {
        final previouslySelected = previous.navButtonModelList.firstWhere(
          (element) => element.isSelected,
          orElse: () => previous.navButtonModelList.first,
        );
        final currentSelected = current.navButtonModelList.firstWhere(
          (element) => element.isSelected,
          orElse: () => current.navButtonModelList.first,
        );

        return model == previouslySelected || model == currentSelected;
      },
      builder: (context, state) {
        return RoundedContainer(
          borderColor: model.isSelected ? Colors.blue[100] : Colors.transparent,
          radius: 12,
          width: 60,
          child: GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: onTap,
            child: Column(
              children: [
                const SizedBox(height: 5),
                Text(
                  model.day,
                  style: TextStyle(
                    color: Colors.blueAccent[100],
                    fontSize: 15,
                  ),
                ),
                Text(
                  model.month,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w300,
                    color: Colors.yellow[100],
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 2),
                Text(
                  model.date.toString(),
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w300,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 5),
              ],
            ),
          ),
        );
      },
    );
  }
}
