import 'package:flutter/material.dart';
<<<<<<< HEAD
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

/// Centralized design system for Kenvinsam SariHub.
/// Modern, clean design with teal-emerald gradient palette.
class AppTheme {
  // ─── Brand Colors ───
  static const Color primaryGreen = Color(0xFF0D9373);
  static const Color lightGreen = Color(0xFF34D399);
  static const Color darkGreen = Color(0xFF065F46);
  static const Color accentGreen = Color(0xFF6EE7B7);
  static const Color paleGreen = Color(0xFFECFDF5);

  // Gradient colors
  static const Color gradientStart = Color(0xFF0D9373);
  static const Color gradientEnd = Color(0xFF059669);
  static const Color gradientAccent = Color(0xFF34D399);

  // Surface & Card colors
  static const Color surfaceLight = Color(0xFFF1F5F9);
  static const Color cardLight = Colors.white;
  static const Color surfaceDark = Color(0xFF0F1419);
  static const Color cardDark = Color(0xFF1A2332);
  static const Color cardDarkElevated = Color(0xFF1F2937);

  // Semantic colors
  static const Color success = Color(0xFF10B981);
=======
import 'package:google_fonts/google_fonts.dart';

/// Centralized design system for Kenvinsam SariHub.
/// All colors, spacing, typography, and component styles live here.
class AppTheme {
  // ─── Colors ───
  static const Color primaryGreen = Color(0xFF2E7D32);
  static const Color lightGreen = Color(0xFF4CAF50);
  static const Color darkGreen = Color(0xFF1B5E20);
  static const Color accentGreen = Color(0xFF66BB6A);
  static const Color paleGreen = Color(0xFFE8F5E9);

  static const Color surfaceLight = Color(0xFFF8F9FA);
  static const Color cardLight = Colors.white;
  static const Color surfaceDark = Color(0xFF121212);
  static const Color cardDark = Color(0xFF1E1E1E);

  // Semantic colors
  static const Color success = Color(0xFF22C55E);
>>>>>>> 4dd908a849b3b51b9738ab984e1088d324c50337
  static const Color warning = Color(0xFFF59E0B);
  static const Color error = Color(0xFFEF4444);
  static const Color info = Color(0xFF3B82F6);

<<<<<<< HEAD
  // Text colors (light)
  static const Color textPrimary = Color(0xFF111827);
  static const Color textSecondary = Color(0xFF4B5563);
  static const Color textMuted = Color(0xFF6B7280);

  // Text colors (dark)
  static const Color textPrimaryDark = Color(0xFFF9FAFB);
  static const Color textSecondaryDark = Color(0xFFD1D5DB);
  static const Color textMutedDark = Color(0xFF9CA3AF);
=======
  // Text colors (light mode defaults — used when no context available)
  static const Color textPrimary = Color(0xFF111827);
  static const Color textSecondary = Color(0xFF6B7280);
  static const Color textMuted = Color(0xFF9CA3AF);

  // Text colors (dark mode)
  static const Color textPrimaryDark = Color(0xFFF9FAFB);
  static const Color textSecondaryDark = Color(0xFF9CA3AF);
  static const Color textMutedDark = Color(0xFF6B7280);
>>>>>>> 4dd908a849b3b51b9738ab984e1088d324c50337

  // ─── Spacing ───
  static const double spaceXs = 4;
  static const double spaceSm = 8;
  static const double spaceMd = 12;
  static const double spaceLg = 16;
  static const double spaceXl = 20;
  static const double space2xl = 24;
  static const double space3xl = 32;
<<<<<<< HEAD
  static const double space4xl = 40;

  // ─── Border radius ───
  static const double radiusSm = 10;
  static const double radiusMd = 14;
  static const double radiusLg = 18;
  static const double radiusXl = 24;
  static const double radius2xl = 28;
  static const double radiusFull = 999;

  // ─── Gradients ───
  static const LinearGradient primaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [gradientStart, gradientEnd],
  );

