import 'package:barbearia_rei_du_corte/screens/home_screen.dart';
import 'package:barbearia_rei_du_corte/screens/main_screen.dart';
import 'package:barbearia_rei_du_corte/services/auth_service.dart';
import 'package:barbearia_rei_du_corte/utils/colors.dart';
import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final authService = AuthService();
    final currentUser = authService.getCurrentUser();

    return Drawer(
      child: Container(
        color: AppColors.cardBackground,
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: const Text(
                'Rei Du Corte',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.black),
              ),
              accountEmail: Text(
                currentUser?.email ?? 'O seu estilo é a nossa prioridade',
                style: const TextStyle(color: Colors.black87),
              ),
              currentAccountPicture: CircleAvatar(
                backgroundColor: AppColors.background,
                child: Image.asset('assets/rdc.PNG', height: 45, fit: BoxFit.contain),
              ),
              decoration: const BoxDecoration(
                color: AppColors.primary,
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home_outlined, color: AppColors.text),
              title: const Text('Home', style: TextStyle(color: AppColors.text)),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const HomeScreen()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.content_cut_outlined, color: AppColors.text),
              title: const Text('Serviços', style: TextStyle(color: AppColors.text)),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const MainScreen(initialIndex: 0)),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.calendar_today_outlined, color: AppColors.text),
              title: const Text('Meus Agendamentos', style: TextStyle(color: AppColors.text)),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const MainScreen(initialIndex: 1)),
                );
              },
            ),
            const Divider(color: AppColors.textSecondary),
            ListTile(
              leading: const Icon(Icons.logout, color: AppColors.text),
              title: const Text('Sair', style: TextStyle(color: AppColors.text)),
              onTap: () {
                authService.signOut();
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
