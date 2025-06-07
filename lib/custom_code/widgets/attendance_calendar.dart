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

import 'index.dart'; // Imports other custom widgets

import 'index.dart'; // Imports other custom widgets
import 'package:cloud_firestore/cloud_firestore.dart';

import 'index.dart'; // Imports other custom widgets

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
  DateTime? _selectedDay = DateTime.now();
  Map<DateTime, List<AttendanceRecord>> _attendanceEvents = {};
  bool _isLoading = true;
  Timer? _timer;
  Map<DateTime, Duration> _activeDurations = {};
  Map<String, dynamic> _monthlySummary = {};
  String _currentMonthKey = '';

  @override
  void initState() {
    super.initState();
    _loadAttendanceData();
    _loadMonthlySummary(DateTime.now());
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
      Duration totalActive = Duration.zero;
      for (var record in entry.value) {
        if (record.checkOut == null) {
          totalActive += now.difference(record.checkIn);
        }
      }
      if (totalActive > Duration.zero) {
        newDurations[entry.key] = totalActive;
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

  Future<void> _loadMonthlySummary(DateTime date) async {
    if (widget.userId == null) return;
    final monthKey = "${date.year}-${date.month.toString().padLeft(2, '0')}";
    final summaryDocId = "${widget.userId}_$monthKey";
    final summaryRef = FirebaseFirestore.instance
        .collection('attendance_summaries')
        .doc(summaryDocId);
    final doc = await summaryRef.get();
    if (doc.exists) {
      setState(() {
        _monthlySummary = doc.data() ?? {};
        _currentMonthKey = monthKey;
      });
    } else {
      setState(() {
        _monthlySummary = {};
        _currentMonthKey = monthKey;
      });
    }
  }

  Future<void> updateTodayAndMonthAttendanceSummary(
      String userId, DateTime date) async {
    final monthKey = "${date.year}-${date.month.toString().padLeft(2, '0')}";
    final docId = "${userId}_$monthKey";
    final summaryRef = FirebaseFirestore.instance
        .collection('attendance_summaries')
        .doc(docId);

    // Get today's date string
    final todayString =
        "${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";

    // Fetch all attendance records for this user for the month
    final startOfMonth = DateTime(date.year, date.month, 1);
    final endOfMonth = DateTime(date.year, date.month + 1, 0);
    final attendanceRef = FirebaseFirestore.instance.collection('attendance');
    final querySnapshot = await attendanceRef
        .where('userId', isEqualTo: userId)
        .where('date', isGreaterThanOrEqualTo: Timestamp.fromDate(startOfMonth))
        .where('date', isLessThanOrEqualTo: Timestamp.fromDate(endOfMonth))
        .get();

    // Prepare monthly summary
    int totalMinutes = 0;
    int totalDaysWorked = 0;
    int regularDays = 0;
    int overtimeMinutes = 0;
    int regularMinutesThisMonth = 0;
    int overtimeMinutesThisMonth = 0;

    // Prepare today's summary
    int dayMinutes = 0;
    DateTime? firstIn;
    DateTime? lastOut;
    bool hasActiveCheckIn = false;
    DateTime? activeCheckInTime;

    // Group records by day
    Map<String, List<Map<String, dynamic>>> dailyRecords = {};
    for (var doc in querySnapshot.docs) {
      final data = doc.data();
      final dateObj = (data['date'] as Timestamp).toDate();
      final dayKey =
          "${dateObj.year}-${dateObj.month.toString().padLeft(2, '0')}-${dateObj.day.toString().padLeft(2, '0')}";
      dailyRecords.putIfAbsent(dayKey, () => []).add(data);
    }

    for (var entry in dailyRecords.entries) {
      int thisDayMinutes = 0;
      DateTime? thisFirstIn;
      DateTime? thisLastOut;
      bool thisHasActiveCheckIn = false;
      DateTime? thisActiveCheckInTime;
      for (var record in entry.value) {
        final checkIn = (record['checkIn'] as Timestamp).toDate();
        final checkOut = record['checkOut'] != null
            ? (record['checkOut'] as Timestamp).toDate()
            : null;
        if (checkOut != null) {
          thisDayMinutes += checkOut.difference(checkIn).inMinutes;
          if (thisFirstIn == null || checkIn.isBefore(thisFirstIn))
            thisFirstIn = checkIn;
          if (thisLastOut == null || checkOut.isAfter(thisLastOut))
            thisLastOut = checkOut;
        } else {
          thisHasActiveCheckIn = true;
          if (thisActiveCheckInTime == null ||
              checkIn.isBefore(thisActiveCheckInTime))
            thisActiveCheckInTime = checkIn;
          if (thisFirstIn == null || checkIn.isBefore(thisFirstIn))
            thisFirstIn = checkIn;
        }
      }
      bool isRegular = thisDayMinutes >= 480;
      int overtime = isRegular ? (thisDayMinutes - 480) : 0;

      if (thisDayMinutes > 0) {
        totalMinutes += thisDayMinutes;
        totalDaysWorked += 1;
        if (isRegular) regularDays += 1;
        overtimeMinutes += overtime;
        // Calculate regular and overtime work minutes for the month
        if (thisDayMinutes > 480) {
          regularMinutesThisMonth += 480;
          overtimeMinutesThisMonth += (thisDayMinutes - 480);
        } else {
          regularMinutesThisMonth += thisDayMinutes;
        }
      }

      // If this is today, set today's summary
      if (entry.key == todayString) {
        dayMinutes = thisDayMinutes;
        firstIn = thisFirstIn;
        lastOut = thisLastOut;
        hasActiveCheckIn = thisHasActiveCheckIn;
        activeCheckInTime = thisActiveCheckInTime;
      }
    }

    bool isRegularToday = dayMinutes >= 480;
    int overtimeToday = isRegularToday ? (dayMinutes - 480) : 0;
    double totalWorkHours = totalMinutes / 60.0;
    double regularWorkHours = regularMinutesThisMonth / 60.0;
    double overtimeWorkHours = overtimeMinutesThisMonth / 60.0;

    await summaryRef.set({
      "userId": userId,
      "month": monthKey,
      "date": todayString,
      "minutesWorked": dayMinutes,
      "clockInTime": hasActiveCheckIn
          ? activeCheckInTime?.toIso8601String()
          : firstIn?.toIso8601String(),
      "clockOutTime": lastOut?.toIso8601String(),
      "status": hasActiveCheckIn
          ? "working"
          : (dayMinutes > 0 ? "worked" : "not working"),
      "overtime": overtimeToday,
      "isRegular": isRegularToday,
      "lastUpdated": FieldValue.serverTimestamp(),
      // Monthly summary:
      "totalMinutesWorked": totalMinutes,
      "totalWorkHours": totalWorkHours,
      "regularWorkHours": regularWorkHours,
      "overtimeWorkHours": overtimeWorkHours,
      "totalDaysWorked": totalDaysWorked,
      "regularDays": regularDays,
      "overtimeMinutes": overtimeMinutes,
    }, SetOptions(merge: true));
  }

  Future<void> _recordAttendance(DateTime date, bool isCheckIn) async {
    if (widget.userId == null) return;
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final selectedDate = DateTime(date.year, date.month, date.day);
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
        // After check-in, set firstCheckInTime to earliest for today (only if not set or earlier)
        final monthKey = "${now.year}-${now.month.toString().padLeft(2, '0')}";
        final docId = "${widget.userId}_$monthKey";
        final summaryRef = FirebaseFirestore.instance
            .collection('attendance_summaries')
            .doc(docId);
        final summaryDoc = await summaryRef.get();
        DateTime? existingFirstCheckIn;
        if (summaryDoc.exists &&
            summaryDoc.data()?['firstCheckInTime'] != null) {
          existingFirstCheckIn =
              DateTime.tryParse(summaryDoc.data()!['firstCheckInTime']);
        }
        DateTime newCheckInTime = now;
        DateTime? firstCheckInToSet = existingFirstCheckIn;
        if (existingFirstCheckIn == null ||
            newCheckInTime.isBefore(existingFirstCheckIn)) {
          firstCheckInToSet = newCheckInTime;
        }
        await summaryRef.set({
          "clockOutTime": null,
          "clockInTime": firstCheckInToSet?.toIso8601String(),
          "firstCheckInTime": firstCheckInToSet?.toIso8601String(),
        }, SetOptions(merge: true));
      } else {
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
        // After check-out, set lastCheckOutTime to latest for today (only if not set or later)
        final monthKey = "${now.year}-${now.month.toString().padLeft(2, '0')}";
        final docId = "${widget.userId}_$monthKey";
        final summaryRef = FirebaseFirestore.instance
            .collection('attendance_summaries')
            .doc(docId);
        final summaryDoc = await summaryRef.get();
        DateTime? existingLastCheckOut;
        if (summaryDoc.exists &&
            summaryDoc.data()?['lastCheckOutTime'] != null) {
          existingLastCheckOut =
              DateTime.tryParse(summaryDoc.data()!['lastCheckOutTime']);
        }
        DateTime newCheckOutTime = now;
        DateTime? lastCheckOutToSet = existingLastCheckOut;
        if (existingLastCheckOut == null ||
            newCheckOutTime.isAfter(existingLastCheckOut)) {
          lastCheckOutToSet = newCheckOutTime;
        }
        await summaryRef.set({
          "lastCheckOutTime": lastCheckOutToSet?.toIso8601String(),
          "clockOutTime": lastCheckOutToSet?.toIso8601String(),
        }, SetOptions(merge: true));
      }
      await _loadAttendanceData();
      await updateTodayAndMonthAttendanceSummary(
          widget.userId!, DateTime.now());
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
    final dayKey =
        "${day.year}-${day.month.toString().padLeft(2, '0')}-${day.day.toString().padLeft(2, '0')}";
    final dailySummaries = _monthlySummary['dailySummaries'] ?? {};
    if (dailySummaries[dayKey] == null) return '';
    final minutes = dailySummaries[dayKey]['minutesWorked'] ?? 0;
    if (minutes == 0) return '';
    final hours = minutes ~/ 60;
    final mins = minutes % 60;
    return hours > 0
        ? '${hours.toString().padLeft(2, '0')}:${mins.toString().padLeft(2, '0')}'
        : '${mins.toString().padLeft(2, '0')} mins';
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

    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final isTodaySelected = _selectedDay != null &&
        _selectedDay!.year == today.year &&
        _selectedDay!.month == today.month &&
        _selectedDay!.day == today.day;

    // Determine if user has active check-in for today
    bool hasActiveCheckIn = false;
    if (_attendanceEvents[today] != null) {
      hasActiveCheckIn =
          _attendanceEvents[today]!.any((record) => record.checkOut == null);
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
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TableCalendar(
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
                _loadMonthlySummary(focusedDay);
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
          ),
          const SizedBox(height: 16),
          if (_selectedDay != null) ...[
            if (isTodaySelected) ...[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  if (!hasActiveCheckIn)
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
                  if (hasActiveCheckIn)
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
            ],
            Expanded(
              child: SingleChildScrollView(
                child: Container(
                  margin: const EdgeInsets.all(8),
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
                      ...(_attendanceEvents[DateTime(
                                _selectedDay!.year,
                                _selectedDay!.month,
                                _selectedDay!.day,
                              )] ??
                              [])
                          .map((record) {
                        final duration = record.checkOut != null
                            ? record.checkOut!.difference(record.checkIn)
                            : DateTime.now().difference(record.checkIn);

                        return Card(
                          elevation: 0,
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
