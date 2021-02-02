import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:black_cat_lib/black_cat_lib.dart';

class SearchListTile extends StatelessWidget {
  final String text;
  final Function onTap;
  final Color color;

  const SearchListTile({Key key, this.text, this.onTap, this.color})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return RoundedContainer(
      color: color ?? Colors.black54,
      radius: 7,
      child: ListTile(
        title: MyTextWidget(text: text, fontSize: 18),
        onTap: () async {
          onTap();
        },
      ),
    ).paddingSymmetric(vertical: 10);
  }
}