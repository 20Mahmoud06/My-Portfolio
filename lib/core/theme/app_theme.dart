import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import '../constants/app_colors.dart';

class AppTheme {
  AppTheme._();

  static ThemeData get light => _buildTheme(Brightness.light);
  static ThemeData get dark => _buildTheme(Brightness.dark);

  static ThemeData _buildTheme(Brightness brightness) {
    final isLight = brightness == Brightness.light;

    final colorScheme = ColorScheme(
      brightness: brightness,
      primary: AppColors.primary,
      onPrimary: Colors.white,
      primaryContainer:
          isLight ? const Color(0xFFBBDEFB) : const Color(0xFF1565C0),
      onPrimaryContainer: isLight ? const Color(0xFF004B8D) : Colors.white,
      secondary: AppColors.accent,
      onSecondary: Colors.white,
      secondaryContainer:
          isLight ? const Color(0xFFB2EBF2) : const Color(0xFF006064),
      onSecondaryContainer: isLight ? const Color(0xFF00363A) : Colors.white,
      surface:
          isLight ? AppColors.lightSurface : AppColors.darkSurface,
      onSurface: isLight ? AppColors.lightText : AppColors.darkText,
      surfaceContainerHighest:
          isLight ? AppColors.lightSurface2 : AppColors.darkSurface2,
      onSurfaceVariant: isLight
          ? AppColors.lightTextSecondary
          : AppColors.darkTextSecondary,
      outline: isLight ? AppColors.lightBorder : AppColors.darkBorder,
      outlineVariant: isLight
          ? const Color(0xFFE2EDF8)
          : const Color(0xFF2D3F55),
      error: const Color(0xFFEF4444),
      onError: Colors.white,
      errorContainer: const Color(0xFFFFDAD6),
      onErrorContainer: const Color(0xFF410002),
      shadow: isLight
          ? const Color(0xFF42A5F5).withValues(alpha: 0.12)
          : Colors.black.withValues(alpha: 0.5),
      scrim: Colors.black,
      inverseSurface:
          isLight ? AppColors.darkSurface : AppColors.lightSurface,
      onInverseSurface: isLight ? AppColors.darkText : AppColors.lightText,
      inversePrimary: AppColors.primaryDark,
    );

    final textTheme = GoogleFonts.interTextTheme(
      TextTheme(
        displayLarge: TextStyle(
          fontSize: 64,
          fontWeight: FontWeight.w800,
          color: isLight ? AppColors.lightText : AppColors.darkText,
          letterSpacing: -1.5,
        ),
        displayMedium: TextStyle(
          fontSize: 48,
          fontWeight: FontWeight.w700,
          color: isLight ? AppColors.lightText : AppColors.darkText,
          letterSpacing: -1,
        ),
        displaySmall: TextStyle(
          fontSize: 36,
          fontWeight: FontWeight.w700,
          color: isLight ? AppColors.lightText : AppColors.darkText,
          letterSpacing: -0.5,
        ),
        headlineLarge: TextStyle(
          fontSize: 32,
          fontWeight: FontWeight.w700,
          color: isLight ? AppColors.lightText : AppColors.darkText,
        ),
        headlineMedium: TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.w600,
          color: isLight ? AppColors.lightText : AppColors.darkText,
        ),
        headlineSmall: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.w600,
          color: isLight ? AppColors.lightText : AppColors.darkText,
        ),
        titleLarge: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: isLight ? AppColors.lightText : AppColors.darkText,
        ),
        titleMedium: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: isLight ? AppColors.lightText : AppColors.darkText,
        ),
        titleSmall: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: isLight ? AppColors.lightText : AppColors.darkText,
        ),
        bodyLarge: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w400,
          color: isLight
              ? AppColors.lightTextSecondary
              : AppColors.darkTextSecondary,
          height: 1.7,
        ),
        bodyMedium: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: isLight
              ? AppColors.lightTextSecondary
              : AppColors.darkTextSecondary,
          height: 1.6,
        ),
        bodySmall: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w400,
          color: isLight
              ? AppColors.lightTextSecondary
              : AppColors.darkTextSecondary,
        ),
        labelLarge: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: isLight ? AppColors.lightText : AppColors.darkText,
          letterSpacing: 0.1,
        ),
        labelMedium: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          color: isLight
              ? AppColors.lightTextSecondary
              : AppColors.darkTextSecondary,
          letterSpacing: 0.5,
        ),
        labelSmall: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w500,
          color: isLight
              ? AppColors.lightTextSecondary
              : AppColors.darkTextSecondary,
          letterSpacing: 0.5,
        ),
      ),
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      textTheme: textTheme,
      scaffoldBackgroundColor:
          isLight ? AppColors.lightBackground : AppColors.darkBackground,
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        systemOverlayStyle: isLight
            ? SystemUiOverlayStyle.dark
            : SystemUiOverlayStyle.light,
      ),
      cardTheme: CardThemeData(
        color: isLight ? AppColors.lightSurface : AppColors.darkSurface,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(
            color: isLight ? AppColors.lightBorder : AppColors.darkBorder,
            width: 1,
          ),
        ),
      ),
      dividerTheme: DividerThemeData(
        color: isLight ? AppColors.lightBorder : AppColors.darkBorder,
        thickness: 1,
      ),
      iconTheme: IconThemeData(
        color: isLight ? AppColors.lightTextSecondary : AppColors.darkTextSecondary,
      ),
    );
  }
}