  static const LinearGradient brandGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF065F46), Color(0xFF0D9373), Color(0xFF34D399)],
  );

  static const LinearGradient splashGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF064E3B), Color(0xFF065F46), Color(0xFF0D9373)],
  );

  static LinearGradient get cardGradientLight => LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          Colors.white,
          Colors.white.withOpacity(0.95),
        ],
      );

  // ─── Shadows ───
  static List<BoxShadow> get shadowSm => [
        BoxShadow(
          color: Colors.black.withOpacity(0.08),
          blurRadius: 10,
          offset: const Offset(0, 2),
          spreadRadius: -1,
=======

  // ─── Border radius ───
  static const double radiusSm = 8;
  static const double radiusMd = 12;
  static const double radiusLg = 16;
  static const double radiusXl = 20;
  static const double radiusFull = 999;

  // ─── Shadows ───
  static List<BoxShadow> get shadowSm => [
        BoxShadow(
          color: Colors.black.withOpacity(0.04),
          blurRadius: 6,
          offset: const Offset(0, 1),
>>>>>>> 4dd908a849b3b51b9738ab984e1088d324c50337
        ),
      ];

  static List<BoxShadow> get shadowMd => [
        BoxShadow(
<<<<<<< HEAD
          color: Colors.black.withOpacity(0.10),
          blurRadius: 20,
          offset: const Offset(0, 4),
          spreadRadius: -2,
=======
          color: Colors.black.withOpacity(0.06),
          blurRadius: 12,
          offset: const Offset(0, 2),
>>>>>>> 4dd908a849b3b51b9738ab984e1088d324c50337
        ),
      ];

  static List<BoxShadow> get shadowLg => [
        BoxShadow(
<<<<<<< HEAD
          color: Colors.black.withOpacity(0.12),
          blurRadius: 28,
          offset: const Offset(0, 8),
          spreadRadius: -4,
        ),
      ];

  static List<BoxShadow> get shadowGreen => [
        BoxShadow(
          color: primaryGreen.withOpacity(0.25),
          blurRadius: 20,
          offset: const Offset(0, 6),
          spreadRadius: -4,
        ),
      ];

  // ─── Typography ───
  static TextStyle get headingXl => GoogleFonts.poppins(
        fontSize: 28,
        fontWeight: FontWeight.w700,
        height: 1.2,
        letterSpacing: -0.5,
=======
          color: Colors.black.withOpacity(0.08),
          blurRadius: 24,
          offset: const Offset(0, 4),
        ),
      ];

  // ─── Typography helpers ───
  static TextStyle get headingXl => GoogleFonts.poppins(
        fontSize: 26,
        fontWeight: FontWeight.w700,
        height: 1.2,
        letterSpacing: -0.3,
>>>>>>> 4dd908a849b3b51b9738ab984e1088d324c50337
      );

  static TextStyle get headingLg => GoogleFonts.poppins(
        fontSize: 22,
        fontWeight: FontWeight.w700,
        height: 1.25,
<<<<<<< HEAD
        letterSpacing: -0.3,
=======
        letterSpacing: -0.2,
>>>>>>> 4dd908a849b3b51b9738ab984e1088d324c50337
      );

  static TextStyle get headingMd => GoogleFonts.poppins(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        height: 1.3,
<<<<<<< HEAD
        letterSpacing: -0.2,
=======
>>>>>>> 4dd908a849b3b51b9738ab984e1088d324c50337
      );

  static TextStyle get headingSm => GoogleFonts.poppins(
        fontSize: 16,
        fontWeight: FontWeight.w600,
<<<<<<< HEAD
        height: 1.35,
=======
        height: 1.3,
>>>>>>> 4dd908a849b3b51b9738ab984e1088d324c50337
      );

  static TextStyle get bodyLg => GoogleFonts.poppins(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        height: 1.5,
      );

  static TextStyle get bodyMd => GoogleFonts.poppins(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        height: 1.5,
      );

  static TextStyle get bodySm => GoogleFonts.poppins(
        fontSize: 13,
        fontWeight: FontWeight.w400,
<<<<<<< HEAD
        height: 1.45,
=======
        height: 1.4,
>>>>>>> 4dd908a849b3b51b9738ab984e1088d324c50337
      );

  static TextStyle get caption => GoogleFonts.poppins(
        fontSize: 11,
        fontWeight: FontWeight.w500,
        height: 1.3,
      );

  static TextStyle get label => GoogleFonts.poppins(
        fontSize: 12,
        fontWeight: FontWeight.w600,
        height: 1.3,
<<<<<<< HEAD
        letterSpacing: 0.2,
      );

  static TextStyle get mono => GoogleFonts.jetBrainsMono(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        height: 1.4,
      );

  // ─── Light Theme ───
=======
      );

  // ─── Themes ───
