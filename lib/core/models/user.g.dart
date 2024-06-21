// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserModelImpl _$$UserModelImplFromJson(Map<String, dynamic> json) =>
    _$UserModelImpl(
      sexualOrientation: json['sexualOrientation'] as String,
      lastName: json['lastName'] as String,
      firstName: json['firstName'] as String,
      profileImages: (json['profileImages'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      uid: json['uid'] as String,
      gender: json['gender'] as String,
      interestedGender: json['interestedGender'] as String,
      lookingFor: (json['lookingFor'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      location: json['location'] as String,
      about: json['about'] as String?,
      subscription: json['subscription'] as bool,
      isAdmin: json['isAdmin'] as bool,
      currentLocation:
          Location.fromJson(json['currentLocation'] as Map<String, dynamic>),
      hobiesAndInterests: (json['hobiesAndInterests'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      birthDate: DateTime.parse(json['birthDate'] as String),
      isValidated: json['isValidated'] as bool,
      canRecieveImages: json['canRecieveImages'] as bool,
      canRecieveAudios: json['canRecieveAudios'] as bool,
      canRecieveVideos: json['canRecieveVideos'] as bool,
    );

Map<String, dynamic> _$$UserModelImplToJson(_$UserModelImpl instance) =>
    <String, dynamic>{
      'sexualOrientation': instance.sexualOrientation,
      'lastName': instance.lastName,
      'firstName': instance.firstName,
      'profileImages': instance.profileImages,
      'uid': instance.uid,
      'gender': instance.gender,
      'interestedGender': instance.interestedGender,
      'lookingFor': instance.lookingFor,
      'location': instance.location,
      'about': instance.about,
      'subscription': instance.subscription,
      'isAdmin': instance.isAdmin,
      'currentLocation': instance.currentLocation,
      'hobiesAndInterests': instance.hobiesAndInterests,
      'birthDate': instance.birthDate.toIso8601String(),
      'isValidated': instance.isValidated,
      'canRecieveImages': instance.canRecieveImages,
      'canRecieveAudios': instance.canRecieveAudios,
      'canRecieveVideos': instance.canRecieveVideos,
    };

_$LocationImpl _$$LocationImplFromJson(Map<String, dynamic> json) =>
    _$LocationImpl(
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
    );

Map<String, dynamic> _$$LocationImplToJson(_$LocationImpl instance) =>
    <String, dynamic>{
      'latitude': instance.latitude,
      'longitude': instance.longitude,
    };
