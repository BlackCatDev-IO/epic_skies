part of 'bg_image_bloc.dart';

abstract class BgImageEvent {
  const BgImageEvent();
}

class BgImageUpdateOnRefresh extends BgImageEvent {
  BgImageUpdateOnRefresh({
    required this.weatherState,
  });

  final WeatherState weatherState;

  @override
  String toString() => 'BgImageUpdateOnRefresh';
}

class BgImageSelectFromDeviceGallery extends BgImageEvent {}

class BgImageSelectFromAppGallery extends BgImageEvent {
  BgImageSelectFromAppGallery({required this.imageFile});

  final File imageFile;

  @override
  String toString() => 'BgImageSelectFromAppGallery';
}

class BgImageInitDynamicSetting extends BgImageEvent {
  BgImageInitDynamicSetting({
    required this.weatherState,
  });

  final WeatherState weatherState;

  @override
  String toString() => 'BgImageInitDynamicSetting';
}

class BgImageFetchOnFirstInstall extends BgImageEvent {
  BgImageFetchOnFirstInstall();

  @override
  String toString() => 'BgImageFetchOnFirstInstall';
}
