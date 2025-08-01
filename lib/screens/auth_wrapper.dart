import 'package:barbearia_rei_du_corte/screens/auth_screen.dart';
import 'package:barbearia_rei_du_corte/screens/home_screen.dart';
import 'package:barbearia_rei_du_corte/services/auth_service.dart';
import 'package:barbearia_rei_du_corte/utils/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final authService = AuthService();

    return StreamBuilder<User?>(
      stream: authService.user,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          return snapshot.hasData ? const HomeScreen() : const AuthScreen();
        }
        return const Scaffold(
          backgroundColor: AppColors.background,
          body: Center(
            child: CircularProgressIndicator(color: AppColors.primary),
          ),
        );
      },
    );
  }
}
