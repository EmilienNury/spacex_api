import 'package:flutter/material.dart';
import 'package:spacex_api/app/app.dart';
import 'package:spacex_api/core/manager/database_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DataBaseManager().init();
  runApp(const MyApp());
}
