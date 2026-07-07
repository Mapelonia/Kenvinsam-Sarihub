import 'package:flutter/material.dart';
import 'package:kenvinsam_sarihub/utils/theme.dart';

<<<<<<< HEAD
/// Reusable search bar widget with modern styling.
class AppSearchBar extends StatelessWidget {
  final String hintText;
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onTap;
  final bool readOnly;
  final bool autofocus;
  final Widget? trailing;
=======
/// A polished search bar with elevation and subtle gradient.
class AppSearchBar extends StatelessWidget {
  final String hintText;
  final VoidCallback? onTap;
  final ValueChanged<String>? onChanged;
  final TextEditingController? controller;
  final bool readOnly;
  final VoidCallback? onClear;
  final bool showFilterButton;
  final VoidCallback? onFilter;
>>>>>>> 4dd908a849b3b51b9738ab984e1088d324c50337

  const AppSearchBar({
    super.key,
    this.hintText = 'Search...',
<<<<<<< HEAD
    this.controller,
    this.onChanged,
    this.onTap,
    this.readOnly = false,
    this.autofocus = false,
    this.trailing,
=======
    this.onTap,
    this.onChanged,
    this.controller,
    this.readOnly = false,
    this.onClear,
    this.showFilterButton = false,
    this.onFilter,
>>>>>>> 4dd908a849b3b51b9738ab984e1088d324c50337
  });

  @override
  Widget build(BuildContext context) {
<<<<<<< HEAD
    final isDark = context.isDark;

    return GestureDetector(
      onTap: readOnly ? onTap : null,
      child: Container(
        decoration: BoxDecoration(
          color: isDark ? AppTheme.cardDark : const Color(0xFFE8ECF0),
          borderRadius: BorderRadius.circular(AppTheme.radiusMd),
          border: Border.all(
            color: isDark
                ? Colors.white.withOpacity(0.06)
                : Colors.transparent,
          ),
        ),
        child: TextField(
          controller: controller,
          onChanged: onChanged,
          onTap: readOnly ? null : onTap,
          readOnly: readOnly,
          autofocus: autofocus,
          enabled: !readOnly,
          style: AppTheme.bodyMd.copyWith(color: context.textPrimary),
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: AppTheme.bodyMd.copyWith(color: context.textMuted),
            prefixIcon: Icon(
              Icons.search_rounded,
              color: context.textMuted,
              size: 20,
            ),
            suffixIcon: trailing,
            border: InputBorder.none,
            enabledBorder: InputBorder.none,
            focusedBorder: InputBorder.none,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: AppTheme.spaceLg,
              vertical: AppTheme.spaceLg,
            ),
            filled: false,
          ),
        ),
      ),
=======
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final hasText = controller != null && controller!.text.isNotEmpty;

    return Row(
      children: [
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: isDark ? AppTheme.cardDark : Colors.white,
              borderRadius: BorderRadius.circular(AppTheme.radiusMd),
              border: Border.all(
                color: isDark ? Colors.grey.shade800 : Colors.grey.shade200,
                width: 1,
              ),
              boxShadow: !isDark
                  ? [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.03),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ]
                  : null,
            ),
            child: TextField(
              controller: controller,
              readOnly: readOnly,
              onTap: onTap,
              onChanged: onChanged,
              style: AppTheme.bodyMd,
              decoration: InputDecoration(
                hintText: hintText,
                hintStyle: AppTheme.bodyMd.copyWith(color: context.textMuted),
                prefixIcon: Padding(
                  padding: const EdgeInsets.only(left: 12, right: 8),
                  child: Icon(
                    Icons.search_rounded,
                    color: context.textSecondary,
                    size: 20,
                  ),
                ),
                prefixIconConstraints: const BoxConstraints(
                  minWidth: 40,
                  minHeight: 40,
                ),
                suffixIcon: hasText && onClear != null
                    ? IconButton(
                        icon: const Icon(Icons.close_rounded, size: 18),
                        color: context.textSecondary,
                        onPressed: onClear,
                        splashRadius: 18,
                      )
                    : null,
                border: InputBorder.none,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 14,
                ),
              ),
            ),
          ),
        ),
        if (showFilterButton) ...[
          const SizedBox(width: AppTheme.spaceSm),
          GestureDetector(
            onTap: onFilter,
            child: Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [AppTheme.primaryGreen, AppTheme.lightGreen],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(AppTheme.radiusMd),
                boxShadow: [
                  BoxShadow(
                    color: AppTheme.primaryGreen.withOpacity(0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: const Icon(
                Icons.tune_rounded,
                color: Colors.white,
                size: 22,
              ),
            ),
          ),
        ],
      ],
>>>>>>> 4dd908a849b3b51b9738ab984e1088d324c50337
    );
  }
}
