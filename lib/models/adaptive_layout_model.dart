import 'package:equatable/equatable.dart';

class AdaptiveLayoutModel extends Equatable {
  final double appBarPadding;
  final double appBarHeight;
  final double settingsHeaderHeight;

  const AdaptiveLayoutModel({
    required this.appBarPadding,
    required this.appBarHeight,
    required this.settingsHeaderHeight,
  });

  factory AdaptiveLayoutModel.fromMap(Map<String, dynamic> map) {
    return AdaptiveLayoutModel(
      appBarPadding: map['appBarPadding']! as double,
      appBarHeight: map['appBarHeight']! as double,
      settingsHeaderHeight: map['settingsHeaderHeight']! as double,
    );
  }

  Map toMap() {
    return {
      'appBarPadding': appBarPadding,
      'appBarHeight': appBarHeight,
      'settingsHeaderHeight': settingsHeaderHeight
    };
  }

  @override
  List<Object?> get props =>
      [appBarPadding, appBarHeight, settingsHeaderHeight];
}
