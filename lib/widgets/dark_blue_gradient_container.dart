import 'package:black_cat_lib/constants.dart';
import 'package:flutter/cupertino.dart';


class DarkBlueGradientContainer extends StatelessWidget {
  final Widget child;

  const DarkBlueGradientContainer({Key key, this.child}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [scaffoldBackgroundColor(context), kAppBarColor1]),
      ),
      child: child,
    );
  }
}
