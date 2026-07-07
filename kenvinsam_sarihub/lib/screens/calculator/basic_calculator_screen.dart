import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:kenvinsam_sarihub/models/calc_history.dart';
import 'package:kenvinsam_sarihub/services/calc_history_service.dart';
import 'package:kenvinsam_sarihub/widgets/app_dialog.dart';
import 'package:kenvinsam_sarihub/utils/helpers.dart';
import 'package:kenvinsam_sarihub/utils/theme.dart';

class BasicCalculatorScreen extends StatefulWidget {
  const BasicCalculatorScreen({super.key});

  @override
  State<BasicCalculatorScreen> createState() => _BasicCalculatorScreenState();
}

class _BasicCalculatorScreenState extends State<BasicCalculatorScreen>
    with SingleTickerProviderStateMixin {
  late TabController _innerTabController;
  final _historyService = CalcHistoryService();

  // Calculator state
  String _display = '0';
  String _expression = '';
  double _firstOperand = 0;
  String _operator = '';
  bool _waitingForSecond = false;
  bool _justEvaluated = false;
  List<CalcHistory> _history = [];

  @override
  void initState() {
    super.initState();
    _innerTabController = TabController(length: 2, vsync: this);
    _loadHistory();
  }

  @override
  void dispose() {
    _innerTabController.dispose();
    super.dispose();
  }

  Future<void> _loadHistory() async {
    final list = await _historyService.getAll();
    setState(() => _history = list);
  }

  // ─── Calculator logic ───

  void _onDigit(String digit) {
    setState(() {
      if (_justEvaluated) {
        _display = digit;
        _expression = digit;
        _justEvaluated = false;
        return;
      }
      if (_waitingForSecond) {
        _display = digit;
        _waitingForSecond = false;
      } else {
        _display = _display == '0' ? digit : _display + digit;
      }
    });
  }

  void _onDecimal() {
    setState(() {
      if (_justEvaluated) { _display = '0.'; _justEvaluated = false; return; }
      if (_waitingForSecond) { _display = '0.'; _waitingForSecond = false; return; }
      if (!_display.contains('.')) _display += '.';
    });
  }

  void _onOperator(String op) {
    setState(() {
      _justEvaluated = false;
      final value = double.tryParse(_display) ?? 0;
      if (_operator.isNotEmpty && !_waitingForSecond) {
        final result = _evaluate(_firstOperand, value, _operator);
        _firstOperand = result;
        _display = _formatResult(result);
      } else {
        _firstOperand = value;
      }
      _operator = op;
      _expression = '${_formatResult(_firstOperand)} $op';
      _waitingForSecond = true;
    });
  }

  void _onEquals() {
    if (_operator.isEmpty) return;
    setState(() {
      final second = double.tryParse(_display) ?? 0;
      final result = _evaluate(_firstOperand, second, _operator);
      final fullExpr = '${_formatResult(_firstOperand)} $_operator ${_formatResult(second)}';
      final resultStr = _formatResult(result);

      _historyService.save('$fullExpr =', resultStr);
      _loadHistory();

      _expression = '$fullExpr =';
      _display = resultStr;
      _operator = '';
      _firstOperand = result;
      _waitingForSecond = false;
      _justEvaluated = true;
    });
  }

  void _onPercent() {
    setState(() {
      final value = double.tryParse(_display) ?? 0;
      final result = value / 100;
      _display = _formatResult(result);
      _justEvaluated = false;
    });
  }

  void _onToggleSign() {
    setState(() {
      final value = double.tryParse(_display) ?? 0;
      _display = _formatResult(-value);
    });
  }

  void _onBackspace() {
    setState(() {
      if (_display.length > 1) {
        _display = _display.substring(0, _display.length - 1);
      } else {
        _display = '0';
      }
    });
  }

  void _onClear() {
    setState(() {
      _display = '0';
      _expression = '';
      _firstOperand = 0;
      _operator = '';
      _waitingForSecond = false;
      _justEvaluated = false;
    });
  }

  double _evaluate(double a, double b, String op) {
    switch (op) {
      case '+': return a + b;
      case '−': return a - b;
      case '×': return a * b;
      case '÷': return b != 0 ? a / b : double.nan;
      default: return b;
    }
  }

  String _formatResult(double value) {
    if (value.isNaN) return 'Error';
    if (value.isInfinite) return 'Error';
    if (value == value.truncateToDouble() && value.abs() < 1e12) {
      return value.toInt().toString();
    }
    // Up to 10 significant digits
    final str = value.toStringAsPrecision(10);
    // Remove trailing zeros after decimal
    if (str.contains('.')) {
      return str.replaceAll(RegExp(r'0+$'), '').replaceAll(RegExp(r'\.$'), '');
    }
    return str;
  }

  void _useHistoryItem(CalcHistory item) {
    setState(() {
      _display = item.result;
      _expression = item.expression;
      _justEvaluated = true;
    });
    _innerTabController.animateTo(0);
  }

  // ─── Build ───

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TabBar(
          controller: _innerTabController,
          labelColor: AppTheme.primaryGreen,
          unselectedLabelColor: context.textSecondary,
          indicatorColor: AppTheme.primaryGreen,
          indicatorWeight: 3,
          labelStyle: AppTheme.label.copyWith(fontSize: 13),
          tabs: const [
            Tab(text: 'Calculator', icon: Icon(Icons.dialpad_rounded, size: 18)),
            Tab(text: 'History', icon: Icon(Icons.history_rounded, size: 18)),
          ],
        ),
        Expanded(
          child: TabBarView(
            controller: _innerTabController,
            children: [
              _buildCalculator(),
              _buildHistory(),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCalculator() {
    final isDark = context.isDark;
    final display = _display.length > 14
        ? _display.substring(_display.length - 14)
        : _display;

    return Column(
      children: [
        // ── Display ──
        Expanded(
          flex: 3,
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(
                AppTheme.space2xl, AppTheme.spaceLg, AppTheme.space2xl, AppTheme.spaceLg),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: isDark
                    ? [const Color(0xFF0F1419), const Color(0xFF1A2332)]
                    : [AppTheme.darkGreen, AppTheme.primaryGreen],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                // Expression line
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 150),
                  child: Text(
                    _expression,
                    key: ValueKey(_expression),
                    style: AppTheme.bodyMd.copyWith(
                      color: Colors.white.withOpacity(0.55),
                      fontSize: 15,
                    ),
                    textAlign: TextAlign.end,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(height: AppTheme.spaceSm),
                // Main display
                GestureDetector(
                  onLongPress: () {
                    Clipboard.setData(ClipboardData(text: _display));
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Copied'), duration: Duration(seconds: 1)),
                    );
                  },
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    alignment: Alignment.centerRight,
                    child: Text(
                      display,
                      style: const TextStyle(
                        fontSize: 56,
                        fontWeight: FontWeight.w300,
                        color: Colors.white,
                        letterSpacing: -1,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),

        // ── Keypad ──
        Expanded(
          flex: 5,
          child: Container(
            color: isDark ? AppTheme.cardDark : Colors.white,
            padding: const EdgeInsets.all(AppTheme.spaceMd),
            child: Column(
              children: [
                _keyRow([
                  _CalcKey('AC', _onClear, type: _KeyType.function),
                  _CalcKey('+/−', _onToggleSign, type: _KeyType.function),
                  _CalcKey('%', _onPercent, type: _KeyType.function),
                  _CalcKey('÷', () => _onOperator('÷'), type: _KeyType.operator, isActive: _operator == '÷'),
                ]),
                _keyRow([
                  _CalcKey('7', () => _onDigit('7')),
                  _CalcKey('8', () => _onDigit('8')),
                  _CalcKey('9', () => _onDigit('9')),
                  _CalcKey('×', () => _onOperator('×'), type: _KeyType.operator, isActive: _operator == '×'),
                ]),
                _keyRow([
                  _CalcKey('4', () => _onDigit('4')),
                  _CalcKey('5', () => _onDigit('5')),
                  _CalcKey('6', () => _onDigit('6')),
                  _CalcKey('−', () => _onOperator('−'), type: _KeyType.operator, isActive: _operator == '−'),
                ]),
                _keyRow([
                  _CalcKey('1', () => _onDigit('1')),
                  _CalcKey('2', () => _onDigit('2')),
                  _CalcKey('3', () => _onDigit('3')),
                  _CalcKey('+', () => _onOperator('+'), type: _KeyType.operator, isActive: _operator == '+'),
                ]),
                _keyRow([
                  _CalcKey('⌫', _onBackspace, type: _KeyType.function),
                  _CalcKey('0', () => _onDigit('0')),
                  _CalcKey('.', _onDecimal),
                  _CalcKey('=', _onEquals, type: _KeyType.equals),
                ]),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _keyRow(List<_CalcKey> keys) {
    return Expanded(
      child: Row(
        children: keys.map((key) => Expanded(
          child: Padding(
            padding: const EdgeInsets.all(4),
            child: _KeyButton(calcKey: key),
          ),
        )).toList(),
      ),
    );
  }

  Widget _buildHistory() {
    if (_history.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.history_rounded, size: 56, color: Colors.grey.shade400),
            const SizedBox(height: AppTheme.spaceMd),
            Text('No calculations yet', style: AppTheme.bodyMd.copyWith(color: context.textSecondary)),
          ],
        ),
      );
    }

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(AppTheme.spaceLg, AppTheme.spaceMd, AppTheme.spaceMd, 0),
          child: Row(
            children: [
              Text('${_history.length} saved calculation(s)',
                  style: AppTheme.caption.copyWith(color: context.textSecondary)),
              const Spacer(),
              TextButton.icon(
                onPressed: _confirmClearAll,
                icon: const Icon(Icons.delete_sweep_rounded, size: 16),
                label: const Text('Clear All'),
                style: TextButton.styleFrom(foregroundColor: AppTheme.error),
              ),
            ],
          ),
        ),
        Expanded(
          child: AnimationLimiter(
            child: ListView.separated(
              padding: const EdgeInsets.all(AppTheme.spaceLg),
              itemCount: _history.length,
              separatorBuilder: (_, __) => const SizedBox(height: AppTheme.spaceSm),
              itemBuilder: (context, index) {
                final item = _history[index];
                return AnimationConfiguration.staggeredList(
                  position: index,
                  duration: const Duration(milliseconds: 300),
                  child: SlideAnimation(
                    verticalOffset: 20,
                    child: FadeInAnimation(
                      child: _HistoryCard(
                        item: item,
                        onTap: () => _useHistoryItem(item),
                        onDelete: () async {
                          await _historyService.deleteOne(item.id!);
                          _loadHistory();
                        },
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }

  void _confirmClearAll() async {
    final ok = await AppDialog.confirm(
      context: context,
      title: 'Clear History',
      message: 'Delete all calculation history? This cannot be undone.',
      icon: Icons.delete_sweep_rounded,
      confirmLabel: 'Clear All',
      destructive: true,
    );
    if (!ok || !mounted) return;
    await _historyService.clearAll();
    _loadHistory();
  }
}

// ─── Key types ───
enum _KeyType { digit, operator, function, equals }

class _CalcKey {
  final String label;
  final VoidCallback onTap;
  final _KeyType type;
  final bool isActive;

  const _CalcKey(this.label, this.onTap,
      {this.type = _KeyType.digit, this.isActive = false});
}

// ─── Key button widget ───
class _KeyButton extends StatelessWidget {
  final _CalcKey calcKey;

  const _KeyButton({super.key, required this.calcKey});

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDark;

    Color bg;
    Color fg;

    switch (calcKey.type) {
      case _KeyType.operator:
        bg = calcKey.isActive
            ? AppTheme.primaryGreen
            : AppTheme.primaryGreen.withOpacity(0.12);
        fg = calcKey.isActive ? Colors.white : AppTheme.primaryGreen;
        break;
      case _KeyType.equals:
        bg = AppTheme.primaryGreen;
        fg = Colors.white;
        break;
      case _KeyType.function:
        bg = isDark ? Colors.grey.shade800 : Colors.grey.shade200;
        fg = isDark ? Colors.white : AppTheme.textPrimary;
        break;
      case _KeyType.digit:
      default:
        bg = isDark ? const Color(0xFF2A2A2A) : Colors.grey.shade100;
        fg = isDark ? Colors.white : AppTheme.textPrimary;
    }

    return Material(
      color: bg,
      borderRadius: BorderRadius.circular(AppTheme.radiusMd),
      child: InkWell(
        onTap: calcKey.onTap,
        borderRadius: BorderRadius.circular(AppTheme.radiusMd),
        child: Container(
          alignment: Alignment.center,
          child: calcKey.label == '⌫'
              ? Icon(Icons.backspace_outlined, color: fg, size: 22)
              : Text(
                  calcKey.label,
                  style: TextStyle(
                    fontSize: calcKey.type == _KeyType.operator ||
                            calcKey.type == _KeyType.equals
                        ? 26
                        : 22,
                    fontWeight: FontWeight.w400,
                    color: fg,
                  ),
                ),
        ),
      ),
    );
  }
}

// ─── History card ───
class _HistoryCard extends StatelessWidget {
  final CalcHistory item;
  final VoidCallback onTap;
  final VoidCallback onDelete;

  const _HistoryCard({
    required this.item,
    required this.onTap,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDark;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppTheme.radiusMd),
        child: Container(
          padding: const EdgeInsets.symmetric(
              horizontal: AppTheme.spaceLg, vertical: AppTheme.spaceMd),
          decoration: BoxDecoration(
            color: isDark ? AppTheme.cardDark : Colors.white,
            borderRadius: BorderRadius.circular(AppTheme.radiusMd),
            border: Border.all(
              color: isDark ? Colors.grey.shade800 : Colors.grey.shade200,
              width: 1,
            ),
          ),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.expression,
                      style: AppTheme.bodySm.copyWith(
                        color: context.textSecondary,
                        fontSize: 13,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 2),
                    Text(
                      item.result,
                      style: AppTheme.headingSm.copyWith(
                        color: AppTheme.primaryGreen,
                        fontSize: 20,
                        letterSpacing: -0.5,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      Helpers.timeAgo(item.createdAt),
                      style: AppTheme.caption.copyWith(
                          color: context.textMuted, fontSize: 10),
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Copy result
                  IconButton(
                    icon: Icon(Icons.copy_rounded,
                        size: 18, color: context.textSecondary),
                    tooltip: 'Copy result',
                    splashRadius: 18,
                    onPressed: () {
                      Clipboard.setData(ClipboardData(text: item.result));
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Copied to clipboard'),
                          duration: Duration(seconds: 1),
                        ),
                      );
                    },
                  ),
                  // Delete
                  IconButton(
                    icon: const Icon(Icons.close_rounded,
                        size: 18, color: AppTheme.error),
                    tooltip: 'Delete',
                    splashRadius: 18,
                    onPressed: onDelete,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
