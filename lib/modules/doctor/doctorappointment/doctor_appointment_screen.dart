import 'dart:async';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../routes/app_routes.dart';
import '../../../utils/app_text_style.dart';
import '../../../utils/device_utility.dart';
import '../../../utils/image_path.dart';
import '../../../utils/sizes.dart';
import '../../../utils/theme/colors/q_color.dart';
import '../widgets/appointment_card_widget.dart';

class DoctorAppointments extends StatefulWidget {
  const DoctorAppointments({super.key});

  @override
  State<DoctorAppointments> createState() => _DoctorAppointmentsState();
}

class _DoctorAppointmentsState extends State<DoctorAppointments> {
  late Timer _timer;
  late String _currentDateTime;
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  // Sample appointment data
  final List<Map<String, String>> _allAppointments = [
    {
      'patientName': 'John Doe',
      'day': 'Wednesday',
      'date': '08 Oct 2025',
      'time': 'Time : 09:30 AM',
      'status': 'Completed',
    },
    {
      'patientName': 'Mary Okpe',
      'day': 'Thursday',
      'date': '09 Oct 2025',
      'time': 'Time : 09:30 AM',
      'status': 'Pending',
    },
    {
      'patientName': 'Mikel Chinwike',
      'day': 'Wednesday',
      'date': '08 Oct 2025',
      'time': 'Time : 09:30 AM',
      'status': 'Rejected',
    },
    {
      'patientName': 'Sarah Johnson',
      'day': 'Friday',
      'date': '10 Oct 2025',
      'time': 'Time : 10:00 AM',
      'status': 'Pending',
    },
    {
      'patientName': 'David Smith',
      'day': 'Friday',
      'date': '10 Oct 2025',
      'time': 'Time : 02:00 PM',
      'status': 'Completed',
    },
    {
      'patientName': 'Emma Wilson',
      'day': 'Monday',
      'date': '13 Oct 2025',
      'time': 'Time : 11:30 AM',
      'status': 'Cancelled',
    },
  ];

  @override
  void initState() {
    super.initState();
    _updateDateTime();
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      _updateDateTime();
    });

    _searchController.addListener(() {
      setState(() {
        _searchQuery = _searchController.text.toLowerCase();
      });
    });
  }

  void _updateDateTime() {
    final now = DateTime.now();
    final dateFormat = DateFormat('EEE d MMM yyyy | HH:mm:ss');
    setState(() {
      _currentDateTime = dateFormat.format(now);
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    _searchController.dispose();
    super.dispose();
  }

  // Filter appointments based on search query
  List<Map<String, String>> get _filteredAppointments {
    if (_searchQuery.isEmpty) {
      return _allAppointments;
    }

    return _allAppointments.where((appointment) {
      final patientName = appointment['patientName']!.toLowerCase();
      final date = appointment['date']!.toLowerCase();
      final status = appointment['status']!.toLowerCase();
      final day = appointment['day']!.toLowerCase();

      return patientName.contains(_searchQuery) ||
          date.contains(_searchQuery) ||
          status.contains(_searchQuery) ||
          day.contains(_searchQuery);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    bool isDark = TDeviceUtils.isDarkMode(context);

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
            child: Column(
              children: [
                /// TOP BAR WITH PROFILE, SEARCH, NOTIFICATION
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () {
                        AppRouter.router.push('/doctorProfileScreen');
                      },
                      child: CircleAvatar(
                        radius: 20,
                        backgroundImage: AssetImage(QImagesPath.profile),
                      ),
                    ),
                    SizedBox(width: 2),

                    /// SEARCH FIELD
                    SizedBox(
                      height: 38,
                      width: 230,
                      child: Center(
                        child: TextField(
                          controller: _searchController,
                          cursorColor: Colors.black,
                          decoration: InputDecoration(
                            hintText: "Search Appointments",
                            hintStyle: TAppTextStyle.inter(
                              weight: FontWeight.w400,
                              color: QColors.lightGray400,
                              fontSize: QSizes.fontSizeSmx,
                            ),
                            suffixIcon: _searchQuery.isNotEmpty
                                ? IconButton(
                              icon: Icon(
                                Icons.clear,
                                color: QColors.lightTextColor,
                                size: 20,
                              ),
                              onPressed: () {
                                _searchController.clear();
                              },
                            )
                                : Icon(
                              Icons.search,
                              color: QColors.lightTextColor,
                              size: 22,
                            ),
                            suffixIconConstraints: BoxConstraints(
                              minWidth: 40,
                              minHeight: 20,
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(
                                color: QColors.progressLight,
                                width: 1,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(
                                color: QColors.progressLight,
                                width: 2,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),

                    /// NOTIFICATION ICON
                    IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.notifications_none,
                        color: QColors.progressLight,
                        size: 30,
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 20),

                /// REAL-TIME CLOCK
                Center(
                  child: Text(
                    "Today: $_currentDateTime",
                    style: TAppTextStyle.inter(
                      color: QColors.lightTextColor,
                      fontSize: 20,
                      weight: FontWeight.w400,
                    ),
                  ),
                ),

                SizedBox(height: 20),

                /// SEARCH RESULTS INFO
                if (_searchQuery.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Search Results: ${_filteredAppointments.length}",
                          style: TAppTextStyle.inter(
                            color: QColors.lightTextColor,
                            fontSize: 16,
                            weight: FontWeight.w500,
                          ),
                        ),
                        if (_searchQuery.isNotEmpty)
                          TextButton(
                            onPressed: () {
                              _searchController.clear();
                            },
                            child: Text(
                              "Clear Search",
                              style: TAppTextStyle.inter(
                                color: QColors.progressLight,
                                fontSize: 14,
                                weight: FontWeight.w500,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),

                SizedBox(height: 10),

                /// APPOINTMENTS LIST
                _filteredAppointments.isEmpty
                    ? _buildEmptyState()
                    : Column(
                  children: _filteredAppointments.map((appointment) {
                    return AppointmentCardWidget(
                      patientName: appointment['patientName']!,
                      day: appointment['day']!,
                      date: appointment['date']!,
                      time: appointment['time']!,
                      status: appointment['status']!,
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// EMPTY STATE WIDGET
  Widget _buildEmptyState() {
    return Container(
      padding: EdgeInsets.all(40),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.search_off,
            size: 80,
            color: Colors.grey.shade400,
          ),
          SizedBox(height: 20),
          Text(
            _searchQuery.isNotEmpty
                ? "No appointments found for '$_searchQuery'"
                : "No appointments available",
            textAlign: TextAlign.center,
            style: TAppTextStyle.inter(
              color: Colors.grey.shade600,
              fontSize: 16,
              weight: FontWeight.w500,
            ),
          ),
          if (_searchQuery.isNotEmpty) ...[
            SizedBox(height: 10),
            TextButton(
              onPressed: () {
                _searchController.clear();
              },
              child: Text(
                "Clear Search",
                style: TAppTextStyle.inter(
                  color: QColors.progressLight,
                  fontSize: 14,
                  weight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}