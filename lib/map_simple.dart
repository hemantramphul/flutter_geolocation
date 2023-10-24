// Import Flutter's material library for building UI components
import 'dart:async';

import 'package:flutter/material.dart';
// Import a custom module or file named 'map_location_details.dart'
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapSimplePage extends StatefulWidget {
  const MapSimplePage({super.key, required this.title});
  final String title;

  @override
  State<MapSimplePage> createState() => _MapSimplePageState();
}

class _MapSimplePageState extends State<MapSimplePage> {
  // Initialize a default marker icon
  BitmapDescriptor markerIcon = BitmapDescriptor.defaultMarker;

  @override
  void initState() {
    // Call the function to add a custom marker icon
    addCustomIcon();
    super.initState();
  }

  // Load a custom marker icon from an asset
  void addCustomIcon() {
    BitmapDescriptor.fromAssetImage(
      const ImageConfiguration(),
      "assets/location.png", // Replace with the path to your custom marker image
    ).then(
      (icon) {
        // Set the markerIcon to the loaded custom icon
        setState(() {
          markerIcon = icon;
        });
      },
    );
  }

  // Create a Completer to hold the GoogleMapController, allowing access to the map
  final Completer<GoogleMapController> controllerMap = Completer();

  // Initialize an empty set to hold map markers
  Set<Marker> markers = {};

  // Callback function when the map is created
  void _onMapCreated(GoogleMapController controller) {
    setState(() {
      // Add a marker to the map with specific details
      markers.add(
        Marker(
          markerId: const MarkerId("id-1"),
          position: const LatLng(-20.2254, 57.4968),
          icon: markerIcon, // Set the custom icon
          infoWindow: const InfoWindow(title: "Bagatelle"),
        ),
      );
    });
  }

  // Define the initial camera position for the map
  final CameraPosition _initialCameraPosition = const CameraPosition(
    target: LatLng(-20.2479347, 57.5671908), // Initial map center coordinates
    zoom: 10, // Initial zoom level for the map
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Simple Map"), // Display the app bar title
        centerTitle: true, // Center align the app bar title
      ),
      body: GoogleMap(
        mapType: MapType.hybrid, // Set the map type to hybrid
        initialCameraPosition:
            _initialCameraPosition, // Use the initial camera position
        // onMapCreated: (GoogleMapController controller) {
        //   _controller.complete(controller);
        // },
        onMapCreated: _onMapCreated, // Call the custom _onMapCreated function
        markers: markers, // Display the markers on the map
      ),
    );
  }
}
