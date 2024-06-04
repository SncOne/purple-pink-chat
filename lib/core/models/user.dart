// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.freezed.dart';
part 'user.g.dart';

@freezed
abstract class UserModel with _$UserModel {
  const factory UserModel({
    required String sexualOrientation,
    required String lastName,
    required String firstName,
    required List<String> profileImages,
    required String uid,
    required String gender,
    required String interestedGender,
    required String lookingFor,
    required String location,
    required List<String> hobiesAndInterests,
    @JsonKey(name: 'birthDate') required DateTime birthDate,
  }) = _UserModel;

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);
}
