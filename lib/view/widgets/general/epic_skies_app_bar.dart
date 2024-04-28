import 'package:black_cat_lib/black_cat_lib.dart';
import 'package:epic_skies/extensions/widget_extensions.dart';
import 'package:epic_skies/services/register_services.dart';
import 'package:epic_skies/services/ticker_controllers/tab_navigation_controller.dart';
import 'package:epic_skies/services/view_controllers/adaptive_layout.dart';
import 'package:epic_skies/services/view_controllers/color_cubit/color_cubit.dart';
import 'package:epic_skies/view/screens/search_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EpicSkiesAppBar extends StatelessWidget implements PreferredSizeWidget {
  const EpicSkiesAppBar({super.key});

  static const _iconSize = 35.0;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ColorCubit, ColorState>(
      builder: (context, state) {
        return AppBar(
          bottom: const EpicTabBar(),
          automaticallyImplyLeading: false,
          leading: IconButton(
            icon: const Icon(
              Icons.menu,
              color: Colors.white38,
              size: _iconSize,
            ),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
          toolbarHeight: 100,
          backgroundColor: state.theme.appBarColor,
          centerTitle: true,
          actions: [
            Builder(
              builder: (context) => IconButton(
                icon: const Icon(
                  Icons.search,
                  size: _iconSize,
                ),
                onPressed: () => Navigator.of(context).pushNamed(
                  SearchScreen.id,
                ),
              ).paddingOnly(right: 20),
            ),
          ],
          iconTheme: const IconThemeData(color: Colors.white38),
          elevation: 15,
          title: const EpicSkiesHeader(),
        );
      },
    );
  }

  @override
  Size get preferredSize =>
      Size.fromHeight(getIt<AdaptiveLayout>().appBarHeight);
}

class EpicTabBar extends StatelessWidget implements PreferredSizeWidget {
  const EpicTabBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(200);
  @override
  Widget build(BuildContext context) {
    return TabBar(
      controller: getIt<TabNavigationController>().tabController,
      tabs: const [
        WeatherTab(tabTitle: 'Home'),
        WeatherTab(tabTitle: 'Hourly'),
        WeatherTab(tabTitle: 'Daily'),
        WeatherTab(tabTitle: 'Locations'),
      ],
    );
  }
}

class WeatherTab extends StatelessWidget {
  const WeatherTab({
    required this.tabTitle,
    super.key,
  });
  final String tabTitle;

  @override
  Widget build(BuildContext context) {
    return Tab(
      child: BlocBuilder<ColorCubit, ColorState>(
        builder: (context, state) {
          return MyTextWidget(
            text: tabTitle,
            fontSize: 17,
            color: state.theme.tabTitleColor,
          );
        },
      ),
    );
  }
}

class EpicSkiesHeader extends StatelessWidget {
  const EpicSkiesHeader({super.key});

  static const _fontSize = 45.0;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ColorCubit, ColorState>(
      builder: (context, state) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            MyTextWidget(
              text: 'Epic ',
              fontSize: _fontSize,
              color: state.theme.epicSkiesHeaderFontColor,
              fontWeight: FontWeight.bold,
              fontFamily: 'Montserrat',
            ),
            MyTextWidget(
              text: 'Skies',
              fontSize: _fontSize,
              color: state.theme.epicSkiesHeaderFontColor,
              fontWeight: FontWeight.w100,
              fontFamily: 'Montserrat',
            ),
          ],
        ).paddingOnly(top: 15);
      },
    );
  }
}

AppBar settingsAppBar({required String label, required bool backButtonShown}) {
  return AppBar(
    backgroundColor: Colors.transparent,
    automaticallyImplyLeading: backButtonShown,
    centerTitle: true,
    iconTheme: const IconThemeData(
      color: Colors.blueGrey,
      size: 30,
    ),
    elevation: 15,
    title: MyTextWidget(
      text: label,
      fontSize: 45,
      color: Colors.blueGrey[500],
      fontWeight: FontWeight.w200,
    ),
  );
}
