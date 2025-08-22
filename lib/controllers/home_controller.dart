import 'dart:async';

import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fire_respondents/models/home_screen_model.dart';

import '../components/smooth_route.dart';
import '../screens/home_screen/details_screen.dart';

// Providers
final locationProvider = StateProvider<LatLng?>((ref) => null);
final emergencyMarkersProvider = StateProvider<Set<Marker>>(
  (ref) => <Marker>{},
);

class HomeController {
  final homeModel = HomeScreenModel();
  final showFieldProvider = StateProvider<bool>((ref) => false);
  final tabIndex = StateProvider<int?>((ref) => null);
  final loadingBtn = StateProvider<bool>((ref) => false);

  GoogleMapController? mapController;
  String mapStyle = "";

  Future<void> initializeApp(WidgetRef ref) async {
    await _determinePosition(ref);
  }

  Future<void> _determinePosition(WidgetRef ref) async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      await Geolocator.openLocationSettings();
      return;
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) return;
    }

    if (permission == LocationPermission.deniedForever) {
      await Geolocator.openAppSettings();
      return;
    }

    Position position = await Geolocator.getCurrentPosition(
      locationSettings: LocationSettings(accuracy: LocationAccuracy.high),
    );

    ref.read(locationProvider.notifier).state = LatLng(
      position.latitude,
      position.longitude,
    );
  }

  double _colorToHue(Color color) {
    if (color == Colors.red) return BitmapDescriptor.hueRed;
    if (color == Colors.blue) return BitmapDescriptor.hueBlue;
    if (color == Colors.green) return BitmapDescriptor.hueGreen;
    return BitmapDescriptor.hueOrange;
  }

  void onMapCreated(GoogleMapController controller) async {
    mapStyle = await rootBundle.loadString(
      'assets/custom_map_style/map_style.json',
    );
    mapController = controller;
  }

  void addEmergency(
    String type,
    Color color,
    WidgetRef ref,
    BuildContext context,
  ) {
    final currentLocation = ref.read(locationProvider);
    if (currentLocation == null) return;

    final newMarker = Marker(
      markerId: MarkerId('${type}_${DateTime.now()}'),
      position: currentLocation,
      icon: BitmapDescriptor.defaultMarkerWithHue(_colorToHue(color)),
      infoWindow: InfoWindow(
        title: "$type Emergency",
        snippet:
            "Reported at ${DateTime.now().hour}:${DateTime.now().minute.toString().padLeft(2, '0')}",
      ),
    );

    final updatedMarkers = Set<Marker>.from(ref.read(emergencyMarkersProvider))
      ..add(newMarker);
    ref.read(emergencyMarkersProvider.notifier).state = updatedMarkers;

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text("$type emergency sent!")));
  }

  void collapseField(WidgetRef ref, int index) {
    ref.read(tabIndex.notifier).state = index;
    final currentValue = ref.read(showFieldProvider);
    if (currentValue) return;
    ref.read(showFieldProvider.notifier).state = !currentValue;
  }

  void minimizeField(WidgetRef ref) {
    final currentValue = ref.read(showFieldProvider);
    ref.read(tabIndex.notifier).state = null;
    ref.read(showFieldProvider.notifier).state = !currentValue;
  }

  void fileReports(WidgetRef ref) async {
    ref.read(loadingBtn.notifier).state = true;
    await Future.delayed(Duration(milliseconds: 500));
    homeModel.reports.add(
      HomeScreenModel(
        type: "Ambulance",
        image: "accident.png",
        isInjured: true,
        description: "Major car accident near Main Street. ataya",
      ),
    );

    ref.read(loadingBtn.notifier).state = false;
    SmoothRoute(
      // ignore: use_build_context_synchronously
      context: ref.context,
      child: DetailsScreen(reports: homeModel.reports),
    ).route();
  }
}
