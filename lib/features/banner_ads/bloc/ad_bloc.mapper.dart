// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'ad_bloc.dart';

class AdFreeStatusMapper extends EnumMapper<AdFreeStatus> {
  AdFreeStatusMapper._();

  static AdFreeStatusMapper? _instance;
  static AdFreeStatusMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = AdFreeStatusMapper._());
    }
    return _instance!;
  }

  static AdFreeStatus fromValue(dynamic value) {
    ensureInitialized();
    return MapperContainer.globals.fromValue(value);
  }

  @override
  AdFreeStatus decode(dynamic value) {
    switch (value) {
      case 'initial':
        return AdFreeStatus.initial;
      case 'loading':
        return AdFreeStatus.loading;
      case 'showAds':
        return AdFreeStatus.showAds;
      case 'adFreePurchased':
        return AdFreeStatus.adFreePurchased;
      case 'adFreeRestored':
        return AdFreeStatus.adFreeRestored;
      case 'trialPeriod':
        return AdFreeStatus.trialPeriod;
      case 'trialEnded':
        return AdFreeStatus.trialEnded;
      case 'error':
        return AdFreeStatus.error;
      default:
        throw MapperException.unknownEnumValue(value);
    }
  }

  @override
  dynamic encode(AdFreeStatus self) {
    switch (self) {
      case AdFreeStatus.initial:
        return 'initial';
      case AdFreeStatus.loading:
        return 'loading';
      case AdFreeStatus.showAds:
        return 'showAds';
      case AdFreeStatus.adFreePurchased:
        return 'adFreePurchased';
      case AdFreeStatus.adFreeRestored:
        return 'adFreeRestored';
      case AdFreeStatus.trialPeriod:
        return 'trialPeriod';
      case AdFreeStatus.trialEnded:
        return 'trialEnded';
      case AdFreeStatus.error:
        return 'error';
    }
  }
}

extension AdFreeStatusMapperExtension on AdFreeStatus {
  String toValue() {
    AdFreeStatusMapper.ensureInitialized();
    return MapperContainer.globals.toValue<AdFreeStatus>(this) as String;
  }
}

class AdStateMapper extends ClassMapperBase<AdState> {
  AdStateMapper._();

  static AdStateMapper? _instance;
  static AdStateMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = AdStateMapper._());
      AdFreeStatusMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'AdState';

  static AdFreeStatus _$status(AdState v) => v.status;
  static const Field<AdState, AdFreeStatus> _f$status =
      Field('status', _$status, opt: true, def: AdFreeStatus.initial);
  static String _$errorMessage(AdState v) => v.errorMessage;
  static const Field<AdState, String> _f$errorMessage =
      Field('errorMessage', _$errorMessage, opt: true, def: '');
  static DateTime? _$appInstallDate(AdState v) => v.appInstallDate;
  static const Field<AdState, DateTime> _f$appInstallDate =
      Field('appInstallDate', _$appInstallDate, opt: true);

  @override
  final MappableFields<AdState> fields = const {
    #status: _f$status,
    #errorMessage: _f$errorMessage,
    #appInstallDate: _f$appInstallDate,
  };

  static AdState _instantiate(DecodingData data) {
    return AdState(
        status: data.dec(_f$status),
        errorMessage: data.dec(_f$errorMessage),
        appInstallDate: data.dec(_f$appInstallDate));
  }

  @override
  final Function instantiate = _instantiate;

  static AdState fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<AdState>(map);
  }

  static AdState fromJson(String json) {
    return ensureInitialized().decodeJson<AdState>(json);
  }
}

mixin AdStateMappable {
  String toJson() {
    return AdStateMapper.ensureInitialized()
        .encodeJson<AdState>(this as AdState);
  }

  Map<String, dynamic> toMap() {
    return AdStateMapper.ensureInitialized()
        .encodeMap<AdState>(this as AdState);
  }

  AdStateCopyWith<AdState, AdState, AdState> get copyWith =>
      _AdStateCopyWithImpl(this as AdState, $identity, $identity);
  @override
  String toString() {
    return AdStateMapper.ensureInitialized().stringifyValue(this as AdState);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (runtimeType == other.runtimeType &&
            AdStateMapper.ensureInitialized()
                .isValueEqual(this as AdState, other));
  }

  @override
  int get hashCode {
    return AdStateMapper.ensureInitialized().hashValue(this as AdState);
  }
}

extension AdStateValueCopy<$R, $Out> on ObjectCopyWith<$R, AdState, $Out> {
  AdStateCopyWith<$R, AdState, $Out> get $asAdState =>
      $base.as((v, t, t2) => _AdStateCopyWithImpl(v, t, t2));
}

abstract class AdStateCopyWith<$R, $In extends AdState, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call(
      {AdFreeStatus? status, String? errorMessage, DateTime? appInstallDate});
  AdStateCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _AdStateCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, AdState, $Out>
    implements AdStateCopyWith<$R, AdState, $Out> {
  _AdStateCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<AdState> $mapper =
      AdStateMapper.ensureInitialized();
  @override
  $R call(
          {AdFreeStatus? status,
          String? errorMessage,
          Object? appInstallDate = $none}) =>
      $apply(FieldCopyWithData({
        if (status != null) #status: status,
        if (errorMessage != null) #errorMessage: errorMessage,
        if (appInstallDate != $none) #appInstallDate: appInstallDate
      }));
  @override
  AdState $make(CopyWithData data) => AdState(
      status: data.get(#status, or: $value.status),
      errorMessage: data.get(#errorMessage, or: $value.errorMessage),
      appInstallDate: data.get(#appInstallDate, or: $value.appInstallDate));

  @override
  AdStateCopyWith<$R2, AdState, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _AdStateCopyWithImpl($value, $cast, t);
}
