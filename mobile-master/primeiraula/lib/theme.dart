// // lib/theme.dart
// import 'package:flutter/material.dart';

// class AppColors {
//   static const Color primary = Color(0xFF006A8E);      // Azul petróleo
//   static const Color secondary = Color(0xFFFFA726);    // Laranja suave
//   static const Color background = Color(0xFFF0F9FF);   // Fundo azul muito claro
//   static const Color accent = Color(0xFF6A1B9A);       // Roxo moderno
//   static const Color success = Color(0xFF43A047);      // Verde esmeralda
//   static const Color danger = Color(0xFFE53935);       // Vermelho coral
//   static const Color card = Color(0xFFFFFFFF);         // Branco para cards
//   static const Color mutedText = Color(0xFF6B7280);    // Texto secundário
// }

// final ThemeData appTheme = ThemeData(
//   scaffoldBackgroundColor: AppColors.background,
//   primaryColor: AppColors.primary,
//   colorScheme: ColorScheme.fromSwatch().copyWith(
//     primary: AppColors.primary,
//     secondary: AppColors.secondary,
//   ),
//   elevatedButtonTheme: ElevatedButtonThemeData(
//     style: ElevatedButton.styleFrom(
//       backgroundColor: AppColors.accent,
//       foregroundColor: Colors.white,
//       padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 18),
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//     ),
//   ),
//   floatingActionButtonTheme: const FloatingActionButtonThemeData(
//     backgroundColor: AppColors.danger,
//     foregroundColor: Colors.white,
//   ),
//   appBarTheme: const AppBarTheme(
//     backgroundColor: AppColors.primary,
//     foregroundColor: Colors.white,
//     elevation: 0,
//     centerTitle: true,
//   ),
//   cardTheme: CardTheme(
//     color: AppColors.card,
//     elevation: 2,
//     margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
//     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//   ),
//   textTheme: const TextTheme(
//     titleLarge: TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: Colors.black),
//     bodyMedium: TextStyle(fontSize: 14, color: Colors.black87),
//     bodySmall: TextStyle(fontSize: 12, color: AppColors.mutedText),
//   ),
// );
