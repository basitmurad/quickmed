import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';

import '../../../routes/app_routes.dart';
import '../../../utils/app_text_style.dart';
import '../../../utils/image_path.dart';
import '../../../utils/sizes.dart';
import '../../../utils/theme/colors/q_color.dart';
import '../../../utils/widgets/TButton.dart';

class UpdateAvailabilityScreen extends StatefulWidget {
  const UpdateAvailabilityScreen({super.key});

  @override
  State<UpdateAvailabilityScreen> createState() => _UpdateAvailabilityScreenState();
}

class _UpdateAvailabilityScreenState extends State<UpdateAvailabilityScreen> {
  DateTime _selectedDay = DateTime.now();
  DateTime _focusedDay = DateTime.now();

  // Store booked dates (example data - replace with your actual data)
  final Set<DateTime> _bookedDates = {
    DateTime(2025, 10, 15),
    DateTime(2025, 10, 20),
    DateTime(2025, 10, 25),
  };

  // Store time slots for the selected date
  List<TimeSlot> _timeSlots = [];

  @override
  void initState() {
    super.initState();
    // Initialize with example time slots
    _timeSlots = [
      TimeSlot(startTime: TimeOfDay(hour: 9, minute: 0), endTime: TimeOfDay(hour: 11, minute: 0)),
      TimeSlot(startTime: TimeOfDay(hour: 14, minute: 0), endTime: TimeOfDay(hour: 16, minute: 0)),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          "Update Availability",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
            child: Column(
              children: [
                const Text(
                  "Select Date & Set Time Slots",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 20),

                /// ---------------- CALENDAR ----------------
                _buildCalendar(),

                SizedBox(height: 20),

                Text(
                  "Selected Date: ${DateFormat('d MMM yyyy').format(_selectedDay)}",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                    color: Colors.black87,
                  ),
                ),

                SizedBox(height: 25),

                Text(
                  "Set Time Slots",
                  style: TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.w700,
                  ),
                ),

                SizedBox(height: 12),

                /// ---------------- TIME SLOTS LIST ----------------
                _timeSlots.isEmpty
                    ? _buildEmptyTimeSlots()
                    : _buildTimeSlotsList(),

                SizedBox(height: 20),

                /// ---------------- ADD ANOTHER SLOT ----------------
                GestureDetector(
                  onTap: _addTimeSlot,
                  child: Text(
                    "+ Add Another Time Slot",
                    style: TextStyle(
                      color: Colors.blue.shade600,
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),

                SizedBox(height: 40),

                QButton(
                  text: 'Confirm',
                  onPressed: _confirmAvailability,
                ),

                const SizedBox(height: 26)
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// ---------------- CALENDAR WIDGET ----------------
  Widget _buildCalendar() {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(12),
      ),
      child: TableCalendar(
        firstDay: DateTime.now(),
        lastDay: DateTime.now().add(Duration(days: 365)),
        focusedDay: _focusedDay,
        selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
        calendarFormat: CalendarFormat.month,
        startingDayOfWeek: StartingDayOfWeek.monday,
        onDaySelected: (selectedDay, focusedDay) {
          setState(() {
            _selectedDay = selectedDay;
            _focusedDay = focusedDay;
          });
        },
        calendarStyle: CalendarStyle(
          selectedDecoration: BoxDecoration(
            color: QColors.progressLight,
            shape: BoxShape.circle,
          ),
          todayDecoration: BoxDecoration(
            color: Colors.blue.shade200,
            shape: BoxShape.circle,
          ),
          markerDecoration: BoxDecoration(
            color: Colors.red,
            shape: BoxShape.circle,
          ),
        ),
        headerStyle: HeaderStyle(
          formatButtonVisible: false,
          titleCentered: true,
          titleTextStyle: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        // Highlight booked dates
        calendarBuilders: CalendarBuilders(
          defaultBuilder: (context, day, focusedDay) {
            if (_isBooked(day)) {
              return Container(
                margin: EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: Colors.orange.shade100,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    '${day.day}',
                    style: TextStyle(color: Colors.orange.shade900),
                  ),
                ),
              );
            }
            return null;
          },
        ),
      ),
    );
  }

  /// ---------------- TIME SLOTS LIST ----------------
  Widget _buildTimeSlotsList() {
    return Column(
      children: _timeSlots.asMap().entries.map((entry) {
        int index = entry.key;
        TimeSlot slot = entry.value;
        return _buildTimeSlotTile(slot, index);
      }).toList(),
    );
  }

  /// ---------------- EMPTY TIME SLOTS ----------------
  Widget _buildEmptyTimeSlots() {
    return Container(
      padding: EdgeInsets.all(20),
      child: Text(
        "No time slots added yet",
        style: TextStyle(
          color: Colors.grey,
          fontSize: 16,
          fontStyle: FontStyle.italic,
        ),
      ),
    );
  }

  /// ---------------- TIME SLOT TILE UI ----------------
  Widget _buildTimeSlotTile(TimeSlot slot, int index) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      margin: EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        border: Border.all(color: Color(0xffd9d9d9)),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              "${_formatTimeOfDay(slot.startTime)} - ${_formatTimeOfDay(slot.endTime)}",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
            ),
          ),
          Row(
            children: [
              IconButton(
                icon: Icon(Icons.edit, color: Colors.blue, size: 20),
                onPressed: () => _editTimeSlot(index),
              ),
              IconButton(
                icon: Icon(Icons.delete, color: Colors.red, size: 20),
                onPressed: () => _deleteTimeSlot(index),
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// ---------------- ADD TIME SLOT ----------------
  void _addTimeSlot() async {
    TimeSlot? newSlot = await _showTimeSlotDialog();
    if (newSlot != null) {
      setState(() {
        _timeSlots.add(newSlot);
      });
    }
  }

  /// ---------------- EDIT TIME SLOT ----------------
  void _editTimeSlot(int index) async {
    TimeSlot? editedSlot = await _showTimeSlotDialog(existingSlot: _timeSlots[index]);
    if (editedSlot != null) {
      setState(() {
        _timeSlots[index] = editedSlot;
      });
    }
  }

  /// ---------------- DELETE TIME SLOT ----------------
  void _deleteTimeSlot(int index) {
    setState(() {
      _timeSlots.removeAt(index);
    });
  }

  /// ---------------- TIME SLOT DIALOG ----------------
  Future<TimeSlot?> _showTimeSlotDialog({TimeSlot? existingSlot}) async {
    TimeOfDay? startTime = existingSlot?.startTime ?? TimeOfDay(hour: 9, minute: 0);
    TimeOfDay? endTime = existingSlot?.endTime ?? TimeOfDay(hour: 11, minute: 0);

    return showDialog<TimeSlot>(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Text(existingSlot == null ? 'Add Time Slot' : 'Edit Time Slot'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ListTile(
                    title: Text('Start Time'),
                    subtitle: Text(_formatTimeOfDay(startTime!)),
                    trailing: Icon(Icons.access_time),
                    onTap: () async {
                      TimeOfDay? picked = await showTimePicker(
                        context: context,
                        initialTime: startTime!,
                      );
                      if (picked != null) {
                        setState(() {
                          startTime = picked;
                        });
                      }
                    },
                  ),
                  SizedBox(height: 16),
                  ListTile(
                    title: Text('End Time'),
                    subtitle: Text(_formatTimeOfDay(endTime!)),
                    trailing: Icon(Icons.access_time),
                    onTap: () async {
                      TimeOfDay? picked = await showTimePicker(
                        context: context,
                        initialTime: endTime!,
                      );
                      if (picked != null) {
                        setState(() {
                          endTime = picked;
                        });
                      }
                    },
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text('Cancel'),
                ),
                ElevatedButton(
                  onPressed: () {
                    if (_isValidTimeSlot(startTime!, endTime!)) {
                      Navigator.pop(
                        context,
                        TimeSlot(startTime: startTime!, endTime: endTime!),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('End time must be after start time'),
                          backgroundColor: Colors.red,
                        ),
                      );
                    }
                  },
                  child: Text('Save'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  /// ---------------- CONFIRM AVAILABILITY ----------------
  void _confirmAvailability() {
    if (_timeSlots.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please add at least one time slot'),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }

    // Here you would typically save to your backend/database
    print("Selected Date: ${DateFormat('d MMM yyyy').format(_selectedDay)}");
    print("Time Slots:");
    for (var slot in _timeSlots) {
      print("  ${_formatTimeOfDay(slot.startTime)} - ${_formatTimeOfDay(slot.endTime)}");
    }

    AppRouter.router.push('/availabilityUpdatedScreen');
  }

  /// ---------------- HELPER METHODS ----------------
  bool _isBooked(DateTime day) {
    return _bookedDates.any((bookedDate) =>
    bookedDate.year == day.year &&
        bookedDate.month == day.month &&
        bookedDate.day == day.day);
  }

  String _formatTimeOfDay(TimeOfDay time) {
    final hour = time.hourOfPeriod == 0 ? 12 : time.hourOfPeriod;
    final minute = time.minute.toString().padLeft(2, '0');
    final period = time.period == DayPeriod.am ? 'AM' : 'PM';
    return '$hour:$minute $period';
  }

  bool _isValidTimeSlot(TimeOfDay start, TimeOfDay end) {
    final startMinutes = start.hour * 60 + start.minute;
    final endMinutes = end.hour * 60 + end.minute;
    return endMinutes > startMinutes;
  }
}

/// ---------------- TIME SLOT MODEL ----------------
class TimeSlot {
  final TimeOfDay startTime;
  final TimeOfDay endTime;

  TimeSlot({required this.startTime, required this.endTime});
}