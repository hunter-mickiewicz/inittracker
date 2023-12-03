// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:init_tracker/combatant_manager.dart';

import 'tracker_options.dart';

CombatantManager? combMan;

void main() {
  init();
  runApp(const MyApp());
}

void init() {
  combMan = CombatantManager();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Initiative Tracker',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'D&D Initiative Tracker'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: const Center(child: TrackerOptions()),
    );
  }
}
