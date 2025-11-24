import 'package:flutter/material.dart';
import 'package:icsa_mobile_app/src/core/theme/app_text_styles.dart';
import 'package:icsa_mobile_app/src/features/admin/presentation/widgets/admin_module_card.dart';

class AdminCardSection extends StatelessWidget {
  const AdminCardSection({super.key});

  // CRUD OPERATIONS FOR STUDENTS, EVENTS, ANNOUNCEMENTS, CLEARANCE, FINES, AND PAYMENT
  @override
  Widget build(BuildContext context) {
    // For this template, we'll just create a fixed number of items
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Admin Modules",
          style: AppTextStyles.heading2,
          textAlign: TextAlign.left,
        ),
        SizedBox(height: 16),
        const SizedBox(
          width: double.maxFinite,
          child: AdminModuleCard(
            location: "/admin/students",
            title: "Student Admin Module",
          ),
        ),
        SizedBox(height: 16),
        const SizedBox(
          width: double.maxFinite,
          child: AdminModuleCard(
            location: "/admin/fines",
            title: "Fines Admin Module",
          ),
        ),
        SizedBox(height: 16),
        const SizedBox(
          width: double.maxFinite,
          child: AdminModuleCard(
            location: "/admin/events",
            title: "Events Admin Module",
          ),
        ),
        SizedBox(height: 16),
        const SizedBox(
          width: double.maxFinite,
          child: AdminModuleCard(
            location: "/admin/announcements",
            title: "Announcements Admin Module",
          ),
        ),
        SizedBox(height: 16),
        const SizedBox(
          width: double.maxFinite,
          child: AdminModuleCard(
            location: "/admin/clearance",
            title: "Clearance Admin Module",
          ),
        ),
      ],
    );
  }
}
