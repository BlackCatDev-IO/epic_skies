// Flutter imports:
import 'package:flutter/material.dart';

/// These are widget extensions for commonly used UI elements. eg. instead of
/// wrapping a widget in a `Center`
/// Center(
///   child: Text('Example Text'),
/// ),
///
/// you can use the extension `Text('Example Text').center()`

/// add Padding Property to widget
extension CustomWidgetExtensions on Widget {
  Widget paddingAll(double padding) =>
      Padding(padding: EdgeInsets.all(padding), child: this);

  Widget paddingSymmetric({double horizontal = 0.0, double vertical = 0.0}) =>
      Padding(
        padding:
            EdgeInsets.symmetric(horizontal: horizontal, vertical: vertical),
        child: this,
      );

  Widget paddingOnly({
    double left = 0.0,
    double top = 0.0,
    double right = 0.0,
    double bottom = 0.0,
  }) =>
      Padding(
        padding:
            EdgeInsets.only(top: top, left: left, right: right, bottom: bottom),
        child: this,
      );

  Widget get paddingZero => Padding(padding: EdgeInsets.zero, child: this);
}

/// Add margin property to widget
extension WidgetMarginX on Widget {
  Widget marginAll(double margin) =>
      Container(margin: EdgeInsets.all(margin), child: this);

  Widget marginSymmetric({double horizontal = 0.0, double vertical = 0.0}) =>
      Container(
        margin:
            EdgeInsets.symmetric(horizontal: horizontal, vertical: vertical),
        child: this,
      );

  Widget marginOnly({
    double left = 0.0,
    double top = 0.0,
    double right = 0.0,
    double bottom = 0.0,
  }) =>
      Container(
        margin:
            EdgeInsets.only(top: top, left: left, right: right, bottom: bottom),
        child: this,
      );

  Widget get marginZero => Container(margin: EdgeInsets.zero, child: this);
}

/// Allows you to insert widgets inside a CustomScrollView
extension WidgetSliverBoxX on Widget {
  Widget get sliverBox => SliverToBoxAdapter(child: this);
}
