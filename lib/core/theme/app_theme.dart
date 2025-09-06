import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppTheme {
  // Cores principais estilo Apple
  static const Color primaryColor = Color(0xFF007AFF); // Azul iOS
  static const Color primaryVariant = Color(0xFF0051D5);
  static const Color secondaryColor = Color(0xFF5856D6); // Roxo iOS
  static const Color accentColor = Color(0xFFFF9500); // Laranja iOS
  static const Color backgroundColor = Color(0xFFF2F2F7); // Cinza claro iOS
  static const Color surfaceColor = Color(0xFFFFFFFF);
  static const Color errorColor = Color(0xFFFF3B30); // Vermelho iOS
  static const Color successColor = Color(0xFF34C759); // Verde iOS
  static const Color warningColor = Color(0xFFFF9500); // Laranja iOS
  
  // Cores para dark mode
  static const Color darkBackgroundColor = Color(0xFF000000);
  static const Color darkSurfaceColor = Color(0xFF1C1C1E);
  static const Color darkPrimaryColor = Color(0xFF0A84FF);
  static const Color darkSecondaryColor = Color(0xFF5E5CE6);
  static const Color darkAccentColor = Color(0xFFFF9F0A);

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: primaryColor,
        brightness: Brightness.light,
        primary: primaryColor,
        secondary: secondaryColor,
        surface: surfaceColor,
        background: backgroundColor,
        error: errorColor,
        tertiary: accentColor,
      ),
      scaffoldBackgroundColor: backgroundColor,
      appBarTheme: const AppBarTheme(
        centerTitle: false,
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
        titleTextStyle: TextStyle(
          fontSize: 34,
          fontWeight: FontWeight.bold,
          color: Colors.black,
          letterSpacing: -0.5,
        ),
        systemOverlayStyle: SystemUiOverlayStyle.dark,
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: primaryColor,
        unselectedItemColor: Color(0xFF8E8E93),
        backgroundColor: surfaceColor,
        elevation: 0,
        selectedLabelStyle: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 10,
        ),
        unselectedLabelStyle: TextStyle(
          fontWeight: FontWeight.w400,
          fontSize: 10,
        ),
      ),
      cardTheme: CardThemeData(
        elevation: 0,
        color: surfaceColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        shadowColor: Colors.black.withOpacity(0.1),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryColor,
          foregroundColor: Colors.white,
          elevation: 0,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          textStyle: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 17,
          ),
        ),
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
        elevation: 0,
        shape: CircleBorder(),
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFFE5E5EA)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFFE5E5EA)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: primaryColor, width: 2),
        ),
        filled: true,
        fillColor: const Color(0xFFF2F2F7),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        hintStyle: const TextStyle(
          color: Color(0xFF8E8E93),
          fontSize: 17,
        ),
      ),
      textTheme: const TextTheme(
        headlineLarge: TextStyle(
          fontSize: 34,
          fontWeight: FontWeight.bold,
          color: Colors.black,
          letterSpacing: -0.5,
          height: 1.2,
        ),
        headlineMedium: TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.bold,
          color: Colors.black,
          letterSpacing: -0.4,
          height: 1.2,
        ),
        headlineSmall: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.w600,
          color: Colors.black,
          letterSpacing: -0.3,
          height: 1.3,
        ),
        titleLarge: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: Colors.black,
          letterSpacing: -0.2,
          height: 1.3,
        ),
        titleMedium: TextStyle(
          fontSize: 17,
          fontWeight: FontWeight.w600,
          color: Colors.black,
          letterSpacing: -0.1,
          height: 1.3,
        ),
        titleSmall: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w500,
          color: Colors.black,
          height: 1.3,
        ),
        bodyLarge: TextStyle(
          fontSize: 17,
          fontWeight: FontWeight.w400,
          color: Colors.black,
          height: 1.4,
        ),
        bodyMedium: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w400,
          color: Colors.black,
          height: 1.4,
        ),
        bodySmall: TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w400,
          color: Color(0xFF8E8E93),
          height: 1.4,
        ),
        labelLarge: TextStyle(
          fontSize: 17,
          fontWeight: FontWeight.w600,
          color: primaryColor,
          height: 1.3,
        ),
        labelMedium: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w500,
          color: Color(0xFF8E8E93),
          height: 1.3,
        ),
        labelSmall: TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w500,
          color: Color(0xFF8E8E93),
          height: 1.3,
        ),
      ),
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: darkPrimaryColor,
        brightness: Brightness.dark,
        primary: darkPrimaryColor,
        secondary: darkSecondaryColor,
        surface: darkSurfaceColor,
        background: darkBackgroundColor,
        error: errorColor,
        tertiary: darkAccentColor,
      ),
      scaffoldBackgroundColor: darkBackgroundColor,
      appBarTheme: const AppBarTheme(
        centerTitle: false,
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.white,
        titleTextStyle: TextStyle(
          fontSize: 34,
          fontWeight: FontWeight.bold,
          color: Colors.white,
          letterSpacing: -0.5,
        ),
        systemOverlayStyle: SystemUiOverlayStyle.light,
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: darkPrimaryColor,
        unselectedItemColor: Color(0xFF8E8E93),
        backgroundColor: darkSurfaceColor,
        elevation: 0,
        selectedLabelStyle: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 10,
        ),
        unselectedLabelStyle: TextStyle(
          fontWeight: FontWeight.w400,
          fontSize: 10,
        ),
      ),
      cardTheme: CardThemeData(
        elevation: 0,
        color: darkSurfaceColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        shadowColor: Colors.black.withOpacity(0.3),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: darkPrimaryColor,
          foregroundColor: Colors.white,
          elevation: 0,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          textStyle: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 17,
          ),
        ),
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: darkPrimaryColor,
        foregroundColor: Colors.white,
        elevation: 0,
        shape: CircleBorder(),
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFF38383A)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFF38383A)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: darkPrimaryColor, width: 2),
        ),
        filled: true,
        fillColor: const Color(0xFF1C1C1E),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        hintStyle: const TextStyle(
          color: Color(0xFF8E8E93),
          fontSize: 17,
        ),
      ),
      textTheme: const TextTheme(
        headlineLarge: TextStyle(
          fontSize: 34,
          fontWeight: FontWeight.bold,
          color: Colors.white,
          letterSpacing: -0.5,
          height: 1.2,
        ),
        headlineMedium: TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.bold,
          color: Colors.white,
          letterSpacing: -0.4,
          height: 1.2,
        ),
        headlineSmall: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.w600,
          color: Colors.white,
          letterSpacing: -0.3,
          height: 1.3,
        ),
        titleLarge: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: Colors.white,
          letterSpacing: -0.2,
          height: 1.3,
        ),
        titleMedium: TextStyle(
          fontSize: 17,
          fontWeight: FontWeight.w600,
          color: Colors.white,
          letterSpacing: -0.1,
          height: 1.3,
        ),
        titleSmall: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w500,
          color: Colors.white,
          height: 1.3,
        ),
        bodyLarge: TextStyle(
          fontSize: 17,
          fontWeight: FontWeight.w400,
          color: Colors.white,
          height: 1.4,
        ),
        bodyMedium: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w400,
          color: Colors.white,
          height: 1.4,
        ),
        bodySmall: TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w400,
          color: Color(0xFF8E8E93),
          height: 1.4,
        ),
        labelLarge: TextStyle(
          fontSize: 17,
          fontWeight: FontWeight.w600,
          color: darkPrimaryColor,
          height: 1.3,
        ),
        labelMedium: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w500,
          color: Color(0xFF8E8E93),
          height: 1.3,
        ),
        labelSmall: TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w500,
          color: Color(0xFF8E8E93),
          height: 1.3,
        ),
      ),
    );
  }
}
