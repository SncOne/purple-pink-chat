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
  String get sexualOrientation => throw _privateConstructorUsedError;
  String get lastName => throw _privateConstructorUsedError;
  String get firstName => throw _privateConstructorUsedError;
  List<String> get profileImages => throw _privateConstructorUsedError;
  String get uid => throw _privateConstructorUsedError;
  String get gender => throw _privateConstructorUsedError;
  String get interestedGender => throw _privateConstructorUsedError;
  String get lookingFor => throw _privateConstructorUsedError;
  String get location => throw _privateConstructorUsedError;
  String? get about => throw _privateConstructorUsedError;
  bool get subscription => throw _privateConstructorUsedError;
  bool get isAdmin => throw _privateConstructorUsedError;
  Location get currentLocation => throw _privateConstructorUsedError;
  List<String> get hobiesAndInterests => throw _privateConstructorUsedError;
  @JsonKey(name: 'birthDate')
  DateTime get birthDate => throw _privateConstructorUsedError;

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
      {String sexualOrientation,
      String lastName,
      String firstName,
      List<String> profileImages,
      String uid,
      String gender,
      String interestedGender,
      String lookingFor,
      String location,
      String? about,
      bool subscription,
      bool isAdmin,
      Location currentLocation,
      List<String> hobiesAndInterests,
      @JsonKey(name: 'birthDate') DateTime birthDate});

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
    Object? sexualOrientation = null,
    Object? lastName = null,
    Object? firstName = null,
    Object? profileImages = null,
    Object? uid = null,
    Object? gender = null,
    Object? interestedGender = null,
    Object? lookingFor = null,
    Object? location = null,
    Object? about = freezed,
    Object? subscription = null,
    Object? isAdmin = null,
    Object? currentLocation = null,
    Object? hobiesAndInterests = null,
    Object? birthDate = null,
  }) {
    return _then(_value.copyWith(
      sexualOrientation: null == sexualOrientation
          ? _value.sexualOrientation
          : sexualOrientation // ignore: cast_nullable_to_non_nullable
              as String,
      lastName: null == lastName
          ? _value.lastName
          : lastName // ignore: cast_nullable_to_non_nullable
              as String,
      firstName: null == firstName
          ? _value.firstName
          : firstName // ignore: cast_nullable_to_non_nullable
              as String,
      profileImages: null == profileImages
          ? _value.profileImages
          : profileImages // ignore: cast_nullable_to_non_nullable
              as List<String>,
      uid: null == uid
          ? _value.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as String,
      gender: null == gender
          ? _value.gender
          : gender // ignore: cast_nullable_to_non_nullable
              as String,
      interestedGender: null == interestedGender
          ? _value.interestedGender
          : interestedGender // ignore: cast_nullable_to_non_nullable
              as String,
      lookingFor: null == lookingFor
          ? _value.lookingFor
          : lookingFor // ignore: cast_nullable_to_non_nullable
              as String,
      location: null == location
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as String,
      about: freezed == about
          ? _value.about
          : about // ignore: cast_nullable_to_non_nullable
              as String?,
      subscription: null == subscription
          ? _value.subscription
          : subscription // ignore: cast_nullable_to_non_nullable
              as bool,
      isAdmin: null == isAdmin
          ? _value.isAdmin
          : isAdmin // ignore: cast_nullable_to_non_nullable
              as bool,
      currentLocation: null == currentLocation
          ? _value.currentLocation
          : currentLocation // ignore: cast_nullable_to_non_nullable
              as Location,
      hobiesAndInterests: null == hobiesAndInterests
          ? _value.hobiesAndInterests
          : hobiesAndInterests // ignore: cast_nullable_to_non_nullable
              as List<String>,
      birthDate: null == birthDate
          ? _value.birthDate
          : birthDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
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
      {String sexualOrientation,
      String lastName,
      String firstName,
      List<String> profileImages,
      String uid,
      String gender,
      String interestedGender,
      String lookingFor,
      String location,
      String? about,
      bool subscription,
      bool isAdmin,
      Location currentLocation,
      List<String> hobiesAndInterests,
      @JsonKey(name: 'birthDate') DateTime birthDate});

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
    Object? sexualOrientation = null,
    Object? lastName = null,
    Object? firstName = null,
    Object? profileImages = null,
    Object? uid = null,
    Object? gender = null,
    Object? interestedGender = null,
    Object? lookingFor = null,
    Object? location = null,
    Object? about = freezed,
    Object? subscription = null,
    Object? isAdmin = null,
    Object? currentLocation = null,
    Object? hobiesAndInterests = null,
    Object? birthDate = null,
  }) {
    return _then(_$UserModelImpl(
      sexualOrientation: null == sexualOrientation
          ? _value.sexualOrientation
          : sexualOrientation // ignore: cast_nullable_to_non_nullable
              as String,
      lastName: null == lastName
          ? _value.lastName
          : lastName // ignore: cast_nullable_to_non_nullable
              as String,
      firstName: null == firstName
          ? _value.firstName
          : firstName // ignore: cast_nullable_to_non_nullable
              as String,
      profileImages: null == profileImages
          ? _value._profileImages
          : profileImages // ignore: cast_nullable_to_non_nullable
              as List<String>,
      uid: null == uid
          ? _value.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as String,
      gender: null == gender
          ? _value.gender
          : gender // ignore: cast_nullable_to_non_nullable
              as String,
      interestedGender: null == interestedGender
          ? _value.interestedGender
          : interestedGender // ignore: cast_nullable_to_non_nullable
              as String,
      lookingFor: null == lookingFor
          ? _value.lookingFor
          : lookingFor // ignore: cast_nullable_to_non_nullable
              as String,
      location: null == location
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as String,
      about: freezed == about
          ? _value.about
          : about // ignore: cast_nullable_to_non_nullable
              as String?,
      subscription: null == subscription
          ? _value.subscription
          : subscription // ignore: cast_nullable_to_non_nullable
              as bool,
      isAdmin: null == isAdmin
          ? _value.isAdmin
          : isAdmin // ignore: cast_nullable_to_non_nullable
              as bool,
      currentLocation: null == currentLocation
          ? _value.currentLocation
          : currentLocation // ignore: cast_nullable_to_non_nullable
              as Location,
      hobiesAndInterests: null == hobiesAndInterests
          ? _value._hobiesAndInterests
          : hobiesAndInterests // ignore: cast_nullable_to_non_nullable
              as List<String>,
      birthDate: null == birthDate
          ? _value.birthDate
          : birthDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$UserModelImpl implements _UserModel {
  const _$UserModelImpl(
      {required this.sexualOrientation,
      required this.lastName,
      required this.firstName,
      required final List<String> profileImages,
      required this.uid,
      required this.gender,
      required this.interestedGender,
      required this.lookingFor,
      required this.location,
      this.about,
      required this.subscription,
      required this.isAdmin,
      required this.currentLocation,
      required final List<String> hobiesAndInterests,
      @JsonKey(name: 'birthDate') required this.birthDate})
      : _profileImages = profileImages,
        _hobiesAndInterests = hobiesAndInterests;

  factory _$UserModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$UserModelImplFromJson(json);

  @override
  final String sexualOrientation;
  @override
  final String lastName;
  @override
  final String firstName;
  final List<String> _profileImages;
  @override
  List<String> get profileImages {
    if (_profileImages is EqualUnmodifiableListView) return _profileImages;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_profileImages);
  }

  @override
  final String uid;
  @override
  final String gender;
  @override
  final String interestedGender;
  @override
  final String lookingFor;
  @override
  final String location;
  @override
  final String? about;
  @override
  final bool subscription;
  @override
  final bool isAdmin;
  @override
  final Location currentLocation;
  final List<String> _hobiesAndInterests;
  @override
  List<String> get hobiesAndInterests {
    if (_hobiesAndInterests is EqualUnmodifiableListView)
      return _hobiesAndInterests;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_hobiesAndInterests);
  }

  @override
  @JsonKey(name: 'birthDate')
  final DateTime birthDate;

  @override
  String toString() {
    return 'UserModel(sexualOrientation: $sexualOrientation, lastName: $lastName, firstName: $firstName, profileImages: $profileImages, uid: $uid, gender: $gender, interestedGender: $interestedGender, lookingFor: $lookingFor, location: $location, about: $about, subscription: $subscription, isAdmin: $isAdmin, currentLocation: $currentLocation, hobiesAndInterests: $hobiesAndInterests, birthDate: $birthDate)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserModelImpl &&
            (identical(other.sexualOrientation, sexualOrientation) ||
                other.sexualOrientation == sexualOrientation) &&
            (identical(other.lastName, lastName) ||
                other.lastName == lastName) &&
            (identical(other.firstName, firstName) ||
                other.firstName == firstName) &&
            const DeepCollectionEquality()
                .equals(other._profileImages, _profileImages) &&
            (identical(other.uid, uid) || other.uid == uid) &&
            (identical(other.gender, gender) || other.gender == gender) &&
            (identical(other.interestedGender, interestedGender) ||
                other.interestedGender == interestedGender) &&
            (identical(other.lookingFor, lookingFor) ||
                other.lookingFor == lookingFor) &&
            (identical(other.location, location) ||
                other.location == location) &&
            (identical(other.about, about) || other.about == about) &&
            (identical(other.subscription, subscription) ||
                other.subscription == subscription) &&
            (identical(other.isAdmin, isAdmin) || other.isAdmin == isAdmin) &&
            (identical(other.currentLocation, currentLocation) ||
                other.currentLocation == currentLocation) &&
            const DeepCollectionEquality()
                .equals(other._hobiesAndInterests, _hobiesAndInterests) &&
            (identical(other.birthDate, birthDate) ||
                other.birthDate == birthDate));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      sexualOrientation,
      lastName,
      firstName,
      const DeepCollectionEquality().hash(_profileImages),
      uid,
      gender,
      interestedGender,
      lookingFor,
      location,
      about,
      subscription,
      isAdmin,
      currentLocation,
      const DeepCollectionEquality().hash(_hobiesAndInterests),
      birthDate);

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
          {required final String sexualOrientation,
          required final String lastName,
          required final String firstName,
          required final List<String> profileImages,
          required final String uid,
          required final String gender,
          required final String interestedGender,
          required final String lookingFor,
          required final String location,
          final String? about,
          required final bool subscription,
          required final bool isAdmin,
          required final Location currentLocation,
          required final List<String> hobiesAndInterests,
          @JsonKey(name: 'birthDate') required final DateTime birthDate}) =
      _$UserModelImpl;

  factory _UserModel.fromJson(Map<String, dynamic> json) =
      _$UserModelImpl.fromJson;

  @override
  String get sexualOrientation;
  @override
  String get lastName;
  @override
  String get firstName;
  @override
  List<String> get profileImages;
  @override
  String get uid;
  @override
  String get gender;
  @override
  String get interestedGender;
  @override
  String get lookingFor;
  @override
  String get location;
  @override
  String? get about;
  @override
  bool get subscription;
  @override
  bool get isAdmin;
  @override
  Location get currentLocation;
  @override
  List<String> get hobiesAndInterests;
  @override
  @JsonKey(name: 'birthDate')
  DateTime get birthDate;
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
