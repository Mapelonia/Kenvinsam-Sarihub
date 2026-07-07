import 'package:flutter/material.dart';
import 'package:kenvinsam_sarihub/utils/theme.dart';

<<<<<<< HEAD
enum SnackbarType { success, error, warning, info }

/// Modern snackbar utility.
=======
/// Helper for showing premium snackbars with consistent styling.
>>>>>>> 4dd908a849b3b51b9738ab984e1088d324c50337
class AppSnackbar {
  static void show(
    BuildContext context,
    String message, {
    SnackbarType type = SnackbarType.info,
    Duration duration = const Duration(seconds: 3),
    String? actionLabel,
    VoidCallback? onAction,
  }) {
<<<<<<< HEAD
    final colors = _getColors(type);
=======
    Color bgColor;
    IconData icon;

    switch (type) {
      case SnackbarType.success:
        bgColor = AppTheme.success;
        icon = Icons.check_circle_rounded;
        break;
      case SnackbarType.error:
        bgColor = AppTheme.error;
        icon = Icons.error_rounded;
        break;
      case SnackbarType.warning:
        bgColor = AppTheme.warning;
        icon = Icons.warning_rounded;
        break;
      case SnackbarType.info:
        bgColor = AppTheme.textPrimary;
        icon = Icons.info_rounded;
        break;
    }
>>>>>>> 4dd908a849b3b51b9738ab984e1088d324c50337

    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Container(
<<<<<<< HEAD
              width: 28,
              height: 28,
              decoration: BoxDecoration(
                color: colors.iconBg,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(colors.icon, color: colors.iconColor, size: 16),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                message,
                style: AppTheme.bodyMd.copyWith(
                  color: Colors.white,
                  fontSize: 13,
=======
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.18),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: Colors.white, size: 16),
            ),
            const SizedBox(width: AppTheme.spaceMd),
            Expanded(
              child: Text(
                message,
                style: AppTheme.bodySm.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
>>>>>>> 4dd908a849b3b51b9738ab984e1088d324c50337
                ),
              ),
            ),
          ],
        ),
<<<<<<< HEAD
        backgroundColor: const Color(0xFF1F2937),
=======
        backgroundColor: bgColor,
>>>>>>> 4dd908a849b3b51b9738ab984e1088d324c50337
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppTheme.radiusMd),
        ),
<<<<<<< HEAD
        duration: duration,
        margin: const EdgeInsets.fromLTRB(16, 0, 16, 16),
        action: actionLabel != null
            ? SnackBarAction(
                label: actionLabel,
                textColor: colors.iconColor,
=======
        margin: const EdgeInsets.all(AppTheme.spaceMd),
        elevation: 6,
        duration: duration,
        action: actionLabel != null
            ? SnackBarAction(
                label: actionLabel,
                textColor: Colors.white,
>>>>>>> 4dd908a849b3b51b9738ab984e1088d324c50337
                onPressed: onAction ?? () {},
              )
            : null,
      ),
    );
  }
<<<<<<< HEAD

  static _SnackbarColors _getColors(SnackbarType type) {
    switch (type) {
      case SnackbarType.success:
        return _SnackbarColors(
          icon: Icons.check_circle_rounded,
          iconColor: AppTheme.success,
          iconBg: AppTheme.success.withOpacity(0.15),
        );
      case SnackbarType.error:
        return _SnackbarColors(
          icon: Icons.error_rounded,
          iconColor: AppTheme.error,
          iconBg: AppTheme.error.withOpacity(0.15),
        );
      case SnackbarType.warning:
        return _SnackbarColors(
          icon: Icons.warning_rounded,
          iconColor: AppTheme.warning,
          iconBg: AppTheme.warning.withOpacity(0.15),
        );
      case SnackbarType.info:
        return _SnackbarColors(
          icon: Icons.info_rounded,
          iconColor: AppTheme.info,
          iconBg: AppTheme.info.withOpacity(0.15),
        );
    }
  }
}

class _SnackbarColors {
  final IconData icon;
  final Color iconColor;
  final Color iconBg;

  _SnackbarColors({
    required this.icon,
    required this.iconColor,
    required this.iconBg,
  });
}
=======
}

enum SnackbarType { success, error, warning, info }
>>>>>>> 4dd908a849b3b51b9738ab984e1088d324c50337
