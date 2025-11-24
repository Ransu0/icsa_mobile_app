import 'package:flutter/material.dart';
import 'package:icsa_mobile_app/src/core/routes/router.dart';
import 'package:icsa_mobile_app/src/core/theme/app_theme.dart';
import 'package:icsa_mobile_app/src/core/theme/theme_provider.dart';
import 'package:icsa_mobile_app/src/provider/student_provider.dart';
import 'package:icsa_mobile_app/src/repository/auth_repository.dart';
import 'package:icsa_mobile_app/src/service/auth_service.dart';

import 'package:provider/provider.dart';
import 'package:icsa_mobile_app/src/provider/auth_provider.dart';

class StudentOrgApp extends StatelessWidget {
  const StudentOrgApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(
            create: (_) => AuthProvider(AuthRepository(AuthService()))),
        ChangeNotifierProvider(create: (_) => StudentProvider()),
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        title: 'Student Organization Admin',
        routerConfig: router,
        theme: AppTheme.light(),
        darkTheme: AppTheme.dark(),
        themeMode: ThemeProvider().themeMode,
      ),
    );
  }
}
