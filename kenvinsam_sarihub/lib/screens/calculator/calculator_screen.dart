import 'package:flutter/material.dart';
import 'package:kenvinsam_sarihub/screens/calculator/basic_calculator_screen.dart';
import 'package:kenvinsam_sarihub/utils/helpers.dart';
import 'package:kenvinsam_sarihub/utils/theme.dart';

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
<<<<<<< HEAD
    _tabController.addListener(() => setState(() {}));
=======
>>>>>>> 4dd908a849b3b51b9738ab984e1088d324c50337
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDark;
<<<<<<< HEAD

    return Column(
      children: [
        // Header
        Padding(
          padding: const EdgeInsets.fromLTRB(
            AppTheme.spaceLg,
            AppTheme.space2xl,
            AppTheme.spaceLg,
            AppTheme.spaceSm,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Calculator',
                style: AppTheme.headingLg.copyWith(
                  color: context.textPrimary,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Business tools at your fingertips',
                style: AppTheme.bodySm.copyWith(
                  color: context.textSecondary,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: AppTheme.spaceMd),

        // Tab chips
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: AppTheme.spaceLg),
          child: Row(
            children: [
              _TabChip(
                icon: Icons.calculate_rounded,
                label: 'Calculator',
                isSelected: _tabController.index == 0,
                onTap: () => _tabController.animateTo(0),
              ),
              const SizedBox(width: AppTheme.spaceSm),
              _TabChip(
                icon: Icons.trending_up_rounded,
                label: 'Profit',
                isSelected: _tabController.index == 1,
                onTap: () => _tabController.animateTo(1),
              ),
              const SizedBox(width: AppTheme.spaceSm),
              _TabChip(
                icon: Icons.shopping_bag_rounded,
                label: 'Per Piece',
                isSelected: _tabController.index == 2,
                onTap: () => _tabController.animateTo(2),
              ),
              const SizedBox(width: AppTheme.spaceSm),
              _TabChip(
                icon: Icons.lightbulb_rounded,
                label: 'Suggester',
                isSelected: _tabController.index == 3,
                onTap: () => _tabController.animateTo(3),
              ),
            ],
          ),
        ),
        const SizedBox(height: AppTheme.spaceLg),

        // Content
=======
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            color: isDark ? AppTheme.cardDark : Colors.white,
            border: Border(
              bottom: BorderSide(
                color: isDark ? Colors.grey.shade800 : Colors.grey.shade200,
                width: 1,
              ),
            ),
          ),
          child: TabBar(
            controller: _tabController,
            labelColor: AppTheme.primaryGreen,
            unselectedLabelColor: context.textSecondary,
            indicatorColor: AppTheme.primaryGreen,
            indicatorWeight: 3,
            isScrollable: true,
            labelStyle: AppTheme.label.copyWith(fontSize: 12),
            unselectedLabelStyle: AppTheme.bodySm,
            tabs: const [
              Tab(text: 'Calculator', icon: Icon(Icons.calculate_rounded, size: 18)),
              Tab(text: 'Profit', icon: Icon(Icons.trending_up_rounded, size: 18)),
              Tab(text: 'Per Piece', icon: Icon(Icons.shopping_bag_rounded, size: 18)),
              Tab(text: 'Suggester', icon: Icon(Icons.lightbulb_rounded, size: 18)),
            ],
          ),
        ),
>>>>>>> 4dd908a849b3b51b9738ab984e1088d324c50337
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: const [
              BasicCalculatorScreen(),
              _ProfitCalculator(),
              _PerQuantityCalculator(),
              _PriceSuggester(),
            ],
          ),
        ),
      ],
    );
  }
}

