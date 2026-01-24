import 'package:flutter/material.dart';

class GlassColors {
  // --- Mesh Gradient Backgrounds ---
  static const Color meshBgLight = Color(0xFFF8FAFC); // Slate-50
  static const Color meshBgDark = Color(0xFF020617); // Slate-950

// --- LIGHT MODE BLOBS (The Auroras) ---
  static const Color blob1Light = Color(0xFFA7F3D0); // Emerald-200
  static const Color blob2Light = Color(0xFFBAE6FD); // Sky-200
  static const Color blob3Light = Color(0xFFE2E8F0); // Slate-200

  // --- DARK MODE BLOBS (Subtle & Deep) ---
  static const Color blob1Dark = Color(0xFF064E3B); // Emerald-900 (Deep Green)
  static const Color blob2Dark = Color(0xFF0C4A6E); // Sky-900 (Deep Blue)
  static const Color blob3Dark = Color(0xFF1E293B); // Slate-800 (Dark Grey)

  // --- Glass Panels (The "Frosted" Cards) ---
  static final Color glassPanelLight = Colors.white.withOpacity(0.7);
  static final Color glassPanelDark = const Color(0xFF0F172A).withOpacity(0.6);

  static final Color glassBorderLight = Colors.white.withOpacity(0.5);
  static final Color glassBorderDark = Colors.white.withOpacity(0.1);

  // --- Bottom Navigation ---
  // Light Mode: Almost solid white
  static final Color bottomNavLight = Colors.white.withOpacity(0.95);
  // Dark Mode: Dark Slate with transparency
  static final Color bottomNavDark = const Color(0xFF0F172A).withOpacity(0.8);

  static final Color navBorderLight =
      Colors.white.withOpacity(1.0); // Solid top border
  static final Color navBorderDark = Colors.white.withOpacity(0.1);

  // --- Text ---
  static const Color textDark = Color(0xFF0F172A); // Slate-900
  static const Color textSubtle = Color(0xFF64748B); // Slate-500
  static const Color textLight = Color(0xFFF1F5F9); // Slate-100 (For Dark Mode)

  // --- High Contrast Input Colors (For Visibility) ---
  static const Color inputFillLight = Color(0xFFF7F8FA); // Cool White/Gray
  static const Color inputBorderLight = Color(0xFFD0D5DD); // Neutral Slate Gray
  static const Color inputFillDark = meshBgDark;
  static Color inputBorderDark = glassBorderDark;
}
