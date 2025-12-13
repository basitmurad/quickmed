import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import 'package:quickmed/data/models/models/DoctorModel.dart';
import '../../../utils/app_text_style.dart';
import '../../../utils/device_utility.dart';
import '../../../utils/theme/colors/q_color.dart';
import '../../../utils/widgets/TButton.dart';
import '../../provider/DoctorProvider.dart';

// Main Screen
class SystemSuggestingDoctorScreen extends StatelessWidget {
  const SystemSuggestingDoctorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Remove ChangeNotifierProvider - it should be provided higher up in the widget tree
    return const _SystemSuggestingDoctorScreenContent();
  }
}

class _SystemSuggestingDoctorScreenContent extends StatelessWidget {
  const _SystemSuggestingDoctorScreenContent();

  @override
  Widget build(BuildContext context) {
    final bool isDark = TDeviceUtils.isDarkMode(context);

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

              /// Doctor List, Loading, or Error
              Expanded(
                child: Consumer<DoctorProvider>(
                  builder: (context, provider, child) {
                    // Loading State
                    if (provider.isLoading) {
                      return Center(
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
                      );
                    }

                    // Error State
                    if (provider.hasError) {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.error_outline,
                              size: 64,
                              color: Colors.red.withOpacity(0.5),
                            ),
                            const SizedBox(height: 16),
                            Text(
                              "Oops! Something went wrong",
                              style: TAppTextStyle.inter(
                                fontSize: 18,
                                weight: FontWeight.w600,
                                color: isDark ? Colors.white : Colors.black,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 32),
                              child: Text(
                                provider.errorMessage ?? "Unknown error occurred",
                                textAlign: TextAlign.center,
                                style: TAppTextStyle.inter(
                                  fontSize: 14,
                                  weight: FontWeight.w400,
                                  color: isDark ? Colors.white70 : Colors.black54,
                                ),
                              ),
                            ),
                            const SizedBox(height: 24),
                            ElevatedButton.icon(
                              onPressed: () {
                                provider.clearError();
                                // Optionally retry the search
                              },
                              icon: const Icon(Icons.refresh),
                              label: const Text("Try Again"),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: QColors.newPrimary500,
                                foregroundColor: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      );
                    }

                    // Empty State
                    if (provider.doctors.isEmpty) {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.search_off,
                              size: 64,
                              color: isDark ? Colors.white38 : Colors.black38,
                            ),
                            const SizedBox(height: 16),
                            Text(
                              "No doctors found",
                              style: TAppTextStyle.inter(
                                fontSize: 18,
                                weight: FontWeight.w600,
                                color: isDark ? Colors.white : Colors.black,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              "Try searching with different symptoms",
                              style: TAppTextStyle.inter(
                                fontSize: 14,
                                weight: FontWeight.w400,
                                color: isDark ? Colors.white70 : Colors.black54,
                              ),
                            ),
                          ],
                        ),
                      );
                    }

                    // Success State - Show Doctor List
                    return Column(
                      children: [
                        // Results count
                        Padding(
                          padding: const EdgeInsets.only(bottom: 12),
                          child: Text(
                            "Found ${provider.totalCount} doctor${provider.totalCount != 1 ? 's' : ''}",
                            style: TAppTextStyle.inter(
                              fontSize: 14,
                              weight: FontWeight.w500,
                              color: isDark ? Colors.white70 : Colors.black54,
                            ),
                          ),
                        ),

                        // Doctor list
                        Expanded(
                          child: ListView.builder(
                            itemCount: provider.doctors.length,
                            itemBuilder: (context, index) {
                              final doctor = provider.doctors[index];
                              final isSelected = provider.selectedDoctorId == doctor.id.toString();

                              return DoctorCard(
                                doctor: doctor,
                                isSelected: isSelected,
                                isDark: isDark,
                                onTap: () {
                                  provider.selectDoctor(doctor.id.toString());
                                },
                              );
                            },
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),

              /// Book Appointment Button
              Consumer<DoctorProvider>(
                builder: (context, provider, child) {
                  if (provider.isLoading || provider.selectedDoctorId == null) {
                    return const SizedBox.shrink();
                  }

                  return Padding(
                    padding: const EdgeInsets.only(top: 12),
                    child: QButton(
                      text: "Book Appointment",
                      onPressed: () {
                        final selectedDoctor = provider.selectedDoctor;
                        if (selectedDoctor != null) {
                          context.push(
                            '/selectAppointmentScreen',
                            extra: {
                              'doctorId': selectedDoctor.id,
                              'doctorName': selectedDoctor.fullName,
                              'specialization': selectedDoctor.specialization,
                              'location': selectedDoctor.location,
                              'email': selectedDoctor.email,
                              'imageUrl': selectedDoctor.imageUrl,
                              // Add other fields as needed
                            },
                          );
                        }
                      },
                    ),
                  );
                },
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
  final DoctorModel doctor;
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
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: doctor.imageUrl.isNotEmpty
                    ? Image.network(
                  doctor.imageUrl,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Icon(
                      Icons.person,
                      size: 40,
                      color: QColors.newPrimary500,
                    );
                  },
                )
                    : Icon(
                  Icons.person,
                  size: 40,
                  color: QColors.newPrimary500,
                ),
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
                    doctor.fullName,
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

                  /// Location
                  Row(
                    children: [
                      Icon(
                        Icons.location_on_outlined,
                        size: 14,
                        color: isDark ? Colors.white70 : Colors.black54,
                      ),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          doctor.location,
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

                  /// Match Score
                  if (doctor.matchScore > 0)
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: _getMatchScoreColor(doctor.matchScore).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.verified,
                            size: 12,
                            color: _getMatchScoreColor(doctor.matchScore),
                          ),
                          const SizedBox(width: 4),
                          Text(
                            "${doctor.matchScore}% Match",
                            style: TAppTextStyle.inter(
                              fontSize: 11,
                              weight: FontWeight.w600,
                              color: _getMatchScoreColor(doctor.matchScore),
                            ),
                          ),
                        ],
                      ),
                    ),

                  const SizedBox(height: 8),

                  /// Symptoms covered
                  if (doctor.symptomsList.isNotEmpty)
                    Wrap(
                      spacing: 4,
                      runSpacing: 4,
                      children: doctor.symptomsList.take(3).map((symptom) {
                        return Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 6,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: isDark
                                ? Colors.grey[800]
                                : Colors.grey[200],
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            symptom,
                            style: TAppTextStyle.inter(
                              fontSize: 10,
                              weight: FontWeight.w400,
                              color: isDark ? Colors.white70 : Colors.black54,
                            ),
                          ),
                        );
                      }).toList(),
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

  Color _getMatchScoreColor(int score) {
    if (score >= 80) return Colors.green;
    if (score >= 60) return Colors.orange;
    return Colors.red;
  }
}