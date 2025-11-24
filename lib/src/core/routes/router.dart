// lib/config/router.dart
import 'package:go_router/go_router.dart';
import 'package:icsa_mobile_app/src/common/widgets/no_page_found.dart';
import 'package:icsa_mobile_app/src/common/widgets/unaunthenticated_page.dart';
import 'package:icsa_mobile_app/src/features/admin/presentation/pages/admin_dashboard.dart';
import 'package:icsa_mobile_app/src/features/announcements/presentation/pages/admin_announcement_page.dart';
import 'package:icsa_mobile_app/src/features/announcements/presentation/pages/announcements_page.dart';
import 'package:icsa_mobile_app/src/features/announcements/presentation/pages/create_announcement.dart';
import 'package:icsa_mobile_app/src/features/authentication/presentation/pages/login_page.dart';
import 'package:icsa_mobile_app/src/features/authentication/presentation/pages/register_screen.dart';
import 'package:icsa_mobile_app/src/features/clearance/presentation/pages/admin_clearance_dashboard.dart';
import 'package:icsa_mobile_app/src/features/events/presentation/pages/add_event_page.dart';
import 'package:icsa_mobile_app/src/features/events/presentation/pages/admin_events_page.dart';
import 'package:icsa_mobile_app/src/features/events/presentation/pages/event_page.dart';
import 'package:icsa_mobile_app/src/features/fines/presentation/pages/admin_fines_dashboard.dart';
import 'package:icsa_mobile_app/src/features/fines/presentation/pages/fines_dashboard.dart';
import 'package:icsa_mobile_app/src/features/fines/presentation/pages/fines_detail.dart';
import 'package:icsa_mobile_app/src/features/home/presentation/pages/dashboard_screen.dart';
import 'package:icsa_mobile_app/src/features/home/presentation/pages/settings_screen.dart';
import 'package:icsa_mobile_app/src/features/payment/presentation/pages/payment_gateway.dart';
import 'package:icsa_mobile_app/src/features/payment/presentation/pages/payment_overview.dart';
import 'package:icsa_mobile_app/src/features/profile/presentation/pages/profile_page.dart';
import 'package:icsa_mobile_app/src/features/student/presentation/pages/add_student_dialog.dart';
import 'package:icsa_mobile_app/src/features/student/presentation/pages/student_page.dart';
import 'package:icsa_mobile_app/src/features/student/presentation/pages/update_student.dart';

final router = GoRouter(
  initialLocation: '/login',
  errorBuilder: (context, state) => const NoPageFound(),
  routes: [
    GoRoute(path: "/login", builder: (context, state) => const LoginScreen()),
    GoRoute(
        path: "/register",
        builder: (context, state) => const RegisterAdminPage()),
    GoRoute(
        path: "/home", builder: (context, state) => const DashboardScreen()),
    GoRoute(
      path: '/announcements',
      builder: (context, state) => const AnnouncementPage(),
      routes: [],
    ),
    GoRoute(
        path: "/events",
        builder: (context, state) => const EventsPage(),
        routes: [
          GoRoute(
            path: "details",
            builder: (context, state) => NoPageFound(),
          ),
        ]),
    GoRoute(
        path: "/fines",
        builder: (context, state) => const FinesDashboardScreen(),
        routes: [
          GoRoute(
              path: "detail",
              builder: (context, state) => const FinesDetailScreen(),
              routes: [])
        ]),
    GoRoute(
        path: "/payment",
        builder: (context, state) => const PaymentGatewayScreen(),
        routes: [
          GoRoute(
            path: "overview",
            builder: (context, state) => const PaymentOverviewScreen(),
          )
        ]),
    GoRoute(
        path: "/profile",
        builder: (context, state) => const ProfilePage(),
        routes: []),
    GoRoute(
        path: "/clearance",
        builder: (context, state) => NoPageFound(),
        routes: []),
    GoRoute(
        path: "/settings",
        builder: (context, state) => const SettingsScreen(),
        routes: []),
    GoRoute(
      path: '/admin',
      builder: (context, state) => const AdminDashboardPage(),
      routes: [
        // EVENTS
        GoRoute(
            path: "events",
            builder: (context, state) => const AdminEventsPage(),
            routes: [
              GoRoute(
                  path: "add-event",
                  builder: (context, state) => const AddEventPage())
            ]),
        // STUDENTS
        GoRoute(
          path: 'students',
          builder: (context, state) => const StudentPage(),
          routes: [
            GoRoute(
                path: ("add-student"),
                builder: (context, state) => const StudentFormPage()),
            GoRoute(
              path: "update-student",
              builder: (context, state) => const UpdateStudentFormPage(),
            ),
          ],
        ),
        // CLEARANCE
        GoRoute(
            path: "clearance",
            builder: (context, state) => AdminClearancePage(),
            routes: [
              GoRoute(
                path: "add-clearance-step",
                builder: (context, state) => NoPageFound(),
              ),
              GoRoute(
                path: "update-clearance-step",
                builder: (context, state) => NoPageFound(),
              )
            ]),
        // ANNOUNCEMENTS
        GoRoute(
            path: "announcements",
            builder: (context, state) => AdminAnnouncementPage(),
            routes: [
              GoRoute(
                path: "/create-announcement",
                builder: (context, state) => const CreateAnnouncementPage(),
              ),
              GoRoute(
                path: "/update-announcement",
                builder: (context, state) => const NoPageFound(),
              )
            ]),

        // FINES
        GoRoute(
            path: "fines",
            builder: (context, state) => const AdminFinesPage(),
            routes: [
              GoRoute(
                path: "/details",
                builder: (context, state) => const NoPageFound(),
              )
            ]),
      ],
    ),
  ],
  redirect: (context, state) {
    const UnaunthenticatedPage();
    return null;
  },
);