>>>>>>> 4dd908a849b3b51b9738ab984e1088d324c50337
  static ThemeData get lightTheme {
    final scheme = ColorScheme.fromSeed(
      seedColor: primaryGreen,
      brightness: Brightness.light,
      primary: primaryGreen,
      secondary: lightGreen,
      surface: surfaceLight,
<<<<<<< HEAD
      error: error,
=======
>>>>>>> 4dd908a849b3b51b9738ab984e1088d324c50337
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: scheme,
      scaffoldBackgroundColor: surfaceLight,
      textTheme: GoogleFonts.poppinsTextTheme().apply(
        bodyColor: textPrimary,
        displayColor: textPrimary,
      ),
      appBarTheme: AppBarTheme(
<<<<<<< HEAD
        backgroundColor: Colors.transparent,
        foregroundColor: textPrimary,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: false,
        titleTextStyle: GoogleFonts.poppins(
          fontSize: 20,
          fontWeight: FontWeight.w700,
          color: textPrimary,
          letterSpacing: -0.3,
        ),
        iconTheme: const IconThemeData(color: textPrimary, size: 22),
        systemOverlayStyle: SystemUiOverlayStyle.dark,
      ),
      cardTheme: CardThemeData(
=======
        backgroundColor: primaryGreen,
        foregroundColor: Colors.white,
        elevation: 0,
        scrolledUnderElevation: 4,
        shadowColor: primaryGreen.withOpacity(0.3),
        centerTitle: true,
        titleTextStyle: GoogleFonts.poppins(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: Colors.white,
          letterSpacing: 0.2,
        ),
        iconTheme: const IconThemeData(color: Colors.white, size: 22),
        systemOverlayStyle: null,
      ),
      cardTheme: CardTheme(
>>>>>>> 4dd908a849b3b51b9738ab984e1088d324c50337
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radiusLg),
          side: BorderSide(color: Colors.grey.shade200, width: 1),
        ),
        color: cardLight,
        margin: EdgeInsets.zero,
        clipBehavior: Clip.antiAlias,
        surfaceTintColor: Colors.transparent,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryGreen,
          foregroundColor: Colors.white,
<<<<<<< HEAD
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radiusMd),
          ),
          textStyle: GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.w600),
          elevation: 0,
          minimumSize: const Size(0, 52),
=======
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(radiusMd)),
          textStyle: GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.w600),
          elevation: 0,
          minimumSize: const Size(0, 48),
>>>>>>> 4dd908a849b3b51b9738ab984e1088d324c50337
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: primaryGreen,
<<<<<<< HEAD
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radiusMd),
          ),
          side: BorderSide(color: primaryGreen.withOpacity(0.5), width: 1.5),
          textStyle: GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.w600),
          minimumSize: const Size(0, 52),
=======
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(radiusMd)),
          side: const BorderSide(color: primaryGreen, width: 1.5),
          textStyle: GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.w600),
          minimumSize: const Size(0, 48),
>>>>>>> 4dd908a849b3b51b9738ab984e1088d324c50337
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: primaryGreen,
          textStyle: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w600),
<<<<<<< HEAD
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radiusSm),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
=======
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(radiusSm)),
>>>>>>> 4dd908a849b3b51b9738ab984e1088d324c50337
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
<<<<<<< HEAD
        fillColor: const Color(0xFFE8ECF0),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radiusMd),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radiusMd),
          borderSide: BorderSide.none,
=======
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radiusMd),
          borderSide: BorderSide(color: Colors.grey.shade300, width: 1),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radiusMd),
          borderSide: BorderSide(color: Colors.grey.shade300, width: 1),
