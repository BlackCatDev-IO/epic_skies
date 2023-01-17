part of 'bg_image_bloc.dart';

abstract class BgImageEvent {
  const BgImageEvent();
}

class BgImageInitFromStorage extends BgImageEvent {}

class BgImageUpdateOnRefresh extends BgImageEvent {
  BgImageUpdateOnRefresh({
    required this.condition,
    required this.isDay,
  });

  final String condition;
  final bool isDay;
}

class BgImageSelectFromDeviceGallery extends BgImageEvent {}

class BgImageSelectFromAppGallery extends BgImageEvent {
  BgImageSelectFromAppGallery({required this.imageFile});

  final File imageFile;
}

class BgImageSettingsUpdated extends BgImageEvent {
  BgImageSettingsUpdated({required this.imageSetting});

  final ImageSettings imageSetting;
}
