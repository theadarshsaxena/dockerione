import 'package:flutter/material.dart';
import 'pages/myhomepage.dart';
import 'package:provider/provider.dart';
import 'pages/device_provider.dart';
import 'pages/devices_page.dart';

// void main() {
//   runApp(const MyApp());
// }

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => DeviceProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Docker iOne'),
      routes: {
        '/devices': (context) => DevicePage(),
      },
    );
  }
}
