import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'core/services/hive_service.dart';
import 'core/theme/app_theme.dart';
import 'features/home/screens/main_navigation_screen.dart';
import 'features/onboarding/screens/onboarding_screen.dart';
import 'shared/providers/app_providers.dart';
import 'shared/models/user.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  try {
    // Inicializar Hive
    await HiveService.init();
    
    runApp(
      const ProviderScope(
        child: FitnessProApp(),
      ),
    );
  } catch (e) {
    print('Erro na inicialização: $e');
    // Mostrar tela de erro ou fallback
    runApp(
      MaterialApp(
        home: Scaffold(
          body: Center(
            child: Text('Erro na inicialização: $e'),
          ),
        ),
      ),
    );
  }
}

class FitnessProApp extends ConsumerWidget {
  const FitnessProApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider);
    
    return MaterialApp(
      title: 'Fitness Pro',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      home: _buildHome(user),
    );
  }
  
  Widget _buildHome(User? user) {
    if (user == null) {
      return const OnboardingScreen();
    } else {
      return const MainNavigationScreen();
    }
  }
}