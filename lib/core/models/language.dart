import 'package:freezed_annotation/freezed_annotation.dart';

part 'language.freezed.dart';
part 'language.g.dart';

@freezed
class Language with _$Language {
  const factory Language({
    required String english,
    required String native,
    required String langCode,
    @Default(false) bool isRtl,
  }) = _Language;
  factory Language.fromJson(Map<String, Object?> json) =>
      _$LanguageFromJson(json);
}
