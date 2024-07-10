import 'package:flutter/material.dart';
import 'package:flutter_vlc_player/flutter_vlc_player.dart';

class MediaPlayer extends StatefulWidget {
  const MediaPlayer({super.key});

  @override
  _MediaPlayerState createState() => _MediaPlayerState();
}

class _MediaPlayerState extends State<MediaPlayer> {
  late VlcPlayerController _vlcController;
  late String rtspUrl;

  @override
  void initState() {
    super.initState();
    rtspUrl = 'rtsp://192.168.1.10:8554/test';
    _vlcController =
        VlcPlayerController.network(rtspUrl, hwAcc: HwAcc.disabled);
  }

  @override
  Widget build(BuildContext context) {
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

  @override
  void dispose() {
    _vlcController.dispose();
    super.dispose();
  }
}
