import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  // ── Primary ──────────────────────────────────────────────────────────────
  static const Color primary = Color(0xFF42A5F5);
  static const Color primaryDark = Color(0xFF1E88E5);
  static const Color accent = Color(0xFF22D3EE);
  static const Color accentAlt = Color(0xFF818CF8);

  // ── Light Theme ──────────────────────────────────────────────────────────
  static const Color lightBackground = Color(0xFFF8FBFF);
  static const Color lightBackground2 = Color(0xFFEEF6FF);
  static const Color lightBackground3 = Color(0xFFE8F4FF);
  static const Color lightSurface = Color(0xFFFFFFFF);
  static const Color lightSurface2 = Color(0xFFF0F7FF);
  static const Color lightText = Color(0xFF0F172A);
  static const Color lightTextSecondary = Color(0xFF475569);
  static const Color lightBorder = Color(0xFFDDE8F5);

  // ── Dark Theme ───────────────────────────────────────────────────────────
  static const Color darkBackground = Color(0xFF0F172A);
  static const Color darkBackground2 = Color(0xFF111827);
  static const Color darkBackground3 = Color(0xFF162033);
  static const Color darkSurface = Color(0xFF1E293B);
  static const Color darkSurface2 = Color(0xFF243447);
  static const Color darkText = Color(0xFFF8FAFC);
  static const Color darkTextSecondary = Color(0xFFCBD5E1);
  static const Color darkBorder = Color(0xFF334155);

  // ── Skill Category Colours ───────────────────────────────────────────────
  static const Color skillMobile = Color(0xFF42A5F5);
  static const Color skillBackend = Color(0xFF22D3EE);
  static const Color skillProgramming = Color(0xFF818CF8);
  static const Color skillTools = Color(0xFF34D399);

  // ── Gradient helpers ─────────────────────────────────────────────────────
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [Color(0xFF42A5F5), Color(0xFF22D3EE)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient heroGradientLight = LinearGradient(
    colors: [Color(0xFFF8FBFF), Color(0xFFE8F4FF)],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  static const LinearGradient heroGradientDark = LinearGradient(
    colors: [Color(0xFF0F172A), Color(0xFF162033)],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
}
