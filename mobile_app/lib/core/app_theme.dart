import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class KairouanColors {
  // Kairouan Historical Color Palette
  static const Color gold = Color(0xFFD4AF37);           // Golden accents
  static const Color deepGold = Color(0xFFB8941E);       // Darker gold
  static const Color brass = Color(0xFFB87333);          // Brass details
  static const Color terracotta = Color(0xFFC27145);     // Traditional terracotta
  static const Color limestone = Color(0xFFF5F1E8);      // Limestone walls (Primary Background)
  static const Color warmCream = Color(0xFFFBF8F1);      // Warm cream
  static const Color burgundy = Color(0xFF8B2635);       // Deep burgundy
  static const Color oliveGreen = Color(0xFF6B7C59);     // Olive tones
  static const Color desertSand = Color(0xFFE8D5B7);     // Desert sand
  static const Color midnight = Color(0xFF1A2332);       // Deep blue-black (Primary Brand)
  
  static const Color textMain = Color(0xFF6B3E26);       // Brown (Primary Text)
  static const Color textOlive = Color(0xFF6B7C59);      // Olive (Secondary Text)
}

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: KairouanColors.limestone,
      colorScheme: ColorScheme.fromSeed(
        seedColor: KairouanColors.midnight,
        primary: KairouanColors.midnight,
        secondary: KairouanColors.gold,
        surface: KairouanColors.limestone,
        onSurface: KairouanColors.textMain,
        brightness: Brightness.light,
      ),
      
      // Typography
      textTheme: GoogleFonts.tajawalTextTheme().copyWith(
        displayLarge: GoogleFonts.amiri(
          color: KairouanColors.textMain,
          fontWeight: FontWeight.bold,
          fontSize: 32,
        ),
        displayMedium: GoogleFonts.amiri(
          color: KairouanColors.textMain,
          fontWeight: FontWeight.bold,
          fontSize: 28,
        ),
        titleLarge: GoogleFonts.tajawal(
          color: KairouanColors.textMain,
          fontWeight: FontWeight.w700,
          fontSize: 20,
        ),
        bodyLarge: GoogleFonts.tajawal(
          color: KairouanColors.textMain,
          fontSize: 16,
          height: 1.5,
        ),
        bodyMedium: GoogleFonts.tajawal(
          color: KairouanColors.textOlive,
          fontSize: 14,
        ),
      ),

      // AppBar Theme
      appBarTheme: const AppBarTheme(
        backgroundColor: KairouanColors.limestone,
        elevation: 0,
        centerTitle: true,
        iconTheme: IconThemeData(color: KairouanColors.midnight),
        titleTextStyle: TextStyle(
          color: KairouanColors.midnight,
          fontSize: 18,
          fontWeight: FontWeight.w600,
          fontFamily: 'Tajawal',
        ),
      ),

      // Button Theme
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: KairouanColors.midnight,
          foregroundColor: KairouanColors.gold,
          elevation: 2,
          shadowColor: KairouanColors.gold.withOpacity(0.3),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8), // Kairouan style (0.5rem)
          ),
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            fontFamily: 'Tajawal',
          ),
        ),
      ),
      
      // Outline Button Theme (Kairouan style)
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: KairouanColors.midnight,
          side: const BorderSide(color: KairouanColors.gold, width: 1.5),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            fontFamily: 'Tajawal',
          ),
        ),
      ),
      
      // Input Decoration
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.white.withOpacity(0.8),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: KairouanColors.gold.withOpacity(0.3)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: KairouanColors.gold.withOpacity(0.3)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: KairouanColors.gold, width: 1.5),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        labelStyle: TextStyle(color: KairouanColors.textOlive),
        hintStyle: TextStyle(color: KairouanColors.textOlive.withOpacity(0.5)),
      ),
    );
  }
}
