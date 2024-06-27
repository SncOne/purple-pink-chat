// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserModelImpl _$$UserModelImplFromJson(Map<String, dynamic> json) =>
    _$UserModelImpl(
      uid: json['uid'] as String,
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
      birthDate: DateTime.parse(json['birthDate'] as String),
      profileImages: (json['profileImages'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      about: json['about'] as String?,
      location: json['location'] as String,
      currentLocation:
          Location.fromJson(json['currentLocation'] as Map<String, dynamic>),
      hobiesAndInterests: (json['hobiesAndInterests'] as List<dynamic>)
          .map((e) => $enumDecode(_$HobbyContextEnumMap, e))
          .toList(),
      gender: $enumDecode(_$GenderContextEnumMap, json['gender']),
      interestedGender:
          $enumDecode(_$GenderContextEnumMap, json['interestedGender']),
      lookingFor: (json['lookingFor'] as List<dynamic>)
          .map((e) => $enumDecode(_$lookingForContextEnumMap, e))
          .toList(),
      sexualOrientation: $enumDecode(
          _$sexualOrientationContextEnumMap, json['sexualOrientation']),
      subscription: json['subscription'] as bool,
      subscriptionType:
          $enumDecode(_$SubscriptionTypeEnumMap, json['subscriptionType']),
      dailyMessageLimit: (json['dailyMessageLimit'] as num).toInt(),
      swipeLimitForAd: (json['swipeLimitForAd'] as num).toInt(),
      isAdmin: json['isAdmin'] as bool,
      isValidated: json['isValidated'] as bool,
      canRecieveImages: json['canRecieveImages'] as bool,
      canRecieveAudios: json['canRecieveAudios'] as bool,
      canRecieveVideos: json['canRecieveVideos'] as bool,
    );

Map<String, dynamic> _$$UserModelImplToJson(_$UserModelImpl instance) =>
    <String, dynamic>{
      'uid': instance.uid,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'birthDate': instance.birthDate.toIso8601String(),
      'profileImages': instance.profileImages,
      'about': instance.about,
      'location': instance.location,
      'currentLocation': instance.currentLocation,
      'hobiesAndInterests': instance.hobiesAndInterests
          .map((e) => _$HobbyContextEnumMap[e]!)
          .toList(),
      'gender': _$GenderContextEnumMap[instance.gender]!,
      'interestedGender': _$GenderContextEnumMap[instance.interestedGender]!,
      'lookingFor': instance.lookingFor
          .map((e) => _$lookingForContextEnumMap[e]!)
          .toList(),
      'sexualOrientation':
          _$sexualOrientationContextEnumMap[instance.sexualOrientation]!,
      'subscription': instance.subscription,
      'subscriptionType': _$SubscriptionTypeEnumMap[instance.subscriptionType]!,
      'dailyMessageLimit': instance.dailyMessageLimit,
      'swipeLimitForAd': instance.swipeLimitForAd,
      'isAdmin': instance.isAdmin,
      'isValidated': instance.isValidated,
      'canRecieveImages': instance.canRecieveImages,
      'canRecieveAudios': instance.canRecieveAudios,
      'canRecieveVideos': instance.canRecieveVideos,
    };

const _$HobbyContextEnumMap = {
  HobbyContext.wrestling: 'wrestling',
  HobbyContext.sailing: 'sailing',
  HobbyContext.triathlon: 'triathlon',
  HobbyContext.sauna: 'sauna',
  HobbyContext.comedy: 'comedy',
  HobbyContext.gymAndFitness: 'gymAndFitness',
  HobbyContext.game: 'game',
  HobbyContext.book: 'book',
  HobbyContext.cripto: 'cripto',
  HobbyContext.nft: 'nft',
  HobbyContext.football: 'football',
  HobbyContext.basketball: 'basketball',
  HobbyContext.volleyball: 'volleyball',
  HobbyContext.gliding: 'gliding',
  HobbyContext.climbing: 'climbing',
  HobbyContext.diving: 'diving',
  HobbyContext.movies: 'movies',
  HobbyContext.tvShows: 'tvShows',
  HobbyContext.anime: 'anime',
  HobbyContext.technology: 'technology',
  HobbyContext.music: 'music',
  HobbyContext.traveling: 'traveling',
  HobbyContext.cooking: 'cooking',
  HobbyContext.meditation: 'meditation',
  HobbyContext.hunting: 'hunting',
  HobbyContext.swimming: 'swimming',
};

const _$GenderContextEnumMap = {
  GenderContext.male: 'male',
  GenderContext.female: 'female',
};

const _$lookingForContextEnumMap = {
  lookingForContext.longTermPartner: 'longTermPartner',
  lookingForContext.shortTermPartner: 'shortTermPartner',
  lookingForContext.longTermOpenRelationship: 'longTermOpenRelationship',
  lookingForContext.shortTermOpenRelationship: 'shortTermOpenRelationship',
  lookingForContext.newFriends: 'newFriends',
  lookingForContext.stillFiguringOut: 'stillFiguringOut',
};

const _$sexualOrientationContextEnumMap = {
  sexualOrientationContext.straight: 'straight',
  sexualOrientationContext.gay: 'gay',
  sexualOrientationContext.lesbian: 'lesbian',
  sexualOrientationContext.bisexual: 'bisexual',
  sexualOrientationContext.asexual: 'asexual',
  sexualOrientationContext.demisexual: 'demisexual',
  sexualOrientationContext.pansexual: 'pansexual',
  sexualOrientationContext.bicurious: 'bicurious',
};

const _$SubscriptionTypeEnumMap = {
  SubscriptionType.monthly: 'monthly',
  SubscriptionType.yearly: 'yearly',
  SubscriptionType.none: 'none',
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
