import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vlc_player/flutter_vlc_player.dart';

class MediaScreen extends StatefulWidget {
  const MediaScreen({super.key});

  @override
  State<MediaScreen> createState() => _MediaScreenState();
}

class _MediaScreenState extends State<MediaScreen> {
  late String? rtspUrl;
  late VlcPlayerController _vlcController;

  @override
  void initState() {
    super.initState();
    _vlcController =
        VlcPlayerController.network(rtspUrl!, hwAcc: HwAcc.disabled);
    // Listen for errors
    _vlcController.addListener(() {
      if (_vlcController.value.hasError) {
        _handleError(_vlcController.value.errorDescription);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (ModalRoute.of(context)!.settings.arguments != null) {
      rtspUrl = ModalRoute.of(context)!.settings.arguments as String;
    }
    return Scaffold(
      body: Center(
        child: VlcPlayer(
          controller: _vlcController,
          aspectRatio: 16 / 9, // Set the aspect ratio as needed
          placeholder: const Center(child: CircularProgressIndicator()),
        ),
      ),
    );
  }

  void _handleError(String error) {
    if (kDebugMode) {
      print("VLC Player Error: $error");
    }
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("An error occurred: $error"),
        duration: const Duration(seconds: 3),
      ),
    );
  }

  @override
  void dispose() {
    _vlcController.dispose();
    super.dispose();
  }
}
