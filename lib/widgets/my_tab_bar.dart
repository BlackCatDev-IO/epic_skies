import 'package:black_cat_lib/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyTabBar extends StatelessWidget {
  MyTabBar({@required this.controller});
  final TabController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: GetPlatform.isIOS ? 55 : 40,
      color: Colors.black,
      child: TabBar(
        controller: controller,
        indicatorColor: Colors.greenAccent,
        indicatorWeight: 1.0,
        indicatorSize: TabBarIndicatorSize.tab,
        tabs: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 2.5),
              Container(
                child: Text(
                  'Timer',
                  style: kGoogleFontOpenSansCondensed.copyWith(
                      color: Colors.purpleAccent, fontSize: 22),
                ),
              ),
              const SizedBox(height: 2.5),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'StopWatch',
                style: kGoogleFontOpenSansCondensed.copyWith(
                    color: Colors.purpleAccent, fontSize: 22),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
