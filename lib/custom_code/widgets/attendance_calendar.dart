// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom widgets
import '/custom_code/actions/index.dart'; // Imports custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom widget code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';
import 'dart:async';

class AttendanceCalendar extends StatefulWidget {
  const AttendanceCalendar({
    super.key,
    this.width,
    this.height,
    this.userId,
  });

  final double? width;
  final double? height;
  final String? userId;

  @override
  State<AttendanceCalendar> createState() => _AttendanceCalendarState();
}

class _AttendanceCalendarState extends State<AttendanceCalendar> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  Map<DateTime, List<AttendanceRecord>> _attendanceEvents = {};
  bool _isLoading = true;
  Timer? _timer;
  Map<DateTime, Duration> _activeDurations = {};

  @override
  void initState() {
    super.initState();
    _loadAttendanceData();
    // Start timer for real-time updates
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      _updateActiveDurations();
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _updateActiveDurations() {
    final now = DateTime.now();
    final Map<DateTime, Duration> newDurations = {};

    for (var entry in _attendanceEvents.entries) {
      for (var record in entry.value) {
        if (record.checkOut == null) {
          final duration = now.difference(record.checkIn);
          newDurations[entry.key] = duration;
        }
      }
    }

    if (mounted) {
      setState(() {
        _activeDurations = newDurations;
      });
    }
  }

  Future<void> _loadAttendanceData() async {
    if (widget.userId == null) {
      setState(() {
        _isLoading = false;
      });
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final startDate = DateTime(_focusedDay.year, _focusedDay.month - 1, 1);
      final endDate = DateTime(_focusedDay.year, _focusedDay.month + 1, 0);

      final attendanceRef = FirebaseFirestore.instance.collection('attendance');
      final querySnapshot = await attendanceRef
          .where('userId', isEqualTo: widget.userId)
          .where('date', isGreaterThanOrEqualTo: Timestamp.fromDate(startDate))
          .where('date', isLessThanOrEqualTo: Timestamp.fromDate(endDate))
          .orderBy('date', descending: false)
          .get();

      final Map<DateTime, List<AttendanceRecord>> events = {};
      for (var doc in querySnapshot.docs) {
        final data = doc.data();
        final date = (data['date'] as Timestamp).toDate();
        final checkIn = (data['checkIn'] as Timestamp).toDate();
        final checkOut = data['checkOut'] != null
            ? (data['checkOut'] as Timestamp).toDate()
            : null;

        final normalizedDate = DateTime(date.year, date.month, date.day);
        if (events[normalizedDate] == null) {
          events[normalizedDate] = [];
        }
        events[normalizedDate]!.add(AttendanceRecord(
          checkIn: checkIn,
          checkOut: checkOut,
        ));
      }

      setState(() {
        _attendanceEvents = events;
        _isLoading = false;
      });
      _updateActiveDurations();
    } catch (e) {
      print('Error loading attendance data: $e');
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _recordAttendance(DateTime date, bool isCheckIn) async {
    if (widget.userId == null) return;

    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final selectedDate = DateTime(date.year, date.month, date.day);

    // Only allow check-in/check-out for today
    if (selectedDate != today) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('You can only check in/out for today\'s date'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    final normalizedDate = DateTime(date.year, date.month, date.day);
    final attendanceRef = FirebaseFirestore.instance.collection('attendance');

    try {
      if (isCheckIn) {
        // Fetch all records for today and filter in Dart for active check-in
        final querySnapshot = await attendanceRef
            .where('userId', isEqualTo: widget.userId)
            .where('date',
                isGreaterThanOrEqualTo: Timestamp.fromDate(normalizedDate))
            .where('date',
                isLessThanOrEqualTo: Timestamp.fromDate(
                    normalizedDate.add(const Duration(days: 1))))
            .orderBy('date', descending: true)
            .get();
        final activeCheckIn =
            querySnapshot.docs.where((doc) => doc['checkOut'] == null).toList();

        if (activeCheckIn.isNotEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('You already have an active check-in'),
              backgroundColor: Colors.red,
            ),
          );
          return;
        }

        await attendanceRef.add({
          'userId': widget.userId,
          'date': Timestamp.fromDate(now),
          'checkIn': Timestamp.fromDate(now),
          'checkOut': null,
          'createdAt': FieldValue.serverTimestamp(),
        });
      } else {
        // Fetch all records for today and filter in Dart for active check-in
        final querySnapshot = await attendanceRef
            .where('userId', isEqualTo: widget.userId)
            .where('date',
                isGreaterThanOrEqualTo: Timestamp.fromDate(normalizedDate))
            .where('date',
                isLessThanOrEqualTo: Timestamp.fromDate(
                    normalizedDate.add(const Duration(days: 1))))
            .orderBy('date', descending: true)
            .get();
        final activeCheckInDocs =
            querySnapshot.docs.where((doc) => doc['checkOut'] == null).toList();

        if (activeCheckInDocs.isEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('No active check-in found'),
              backgroundColor: Colors.red,
            ),
          );
          return;
        }

        await activeCheckInDocs.first.reference.update({
          'checkOut': Timestamp.fromDate(now),
        });
      }

      await _loadAttendanceData();
    } catch (e) {
      print('Error recording attendance: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error recording attendance: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  String _getTotalHoursForDay(DateTime day) {
    final normalizedDay = DateTime(day.year, day.month, day.day);
    final records = _attendanceEvents[normalizedDay] ?? [];

    if (records.isEmpty) return '';

    Duration totalDuration = Duration.zero;
    for (var record in records) {
      if (record.checkOut != null) {
        totalDuration += record.checkOut!.difference(record.checkIn);
      } else {
        // Add active duration for records without check-out
        totalDuration += _activeDurations[normalizedDay] ?? Duration.zero;
      }
    }

    if (totalDuration.inHours == 0 && totalDuration.inMinutes == 0) return '';

    final hours = totalDuration.inHours;
    final minutes = totalDuration.inMinutes.remainder(60);
    return '$hours hrs $minutes mins';
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(
            FlutterFlowTheme.of(context).primary,
          ),
        ),
      );
    }

    return Container(
      width: widget.width,
      height: widget.height,
      decoration: BoxDecoration(
        color: FlutterFlowTheme.of(context).secondaryBackground,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          TableCalendar(
            firstDay: DateTime.utc(2024, 1, 1),
            lastDay: DateTime.utc(2025, 12, 31),
            focusedDay: _focusedDay,
            calendarFormat: _calendarFormat,
            selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _selectedDay = selectedDay;
                _focusedDay = focusedDay;
              });
            },
            onFormatChanged: (format) {
              setState(() {
                _calendarFormat = format;
              });
            },
            onPageChanged: (focusedDay) {
              _focusedDay = focusedDay;
              _loadAttendanceData();
            },
            calendarStyle: CalendarStyle(
              markersMaxCount: 1,
              markerDecoration: BoxDecoration(
                color: FlutterFlowTheme.of(context).primary,
                shape: BoxShape.circle,
              ),
              selectedDecoration: BoxDecoration(
                color: FlutterFlowTheme.of(context).primary,
                shape: BoxShape.circle,
              ),
              todayDecoration: BoxDecoration(
                color: FlutterFlowTheme.of(context).primary.withOpacity(0.2),
                shape: BoxShape.circle,
              ),
            ),
            headerStyle: HeaderStyle(
              formatButtonVisible: true,
              titleCentered: true,
              formatButtonShowsNext: false,
              formatButtonDecoration: BoxDecoration(
                color: FlutterFlowTheme.of(context).primary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              formatButtonTextStyle: TextStyle(
                color: FlutterFlowTheme.of(context).primary,
              ),
            ),
            calendarBuilders: CalendarBuilders(
              defaultBuilder: (context, date, _) {
                final totalHours = _getTotalHoursForDay(date);
                if (totalHours.isEmpty) return null;

                return Container(
                  margin: const EdgeInsets.only(top: 4),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        date.day.toString(),
                        style: FlutterFlowTheme.of(context).bodyMedium,
                      ),
                      const SizedBox(height: 2),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 4, vertical: 2),
                        decoration: BoxDecoration(
                          color: FlutterFlowTheme.of(context)
                              .primary
                              .withOpacity(0.1),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          totalHours,
                          style: TextStyle(
                            fontSize: 10,
                            color: FlutterFlowTheme.of(context).primary,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 16),
          if (_selectedDay != null) ...[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () => _recordAttendance(_selectedDay!, true),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: FlutterFlowTheme.of(context).primary,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    elevation: 2,
                  ),
                  child: Text(
                    'Check In',
                    style: FlutterFlowTheme.of(context).titleSmall.override(
                          fontFamily: 'Readex Pro',
                          color: Colors.white,
                        ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () => _recordAttendance(_selectedDay!, false),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: FlutterFlowTheme.of(context).primary,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    elevation: 2,
                  ),
                  child: Text(
                    'Check Out',
                    style: FlutterFlowTheme.of(context).titleSmall.override(
                          fontFamily: 'Readex Pro',
                          color: Colors.white,
                        ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: FlutterFlowTheme.of(context).primaryBackground,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Attendance Details for ${DateFormat('MMMM d, y').format(_selectedDay!)}',
                    style: FlutterFlowTheme.of(context).titleMedium,
                  ),
                  const SizedBox(height: 12),
                  ...(_attendanceEvents[_selectedDay!] ?? []).map((record) {
                    final duration = record.checkOut != null
                        ? record.checkOut!.difference(record.checkIn)
                        : _activeDurations[_selectedDay!] ?? Duration.zero;

                    return Card(
                      elevation: 2,
                      margin: const EdgeInsets.only(bottom: 8),
                      child: ListTile(
                        title: Text(
                          'Check-in: ${DateFormat('hh:mm a').format(record.checkIn)}',
                          style: FlutterFlowTheme.of(context).bodyMedium,
                        ),
                        subtitle: Text(
                          record.checkOut != null
                              ? 'Check-out: ${DateFormat('hh:mm a').format(record.checkOut!)}'
                              : 'Not checked out yet',
                          style: FlutterFlowTheme.of(context).bodySmall,
                        ),
                        trailing: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: FlutterFlowTheme.of(context)
                                .primary
                                .withOpacity(0.1),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            '${duration.inHours} hrs ${duration.inMinutes.remainder(60)} mins',
                            style: TextStyle(
                              color: FlutterFlowTheme.of(context).primary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class AttendanceRecord {
  final DateTime checkIn;
  final DateTime? checkOut;

  AttendanceRecord({
    required this.checkIn,
    this.checkOut,
  });
}
