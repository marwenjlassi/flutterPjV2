import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';
import 'package:exam_flutter/features/location/services/location_service.dart';

class LocationProvider with ChangeNotifier {
  final LocationService _locationService;
  Position? _currentPosition;
  String _currentAddress = 'Fetching location...';
  bool _isLoading = false;
  String? _error;

  LocationProvider(this._locationService);

  Position? get currentPosition => _currentPosition;
  String get currentAddress => _currentAddress;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> updateLocation() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _currentPosition = await _locationService.getCurrentPosition();
      _currentAddress = await _locationService.getAddressFromLatLng(_currentPosition!);
    } catch (e) {
      _error = e.toString();
      _currentAddress = 'Location unavailable';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
