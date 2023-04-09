// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ad_bloc.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_AdState _$$_AdStateFromJson(Map<String, dynamic> json) => _$_AdState(
      status: $enumDecodeNullable(_$AdFreeStatusEnumMap, json['status']) ??
          AdFreeStatus.showAds,
      errorMessage: json['errorMessage'] as String? ?? '',
      isFirstInstall: json['isFirstInstall'] as bool? ?? true,
      appInstallDate: json['appInstallDate'] == null
          ? null
          : DateTime.parse(json['appInstallDate'] as String),
    );

Map<String, dynamic> _$$_AdStateToJson(_$_AdState instance) =>
    <String, dynamic>{
      'status': _$AdFreeStatusEnumMap[instance.status]!,
      'errorMessage': instance.errorMessage,
      'isFirstInstall': instance.isFirstInstall,
      'appInstallDate': instance.appInstallDate?.toIso8601String(),
    };

const _$AdFreeStatusEnumMap = {
  AdFreeStatus.showAds: 'showAds',
  AdFreeStatus.adFreePurchased: 'adFreePurchased',
  AdFreeStatus.trialPeriod: 'trialPeriod',
  AdFreeStatus.trialEnded: 'trialEnded',
  AdFreeStatus.error: 'error',
};
