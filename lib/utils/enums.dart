import 'package:flutter/material.dart';

enum LoadingState { idle, loading, loaded, error }

enum ProfileStatus { notRegistered, profile, registered }

enum OnboardingStatus { none, show }

enum NotifTopics { none, all }

enum SubscriptionType { monthly, yearly, none }

enum EmailProvider {
  gmail(name: 'gmail.com', backgroundColor: Colors.red),
  yahoo(name: 'yahoo.com', backgroundColor: Colors.purple),
  hotmail(name: 'hotmail.com', backgroundColor: Colors.orange),
  outlook(name: 'outlook.com', backgroundColor: Colors.blue);

  const EmailProvider({required this.name, required this.backgroundColor});

  final String name;
  final Color backgroundColor;
}
