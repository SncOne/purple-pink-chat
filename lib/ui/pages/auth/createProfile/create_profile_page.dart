import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:catt_catt/utils/constants.dart';
import 'package:catt_catt/utils/print.dart';
import 'package:catt_catt/utils/styles.dart';
import 'package:country_picker/country_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:geolocator/geolocator.dart';

@RoutePage()
class CreateProfilePage extends HookConsumerWidget {
  const CreateProfilePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    late LocationSettings locationSettings;

    final positionNotifier = useState<Position?>(null);
    final distanceInMeters = useState<double?>(null);

    Future<Position> determinePosition() async {
      bool serviceEnabled;
      LocationPermission permission;

      serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        return Future.error('Location services are disabled.');
      }

      permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          return Future.error('Location permissions are denied');
        }
      }

      if (permission == LocationPermission.deniedForever) {
        permission = await Geolocator.requestPermission();
        return Future.error(
            'Location permissions are permanently denied, we cannot request permissions.');
      }
      return await Geolocator.getCurrentPosition();
    }

    if (defaultTargetPlatform == TargetPlatform.android) {
      locationSettings = AndroidSettings(
        accuracy: LocationAccuracy.high,
        distanceFilter: 100,
        forceLocationManager: true,
        intervalDuration: const Duration(seconds: 10),
        foregroundNotificationConfig: const ForegroundNotificationConfig(
          notificationText:
              "Love Lens will continue to receive your location even when you aren't using it",
          notificationTitle: "Running in Background",
          enableWakeLock: true,
        ),
      );
    } else if (defaultTargetPlatform == TargetPlatform.iOS ||
        defaultTargetPlatform == TargetPlatform.macOS) {
      locationSettings = AppleSettings(
        accuracy: LocationAccuracy.high,
        activityType: ActivityType.fitness,
        distanceFilter: 100,
        pauseLocationUpdatesAutomatically: true,
        showBackgroundLocationIndicator: false,
      );
    } else {
      locationSettings = const LocationSettings(
        accuracy: LocationAccuracy.high,
        distanceFilter: 100,
      );
    }

    useEffect(() {
      determinePosition().then((position) {
        Print.info(
            'Current position: ${position.latitude}, ${position.longitude}');
        positionNotifier.value = position;

        distanceInMeters.value = Geolocator.distanceBetween(
            position.latitude, position.longitude, 37.4219983, -122.084);
        StreamSubscription<Position> positionStream =
            Geolocator.getPositionStream(locationSettings: locationSettings)
                .listen((Position? position) {
          Print.log(position == null
              ? 'Unknown'
              : '${position.latitude.toString()}, ${position.longitude.toString()}');
          positionNotifier.value = position;
        });

        return () => positionStream.cancel();
      }).catchError((e) {
        Print.error('Error getting location: $e');
      });
    }, []);

    return Scaffold(
      appBar: AppBar(
        elevation: 17,
        title: const Text(
          C.title,
          style: TextStyle(fontSize: 24, color: Colors.deepPurple),
        ),
      ),
      body: Padding(
        padding: S.edgeInsets.all24,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
                'Aradaki metre farkı : ${distanceInMeters.value.toString() ?? 'Calculating'}'),
            Text(positionNotifier.value == null
                ? 'Loading location...'
                : '${positionNotifier.value?.latitude.toString()}, ${positionNotifier.value?.longitude.toString()}'),
            ElevatedButton(
              child: const Text('Location'),
              onPressed: () => showCountryPicker(
                context: context,
                showPhoneCode: false,
                onSelect: (Country country) {
                  Print.log(
                      'Select country: ${country.displayNameNoCountryCode}');
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
