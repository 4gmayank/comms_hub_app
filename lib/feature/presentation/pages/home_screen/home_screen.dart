import 'package:comms_hub_app/core/conifg/navigation.dart';
import 'package:flutter/material.dart';

import '../../../../app_routes.dart';
import '../../../../core/utils/constants.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  //home ip address
  // final String rtsp = "rtsp://192.168.1.10:8554/test";
  //hotel ip address
  final String rtsp = "rtsp://10.240.241.192:8554/test";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundWhite,
      body: Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.symmetric(horizontal: 26),
        color: AppColors.white,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text('Enter RTSP source'),
              const SizedBox(height: 10),
              EditTextWithButton(
                mediaFunction: (url) {
                  _handleNavigation(AppRoutes.mediaScreen, url);
                },
              ),
              const SizedBox(height: 20),
              const Text('or You may try'),
              const SizedBox(height: 10),
              TextViewWithButton(mediaFunction: (url) {
                _handleNavigation(AppRoutes.mediaScreen, url);
              }),
            ],
          ),
        ),
      ),
    );
  }

  _handleNavigation(final String route, String url) {
    Navigation.intentWithData(context, route, url);
  }
}

class EditTextWithButton extends StatefulWidget {
  final MediaFunction mediaFunction;

  const EditTextWithButton({super.key, required this.mediaFunction});

  @override
  State<EditTextWithButton> createState() => _EditTextWithButtonState();
}

class _EditTextWithButtonState extends State<EditTextWithButton> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: TextField(
              controller: _controller,
              decoration: const InputDecoration(
                hintText: 'Enter RTSP URL...',
              ),
            ),
          ),
        ),
        ElevatedButton(
          onPressed: () {
            widget.mediaFunction(_controller.text);
          },
          child: const Text('Go'),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

typedef MediaFunction = void Function(String);

class TextViewWithButton extends StatefulWidget {
  final MediaFunction mediaFunction;

  const TextViewWithButton({super.key, required this.mediaFunction});

  @override
  State<TextViewWithButton> createState() => _TextViewWithButtonState();
}

class _TextViewWithButtonState extends State<TextViewWithButton> {
  final String _displayText = 'rtsp://192.168.1.10:8554/test';

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text(
          _displayText,
          style: const TextStyle(fontSize: 16),
        ),
        const SizedBox(height: 10),
        ElevatedButton(
          onPressed: () {
            widget.mediaFunction(_displayText);
          },
          child: const Text('Go'),
        ),
      ],
    );
  }
}
