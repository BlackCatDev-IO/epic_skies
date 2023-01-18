part of 'bg_image_bloc.dart';

abstract class BgImageEvent {
  const BgImageEvent();
}

class BgImageUpdateOnRefresh extends BgImageEvent {
  BgImageUpdateOnRefresh({
    required this.weatherState,
  });

  final WeatherState weatherState;
}

class BgImageSelectFromDeviceGallery extends BgImageEvent {}

class BgImageSelectFromAppGallery extends BgImageEvent {
  BgImageSelectFromAppGallery({required this.imageFile});

  final File imageFile;
}

class BgImageInitDynamicSetting extends BgImageEvent {
  BgImageInitDynamicSetting({
    required this.weatherState,
  });

  final WeatherState weatherState;
}