<<<<<<< HEAD
class _TabChip extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _TabChip({
    required this.icon,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDark;
    final selectedColor = isDark ? AppTheme.lightGreen : AppTheme.primaryGreen;

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected
              ? selectedColor.withOpacity(isDark ? 0.15 : 0.1)
              : isDark
                  ? AppTheme.cardDark
                  : const Color(0xFFE8ECF0),
          borderRadius: BorderRadius.circular(AppTheme.radiusFull),
          border: Border.all(
            color: isSelected
                ? selectedColor.withOpacity(0.3)
                : Colors.transparent,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 16,
              color: isSelected ? selectedColor : context.textMuted,
            ),
            const SizedBox(width: 6),
            Text(
              label,
              style: AppTheme.caption.copyWith(
                color: isSelected ? selectedColor : context.textSecondary,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

=======
>>>>>>> 4dd908a849b3b51b9738ab984e1088d324c50337
// ─── Reusable Form Card ───
class _FormCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final List<Widget> children;

  const _FormCard({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
<<<<<<< HEAD
    final isDark = context.isDark;

    return Container(
      padding: const EdgeInsets.all(AppTheme.spaceLg),
      decoration: BoxDecoration(
        color: isDark ? AppTheme.cardDark : Colors.white,
        borderRadius: BorderRadius.circular(AppTheme.radiusLg),
        border: Border.all(
          color: isDark
              ? Colors.white.withOpacity(0.06)
              : Colors.grey.shade200,
        ),
        boxShadow: isDark ? null : AppTheme.shadowSm,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: isDark
                      ? AppTheme.lightGreen.withOpacity(0.1)
                      : AppTheme.primaryGreen.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(AppTheme.radiusSm),
                ),
                child: Icon(icon, color: context.primaryColor, size: 20),
              ),
              const SizedBox(width: AppTheme.spaceMd),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: AppTheme.headingSm.copyWith(
                      color: context.textPrimary,
                    )),
                    Text(
                      subtitle,
                      style: AppTheme.caption.copyWith(
                        color: context.textMuted,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: AppTheme.spaceLg),
          ...children,
        ],
=======
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppTheme.spaceLg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: AppTheme.paleGreen,
                    borderRadius: BorderRadius.circular(AppTheme.radiusSm),
                  ),
                  child: Icon(icon, color: AppTheme.primaryGreen, size: 18),
                ),
                const SizedBox(width: AppTheme.spaceMd),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(title, style: AppTheme.headingMd),
                      Text(
                        subtitle,
                        style: AppTheme.caption.copyWith(color: context.textSecondary),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppTheme.spaceLg),
            ...children,
          ],
        ),
>>>>>>> 4dd908a849b3b51b9738ab984e1088d324c50337
      ),
    );
  }
}

// ─── Result Card ───
class _ResultCard extends StatelessWidget {
  final String title;
  final List<Widget> children;
  final Color accentColor;

  const _ResultCard({
    required this.title,
    required this.children,
    this.accentColor = AppTheme.primaryGreen,
  });

  @override
  Widget build(BuildContext context) {
<<<<<<< HEAD
    final isDark = context.isDark;

    return Container(
      padding: const EdgeInsets.all(AppTheme.spaceLg),
      decoration: BoxDecoration(
        color: accentColor.withOpacity(isDark ? 0.08 : 0.04),
        borderRadius: BorderRadius.circular(AppTheme.radiusLg),
        border: Border.all(color: accentColor.withOpacity(0.15)),
=======
    return Container(
      padding: const EdgeInsets.all(AppTheme.spaceLg),
      decoration: BoxDecoration(
        color: accentColor.withOpacity(0.06),
        borderRadius: BorderRadius.circular(AppTheme.radiusLg),
        border: Border.all(color: accentColor.withOpacity(0.2)),
>>>>>>> 4dd908a849b3b51b9738ab984e1088d324c50337
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            title,
<<<<<<< HEAD
            style: AppTheme.label.copyWith(
              color: accentColor,
              letterSpacing: 0.5,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppTheme.spaceLg),
=======
            style: AppTheme.label.copyWith(color: accentColor),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppTheme.spaceMd),
>>>>>>> 4dd908a849b3b51b9738ab984e1088d324c50337
          ...children,
        ],
      ),
    );
  }
}

// ─── Profit Calculator ───
class _ProfitCalculator extends StatefulWidget {
  const _ProfitCalculator();

  @override
  State<_ProfitCalculator> createState() => _ProfitCalculatorState();
}

class _ProfitCalculatorState extends State<_ProfitCalculator> {
  final _capitalController = TextEditingController();
  final _sellingController = TextEditingController();
  double _profit = 0;
  double _profitPercent = 0;

