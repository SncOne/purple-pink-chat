// ignore_for_file: invalid_annotation_target

import 'package:catt_catt/utils/enums.dart';
import 'package:catt_catt/utils/lang/strings.g.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.freezed.dart';
part 'user.g.dart';

@freezed
abstract class UserModel with _$UserModel {
  const factory UserModel({
    required String uid,
    required String firstName,
    required String lastName,
    required DateTime birthDate,
    required List<String> profileImages,
    String? about,
    required String location,
    required Location currentLocation,
    required List<HobbyContext> hobiesAndInterests,
    required GenderContext gender,
    required GenderContext interestedGender,
    required List<lookingForContext> lookingFor,
    required sexualOrientationContext sexualOrientation,
    required bool subscription,
    required SubscriptionType subscriptionType,
    required int dailyMessageLimit,
    required int swipeLimitForAd,
    required bool isAdmin,
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
