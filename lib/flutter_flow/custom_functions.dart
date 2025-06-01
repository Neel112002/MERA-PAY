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

double getDailyAmount(String netAmount) {
  try {
    double amount = double.parse(netAmount);
    DateTime now = DateTime.now();

    // Total days in the current month
    int totalDaysInMonth = DateTime(now.year, now.month + 1, 0).day;

    // Current day of the month
    int today = now.day;

    // Calculate daily amount
    double perDay = amount / totalDaysInMonth;

    // Total allocated up to today
    double allocated = perDay * today;

    // Round to 2 decimal places
    return double.parse(allocated.toStringAsFixed(2));
  } catch (e) {
    return 0;
  }
}

double getWithdrawablePercentage(String netAmount) {
  try {
    DateTime now = DateTime.now();

    // Total days in the current month
    int totalDaysInMonth = DateTime(now.year, now.month + 1, 0).day;

    // Current day
    int today = now.day;

    // Percentage withdrawable up to today
    double percentage = (today / totalDaysInMonth) * 100;

    // Round to 2 decimal places
    return double.parse(percentage.toStringAsFixed(2));
  } catch (e) {
    return 0;
  }
}

double? calculatePercentageAmount(
  String amount,
  double percent,
) {
  final parsedAmount = double.tryParse(amount) ?? 0.0;
  return double.parse(((parsedAmount * percent) / 100).toStringAsFixed(2));
}

double addStringAndDouble(
  String value1,
  double value2,
  String value3,
) {
  final parsedValue1 = double.tryParse(value1) ?? 0.0;
  final parsedValue3 = double.tryParse(value3) ?? 0.0;
  return double.parse(
      (parsedValue1 + value2 + parsedValue3).toStringAsFixed(2));
}

double subtractStringValues(
  String value1,
  String value2,
) {
  final num1 = double.tryParse(value1) ?? 0.0;
  final num2 = double.tryParse(value2) ?? 0.0;
  return double.parse((num1 - num2).toStringAsFixed(2));
}

String getNextMonth(String monthYear) {
  try {
    // Normalize input to "Month yyyy" format (e.g., March 2024)
    final formattedInput = toBeginningOfSentenceCase(monthYear.toLowerCase());
    final parsedDate = DateFormat('MMMM yyyy').parse(formattedInput!);
    final nextMonth = DateTime(parsedDate.year, parsedDate.month + 1);
    return DateFormat('MMMM yyyy').format(nextMonth);
  } catch (e) {
    return '';
  }
}
