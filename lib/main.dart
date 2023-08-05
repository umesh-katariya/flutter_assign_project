import 'package:flutter/material.dart';

import 'ui/GamificationScreen/gamification_screen.dart';
import 'utils/app_colors.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Assignment',
      theme: ThemeData(
          appBarTheme: const AppBarTheme(
            color: AppColors.backgroundColor,
          )),
      home: GamificationScreen(),
    );
  }
}

