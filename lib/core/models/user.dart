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
    required List<String> lookingFor,
    required String location,
    String? about,
    required bool subscription,
    required bool isAdmin,
    required Location currentLocation,
    required List<String> hobiesAndInterests,
    required DateTime birthDate,
    required bool isValidated,
    required bool canRecieveImages,
    required bool canRecieveAudios,
    required bool canRecieveVideos,
  }) = _UserModel;

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);
}

@freezed
abstract class Location with _$Location {
  const factory Location({
    required double latitude,
    required double longitude,
  }) = _Location;

  factory Location.fromJson(Map<String, dynamic> json) =>
      _$LocationFromJson(json);
}
