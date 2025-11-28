import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:quickmed/utils/widgets/TButton.dart';

import '../../../utils/app_text_style.dart';
import '../../../utils/device_utility.dart';
import '../../../utils/theme/colors/q_color.dart';

class GetDirectionScreen extends StatefulWidget {
  const GetDirectionScreen({super.key});

  @override
  State<GetDirectionScreen> createState() => _GetDirectionScreenState();
}

class _GetDirectionScreenState extends State<GetDirectionScreen> {
  int selectedTransport = 0;

  final Completer<GoogleMapController> mapController = Completer();

  static const LatLng startPoint = LatLng(6.4667, 7.5100);
  static const LatLng endPoint = LatLng(6.4402, 7.4947);

  Set<Polyline> mapPolylines = {};
  Set<Marker> mapMarkers = {};

  @override
  Widget build(BuildContext context) {
    bool isDark = TDeviceUtils.isDarkMode(context);

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
            child: Column(
              children: [
                // Back Button
                Align(
                  alignment: Alignment.centerLeft,
                  child: GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Row(
                      children: [
                        Icon(Icons.arrow_back,
                            color: isDark ? Colors.white : Colors.black),
                        const SizedBox(width: 6),
                        Text(
                          "Go Back",
                          style: TAppTextStyle.inter(
                            color: isDark ? Colors.white : QColors.lightGray800,
                            fontSize: 16,
                            weight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 40),

                Text(
                  "Get Direction",
                  style: TAppTextStyle.inter(
                    weight: FontWeight.w700,
                    color: Colors.black,
                    fontSize: 20,
                  ),
                ),

                const SizedBox(height: 20),

                // Location card
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.grey.shade300),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        children: [
                          Container(
                            width: 12,
                            height: 12,
                            decoration: const BoxDecoration(
                              color: Colors.blue,
                              shape: BoxShape.circle,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Container(
                            height: 40,
                            width: 2,
                            color: Colors.grey,
                          ),
                          const SizedBox(height: 6),
                          const Icon(Icons.location_on,
                              color: Colors.red, size: 22),
                        ],
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(vertical: 6),
                              decoration: BoxDecoration(
                                color: Colors.grey.shade100,
                                borderRadius: BorderRadius.circular(6),
                              ),
                              alignment: Alignment.center,
                              child: const Text(
                                "Your Location",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.blue,
                                ),
                              ),
                            ),
                            const SizedBox(height: 8),
                            Container(
                              height: 1,
                              width: double.infinity,
                              color: Colors.black.withOpacity(0.2),
                            ),
                            const SizedBox(height: 8),
                            const Text(
                              "Mary Okpe - Hypertension\nNo 2 Abakpa, Nike, 970113, Enugu",
                              style: TextStyle(
                                fontSize: 13,
                                height: 1.4,
                                color: Colors.black87,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                // Google Map
                SizedBox(
                  height: 320,
                  width: double.infinity,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: GoogleMap(
                      initialCameraPosition: const CameraPosition(
                        target: startPoint,
                        zoom: 13,
                      ),
                      markers: mapMarkers,
                      polylines: mapPolylines,
                      myLocationEnabled: true,
                      myLocationButtonEnabled: true,
                      zoomControlsEnabled: true,
                      onMapCreated: (controller) {
                        mapController.complete(controller);
                      },
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                // Transport options
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    transportOption(
                        icon: Icons.directions_car,
                        label: "40 Min",
                        index: 0),
                    transportOption(
                        icon: Icons.directions_bike,
                        label: "40 Min",
                        index: 1),
                    transportOption(
                        icon: Icons.directions_walk,
                        label: "40 Min",
                        index: 2),
                  ],
                ),

                const SizedBox(height: 20),

                QButton(text: 'Start', onPressed: () {})
              ],
            ),
          ),
        ),
      ),
    );
  }

  // -----------------------
  // TRANSPORT OPTION WIDGET
  // -----------------------
  Widget transportOption({
    required IconData icon,
    required String label,
    required int index,
  }) {
    final bool isSelected = selectedTransport == index;

    return GestureDetector(
      onTap: () => setState(() => selectedTransport = index),
      child: Container(
        width: 100,
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? Colors.blue.shade50 : Colors.grey.shade200,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: isSelected ? Colors.blue : Colors.transparent,
            width: 2,
          ),
        ),
        child: Column(
          children: [
            Icon(icon, size: 28, color: Colors.black87),
             SizedBox(height: 8),
            Text(
              label,
              style:  TextStyle(fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
    );
  }
}
