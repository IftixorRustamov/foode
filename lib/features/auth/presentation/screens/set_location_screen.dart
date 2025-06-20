import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:uic_task/core/common/constants/colors/app_colors.dart';
import 'package:uic_task/core/common/widgets/app_bar/action_app_bar_wg.dart';
import 'package:uic_task/core/common/widgets/button/default_button.dart';
import 'package:uic_task/core/routes/custom_router.dart';
import 'package:uic_task/core/utils/responsiveness/app_responsive.dart';
import 'package:uic_task/service_locator.dart';
import '../../../../core/common/textstyles/app_textstyles.dart';
import 'package:uic_task/features/auth/presentation/screens/congrats_screen.dart';

class SetLocationScreen extends StatefulWidget {
  const SetLocationScreen({super.key});

  @override
  State<SetLocationScreen> createState() => _SetLocationScreenState();
}

class _SetLocationScreenState extends State<SetLocationScreen> {
  static const LatLng _defaultLocation = LatLng(
    37.7749,
    -122.4194,
  ); // San Francisco as default
  LatLng? _pickedLocation;
  GoogleMapController? _mapController;
  bool _loadingLocation = false;
  bool _locationFetched = false;

  @override
  void initState() {
    super.initState();
    _pickedLocation = _defaultLocation;
    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    setState(() {
      _loadingLocation = true;
    });
    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        throw Exception(
          'Location services are disabled. Please enable them in your device settings.',
        );
      }
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          throw Exception('Location permissions are denied');
        }
      }
      if (permission == LocationPermission.deniedForever) {
        throw Exception(
          'Location permissions are permanently denied. Please enable them in your device settings.',
        );
      }
      final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      final newLocation = LatLng(position.latitude, position.longitude);
      setState(() {
        _pickedLocation = newLocation;
        _locationFetched = true;
        _loadingLocation = false;
      });
      if (_mapController != null) {
        _mapController!.animateCamera(CameraUpdate.newLatLng(newLocation));
      }
    } catch (e) {
      setState(() {
        _loadingLocation = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to get current location: $e')),
      );
    }
  }

  void _onMapTap(LatLng position) {
    setState(() {
      _pickedLocation = position;
    });
  }

  void _onMapCreated(GoogleMapController controller) {
    _mapController = controller;
    if (_locationFetched && _pickedLocation != null) {
      _mapController!.animateCamera(CameraUpdate.newLatLng(_pickedLocation!));
    }
  }

  void _onConfirmLocation() {
    if (_pickedLocation != null) {
      CustomRouter.go(const CongratsScreen());
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select a location on the map.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: ActionAppBarWg(
        onBackPressed: CustomRouter.close,
        titleText: 'Set your location',
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: appW(0)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: appH(24)),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: appW(24)),
                child: Text(
                  'This data will be displayed in your account profile for security',
                  style: sl<AppTextStyles>().regular(
                    color: AppColors.neutral3,
                    fontSize: 16,
                  ),
                ),
              ),
              SizedBox(height: appH(16)),
              Expanded(
                child: Stack(
                  children: [
                    GoogleMap(
                      initialCameraPosition: CameraPosition(
                        target: _pickedLocation ?? _defaultLocation,
                        zoom: 15,
                      ),
                      onMapCreated: _onMapCreated,
                      onTap: _onMapTap,
                      markers: _pickedLocation != null
                          ? {
                              Marker(
                                markerId: const MarkerId('picked'),
                                position: _pickedLocation!,
                              ),
                            }
                          : {},
                    ),
                    if (_loadingLocation)
                      const Center(child: CircularProgressIndicator()),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: appW(24)),
                child: DefaultButton(
                  text: 'Set location',
                  onPressed: _pickedLocation != null
                      ? _onConfirmLocation
                      : null,
                ),
              ),
              SizedBox(height: appH(16)),
            ],
          ),
        ),
      ),
    );
  }
}
