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

double subStringAndDouble(
  String value1,
  double value2,
  String value3,
) {
  final parsedValue1 = double.tryParse(value1) ?? 0.0;
  final parsedValue3 = double.tryParse(value3) ?? 0.0;
  return double.parse(
      (parsedValue1 - value2 - parsedValue3).toStringAsFixed(2));
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

double convertMinutesToHours(int? minutes) {
  if (minutes == null) return 0.0;
  double hours = minutes / 60;
  return double.parse(hours.toStringAsFixed(2));
}

String extractTimeFromDateTime(String? dateTimeStr) {
  if (dateTimeStr == null || dateTimeStr.isEmpty) return '12:00 AM';
  try {
    final dateTime = DateTime.parse(dateTimeStr);
    final formattedTime = DateFormat('hh:mm a').format(dateTime);
    return formattedTime;
  } catch (e) {
    return '12:00 AM'; // fallback for invalid format
  }
}

double calculatePercentageOf22(int value) {
  if (value == null || value == 0) return 0.0;
  double percentage = (value / 22) * 100;
  return double.parse(percentage.toStringAsFixed(2));
}

double trimToTwoDecimals(double? value) {
  if (value == null) return 0.0;
  return double.parse(value.toStringAsFixed(2));
}

int calculateCredits(double? amount) {
  if (amount == null) {
    return 0;
  }
  return (amount / 100).floor();
}

int? addNullableInts(
  int? a,
  int? b,
) {
  return (a ?? 0) + (b ?? 0);
}
