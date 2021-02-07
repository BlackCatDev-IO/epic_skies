import 'package:epic_skies/widgets/general/login_button.dart';
import 'package:flutter/material.dart';
import 'package:black_cat_lib/black_cat_lib.dart';
import 'package:get/get.dart';

class TestPage extends StatelessWidget {
  static const id = 'test_page';

  final controller = Get.put(CounterController());

  final RxMap gifts = {
    // Key:    Value
    'first': 'partridge',
    'second': 'turtledoves',
    'fifth': 'golden rings'
  }.obs;

  void test() {
    var st = gifts['fifth'];
    debugPrint('Map parse value: $st');
  }

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: Get.context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('AlertDialog Title'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('This is a demo alert dialog.'),
                Text('Would you like to approve of this message?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Approve'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
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
                      // _showMyDialog();

                      final snackBar = SnackBar(
                        backgroundColor: Colors.white,
                        content: Text('Yay! A SnackBar!'),
                        action: SnackBarAction(
                          label: 'Undo',
                          onPressed: () {
                            // Some code to undo the change.
                          },
                        ),
                      );
                      Scaffold.of(context).showSnackBar(snackBar);

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

// class  extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
      
//     );
//   }
// }

class CounterController extends GetxController {
  var counter = 0.obs;

  @override
  void onInit() {
    super.onInit();

    ever(counter, (data) {
      debugPrint('Ever brah $counter');
    });
  }

  void increment() => counter.value++;
}
