// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:subspace/main_screen/main_home.dart';
import 'package:provider/provider.dart';
import 'package:subspace/provider/fav_provider.dart';
import 'package:subspace/provider/sql_helper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SQLHelper.getDatabase;
  runApp(MultiProvider(
    providers: [ChangeNotifierProvider(create: (_) => Fav())],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.grey),
        useMaterial3: true,
      ),
      home: const MainHomePage(),
    );
  }
}
