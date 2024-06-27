// GenderContext enum dönüşüm fonksiyonları
import 'package:catt_catt/utils/enums.dart';
import 'package:catt_catt/utils/lang/strings.g.dart';

String genderContextToString(GenderContext gender) {
  return gender.name;
}

GenderContext stringToGenderContext(String gender) {
  return GenderContext.values.firstWhere((e) => e.name == gender);
}

// HobbyContext enum dönüşüm fonksiyonları
String hobbyContextToString(HobbyContext hobby) {
  return hobby.name;
}

HobbyContext stringToHobbyContext(String hobby) {
  return HobbyContext.values.firstWhere((e) => e.name == hobby);
}

// sexualOrientationContext enum dönüşüm fonksiyonları
String sexualOrientationContextToString(sexualOrientationContext orientation) {
  return orientation.name;
}

sexualOrientationContext stringToSexualOrientationContext(String orientation) {
  return sexualOrientationContext.values
      .firstWhere((e) => e.name == orientation);
}

// lookingForContext enum dönüşüm fonksiyonları
String lookingForContextToString(lookingForContext lookingFor) {
  return lookingFor.name;
}

lookingForContext stringToLookingForContext(String lookingFor) {
  return lookingForContext.values.firstWhere((e) => e.name == lookingFor);
}

String subscriptionTypeToString(SubscriptionType type) {
  return type.toString().split('.').last;
}

SubscriptionType stringToSubscriptionType(String type) {
  return SubscriptionType.values.firstWhere(
      (e) => e.toString().split('.').last == type,
      orElse: () => SubscriptionType.none);
}
