import 'package:material_ui/material_ui.dart';

import 'tokens.dart';

abstract final class AppTheme {
  static ThemeData dark() {
    final scheme = ColorScheme.fromSeed(
      seedColor: NovaColors.emerald,
      brightness: Brightness.dark,
    ).copyWith(
      primary: NovaColors.gold,
      onPrimary: NovaColors.navy,
      secondary: NovaColors.sage,
      surface: NovaColors.emeraldDeep,
      onSurface: NovaColors.ivory,
      error: NovaColors.danger,
    );
    final base = ThemeData(
      useMaterial3: true,
      colorScheme: scheme,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: NovaColors.navy,
    );
    final text = base.textTheme.apply(
      bodyColor: NovaColors.textPrimary,
      displayColor: NovaColors.textPrimary,
    );
    return base.copyWith(
      textTheme: text.copyWith(
        displaySmall: text.displaySmall?.copyWith(
          fontFamily: NovaFonts.display,
          fontWeight: FontWeight.w700,
          color: NovaColors.goldLight,
        ),
        headlineMedium: text.headlineMedium?.copyWith(
          fontFamily: NovaFonts.display,
          fontWeight: FontWeight.w700,
          color: NovaColors.goldLight,
        ),
        headlineSmall: text.headlineSmall?.copyWith(
          fontFamily: NovaFonts.display,
          fontWeight: FontWeight.w700,
          color: NovaColors.goldLight,
        ),
        titleLarge: text.titleLarge?.copyWith(
          fontFamily: NovaFonts.display,
          fontWeight: FontWeight.w700,
          color: NovaColors.goldLight,
        ),
        titleMedium: text.titleMedium?.copyWith(fontWeight: FontWeight.w600),
      ),
      dialogTheme: DialogThemeData(
        backgroundColor: NovaColors.emeraldDeep,
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(NovaRadius.lg),
          side: BorderSide(color: NovaColors.gold.withValues(alpha: 0.45)),
        ),
        titleTextStyle: text.titleLarge?.copyWith(
          fontFamily: NovaFonts.display,
          fontWeight: FontWeight.w700,
          color: NovaColors.goldLight,
        ),
        contentTextStyle: text.bodyMedium?.copyWith(
          color: NovaColors.textSecondary,
          height: 1.4,
        ),
      ),
      snackBarTheme: SnackBarThemeData(
        backgroundColor: NovaColors.emeraldDeep,
        contentTextStyle: const TextStyle(color: NovaColors.ivory),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(NovaRadius.md),
          side: BorderSide(color: NovaColors.gold.withValues(alpha: 0.4)),
        ),
      ),
      switchTheme: SwitchThemeData(
        thumbColor: WidgetStateProperty.resolveWith(
          (s) => s.contains(WidgetState.selected)
              ? Colors.white
              : const Color(0xFFCFD8D4),
        ),
        trackColor: WidgetStateProperty.resolveWith(
          (s) => s.contains(WidgetState.selected)
              ? NovaColors.success
              : const Color(0xFF3B4B47),
        ),
        trackOutlineColor: WidgetStateProperty.all(Colors.transparent),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(foregroundColor: NovaColors.goldLight),
      ),
      iconTheme: const IconThemeData(color: NovaColors.goldLight),
      dividerTheme: DividerThemeData(
        color: NovaColors.gold.withValues(alpha: 0.15),
        thickness: 1,
        space: 1,
      ),
    );
  }
}
