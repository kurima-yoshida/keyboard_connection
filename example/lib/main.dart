import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:keyboard_connection/keyboard_connection.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool? _isKeyboardConnected;

  @override
  void initState() {
    super.initState();
    updateIsKeyboardConnected();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> updateIsKeyboardConnected() async {
    bool? isKeyboardConnected;
    // Platform messages may fail, so we use a try/catch PlatformException.
    // We also handle the message potentially returning null.
    try {
      isKeyboardConnected = await KeyboardConnection.isKeyboardConnected;
    } on PlatformException {
      isKeyboardConnected = null;
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _isKeyboardConnected = isKeyboardConnected;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Text(_isKeyboardConnected == null ? 'Unknown\n' : (_isKeyboardConnected! ? 'Connected' : 'Not connected')),
        ),
      ),
    );
  }
}
