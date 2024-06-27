// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

UserModel _$UserModelFromJson(Map<String, dynamic> json) {
  return _UserModel.fromJson(json);
}

/// @nodoc
mixin _$UserModel {
  String get uid => throw _privateConstructorUsedError;
  String get firstName => throw _privateConstructorUsedError;
  String get lastName => throw _privateConstructorUsedError;
  DateTime get birthDate => throw _privateConstructorUsedError;
  List<String> get profileImages => throw _privateConstructorUsedError;
  String? get about => throw _privateConstructorUsedError;
  String get location => throw _privateConstructorUsedError;
  Location get currentLocation => throw _privateConstructorUsedError;
  List<HobbyContext> get hobiesAndInterests =>
      throw _privateConstructorUsedError;
  GenderContext get gender => throw _privateConstructorUsedError;
  GenderContext get interestedGender => throw _privateConstructorUsedError;
  List<lookingForContext> get lookingFor => throw _privateConstructorUsedError;
  sexualOrientationContext get sexualOrientation =>
      throw _privateConstructorUsedError;
  bool get subscription => throw _privateConstructorUsedError;
  SubscriptionType get subscriptionType => throw _privateConstructorUsedError;
  int get dailyMessageLimit => throw _privateConstructorUsedError;
  int get swipeLimitForAd => throw _privateConstructorUsedError;
  bool get isAdmin => throw _privateConstructorUsedError;
  bool get isValidated => throw _privateConstructorUsedError;
  bool get canRecieveImages => throw _privateConstructorUsedError;
  bool get canRecieveAudios => throw _privateConstructorUsedError;
  bool get canRecieveVideos => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $UserModelCopyWith<UserModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserModelCopyWith<$Res> {
  factory $UserModelCopyWith(UserModel value, $Res Function(UserModel) then) =
      _$UserModelCopyWithImpl<$Res, UserModel>;
  @useResult
  $Res call(
      {String uid,
      String firstName,
      String lastName,
      DateTime birthDate,
      List<String> profileImages,
      String? about,
      String location,
      Location currentLocation,
      List<HobbyContext> hobiesAndInterests,
      GenderContext gender,
      GenderContext interestedGender,
      List<lookingForContext> lookingFor,
      sexualOrientationContext sexualOrientation,
      bool subscription,
      SubscriptionType subscriptionType,
      int dailyMessageLimit,
      int swipeLimitForAd,
      bool isAdmin,
      bool isValidated,
      bool canRecieveImages,
      bool canRecieveAudios,
      bool canRecieveVideos});

  $LocationCopyWith<$Res> get currentLocation;
}

/// @nodoc
class _$UserModelCopyWithImpl<$Res, $Val extends UserModel>
    implements $UserModelCopyWith<$Res> {
  _$UserModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? uid = null,
    Object? firstName = null,
    Object? lastName = null,
    Object? birthDate = null,
    Object? profileImages = null,
    Object? about = freezed,
    Object? location = null,
    Object? currentLocation = null,
    Object? hobiesAndInterests = null,
    Object? gender = null,
    Object? interestedGender = null,
    Object? lookingFor = null,
    Object? sexualOrientation = null,
    Object? subscription = null,
    Object? subscriptionType = null,
    Object? dailyMessageLimit = null,
    Object? swipeLimitForAd = null,
    Object? isAdmin = null,
    Object? isValidated = null,
    Object? canRecieveImages = null,
    Object? canRecieveAudios = null,
    Object? canRecieveVideos = null,
  }) {
    return _then(_value.copyWith(
      uid: null == uid
          ? _value.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as String,
      firstName: null == firstName
          ? _value.firstName
          : firstName // ignore: cast_nullable_to_non_nullable
              as String,
      lastName: null == lastName
          ? _value.lastName
          : lastName // ignore: cast_nullable_to_non_nullable
              as String,
      birthDate: null == birthDate
          ? _value.birthDate
          : birthDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      profileImages: null == profileImages
          ? _value.profileImages
          : profileImages // ignore: cast_nullable_to_non_nullable
              as List<String>,
      about: freezed == about
          ? _value.about
          : about // ignore: cast_nullable_to_non_nullable
              as String?,
      location: null == location
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as String,
      currentLocation: null == currentLocation
          ? _value.currentLocation
          : currentLocation // ignore: cast_nullable_to_non_nullable
              as Location,
      hobiesAndInterests: null == hobiesAndInterests
          ? _value.hobiesAndInterests
          : hobiesAndInterests // ignore: cast_nullable_to_non_nullable
              as List<HobbyContext>,
      gender: null == gender
          ? _value.gender
          : gender // ignore: cast_nullable_to_non_nullable
              as GenderContext,
      interestedGender: null == interestedGender
          ? _value.interestedGender
          : interestedGender // ignore: cast_nullable_to_non_nullable
              as GenderContext,
      lookingFor: null == lookingFor
          ? _value.lookingFor
          : lookingFor // ignore: cast_nullable_to_non_nullable
              as List<lookingForContext>,
      sexualOrientation: null == sexualOrientation
          ? _value.sexualOrientation
          : sexualOrientation // ignore: cast_nullable_to_non_nullable
              as sexualOrientationContext,
      subscription: null == subscription
          ? _value.subscription
          : subscription // ignore: cast_nullable_to_non_nullable
              as bool,
      subscriptionType: null == subscriptionType
          ? _value.subscriptionType
          : subscriptionType // ignore: cast_nullable_to_non_nullable
              as SubscriptionType,
      dailyMessageLimit: null == dailyMessageLimit
          ? _value.dailyMessageLimit
          : dailyMessageLimit // ignore: cast_nullable_to_non_nullable
              as int,
      swipeLimitForAd: null == swipeLimitForAd
          ? _value.swipeLimitForAd
          : swipeLimitForAd // ignore: cast_nullable_to_non_nullable
              as int,
      isAdmin: null == isAdmin
          ? _value.isAdmin
          : isAdmin // ignore: cast_nullable_to_non_nullable
              as bool,
      isValidated: null == isValidated
          ? _value.isValidated
          : isValidated // ignore: cast_nullable_to_non_nullable
              as bool,
      canRecieveImages: null == canRecieveImages
          ? _value.canRecieveImages
          : canRecieveImages // ignore: cast_nullable_to_non_nullable
              as bool,
      canRecieveAudios: null == canRecieveAudios
          ? _value.canRecieveAudios
          : canRecieveAudios // ignore: cast_nullable_to_non_nullable
              as bool,
      canRecieveVideos: null == canRecieveVideos
          ? _value.canRecieveVideos
          : canRecieveVideos // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $LocationCopyWith<$Res> get currentLocation {
    return $LocationCopyWith<$Res>(_value.currentLocation, (value) {
      return _then(_value.copyWith(currentLocation: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$UserModelImplCopyWith<$Res>
    implements $UserModelCopyWith<$Res> {
  factory _$$UserModelImplCopyWith(
          _$UserModelImpl value, $Res Function(_$UserModelImpl) then) =
      __$$UserModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String uid,
      String firstName,
      String lastName,
      DateTime birthDate,
      List<String> profileImages,
      String? about,
      String location,
      Location currentLocation,
      List<HobbyContext> hobiesAndInterests,
      GenderContext gender,
      GenderContext interestedGender,
      List<lookingForContext> lookingFor,
      sexualOrientationContext sexualOrientation,
      bool subscription,
      SubscriptionType subscriptionType,
      int dailyMessageLimit,
      int swipeLimitForAd,
      bool isAdmin,
      bool isValidated,
      bool canRecieveImages,
      bool canRecieveAudios,
      bool canRecieveVideos});

  @override
  $LocationCopyWith<$Res> get currentLocation;
}

/// @nodoc
class __$$UserModelImplCopyWithImpl<$Res>
    extends _$UserModelCopyWithImpl<$Res, _$UserModelImpl>
    implements _$$UserModelImplCopyWith<$Res> {
  __$$UserModelImplCopyWithImpl(
      _$UserModelImpl _value, $Res Function(_$UserModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? uid = null,
    Object? firstName = null,
    Object? lastName = null,
    Object? birthDate = null,
    Object? profileImages = null,
    Object? about = freezed,
    Object? location = null,
    Object? currentLocation = null,
    Object? hobiesAndInterests = null,
    Object? gender = null,
    Object? interestedGender = null,
    Object? lookingFor = null,
    Object? sexualOrientation = null,
    Object? subscription = null,
    Object? subscriptionType = null,
    Object? dailyMessageLimit = null,
    Object? swipeLimitForAd = null,
    Object? isAdmin = null,
    Object? isValidated = null,
    Object? canRecieveImages = null,
    Object? canRecieveAudios = null,
    Object? canRecieveVideos = null,
  }) {
    return _then(_$UserModelImpl(
      uid: null == uid
          ? _value.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as String,
      firstName: null == firstName
          ? _value.firstName
          : firstName // ignore: cast_nullable_to_non_nullable
              as String,
      lastName: null == lastName
          ? _value.lastName
          : lastName // ignore: cast_nullable_to_non_nullable
              as String,
      birthDate: null == birthDate
          ? _value.birthDate
          : birthDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      profileImages: null == profileImages
          ? _value._profileImages
          : profileImages // ignore: cast_nullable_to_non_nullable
              as List<String>,
      about: freezed == about
          ? _value.about
          : about // ignore: cast_nullable_to_non_nullable
              as String?,
      location: null == location
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as String,
      currentLocation: null == currentLocation
          ? _value.currentLocation
          : currentLocation // ignore: cast_nullable_to_non_nullable
              as Location,
      hobiesAndInterests: null == hobiesAndInterests
          ? _value._hobiesAndInterests
          : hobiesAndInterests // ignore: cast_nullable_to_non_nullable
              as List<HobbyContext>,
      gender: null == gender
          ? _value.gender
          : gender // ignore: cast_nullable_to_non_nullable
              as GenderContext,
      interestedGender: null == interestedGender
          ? _value.interestedGender
          : interestedGender // ignore: cast_nullable_to_non_nullable
              as GenderContext,
      lookingFor: null == lookingFor
          ? _value._lookingFor
          : lookingFor // ignore: cast_nullable_to_non_nullable
              as List<lookingForContext>,
      sexualOrientation: null == sexualOrientation
          ? _value.sexualOrientation
          : sexualOrientation // ignore: cast_nullable_to_non_nullable
              as sexualOrientationContext,
      subscription: null == subscription
          ? _value.subscription
          : subscription // ignore: cast_nullable_to_non_nullable
              as bool,
      subscriptionType: null == subscriptionType
          ? _value.subscriptionType
          : subscriptionType // ignore: cast_nullable_to_non_nullable
              as SubscriptionType,
      dailyMessageLimit: null == dailyMessageLimit
          ? _value.dailyMessageLimit
          : dailyMessageLimit // ignore: cast_nullable_to_non_nullable
              as int,
      swipeLimitForAd: null == swipeLimitForAd
          ? _value.swipeLimitForAd
          : swipeLimitForAd // ignore: cast_nullable_to_non_nullable
              as int,
      isAdmin: null == isAdmin
          ? _value.isAdmin
          : isAdmin // ignore: cast_nullable_to_non_nullable
              as bool,
      isValidated: null == isValidated
          ? _value.isValidated
          : isValidated // ignore: cast_nullable_to_non_nullable
              as bool,
      canRecieveImages: null == canRecieveImages
          ? _value.canRecieveImages
          : canRecieveImages // ignore: cast_nullable_to_non_nullable
              as bool,
      canRecieveAudios: null == canRecieveAudios
          ? _value.canRecieveAudios
          : canRecieveAudios // ignore: cast_nullable_to_non_nullable
              as bool,
      canRecieveVideos: null == canRecieveVideos
          ? _value.canRecieveVideos
          : canRecieveVideos // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$UserModelImpl implements _UserModel {
  const _$UserModelImpl(
      {required this.uid,
      required this.firstName,
      required this.lastName,
      required this.birthDate,
      required final List<String> profileImages,
      this.about,
      required this.location,
      required this.currentLocation,
      required final List<HobbyContext> hobiesAndInterests,
      required this.gender,
      required this.interestedGender,
      required final List<lookingForContext> lookingFor,
      required this.sexualOrientation,
      required this.subscription,
      required this.subscriptionType,
      required this.dailyMessageLimit,
      required this.swipeLimitForAd,
      required this.isAdmin,
      required this.isValidated,
      required this.canRecieveImages,
      required this.canRecieveAudios,
      required this.canRecieveVideos})
      : _profileImages = profileImages,
        _hobiesAndInterests = hobiesAndInterests,
        _lookingFor = lookingFor;

  factory _$UserModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$UserModelImplFromJson(json);

  @override
  final String uid;
  @override
  final String firstName;
  @override
  final String lastName;
  @override
  final DateTime birthDate;
  final List<String> _profileImages;
  @override
  List<String> get profileImages {
    if (_profileImages is EqualUnmodifiableListView) return _profileImages;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_profileImages);
  }

  @override
  final String? about;
  @override
  final String location;
  @override
  final Location currentLocation;
  final List<HobbyContext> _hobiesAndInterests;
  @override
  List<HobbyContext> get hobiesAndInterests {
    if (_hobiesAndInterests is EqualUnmodifiableListView)
      return _hobiesAndInterests;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_hobiesAndInterests);
  }

  @override
  final GenderContext gender;
  @override
  final GenderContext interestedGender;
  final List<lookingForContext> _lookingFor;
  @override
  List<lookingForContext> get lookingFor {
    if (_lookingFor is EqualUnmodifiableListView) return _lookingFor;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_lookingFor);
  }

  @override
  final sexualOrientationContext sexualOrientation;
  @override
  final bool subscription;
  @override
  final SubscriptionType subscriptionType;
  @override
  final int dailyMessageLimit;
  @override
  final int swipeLimitForAd;
  @override
  final bool isAdmin;
  @override
  final bool isValidated;
  @override
  final bool canRecieveImages;
  @override
  final bool canRecieveAudios;
  @override
  final bool canRecieveVideos;

  @override
  String toString() {
    return 'UserModel(uid: $uid, firstName: $firstName, lastName: $lastName, birthDate: $birthDate, profileImages: $profileImages, about: $about, location: $location, currentLocation: $currentLocation, hobiesAndInterests: $hobiesAndInterests, gender: $gender, interestedGender: $interestedGender, lookingFor: $lookingFor, sexualOrientation: $sexualOrientation, subscription: $subscription, subscriptionType: $subscriptionType, dailyMessageLimit: $dailyMessageLimit, swipeLimitForAd: $swipeLimitForAd, isAdmin: $isAdmin, isValidated: $isValidated, canRecieveImages: $canRecieveImages, canRecieveAudios: $canRecieveAudios, canRecieveVideos: $canRecieveVideos)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserModelImpl &&
            (identical(other.uid, uid) || other.uid == uid) &&
            (identical(other.firstName, firstName) ||
                other.firstName == firstName) &&
            (identical(other.lastName, lastName) ||
                other.lastName == lastName) &&
            (identical(other.birthDate, birthDate) ||
                other.birthDate == birthDate) &&
            const DeepCollectionEquality()
                .equals(other._profileImages, _profileImages) &&
            (identical(other.about, about) || other.about == about) &&
            (identical(other.location, location) ||
                other.location == location) &&
            (identical(other.currentLocation, currentLocation) ||
                other.currentLocation == currentLocation) &&
            const DeepCollectionEquality()
                .equals(other._hobiesAndInterests, _hobiesAndInterests) &&
            (identical(other.gender, gender) || other.gender == gender) &&
            (identical(other.interestedGender, interestedGender) ||
                other.interestedGender == interestedGender) &&
            const DeepCollectionEquality()
                .equals(other._lookingFor, _lookingFor) &&
            (identical(other.sexualOrientation, sexualOrientation) ||
                other.sexualOrientation == sexualOrientation) &&
            (identical(other.subscription, subscription) ||
                other.subscription == subscription) &&
            (identical(other.subscriptionType, subscriptionType) ||
                other.subscriptionType == subscriptionType) &&
            (identical(other.dailyMessageLimit, dailyMessageLimit) ||
                other.dailyMessageLimit == dailyMessageLimit) &&
            (identical(other.swipeLimitForAd, swipeLimitForAd) ||
                other.swipeLimitForAd == swipeLimitForAd) &&
            (identical(other.isAdmin, isAdmin) || other.isAdmin == isAdmin) &&
            (identical(other.isValidated, isValidated) ||
                other.isValidated == isValidated) &&
            (identical(other.canRecieveImages, canRecieveImages) ||
                other.canRecieveImages == canRecieveImages) &&
            (identical(other.canRecieveAudios, canRecieveAudios) ||
                other.canRecieveAudios == canRecieveAudios) &&
            (identical(other.canRecieveVideos, canRecieveVideos) ||
                other.canRecieveVideos == canRecieveVideos));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        uid,
        firstName,
        lastName,
        birthDate,
        const DeepCollectionEquality().hash(_profileImages),
        about,
        location,
        currentLocation,
        const DeepCollectionEquality().hash(_hobiesAndInterests),
        gender,
        interestedGender,
        const DeepCollectionEquality().hash(_lookingFor),
        sexualOrientation,
        subscription,
        subscriptionType,
        dailyMessageLimit,
        swipeLimitForAd,
        isAdmin,
        isValidated,
        canRecieveImages,
        canRecieveAudios,
        canRecieveVideos
      ]);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$UserModelImplCopyWith<_$UserModelImpl> get copyWith =>
      __$$UserModelImplCopyWithImpl<_$UserModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UserModelImplToJson(
      this,
    );
  }
}

abstract class _UserModel implements UserModel {
  const factory _UserModel(
      {required final String uid,
      required final String firstName,
      required final String lastName,
      required final DateTime birthDate,
      required final List<String> profileImages,
      final String? about,
      required final String location,
      required final Location currentLocation,
      required final List<HobbyContext> hobiesAndInterests,
      required final GenderContext gender,
      required final GenderContext interestedGender,
      required final List<lookingForContext> lookingFor,
      required final sexualOrientationContext sexualOrientation,
      required final bool subscription,
      required final SubscriptionType subscriptionType,
      required final int dailyMessageLimit,
      required final int swipeLimitForAd,
      required final bool isAdmin,
      required final bool isValidated,
      required final bool canRecieveImages,
      required final bool canRecieveAudios,
      required final bool canRecieveVideos}) = _$UserModelImpl;

  factory _UserModel.fromJson(Map<String, dynamic> json) =
      _$UserModelImpl.fromJson;

  @override
  String get uid;
  @override
  String get firstName;
  @override
  String get lastName;
  @override
  DateTime get birthDate;
  @override
  List<String> get profileImages;
  @override
  String? get about;
  @override
  String get location;
  @override
  Location get currentLocation;
  @override
  List<HobbyContext> get hobiesAndInterests;
  @override
  GenderContext get gender;
  @override
  GenderContext get interestedGender;
  @override
  List<lookingForContext> get lookingFor;
  @override
  sexualOrientationContext get sexualOrientation;
  @override
  bool get subscription;
  @override
  SubscriptionType get subscriptionType;
  @override
  int get dailyMessageLimit;
  @override
  int get swipeLimitForAd;
  @override
  bool get isAdmin;
  @override
  bool get isValidated;
  @override
  bool get canRecieveImages;
  @override
  bool get canRecieveAudios;
  @override
  bool get canRecieveVideos;
  @override
  @JsonKey(ignore: true)
  _$$UserModelImplCopyWith<_$UserModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Location _$LocationFromJson(Map<String, dynamic> json) {
  return _Location.fromJson(json);
}

/// @nodoc
mixin _$Location {
  double get latitude => throw _privateConstructorUsedError;
  double get longitude => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $LocationCopyWith<Location> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LocationCopyWith<$Res> {
  factory $LocationCopyWith(Location value, $Res Function(Location) then) =
      _$LocationCopyWithImpl<$Res, Location>;
  @useResult
  $Res call({double latitude, double longitude});
}

/// @nodoc
class _$LocationCopyWithImpl<$Res, $Val extends Location>
    implements $LocationCopyWith<$Res> {
  _$LocationCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? latitude = null,
    Object? longitude = null,
  }) {
    return _then(_value.copyWith(
      latitude: null == latitude
          ? _value.latitude
          : latitude // ignore: cast_nullable_to_non_nullable
              as double,
      longitude: null == longitude
          ? _value.longitude
          : longitude // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$LocationImplCopyWith<$Res>
    implements $LocationCopyWith<$Res> {
  factory _$$LocationImplCopyWith(
          _$LocationImpl value, $Res Function(_$LocationImpl) then) =
      __$$LocationImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({double latitude, double longitude});
}

/// @nodoc
class __$$LocationImplCopyWithImpl<$Res>
    extends _$LocationCopyWithImpl<$Res, _$LocationImpl>
    implements _$$LocationImplCopyWith<$Res> {
  __$$LocationImplCopyWithImpl(
      _$LocationImpl _value, $Res Function(_$LocationImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? latitude = null,
    Object? longitude = null,
  }) {
    return _then(_$LocationImpl(
      latitude: null == latitude
          ? _value.latitude
          : latitude // ignore: cast_nullable_to_non_nullable
              as double,
      longitude: null == longitude
          ? _value.longitude
          : longitude // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$LocationImpl implements _Location {
  const _$LocationImpl({required this.latitude, required this.longitude});

  factory _$LocationImpl.fromJson(Map<String, dynamic> json) =>
      _$$LocationImplFromJson(json);

  @override
  final double latitude;
  @override
  final double longitude;

  @override
  String toString() {
    return 'Location(latitude: $latitude, longitude: $longitude)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LocationImpl &&
            (identical(other.latitude, latitude) ||
                other.latitude == latitude) &&
            (identical(other.longitude, longitude) ||
                other.longitude == longitude));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, latitude, longitude);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$LocationImplCopyWith<_$LocationImpl> get copyWith =>
      __$$LocationImplCopyWithImpl<_$LocationImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$LocationImplToJson(
      this,
    );
  }
}

abstract class _Location implements Location {
  const factory _Location(
      {required final double latitude,
      required final double longitude}) = _$LocationImpl;

  factory _Location.fromJson(Map<String, dynamic> json) =
      _$LocationImpl.fromJson;

  @override
  double get latitude;
  @override
  double get longitude;
  @override
  @JsonKey(ignore: true)
  _$$LocationImplCopyWith<_$LocationImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