  void _calculate() {
    final capital = double.tryParse(_capitalController.text) ?? 0;
    final selling = double.tryParse(_sellingController.text) ?? 0;
    setState(() {
      _profit = Helpers.calculateProfit(capital, selling);
      _profitPercent = Helpers.calculateProfitPercentage(capital, selling);
    });
  }

  @override
  void dispose() {
    _capitalController.dispose();
    _sellingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final hasInput =
        _capitalController.text.isNotEmpty && _sellingController.text.isNotEmpty;
    final color = _profit >= 0 ? AppTheme.success : AppTheme.error;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppTheme.spaceLg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _FormCard(
            title: 'Profit Calculator',
            subtitle: 'Calculate your profit per product',
<<<<<<< HEAD
            icon: Icons.trending_up_rounded,
=======
            icon: Icons.calculate_rounded,
>>>>>>> 4dd908a849b3b51b9738ab984e1088d324c50337
            children: [
              TextField(
                controller: _capitalController,
                decoration: const InputDecoration(
                  labelText: 'Capital Price',
                  prefixText: '₱ ',
                  prefixIcon: Icon(Icons.payments_outlined),
                ),
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                onChanged: (_) => _calculate(),
              ),
              const SizedBox(height: AppTheme.spaceMd),
              TextField(
                controller: _sellingController,
                decoration: const InputDecoration(
                  labelText: 'Selling Price',
                  prefixText: '₱ ',
                  prefixIcon: Icon(Icons.sell_outlined),
                ),
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                onChanged: (_) => _calculate(),
              ),
            ],
          ),
          const SizedBox(height: AppTheme.spaceLg),
          if (hasInput)
            _ResultCard(
              title: 'RESULTS',
              accentColor: color,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _ResultItem(
<<<<<<< HEAD
                      label: 'Profit',
=======
                      label: 'Profit Amount',
>>>>>>> 4dd908a849b3b51b9738ab984e1088d324c50337
                      value: Helpers.formatCurrency(_profit),
                      color: color,
                      icon: _profit >= 0
                          ? Icons.trending_up_rounded
                          : Icons.trending_down_rounded,
                    ),
                    _ResultItem(
                      label: 'Margin',
                      value: '${_profitPercent.toStringAsFixed(1)}%',
                      color: color,
                      icon: Icons.percent_rounded,
                    ),
                  ],
                ),
              ],
            ),
        ],
      ),
    );
  }
}

// ─── Per Piece Calculator ───
class _PerQuantityCalculator extends StatefulWidget {
  const _PerQuantityCalculator();

  @override
  State<_PerQuantityCalculator> createState() => _PerQuantityCalculatorState();
}

class _PerQuantityCalculatorState extends State<_PerQuantityCalculator> {
  final _capitalPriceController = TextEditingController();
  final _quantityController = TextEditingController();
  final _sellingPerPieceController = TextEditingController();

  double _capitalPerPiece = 0;
  double _profitPerPiece = 0;
  double _totalProfit = 0;
  double _profitPercent = 0;

  void _calculate() {
    final capitalTotal = double.tryParse(_capitalPriceController.text) ?? 0;
    final quantity = int.tryParse(_quantityController.text) ?? 0;
    final sellingPerPiece = double.tryParse(_sellingPerPieceController.text) ?? 0;

    setState(() {
      _capitalPerPiece = quantity > 0 ? capitalTotal / quantity : 0;
      if (sellingPerPiece > 0 && _capitalPerPiece > 0) {
        _profitPerPiece = sellingPerPiece - _capitalPerPiece;
        _totalProfit = _profitPerPiece * quantity;
        _profitPercent = (_profitPerPiece / _capitalPerPiece) * 100;
      } else {
        _profitPerPiece = 0;
        _totalProfit = 0;
        _profitPercent = 0;
      }
    });
  }

