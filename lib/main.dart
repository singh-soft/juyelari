import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get_storage/get_storage.dart';
import 'package:juyelari/Features/res/routes/routes.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  await saveDeviceToken(); 
  runApp(const MyApp());
}
Future<void> saveDeviceToken() async {
  final box = GetStorage();

  String platformType = 'unknown';

  if (kIsWeb) {
    platformType = 'web';
  } else if (Platform.isAndroid) {
    platformType = 'android';
    final deviceInfo = DeviceInfoPlugin();
    final androidInfo = await deviceInfo.androidInfo;
    final deviceToken = androidInfo.id;
    box.write('device_token', deviceToken);
  } else if (Platform.isIOS) {
    platformType = 'ios';
    final deviceInfo = DeviceInfoPlugin();
    final iosInfo = await deviceInfo.iosInfo;
    final deviceToken = iosInfo.identifierForVendor ?? 'unknown';
    box.write('device_token', deviceToken);
  } else if (Platform.isWindows) {
    platformType = 'windows';
  } else if (Platform.isMacOS) {
    platformType = 'macos';
  } else if (Platform.isLinux) {
    platformType = 'linux';
  }

  box.write('platform_type', platformType);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      getPages: Routes.appRoutes(),
      
    );
  }
}


