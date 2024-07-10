import 'package:comms_hub_app/media_player.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Media Communication Hub',
      debugShowCheckedModeBanner: false,
      home: MediaPlayer(),
    );
  }
}
