
import 'dart:async';

import 'package:flutter/services.dart';

class KeyboardConnection {
  static const MethodChannel _channel = MethodChannel('jp.ne.sakura.kurima/keyboard_connection');

  static Future<bool?> get isKeyboardConnected async {
    final bool? isKeyboardConnected = await _channel.invokeMethod('isKeyboardConnected');
    return isKeyboardConnected;
  }
}
