import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'export_all.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await LocalStorage.initStorage();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late int? pass;
  @override
  void initState() {
    super.initState();
    pass = LocalStorage.getPass();
    log('pass: $pass');
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'RimTrans',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
          fontFamily: 'OpenSans'),
      home: pass == null
          ? WelcomeScreen(key: widget.key)
          : PinScreen(
              key: widget.key,
              isPinExist: true,
            ),
    );
  }
}