>>>>>>> 4dd908a849b3b51b9738ab984e1088d324c50337
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radiusMd),
          borderSide: const BorderSide(color: primaryGreen, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radiusMd),
<<<<<<< HEAD
          borderSide: const BorderSide(color: error, width: 1.5),
=======
          borderSide: const BorderSide(color: error, width: 1),
>>>>>>> 4dd908a849b3b51b9738ab984e1088d324c50337
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radiusMd),
          borderSide: const BorderSide(color: error, width: 2),
        ),
<<<<<<< HEAD
        contentPadding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
=======
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
>>>>>>> 4dd908a849b3b51b9738ab984e1088d324c50337
        labelStyle: GoogleFonts.poppins(fontSize: 14, color: textSecondary),
        hintStyle: GoogleFonts.poppins(fontSize: 14, color: textMuted),
        floatingLabelStyle: GoogleFonts.poppins(
          fontSize: 14,
          color: primaryGreen,
          fontWeight: FontWeight.w500,
        ),
<<<<<<< HEAD
        prefixIconColor: textSecondary,
        suffixIconColor: textSecondary,
=======
>>>>>>> 4dd908a849b3b51b9738ab984e1088d324c50337
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: primaryGreen,
        foregroundColor: Colors.white,
<<<<<<< HEAD
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radiusLg),
        ),
      ),
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
        indicatorColor: primaryGreen.withOpacity(0.1),
        labelTextStyle: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return GoogleFonts.poppins(
              fontSize: 11,
=======
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(radiusLg)),
      ),
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: Colors.white,
        indicatorColor: primaryGreen.withOpacity(0.12),
        labelTextStyle: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return GoogleFonts.poppins(
              fontSize: 12,
>>>>>>> 4dd908a849b3b51b9738ab984e1088d324c50337
              fontWeight: FontWeight.w600,
              color: primaryGreen,
            );
          }
          return GoogleFonts.poppins(
<<<<<<< HEAD
            fontSize: 11,
            fontWeight: FontWeight.w500,
            color: textMuted,
=======
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: textSecondary,
>>>>>>> 4dd908a849b3b51b9738ab984e1088d324c50337
          );
        }),
        iconTheme: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return const IconThemeData(color: primaryGreen, size: 24);
          }
<<<<<<< HEAD
          return const IconThemeData(color: textMuted, size: 24);
        }),
        elevation: 0,
        height: 72,
=======
          return IconThemeData(color: Colors.grey.shade500, size: 24);
        }),
        elevation: 0,
        height: 68,
>>>>>>> 4dd908a849b3b51b9738ab984e1088d324c50337
      ),
      dividerTheme: DividerThemeData(
        color: Colors.grey.shade200,
        thickness: 1,
        space: 1,
      ),
      snackBarTheme: SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
<<<<<<< HEAD
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radiusMd),
        ),
        backgroundColor: const Color(0xFF1F2937),
        contentTextStyle: GoogleFonts.poppins(fontSize: 14, color: Colors.white),
        elevation: 8,
      ),
      dialogTheme: DialogThemeData(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radiusXl),
        ),
        backgroundColor: Colors.white,
        elevation: 16,
=======
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(radiusMd)),
        backgroundColor: textPrimary,
        contentTextStyle: GoogleFonts.poppins(fontSize: 14, color: Colors.white),
      ),
      dialogTheme: DialogTheme(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(radiusLg)),
        backgroundColor: Colors.white,
        elevation: 8,
>>>>>>> 4dd908a849b3b51b9738ab984e1088d324c50337
        titleTextStyle: GoogleFonts.poppins(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: textPrimary,
        ),
        contentTextStyle: GoogleFonts.poppins(fontSize: 14, color: textSecondary),
      ),
      chipTheme: ChipThemeData(
<<<<<<< HEAD
        backgroundColor: const Color(0xFFE8ECF0),
=======
        backgroundColor: Colors.grey.shade100,
>>>>>>> 4dd908a849b3b51b9738ab984e1088d324c50337
        selectedColor: primaryGreen,
        labelStyle: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.w500),
        secondaryLabelStyle: GoogleFonts.poppins(
          fontSize: 13,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
<<<<<<< HEAD
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radiusFull),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
        side: BorderSide.none,
      ),
      listTileTheme: ListTileThemeData(
        contentPadding: const EdgeInsets.symmetric(horizontal: 18, vertical: 6),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radiusMd),
        ),
