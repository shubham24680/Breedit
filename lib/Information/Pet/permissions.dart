import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

const status = Permission.storage;
Future<void> requestPermission(context) async {
  await status.request();
  Navigator.of(context).pop();
}

Future<bool> checkPermission() async {
  if (await status.isDenied) {
    await status.request();
  } else if (await status.isPermanentlyDenied) {
    openAppSettings();
  }

  return status.isGranted;
}
