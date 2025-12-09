// import 'dart:math' show cos, sin, pi;
//
// import 'package:flutter/material.dart';
// import '../../../utils/app_text_style.dart';
// import '../../../utils/device_utility.dart';
// import '../../../utils/theme/colors/q_color.dart';
// import '../../../utils/widgets/TButton.dart';
//
// class SystemSuggestingDoctorScreen extends StatefulWidget {
//   const SystemSuggestingDoctorScreen({super.key});
//
//   @override
//   State<SystemSuggestingDoctorScreen> createState() =>
//       _SystemSuggestingDoctorScreenState();
// }
//
// class _SystemSuggestingDoctorScreenState
//     extends State<SystemSuggestingDoctorScreen>
//     with TickerProviderStateMixin {
//   late AnimationController _dotsController;
//
//   @override
//   void initState() {
//     super.initState();
//     _dotsController = AnimationController(
//       vsync: this,
//       duration: const Duration(milliseconds: 1200),
//     )..repeat();
//   }
//
//   @override
//   void dispose() {
//     _dotsController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final bool isDark = TDeviceUtils.isDarkMode(context);
//
//     return Scaffold(
//       body: SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 18),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               const SizedBox(height: 12),
//
//               /// Back button
//               GestureDetector(
//                 onTap: () => Navigator.pop(context),
//                 child: Row(
//                   children: [
//                     Icon(
//                       Icons.arrow_back,
//                       color: isDark ? Colors.white : Colors.black,
//                     ),
//                     const SizedBox(width: 6),
//                     Text(
//                       "Go Back",
//                       style: TAppTextStyle.inter(
//                         color: isDark ? Colors.white : Colors.black,
//                         fontSize: 16,
//                         weight: FontWeight.w500,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//
//               const SizedBox(height: 26),
//
//               /// Main title
//               Center(
//                 child: Text(
//                   "Book Appointment",
//                   style: TAppTextStyle.inter(
//                     fontSize: 20,
//                     weight: FontWeight.w600,
//                     color: isDark ? Colors.white : Colors.black,
//                   ),
//                 ),
//               ),
//
//               const SizedBox(height: 24),
//
//               /// Subtitle
//               Center(
//                 child: Text(
//                   "System AI suggesting Doctor",
//                   style: TAppTextStyle.inter(
//                     fontSize: 15,
//                     weight: FontWeight.w400,
//                     color: isDark ? Colors.white70 : Colors.black87,
//                   ),
//                 ),
//               ),
//               Expanded(
//                 child: Center(
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     children: [
//                       AnimatedBuilder(
//                         animation: _dotsController,
//                         builder: (context, child) {
//                           return SizedBox(
//                             width: 70,
//                             height: 70,
//                             child: Stack(
//                               alignment: Alignment.center,
//                               children: List.generate(8, (index) {
//                                 final angle = index * pi / 4;
//                                 final offset = _dotsController.value * 2 * pi;
//                                 final currentAngle = angle + offset;
//
//                                 const radius = 24.0;
//
//                                 final dx = radius * cos(currentAngle);
//                                 final dy = radius * sin(currentAngle);
//
//                                 final opacity = (1 + cos(currentAngle)) / 2;
//
//                                 return Positioned(
//                                   left: 35 + dx,
//                                   top: 35 + dy,
//                                   child: Container(
//                                     width: 8,
//                                     height: 8,
//                                     decoration: BoxDecoration(
//                                       color: QColors.newPrimary500
//                                           .withOpacity(opacity * 0.8),
//                                       shape: BoxShape.circle,
//                                     ),
//                                   ),
//                                 );
//                               }),
//                             ),
//                           );
//                         },
//                       ),
//
//                       const SizedBox(height: 12),
//
//                       Text(
//                         "Loading...",
//                         style: TAppTextStyle.inter(
//                           fontSize: 16,
//                           weight: FontWeight.w500,
//                           color: isDark ? Colors.white70 : Colors.black87,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//
//               /// Bottom button
//               const SizedBox(height: 20),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }



import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import '../../../utils/app_text_style.dart';
import '../../../utils/device_utility.dart';
import '../../../utils/theme/colors/q_color.dart';
import '../../../utils/widgets/TButton.dart';

// Doctor Model
class Doctor {
  final String id;
  final String name;
  final String specialization;
  final String experience;
  final String rating;
  final String availability;
  final String imageUrl;
  final String hospital;
  final String consultationFee;
  final String miles;

  Doctor({
    required this.id,
    required this.name,
    required this.specialization,
    required this.experience,
    required this.rating,
    required this.availability,
    required this.imageUrl,
    required this.hospital,
    required this.consultationFee,
    required this.miles,
  });
}

// Provider for Doctor Suggestion
class DoctorSuggestionProvider extends ChangeNotifier {
  bool _isLoading = true;
  List<Doctor> _suggestedDoctors = [];
  String? _selectedDoctorId;

  bool get isLoading => _isLoading;
  List<Doctor> get suggestedDoctors => _suggestedDoctors;
  String? get selectedDoctorId => _selectedDoctorId;

  Doctor? get selectedDoctor {
    if (_selectedDoctorId == null) return null;
    return _suggestedDoctors.firstWhere((doc) => doc.id == _selectedDoctorId);
  }

  DoctorSuggestionProvider() {
    _loadDoctors();
  }

  // Simulate loading doctors
  Future<void> _loadDoctors() async {
    _isLoading = true;
    notifyListeners();

    // Simulate API call delay
    await Future.delayed(Duration(seconds: 2));

    // Dummy doctor data
    _suggestedDoctors = [
      Doctor(
        id: '1',
        name: 'Dr. Sarah Johnson',
        specialization: 'Cardiologist',
        experience: '15 years',
        rating: '4.8',
        availability: 'Available Today',
        imageUrl: 'https://via.placeholder.com/150',
        hospital: 'City General Hospital',
        consultationFee: '\$80',
        miles: '1.8 miles',
      ),
      Doctor(
        id: '2',
        name: 'Dr. Michael Chen',
        specialization: 'General Physician',
        experience: '12 years',
        rating: '4.9',
        availability: 'Tomorrow 10:00 AM',
        imageUrl: 'https://via.placeholder.com/150',
        hospital: 'Metro Medical Center',
        consultationFee: '\$60',
        miles: '2.3 miles',
      ),
      Doctor(
        id: '3',
        name: 'Dr. Emily Roberts',
        specialization: 'Pulmonologist',
        experience: '10 years',
        rating: '4.7',
        availability: 'Available Today',
        imageUrl: 'https://via.placeholder.com/150',
        hospital: 'Hope Wellness Clinic',
        consultationFee: '\$75',
        miles: '3.1 miles',
      ),
      Doctor(
        id: '4',
        name: 'Dr. James Wilson',
        specialization: 'Internal Medicine',
        experience: '18 years',
        rating: '4.9',
        availability: 'Tomorrow 2:00 PM',
        imageUrl: 'https://via.placeholder.com/150',
        hospital: 'Central Hospital',
        consultationFee: '\$85',
        miles: '1.5 miles',
      ),
    ];

    _isLoading = false;
    notifyListeners();
  }

  void selectDoctor(String doctorId) {
    _selectedDoctorId = doctorId;
    notifyListeners();
  }

  void clearSelection() {
    _selectedDoctorId = null;
    notifyListeners();
  }
}

// Main Screen
class SystemSuggestingDoctorScreen extends StatelessWidget {
  const SystemSuggestingDoctorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => DoctorSuggestionProvider(),
      child: const _SystemSuggestingDoctorScreenContent(),
    );
  }
}