=======
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(radiusFull)),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        side: BorderSide.none,
      ),
      listTileTheme: ListTileThemeData(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(radiusMd)),
>>>>>>> 4dd908a849b3b51b9738ab984e1088d324c50337
      ),
      bottomSheetTheme: const BottomSheetThemeData(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
<<<<<<< HEAD
          borderRadius: BorderRadius.vertical(top: Radius.circular(radius2xl)),
        ),
        elevation: 16,
      ),
      tabBarTheme: TabBarThemeData(
        indicatorColor: primaryGreen,
        labelColor: primaryGreen,
        unselectedLabelColor: textSecondary,
        indicatorSize: TabBarIndicatorSize.label,
        labelStyle: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.w600),
        unselectedLabelStyle: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.w500),
=======
          borderRadius: BorderRadius.vertical(top: Radius.circular(radiusXl)),
        ),
        elevation: 8,
>>>>>>> 4dd908a849b3b51b9738ab984e1088d324c50337
      ),
    );
  }

<<<<<<< HEAD
  // ─── Dark Theme ───
=======
>>>>>>> 4dd908a849b3b51b9738ab984e1088d324c50337
  static ThemeData get darkTheme {
    final scheme = ColorScheme.fromSeed(
      seedColor: primaryGreen,
      brightness: Brightness.dark,
<<<<<<< HEAD
      primary: lightGreen,
      secondary: accentGreen,
      surface: surfaceDark,
      error: error,
=======
      primary: accentGreen,
      secondary: lightGreen,
      surface: surfaceDark,
>>>>>>> 4dd908a849b3b51b9738ab984e1088d324c50337
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: scheme,
      scaffoldBackgroundColor: surfaceDark,
      textTheme: GoogleFonts.poppinsTextTheme(ThemeData.dark().textTheme).apply(
        bodyColor: textPrimaryDark,
        displayColor: textPrimaryDark,
      ),
      appBarTheme: AppBarTheme(
<<<<<<< HEAD
        backgroundColor: Colors.transparent,
        foregroundColor: textPrimaryDark,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: false,
        titleTextStyle: GoogleFonts.poppins(
          fontSize: 20,
          fontWeight: FontWeight.w700,
          color: textPrimaryDark,
          letterSpacing: -0.3,
        ),
        iconTheme: const IconThemeData(color: textPrimaryDark, size: 22),
        systemOverlayStyle: SystemUiOverlayStyle.light,
      ),
      cardTheme: CardThemeData(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radiusLg),
          side: BorderSide(color: Colors.white.withOpacity(0.06), width: 1),
=======
        backgroundColor: cardDark,
        foregroundColor: Colors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: true,
        titleTextStyle: GoogleFonts.poppins(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: Colors.white,
          letterSpacing: 0.2,
        ),
        iconTheme: const IconThemeData(color: Colors.white, size: 22),
      ),
      cardTheme: CardTheme(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radiusLg),
          side: BorderSide(color: Colors.grey.shade800, width: 1),
>>>>>>> 4dd908a849b3b51b9738ab984e1088d324c50337
        ),
        color: cardDark,
        margin: EdgeInsets.zero,
        clipBehavior: Clip.antiAlias,
        surfaceTintColor: Colors.transparent,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
<<<<<<< HEAD
          backgroundColor: lightGreen,
          foregroundColor: const Color(0xFF064E3B),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radiusMd),
          ),
          textStyle: GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.w600),
          elevation: 0,
          minimumSize: const Size(0, 52),
=======
          backgroundColor: accentGreen,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(radiusMd)),
          textStyle: GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.w600),
          elevation: 0,
          minimumSize: const Size(0, 48),
