import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:kenvinsam_sarihub/utils/theme.dart';

<<<<<<< HEAD
enum SkeletonType { list, featured, card, grid }

/// Shimmer skeleton loader for loading states.
=======
/// Animated shimmer skeleton loaders for various card layouts.
>>>>>>> 4dd908a849b3b51b9738ab984e1088d324c50337
class SkeletonLoader extends StatelessWidget {
  final SkeletonType type;
  final int count;

  const SkeletonLoader({
    super.key,
    this.type = SkeletonType.list,
<<<<<<< HEAD
    this.count = 3,
=======
    this.count = 4,
>>>>>>> 4dd908a849b3b51b9738ab984e1088d324c50337
  });

  @override
  Widget build(BuildContext context) {
<<<<<<< HEAD
    final isDark = context.isDark;
    final baseColor = isDark ? const Color(0xFF2A2A2A) : Colors.grey.shade200;
    final highlightColor =
        isDark ? const Color(0xFF3A3A3A) : Colors.grey.shade100;

    return Shimmer.fromColors(
      baseColor: baseColor,
      highlightColor: highlightColor,
      child: _buildContent(),
    );
  }

  Widget _buildContent() {
    switch (type) {
      case SkeletonType.list:
        return Column(
          children: List.generate(count, (_) => _listItem()),
        );
      case SkeletonType.featured:
        return SizedBox(
          height: 220,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: count,
            separatorBuilder: (_, __) => const SizedBox(width: 12),
            itemBuilder: (_, __) => _featuredItem(),
          ),
        );
      case SkeletonType.card:
        return Column(
          children: List.generate(count, (_) => _cardItem()),
        );
      case SkeletonType.grid:
        return Wrap(
          spacing: 12,
          runSpacing: 12,
          children: List.generate(count, (_) => _gridItem()),
        );
    }
  }

  Widget _listItem() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Container(
        padding: const EdgeInsets.all(16),
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
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 14,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    height: 10,
                    width: 100,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    height: 12,
                    width: 70,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ],
              ),
            ),
          ],
=======
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final base = isDark ? Colors.grey.shade800 : Colors.grey.shade200;
    final highlight = isDark ? Colors.grey.shade700 : Colors.grey.shade100;

    return Shimmer.fromColors(
      baseColor: base,
      highlightColor: highlight,
      period: const Duration(milliseconds: 1400),
      child: switch (type) {
        SkeletonType.list => _buildList(context),
        SkeletonType.grid => _buildGrid(context),
        SkeletonType.featured => _buildFeatured(context),
        SkeletonType.stat => _buildStat(context),
      },
    );
  }

  Widget _buildList(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: count,
      itemBuilder: (_, __) => Padding(
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
                width: 64,
                height: 64,
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
                    _bar(double.infinity, 16),
                    const SizedBox(height: 8),
                    _bar(120, 12),
                    const SizedBox(height: 10),
                    _bar(80, 14),
                  ],
                ),
              ),
              const SizedBox(width: AppTheme.spaceMd),
              Container(
                width: 56,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(AppTheme.radiusMd),
                ),
              ),
            ],
          ),
>>>>>>> 4dd908a849b3b51b9738ab984e1088d324c50337
        ),
      ),
    );
  }

<<<<<<< HEAD
  Widget _featuredItem() {
    return Container(
      width: 170,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppTheme.radiusLg),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(AppTheme.radiusMd),
              ),
            ),
          ),
          const SizedBox(height: 12),
          Container(
            height: 14,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(4),
            ),
          ),
          const SizedBox(height: 6),
          Container(
            height: 10,
            width: 60,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(4),
            ),
          ),
          const SizedBox(height: 8),
          Container(
            height: 12,
            width: 80,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(4),
            ),
          ),
        ],
      ),
    );
  }

  Widget _cardItem() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Container(
        height: 100,
=======
  Widget _buildGrid(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: AppTheme.spaceMd,
        mainAxisSpacing: AppTheme.spaceMd,
        childAspectRatio: 1.05,
      ),
      itemCount: count,
      itemBuilder: (_, __) => Container(
>>>>>>> 4dd908a849b3b51b9738ab984e1088d324c50337
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(AppTheme.radiusLg),
        ),
      ),
    );
  }

<<<<<<< HEAD
  Widget _gridItem() {
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppTheme.radiusMd),
=======
  Widget _buildFeatured(BuildContext context) {
    return SizedBox(
      height: 230,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: count,
        separatorBuilder: (_, __) => const SizedBox(width: AppTheme.spaceMd),
        itemBuilder: (_, __) => Container(
          width: 168,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(AppTheme.radiusLg),
          ),
        ),
      ),
    );
  }

  Widget _buildStat(BuildContext context) {
    return Row(
      children: List.generate(2, (index) {
        return Expanded(
          child: Container(
            margin: EdgeInsets.only(
              right: index == 0 ? AppTheme.spaceMd : 0,
            ),
            height: 100,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(AppTheme.radiusLg),
            ),
          ),
        );
      }),
    );
  }

  Widget _bar(double width, double height) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(4),
>>>>>>> 4dd908a849b3b51b9738ab984e1088d324c50337
      ),
    );
  }
}
<<<<<<< HEAD
=======

enum SkeletonType { list, grid, featured, stat }
>>>>>>> 4dd908a849b3b51b9738ab984e1088d324c50337
