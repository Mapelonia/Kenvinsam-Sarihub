import 'package:flutter/material.dart';
<<<<<<< HEAD
import 'package:kenvinsam_sarihub/utils/theme.dart';

/// Modern loading indicator widget.
class LoadingWidget extends StatelessWidget {
  final String? message;
  final double size;

  const LoadingWidget({
    super.key,
    this.message,
    this.size = 40,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: size,
            height: size,
            child: CircularProgressIndicator(
              strokeWidth: 3,
              color: context.primaryColor,
              backgroundColor: context.primaryColor.withOpacity(0.12),
            ),
          ),
          if (message != null) ...[
            const SizedBox(height: AppTheme.spaceLg),
            Text(
              message!,
              style: AppTheme.bodySm.copyWith(
                color: context.textSecondary,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ],
=======
import 'package:shimmer/shimmer.dart';
import 'package:kenvinsam_sarihub/utils/theme.dart';

/// A shimmer loading skeleton for product list views.
class LoadingWidget extends StatelessWidget {
  final int itemCount;

  const LoadingWidget({super.key, this.itemCount = 5});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Shimmer.fromColors(
      baseColor: isDark ? Colors.grey.shade800 : Colors.grey.shade200,
      highlightColor: isDark ? Colors.grey.shade700 : Colors.grey.shade100,
      child: ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: itemCount,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(bottom: AppTheme.spaceMd),
            child: Container(
              padding: const EdgeInsets.all(AppTheme.spaceMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(AppTheme.radiusLg),
              ),
              child: Row(
                children: [
                  Container(
                    width: 56,
                    height: 56,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(AppTheme.radiusMd),
                    ),
                  ),
                  const SizedBox(width: AppTheme.spaceMd),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(height: 14, width: double.infinity, color: Colors.white),
                        const SizedBox(height: 8),
                        Container(height: 12, width: 100, color: Colors.white),
                        const SizedBox(height: 8),
                        Container(height: 14, width: 80, color: Colors.white),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
>>>>>>> 4dd908a849b3b51b9738ab984e1088d324c50337
      ),
    );
  }
}