  @override
  void dispose() {
    _capitalPriceController.dispose();
    _quantityController.dispose();
    _sellingPerPieceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final quantity = int.tryParse(_quantityController.text) ?? 0;
    final showProfit = _profitPerPiece != 0 && _sellingPerPieceController.text.isNotEmpty;
    final color = _profitPerPiece >= 0 ? AppTheme.success : AppTheme.error;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppTheme.spaceLg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _FormCard(
            title: 'Per Piece Calculator',
            subtitle: 'Calculate price per piece from bulk',
            icon: Icons.shopping_bag_rounded,
            children: [
              TextField(
                controller: _capitalPriceController,
                decoration: const InputDecoration(
                  labelText: 'Capital Price (Total)',
                  prefixText: '₱ ',
                  prefixIcon: Icon(Icons.payments_outlined),
                  hintText: 'e.g. 580',
                ),
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                onChanged: (_) => _calculate(),
              ),
              const SizedBox(height: AppTheme.spaceMd),
              TextField(
                controller: _quantityController,
                decoration: const InputDecoration(
                  labelText: 'Quantity',
                  prefixIcon: Icon(Icons.inventory_2_outlined),
                  hintText: 'e.g. 20',
                ),
                keyboardType: TextInputType.number,
                onChanged: (_) => _calculate(),
              ),
              const SizedBox(height: AppTheme.spaceMd),
              TextField(
                controller: _sellingPerPieceController,
                decoration: const InputDecoration(
                  labelText: 'Selling Price per Piece',
                  prefixText: '₱ ',
                  prefixIcon: Icon(Icons.sell_outlined),
                ),
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                onChanged: (_) => _calculate(),
              ),
            ],
          ),
          const SizedBox(height: AppTheme.spaceLg),

          if (_capitalPerPiece > 0)
            _ResultCard(
              title: 'CAPITAL PER PIECE',
              accentColor: AppTheme.info,
              children: [
                Center(
                  child: Text(
                    Helpers.formatCurrency(_capitalPerPiece),
                    style: AppTheme.headingXl.copyWith(color: AppTheme.info),
                  ),
                ),
                const SizedBox(height: 4),
                Center(
                  child: Text(
                    '${Helpers.formatCurrency(double.tryParse(_capitalPriceController.text) ?? 0)} ÷ $quantity pcs',
                    style: AppTheme.caption.copyWith(color: context.textSecondary),
                  ),
                ),
              ],
            ),
<<<<<<< HEAD
          if (_capitalPerPiece > 0)
            const SizedBox(height: AppTheme.spaceMd),
=======
          const SizedBox(height: AppTheme.spaceMd),
>>>>>>> 4dd908a849b3b51b9738ab984e1088d324c50337

          if (showProfit)
            _ResultCard(
              title: 'PROFIT BREAKDOWN',
              accentColor: color,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _ResultItem(
                      label: 'Per Piece',
                      value: Helpers.formatCurrency(_profitPerPiece),
                      color: color,
                      icon: Icons.shopping_bag_rounded,
                    ),
                    _ResultItem(
                      label: 'Total',
                      value: Helpers.formatCurrency(_totalProfit),
                      color: color,
                      icon: Icons.account_balance_wallet_rounded,
                    ),
                    _ResultItem(
                      label: 'Margin',
                      value: '${_profitPercent.toStringAsFixed(1)}%',
                      color: color,
                      icon: Icons.percent_rounded,
                    ),
                  ],
                ),
<<<<<<< HEAD
=======
                const SizedBox(height: AppTheme.spaceMd),
                Container(
                  padding: const EdgeInsets.all(AppTheme.spaceMd),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(AppTheme.radiusSm),
                  ),
                  child: Column(
                    children: [
                      _SummaryRow('Capital per piece', Helpers.formatCurrency(_capitalPerPiece)),
                      _SummaryRow(
                        'Selling per piece',
                        Helpers.formatCurrency(double.tryParse(_sellingPerPieceController.text) ?? 0),
                      ),
                      _SummaryRow('Profit per piece', Helpers.formatCurrency(_profitPerPiece)),
                      const Divider(height: AppTheme.spaceLg),
                      _SummaryRow(
                        'Total profit ($quantity pcs)',
                        Helpers.formatCurrency(_totalProfit),
                        bold: true,
                      ),
                    ],
                  ),
                ),
>>>>>>> 4dd908a849b3b51b9738ab984e1088d324c50337
              ],
            ),
        ],
      ),
    );
  }
}

// ─── Price Suggester ───
class _PriceSuggester extends StatefulWidget {
  const _PriceSuggester();

  @override
  State<_PriceSuggester> createState() => _PriceSuggesterState();
}

class _PriceSuggesterState extends State<_PriceSuggester> {
  final _capitalController = TextEditingController();
  final _profitPercentController = TextEditingController();
  double _suggestedPrice = 0;
  double _expectedProfit = 0;

