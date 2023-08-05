import 'package:flutter/material.dart';

class Constants {
  static final Constants _instance = Constants._();

  Constants._();

  static Constants get instance => _instance;

  static const String appLabelName = 'Main Demo';
  static const String appName = 'Main Demo';
  static const String iosAppLink = 'https://apps.apple.com/us/app/id';
  static const String androidAppLink = 'play.google.com/store/apps/details?id=com.example';


}