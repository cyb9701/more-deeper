import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_playround/riverpod/provider_observer.dart';
import 'package:riverpod_playround/screen/home_screen.dart';

void main() {
  runApp(ProviderScope(
    observers: [ProviderLogger()],
    child: const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    ),
  ));
}