class _SystemSuggestingDoctorScreenContent extends StatelessWidget {
  const _SystemSuggestingDoctorScreenContent();

  @override
  Widget build(BuildContext context) {
    final bool isDark = TDeviceUtils.isDarkMode(context);
    final provider = Provider.of<DoctorSuggestionProvider>(context);

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 12),

              /// Back button
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Row(
                  children: [
                    Icon(
                      Icons.arrow_back,
                      color: isDark ? Colors.white : Colors.black,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      "Go Back",
                      style: TAppTextStyle.inter(
                        color: isDark ? Colors.white : Colors.black,
                        fontSize: 16,
                        weight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              /// Title
              Center(
                child: Text(
                  "Suggested Doctors",
                  style: TAppTextStyle.inter(
                    fontSize: 22,
                    weight: FontWeight.w600,
                    color: isDark ? Colors.white : Colors.black,
                  ),
                ),
              ),

              const SizedBox(height: 8),

              /// Subtitle
              Center(
                child: Text(
                  "Based on your symptoms",
                  style: TAppTextStyle.inter(
                    fontSize: 14,
                    weight: FontWeight.w400,
                    color: isDark ? Colors.white70 : Colors.black54,
                  ),
                ),
              ),

              const SizedBox(height: 24),

              /// Doctor List or Loading
              Expanded(
                child: provider.isLoading
                    ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(
                        color: QColors.newPrimary500,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        "Finding the best doctors for you...",
                        style: TAppTextStyle.inter(
                          fontSize: 14,
                          weight: FontWeight.w500,
                          color: isDark ? Colors.white70 : Colors.black54,
                        ),
                      ),
                    ],
                  ),
                )
                    : ListView.builder(
                  itemCount: provider.suggestedDoctors.length,
                  itemBuilder: (context, index) {
                    final doctor = provider.suggestedDoctors[index];
                    final isSelected = provider.selectedDoctorId == doctor.id;

                    return DoctorCard(
                      doctor: doctor,
                      isSelected: isSelected,
                      isDark: isDark,
                      onTap: () {
                        provider.selectDoctor(doctor.id);
                      },
                    );
                  },
                ),
              ),

              /// Book Appointment Button
              if (!provider.isLoading && provider.selectedDoctorId != null)
                Padding(
                  padding: const EdgeInsets.only(top: 12),
                  child: QButton(
                    text: "Book Appointment",
                    onPressed: () {
                      // Navigate to appointment selection screen with doctor data
                      final selectedDoctor = provider.selectedDoctor;
                      if (selectedDoctor != null) {
                        context.push(
                          '/selectAppointmentScreen',
                          extra: {
                            'doctorName': selectedDoctor.name,
                            'specialization': selectedDoctor.specialization,
                            'miles': selectedDoctor.miles,
                            'hospital': selectedDoctor.hospital,
                            'consultationFee': selectedDoctor.consultationFee,
                          },
                        );
                      }
                    },
                  ),
                ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}

// Doctor Card Widget
class DoctorCard extends StatelessWidget {
  final Doctor doctor;
  final bool isSelected;
  final bool isDark;
  final VoidCallback onTap;

  const DoctorCard({
    super.key,
    required this.doctor,
    required this.isSelected,
    required this.isDark,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected
              ? QColors.newPrimary500.withOpacity(0.1)
              : (isDark ? Colors.grey[850] : Colors.white),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected
                ? QColors.newPrimary500
                : (isDark ? Colors.grey[700]! : Colors.grey[300]!),
            width: isSelected ? 2 : 1,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Doctor Image
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: QColors.newPrimary500.withOpacity(0.2),
                image: DecorationImage(
                  image: NetworkImage(doctor.imageUrl),
                  fit: BoxFit.cover,
                  onError: (_, __) {},
                ),
              ),
              child: Icon(
                Icons.person,
                size: 40,
                color: QColors.newPrimary500,
              ),
            ),

            const SizedBox(width: 16),

            /// Doctor Details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// Name
                  Text(
                    doctor.name,
                    style: TAppTextStyle.inter(
                      fontSize: 16,
                      weight: FontWeight.w600,
                      color: isDark ? Colors.white : Colors.black,
                    ),
                  ),

                  const SizedBox(height: 4),

                  /// Specialization
                  Text(
                    doctor.specialization,
                    style: TAppTextStyle.inter(
                      fontSize: 14,
                      weight: FontWeight.w500,
                      color: QColors.newPrimary500,
                    ),
                  ),

                  const SizedBox(height: 8),

                  /// Experience & Rating Row
                  Row(
                    children: [
                      Icon(
                        Icons.work_outline,
                        size: 14,
                        color: isDark ? Colors.white70 : Colors.black54,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        doctor.experience,
                        style: TAppTextStyle.inter(
                          fontSize: 12,
                          weight: FontWeight.w400,
                          color: isDark ? Colors.white70 : Colors.black54,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Icon(
                        Icons.star,
                        size: 14,
                        color: Colors.amber,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        doctor.rating,
                        style: TAppTextStyle.inter(
                          fontSize: 12,
                          weight: FontWeight.w400,
                          color: isDark ? Colors.white70 : Colors.black54,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 8),

                  /// Hospital
                  Row(
                    children: [
                      Icon(
                        Icons.local_hospital_outlined,
                        size: 14,
                        color: isDark ? Colors.white70 : Colors.black54,
                      ),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          doctor.hospital,
                          style: TAppTextStyle.inter(
                            fontSize: 12,
                            weight: FontWeight.w400,
                            color: isDark ? Colors.white70 : Colors.black54,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 8),

                  /// Availability & Fee Row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      /// Availability
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.green.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          doctor.availability,
                          style: TAppTextStyle.inter(
                            fontSize: 11,
                            weight: FontWeight.w500,
                            color: Colors.green,
                          ),
                        ),
                      ),

                      /// Consultation Fee
                      Text(
                        doctor.consultationFee,
                        style: TAppTextStyle.inter(
                          fontSize: 14,
                          weight: FontWeight.w600,
                          color: QColors.newPrimary500,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            /// Selection Indicator
            if (isSelected)
              Icon(
                Icons.check_circle,
                color: QColors.newPrimary500,
                size: 24,
              ),
          ],
        ),
      ),
    );
  }
}