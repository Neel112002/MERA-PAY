// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'package:flutter/foundation.dart'; // For kIsWeb

Future<void> showTopSnackBar(
  BuildContext context,
  String message,
  Color backgroundColor,
  Color fontColor,
  int delay,
  double fontSize,
) async {
  final overlay = Overlay.of(context);
  if (overlay == null) return;

  // Create an OverlayEntry to display the snack bar
  final overlayEntry = OverlayEntry(
    builder: (context) => Positioned(
      bottom: MediaQuery.of(context).padding.bottom +
          20, // Above the bottom padding
      left: kIsWeb
          ? null // For web, no left constraint
          : MediaQuery.of(context).size.width * 0.1, // Centered for mobile
      right: kIsWeb
          ? MediaQuery.of(context).size.width * 0.05 // Right-aligned for web
          : MediaQuery.of(context).size.width * 0.1, // Centered for mobile
      child: Material(
        color: Colors.transparent,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          constraints: BoxConstraints(
            maxWidth: kIsWeb
                ? MediaQuery.of(context).size.width *
                    0.3 // Smaller width for web
                : MediaQuery.of(context).size.width *
                    0.8, // Larger width for mobile
          ),
          decoration: BoxDecoration(
            color: backgroundColor, // Use the backgroundColor parameter
            borderRadius:
                BorderRadius.circular(kIsWeb ? 10 : 30), // Sharper for web
            boxShadow: const [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 10,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: Text(
            message, // Display the message text
            style: TextStyle(
              color: fontColor,
              fontSize: fontSize,
            ),
            textAlign: TextAlign.center, // Center the text within the container
          ),
        ),
      ),
    ),
  );

  // Insert the OverlayEntry into the overlay
  overlay.insert(overlayEntry);

  // Remove the snack bar after the specified delay
  await Future.delayed(Duration(milliseconds: delay));
  overlayEntry.remove();
}
