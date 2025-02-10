import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionHandler {
  Future<bool> requestStoragePermission(BuildContext context) async {
    // Log current permission status for debugging
    PermissionStatus currentStatus = await Permission.storage.status;
    debugPrint("Current storage permission status: $currentStatus");

    // If already granted, return immediately
    if (currentStatus.isGranted) return true;

    // If permanently denied, guide user to app settings
    if (currentStatus.isPermanentlyDenied) {
      return await _showPermanentDenialDialog(context);
    }

    // Show rationale dialog if not previously denied
    bool? shouldRequest = await _showPermissionRationaleDialog(context);
    if (shouldRequest != true) return false;

    // Request permission
    PermissionStatus requestResult = await Permission.storage.request();
    debugPrint("Permission request result: $requestResult");

    switch (requestResult) {
      case PermissionStatus.granted:
        return true;
      case PermissionStatus.denied:
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Storage permission denied'))
        );
        return false;
      case PermissionStatus.permanentlyDenied:
        return await _showPermanentDenialDialog(context);
      default:
        return false;
    }
  }

  Future<bool?> _showPermissionRationaleDialog(BuildContext context) {
    return showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Storage Access Required'),
        content: Text(
            'This app needs storage access to save your PDF tickets. '
                'Would you like to grant permission?'
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text('Deny'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: Text('Allow'),
          ),
        ],
      ),
    );
  }

  Future<bool> _showPermanentDenialDialog(BuildContext context) async {
    bool? result = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Permission Required'),
        content: Text(
            'Storage access has been permanently denied. '
                'Would you like to open app settings to manually enable?'
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              openAppSettings();
              Navigator.of(context).pop(true);
            },
            child: Text('Open Settings'),
          ),
        ],
      ),
    );

    return result ?? false;
  }
}