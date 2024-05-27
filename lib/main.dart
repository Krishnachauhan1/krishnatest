import 'package:flutter/material.dart';
import 'package:krishnatest/view/Dashboard.dart';
import 'package:provider/provider.dart';

import 'controllers/profic_pic_controller.dart';

void main() {
  runApp(ChangeNotifierProvider(
    create: (context) => ProfilePicController(),
     child: MyApp()));
}

class MyApp extends StatelessWidget {
  static final navigatorKey = GlobalKey<NavigatorState>();
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const Dashboard(),
    );
  }
}
