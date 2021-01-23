import 'dart:async';

import 'package:epic_skies/widgets/login_button.dart';
import 'package:flutter/material.dart';
import 'package:black_cat_lib/black_cat_lib.dart';
import 'package:get/get.dart';

class TestPage extends StatelessWidget {
  static const id = 'test_page';

  final controller = Get.put(CounterController());

  RxMap gifts = {
    // Key:    Value
    'first': 'partridge',
    'second': 'turtledoves',
    'fifth': 'golden rings'
  }.obs;

  void test() {
    var st = gifts['fifth'];
    debugPrint('Map parse value: $st');
  }

  @override
  Widget build(BuildContext context) {
    final c = Get.find<CounterController>();

    void print() => debugPrint('dummy function');

    // forEach is fine for firing off onChange methods.

    c.counter.stream.forEach((data) => debugPrint("For each method brah"));

    //When more control is needed, creating a subscription with listen offers that.

    final subscription = c.counter.listen(
      (data) {
        // debugPrint(data.toString());
      },
      onDone: () {
        print();
      },
      onError: (err) {
        debugPrint('Error');
      },
      cancelOnError: false,
    );

    subscription.cancel();

    return SafeArea(
      child: Scaffold(
        body: GetX<CounterController>(
          init: CounterController(),
          builder: (controller) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const Text('TEST PAGE', style: kGoogleFontOpenSansCondensed),
                MyTextWidget(text: controller.counter.value.toString()),
                LoginButtonNoIcon(
                    onPressed: () {
                      test();
                      controller.increment();
                      // NotificationController().testNotification();
                    },
                    text: 'Test Stream'),
              ],
            ).paddingSymmetric(horizontal: 15, vertical: 15);
          },
        ),
      ),
    );
  }
}

class CounterController extends GetxController {
  var counter = 0.obs;

  void increment() => counter.value++;
}
