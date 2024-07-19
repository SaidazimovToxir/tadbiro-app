// import 'package:geolocator/geolocator.dart';

// class LocationService {
//   static LocationPermission? permission;

//   static Future<bool> checkPermissions() async {
//     LocationPermission permission = await Geolocator.checkPermission();
//     if (permission == LocationPermission.denied) {
//       permission = await Geolocator.requestPermission();
//     }
//     return permission != LocationPermission.deniedForever;
//   }

//   static Future<Position?> determinePosition() async {
//     if (permission != LocationPermission.deniedForever ||
//         permission != LocationPermission.denied) {
//       return await Geolocator.getCurrentPosition();
//     }
//     return null;
//   }
// }

import 'package:geolocator/geolocator.dart';
import 'package:location/location.dart';


class LocationService {
  static bool isServiceEnabled = false;
  static LocationData? currentLocation;

  static Future<bool> checkPermissions() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
    return permission != LocationPermission.deniedForever;
  }

  static Future<Position?> determinePosition() async {
    bool hasPermission = await checkPermissions();
    if (hasPermission) {
      return await Geolocator.getCurrentPosition();
    }
    return null;
  }

  // static Future<void> getCurrentLcoation() async {
  //   if (isServiceEnabled && permissionStatus == PermissionStatus.granted) {
  //     currentLocation = await _location.getLocation();
  //   }
  // }
}


/* 
import 'package:location/location.dart';

class LocationService {
  static final _location = Location();

  static bool isServiceEnabled = false;
  static PermissionStatus permissionStatus = PermissionStatus.denied;
  static LocationData? currentLocation;

  static Future<void> init() async {
    await _checkService();
    await _checkPermission();
  }

  // joylashuv olish xizmati yoqilganmi teshiramiz
  static Future<void> _checkService() async {
    isServiceEnabled = await _location.serviceEnabled();

    if (!isServiceEnabled) {
      isServiceEnabled = await _location.requestService();
      if (!isServiceEnabled) {
        return; // Redicrect ot Settings - Sozlamalar to'girlsh kerak endi
      }
    }
  }

  // joylashuv olish uchun ruxsat berilganmi teshiramiz
  static Future<void> _checkPermission() async {
    permissionStatus = await _location.hasPermission();

    if (permissionStatus == PermissionStatus.denied) {
      permissionStatus = await _location.requestPermission();
      if (permissionStatus != PermissionStatus.granted) {
        return; // Sozlamalardan to'g'irlash kerak (ruxsat berish kerak)
      }
    }
  }

  // hozirgi joylashuvni olamiz
  static Future<void> getCurrentLcoation() async {
    if (isServiceEnabled && permissionStatus == PermissionStatus.granted) {
      currentLocation = await _location.getLocation();
    }
  }
}

 */