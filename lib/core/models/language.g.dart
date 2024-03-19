// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'language.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$LanguageImpl _$$LanguageImplFromJson(Map<String, dynamic> json) =>
    _$LanguageImpl(
      english: json['english'] as String,
      native: json['native'] as String,
      langCode: json['langCode'] as String,
      isRtl: json['isRtl'] as bool? ?? false,
    );

Map<String, dynamic> _$$LanguageImplToJson(_$LanguageImpl instance) =>
    <String, dynamic>{
      'english': instance.english,
      'native': instance.native,
      'langCode': instance.langCode,
      'isRtl': instance.isRtl,
    };