>>>>>>> 4dd908a849b3b51b9738ab984e1088d324c50337
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
<<<<<<< HEAD
          foregroundColor: lightGreen,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radiusMd),
          ),
          side: BorderSide(color: lightGreen.withOpacity(0.5), width: 1.5),
          textStyle: GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.w600),
          minimumSize: const Size(0, 52),
=======
          foregroundColor: accentGreen,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(radiusMd)),
          side: const BorderSide(color: accentGreen, width: 1.5),
          textStyle: GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.w600),
          minimumSize: const Size(0, 48),
>>>>>>> 4dd908a849b3b51b9738ab984e1088d324c50337
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
<<<<<<< HEAD
          foregroundColor: lightGreen,
          textStyle: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w600),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radiusSm),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
=======
          foregroundColor: accentGreen,
          textStyle: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w600),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(radiusSm)),
>>>>>>> 4dd908a849b3b51b9738ab984e1088d324c50337
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
<<<<<<< HEAD
        fillColor: cardDarkElevated,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radiusMd),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radiusMd),
          borderSide: BorderSide(color: Colors.white.withOpacity(0.06), width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radiusMd),
          borderSide: const BorderSide(color: lightGreen, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radiusMd),
          borderSide: const BorderSide(color: error, width: 1.5),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radiusMd),
          borderSide: const BorderSide(color: error, width: 2),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
        labelStyle: GoogleFonts.poppins(fontSize: 14, color: textSecondaryDark),
        hintStyle: GoogleFonts.poppins(fontSize: 14, color: textMutedDark),
        floatingLabelStyle: GoogleFonts.poppins(
          fontSize: 14,
          color: lightGreen,
          fontWeight: FontWeight.w500,
        ),
        prefixIconColor: textSecondaryDark,
        suffixIconColor: textSecondaryDark,
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: lightGreen,
        foregroundColor: const Color(0xFF064E3B),
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radiusLg),
        ),
      ),
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: cardDark,
        surfaceTintColor: Colors.transparent,
        indicatorColor: lightGreen.withOpacity(0.12),
        labelTextStyle: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return GoogleFonts.poppins(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: lightGreen,
            );
          }
          return GoogleFonts.poppins(
            fontSize: 11,
            fontWeight: FontWeight.w500,
            color: textMutedDark,
=======
        fillColor: cardDark,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radiusMd),
          borderSide: BorderSide(color: Colors.grey.shade800, width: 1),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radiusMd),
          borderSide: BorderSide(color: Colors.grey.shade800, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radiusMd),
          borderSide: const BorderSide(color: accentGreen, width: 2),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        labelStyle: GoogleFonts.poppins(fontSize: 14, color: Colors.grey.shade400),
        hintStyle: GoogleFonts.poppins(fontSize: 14, color: Colors.grey.shade600),
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: accentGreen,
        foregroundColor: Colors.white,
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(radiusLg)),
      ),
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: cardDark,
        indicatorColor: accentGreen.withOpacity(0.18),
        labelTextStyle: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return GoogleFonts.poppins(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: accentGreen,
            );
          }
          return GoogleFonts.poppins(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: Colors.grey.shade500,
>>>>>>> 4dd908a849b3b51b9738ab984e1088d324c50337
          );
        }),
        iconTheme: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
<<<<<<< HEAD
            return const IconThemeData(color: lightGreen, size: 24);
          }
          return IconThemeData(color: textMutedDark, size: 24);
        }),
        elevation: 0,
        height: 72,
      ),
      dividerTheme: DividerThemeData(
        color: Colors.white.withOpacity(0.06),
=======
            return const IconThemeData(color: accentGreen, size: 24);
          }
          return IconThemeData(color: Colors.grey.shade500, size: 24);
        }),
        elevation: 0,
        height: 68,
      ),
      dividerTheme: DividerThemeData(
        color: Colors.grey.shade800,
>>>>>>> 4dd908a849b3b51b9738ab984e1088d324c50337
        thickness: 1,
        space: 1,
      ),
      snackBarTheme: SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