  void _calculate() {
    final capital = double.tryParse(_capitalController.text) ?? 0;
    final percent = double.tryParse(_profitPercentController.text) ?? 0;
    setState(() {
      _suggestedPrice = Helpers.suggestSellingPrice(capital, percent);
      _expectedProfit = _suggestedPrice - capital;
    });
  }

  @override
  void dispose() {
    _capitalController.dispose();
    _profitPercentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final hasInput = _capitalController.text.isNotEmpty &&
        _profitPercentController.text.isNotEmpty;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppTheme.spaceLg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _FormCard(
            title: 'Price Suggester',
            subtitle: 'Get a suggested selling price',
            icon: Icons.lightbulb_rounded,
            children: [
              TextField(
                controller: _capitalController,
                decoration: const InputDecoration(
                  labelText: 'Capital Price',
                  prefixText: '₱ ',
                  prefixIcon: Icon(Icons.payments_outlined),
                ),
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                onChanged: (_) => _calculate(),
              ),
              const SizedBox(height: AppTheme.spaceMd),
              TextField(
                controller: _profitPercentController,
                decoration: const InputDecoration(
                  labelText: 'Desired Profit %',
                  suffixText: '%',
                  prefixIcon: Icon(Icons.percent_rounded),
                ),
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                onChanged: (_) => _calculate(),
              ),
            ],
          ),
          const SizedBox(height: AppTheme.spaceLg),
          if (hasInput)
            _ResultCard(
              title: 'SUGGESTED PRICE',
              accentColor: AppTheme.primaryGreen,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _ResultItem(
                      label: 'Sell At',
                      value: Helpers.formatCurrency(_suggestedPrice),
                      color: AppTheme.primaryGreen,
                      icon: Icons.sell_rounded,
                    ),
                    _ResultItem(
                      label: 'Expected Profit',
                      value: Helpers.formatCurrency(_expectedProfit),
                      color: AppTheme.success,
                      icon: Icons.trending_up_rounded,
                    ),
                  ],
                ),
              ],
            ),
        ],
      ),
    );
  }
}

// ─── Shared Result Item ───
class _ResultItem extends StatelessWidget {
  final String label;
  final String value;
  final Color color;
  final IconData icon;

  const _ResultItem({
    required this.label,
    required this.value,
    required this.color,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
<<<<<<< HEAD
          padding: const EdgeInsets.all(10),
=======
          padding: const EdgeInsets.all(8),
>>>>>>> 4dd908a849b3b51b9738ab984e1088d324c50337
          decoration: BoxDecoration(
            color: color.withOpacity(0.12),
            shape: BoxShape.circle,
          ),
<<<<<<< HEAD
          child: Icon(icon, color: color, size: 18),
=======
          child: Icon(icon, color: color, size: 20),
>>>>>>> 4dd908a849b3b51b9738ab984e1088d324c50337
        ),
        const SizedBox(height: AppTheme.spaceSm),
        Text(
          value,
<<<<<<< HEAD
          style: AppTheme.headingSm.copyWith(color: color, fontSize: 15),
=======
          style: AppTheme.headingSm.copyWith(color: color),
>>>>>>> 4dd908a849b3b51b9738ab984e1088d324c50337
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 2),
        Text(
          label,
<<<<<<< HEAD
          style: AppTheme.caption.copyWith(color: context.textMuted),
=======
          style: AppTheme.caption.copyWith(color: context.textSecondary),
>>>>>>> 4dd908a849b3b51b9738ab984e1088d324c50337
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
<<<<<<< HEAD
=======

class _SummaryRow extends StatelessWidget {
  final String label;
  final String value;
  final bool bold;

  const _SummaryRow(this.label, this.value, {this.bold = false});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: AppTheme.bodySm.copyWith(
              color: context.textSecondary,
              fontWeight: bold ? FontWeight.w700 : FontWeight.w500,
            ),
          ),
          Text(
            value,
            style: AppTheme.bodySm.copyWith(
              fontWeight: bold ? FontWeight.w700 : FontWeight.w600,
              color: context.textPrimary,
            ),
          ),
        ],
      ),
    );
  }
}
>>>>>>> 4dd908a849b3b51b9738ab984e1088d324c50337
