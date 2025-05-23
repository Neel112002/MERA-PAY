import 'dart:convert';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'lat_lng.dart';
import 'place.dart';
import 'uploaded_file.dart';
import '/backend/backend.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '/auth/firebase_auth/auth_util.dart';

List<String>? countryFunction(List<String>? countries) {
  if (countries == null) return [];
  countries.sort((a, b) => a.toLowerCase().compareTo(b.toLowerCase()));
  return countries;
}

String formatCountryCode(
  String root,
  List<String> suffixes,
) {
  if (root.isEmpty || suffixes.isEmpty) return '';
  return root + suffixes.first;
}