<<<<<<< HEAD
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radiusMd),
        ),
        backgroundColor: cardDarkElevated,
        contentTextStyle: GoogleFonts.poppins(fontSize: 14, color: Colors.white),
        elevation: 8,
      ),
      dialogTheme: DialogThemeData(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radiusXl),
        ),
        backgroundColor: cardDark,
        elevation: 16,
        titleTextStyle: GoogleFonts.poppins(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: textPrimaryDark,
        ),
        contentTextStyle: GoogleFonts.poppins(fontSize: 14, color: textSecondaryDark),
      ),
      chipTheme: ChipThemeData(
        backgroundColor: cardDarkElevated,
        selectedColor: lightGreen,
        labelStyle: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.w500),
        secondaryLabelStyle: GoogleFonts.poppins(
          fontSize: 13,
          fontWeight: FontWeight.w600,
          color: const Color(0xFF064E3B),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radiusFull),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
        side: BorderSide.none,
      ),
      listTileTheme: ListTileThemeData(
        contentPadding: const EdgeInsets.symmetric(horizontal: 18, vertical: 6),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radiusMd),
=======
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(radiusMd)),
        backgroundColor: Colors.grey.shade900,
        contentTextStyle: GoogleFonts.poppins(fontSize: 14, color: Colors.white),
      ),
      dialogTheme: DialogTheme(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(radiusLg)),
        backgroundColor: cardDark,
        elevation: 8,
        titleTextStyle: GoogleFonts.poppins(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
        contentTextStyle: GoogleFonts.poppins(
          fontSize: 14,
          color: Colors.grey.shade300,
>>>>>>> 4dd908a849b3b51b9738ab984e1088d324c50337
        ),
      ),
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: cardDark,
        shape: const RoundedRectangleBorder(
<<<<<<< HEAD
          borderRadius: BorderRadius.vertical(top: Radius.circular(radius2xl)),
        ),
        elevation: 16,
      ),
      tabBarTheme: TabBarThemeData(
        indicatorColor: lightGreen,
        labelColor: lightGreen,
        unselectedLabelColor: textSecondaryDark,
        indicatorSize: TabBarIndicatorSize.label,
        labelStyle: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.w600),
        unselectedLabelStyle: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.w500),
=======
          borderRadius: BorderRadius.vertical(top: Radius.circular(radiusXl)),
        ),
        elevation: 8,
>>>>>>> 4dd908a849b3b51b9738ab984e1088d324c50337
      ),
    );
  }
}

/// Extension on BuildContext for theme-aware colors.
<<<<<<< HEAD
=======
/// Use `context.textPrimary` instead of `AppTheme.textPrimary` in widgets.
>>>>>>> 4dd908a849b3b51b9738ab984e1088d324c50337
extension AppThemeContext on BuildContext {
  bool get isDark => Theme.of(this).brightness == Brightness.dark;

  Color get textPrimary =>
      isDark ? AppTheme.textPrimaryDark : AppTheme.textPrimary;
  Color get textSecondary =>
      isDark ? AppTheme.textSecondaryDark : AppTheme.textSecondary;
  Color get textMuted =>
      isDark ? AppTheme.textMutedDark : AppTheme.textMuted;
  Color get cardBg =>
      isDark ? AppTheme.cardDark : AppTheme.cardLight;
  Color get borderColor =>
<<<<<<< HEAD
      isDark ? const Color(0xFF374151) : const Color(0xFFD1D5DB);
  Color get paleGreenAdapted =>
      isDark ? const Color(0xFF1A3A2E) : AppTheme.paleGreen;
  Color get surfaceBg =>
      isDark ? AppTheme.surfaceDark : AppTheme.surfaceLight;
  Color get primaryColor =>
      isDark ? AppTheme.lightGreen : AppTheme.primaryGreen;
  Color get inputFill =>
      isDark ? AppTheme.cardDarkElevated : const Color(0xFFE8ECF0);
=======
      isDark ? const Color(0xFF374151) : const Color(0xFFE5E7EB);
  Color get paleGreenAdapted =>
      isDark ? const Color(0xFF1B3A1B) : AppTheme.paleGreen;
>>>>>>> 4dd908a849b3b51b9738ab984e1088d324c50337
}
