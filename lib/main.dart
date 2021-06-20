import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:safira_woocommerce_app/Providers/CartProviders.dart';

import "package:provider/provider.dart";
import 'package:safira_woocommerce_app/ui/splash.dart';
import 'package:safira_woocommerce_app/utils/sharedServices.dart';

void main() {
  runApp(MyApp());
  // AwesomeNotifications().initialize(null, [
  //   NotificationChannel(
  //       channelKey: 'basic_channel',
  //       channelName: 'Basic notifications',
  //       channelDescription: 'Notification channel for basic tests',
  //       defaultColor: Color(0xFF9D50DD),
  //       ledColor: Colors.white)
  // ]);
  WidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global = MyHttpOverrides();
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  SharedServices sharedServices = SharedServices();
  bool login = false;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [ChangeNotifierProvider.value(value: CartModel())],
        child: MaterialApp(
            debugShowCheckedModeBanner: false,

            // theme: OpenFlutterEcommerceTheme.of(context),
            home: AnimatedSplash()));
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
