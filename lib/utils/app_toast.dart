import 'package:flutter/material.dart';
import 'package:another_flushbar/flushbar.dart';

class AppToast {
  
  static String cleanMessage(Object error) {
  final message = error.toString();
  return message.replaceFirst(RegExp(r'^Exception:\s*'), '');
}

  static void showError(BuildContext context, String message) {
    _showToast(
      
      context,
      message,
      icon: Icons.error_outline,
      colors: [Colors.redAccent, Colors.red.shade700],
    );
  }

  static void showSuccess(BuildContext context, String message) {
    _showToast(
      context,
      message,
      icon: Icons.check_circle,
      colors: [Colors.greenAccent.shade400, Colors.green.shade700],
    );
  }

  static void showInfo(BuildContext context, String message) {
    _showToast(
      context,
      message,
      icon: Icons.info_outline,
      colors: [Colors.blueAccent, Colors.indigo],
    );
  }

  static void _showToast(
    BuildContext context,
    String message, {
    required IconData icon,
    required List<Color> colors,
  }) {
    Flushbar(
      margin: const EdgeInsets.all(12),
      borderRadius: BorderRadius.circular(16),
      backgroundGradient: LinearGradient(
        colors: colors,
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      boxShadows: [
        BoxShadow(
          color: Colors.black.withOpacity(0.25),
          blurRadius: 8,
          offset: const Offset(2, 4),
        )
      ],
      flushbarPosition: FlushbarPosition.TOP,
      icon: Icon(icon, color: Colors.white, size: 28),
      messageText: Text(
        message,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 15,
          fontWeight: FontWeight.w600,
        ),
      ),
      duration: const Duration(seconds: 3),
      animationDuration: const Duration(milliseconds: 600),
      forwardAnimationCurve: Curves.easeOutBack, // bounce-in effect
      reverseAnimationCurve: Curves.easeIn, // smooth out
      isDismissible: true,
      mainButton: TextButton(
        onPressed: () {}, // optional action
        child: const Text(
          "OK",
          style: TextStyle(color: Colors.white70, fontWeight: FontWeight.bold),
        ),
      ),
    ).show(context);
  }
}
