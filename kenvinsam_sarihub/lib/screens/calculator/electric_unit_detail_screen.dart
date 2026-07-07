import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:intl/intl.dart';
import 'package:kenvinsam_sarihub/models/electric_bill.dart';
import 'package:kenvinsam_sarihub/services/electric_bill_service.dart';
import 'package:kenvinsam_sarihub/widgets/app_dialog.dart';
import 'package:kenvinsam_sarihub/widgets/app_snackbar.dart';
import 'package:kenvinsam_sarihub/widgets/empty_state_widget.dart';
import 'package:kenvinsam_sarihub/utils/helpers.dart';
import 'package:kenvinsam_sarihub/utils/theme.dart';

class ElectricUnitDetailScreen extends StatefulWidget {
  final ElectricUnit unit;
  final Color color;
  const ElectricUnitDetailScreen({super.key, required this.unit, required this.color});

  @override
  State<ElectricUnitDetailScreen> createState() => _ElectricUnitDetailScreenState();
}

class _ElectricUnitDetailScreenState extends State<ElectricUnitDetailScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final _service = ElectricBillService();

  // Calculator fields
  final _previousController = TextEditingController();
  final _presentController = TextEditingController();
  final _rateController = TextEditingController(text: '11.50');
  final _otherChargesController = TextEditingController(text: '0');
  final _notesController = TextEditingController();
  double _consumption = 0;
  double _electricityCharge = 0;
  double _totalBill = 0;
  String _billingMonth = '';
  DateTime? _billingDate;
  BillPaymentStatus _paymentStatus = BillPaymentStatus.unpaid;

  // History
  List<ElectricBill> _history = [];
  Map<String, List<ElectricBill>> _groupedHistory = {};
  double _avgConsumption = 0;
  double _totalSpent = 0;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _billingMonth = DateFormat('MMMM yyyy').format(DateTime.now());
    _billingDate = DateTime.now();
    _loadData();
  }

  Future<void> _loadData() async {
    setState(() => _isLoading = true);
    _history = await _service.getBillsByUnit(widget.unit.id!);
    _groupedHistory = await _service.getBillsGroupedByMonth(widget.unit.id!);
    _avgConsumption = await _service.getAverageConsumption(widget.unit.id!);
    _totalSpent = await _service.getTotalBillForUnit(widget.unit.id!);
    setState(() => _isLoading = false);
  }

  void _calculate() {
    final previous = double.tryParse(_previousController.text) ?? 0;
    final present = double.tryParse(_presentController.text) ?? 0;
    final rate = double.tryParse(_rateController.text) ?? 0;
    final other = double.tryParse(_otherChargesController.text) ?? 0;
    setState(() {
      _consumption = present - previous;
      _electricityCharge = _consumption * rate;
      _totalBill = _electricityCharge + other;
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    _previousController.dispose();
    _presentController.dispose();
    _rateController.dispose();
    _otherChargesController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  Future<void> _saveRecord() async {
    final previous = double.tryParse(_previousController.text);
    final present = double.tryParse(_presentController.text);
    final rate = double.tryParse(_rateController.text);
    if (previous == null || present == null || rate == null) {
      AppSnackbar.show(context, 'Please fill in all required fields', type: SnackbarType.warning);
      return;
    }
    if (present <= previous) {
      AppSnackbar.show(context, 'Present reading must be greater than previous reading', type: SnackbarType.error);
      return;
    }
    if (rate <= 0) {
      AppSnackbar.show(context, 'Rate must be greater than zero', type: SnackbarType.error);
      return;
    }
    final exists = await _service.billExistsForMonth(widget.unit.id!, _billingMonth);
    if (exists) {
      final proceed = await showDialog<bool>(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('Duplicate Entry'),
          content: Text('A bill already exists for $_billingMonth. Save another?'),
          actions: [
            TextButton(onPressed: () => Navigator.pop(ctx, false), child: const Text('Cancel')),
            ElevatedButton(onPressed: () => Navigator.pop(ctx, true), child: const Text('Save Anyway')),
          ],
        ),
      );
      if (proceed != true) return;
    }
    final other = double.tryParse(_otherChargesController.text) ?? 0;
    final bill = ElectricBill(
      unitId: widget.unit.id!,
      previousReading: previous,
      presentReading: present,
      ratePerKwh: rate,
      consumption: _consumption,
      otherCharges: other,
      totalBill: _totalBill,
      billingMonth: _billingMonth,
      billingDate: _billingDate,
      paymentStatus: _paymentStatus,
      notes: _notesController.text.trim().isEmpty ? null : _notesController.text.trim(),
    );
    await _service.addBillRecord(bill);
    await _loadData();
    _previousController.clear();
    _presentController.clear();
    _notesController.clear();
    _otherChargesController.text = '0';
    setState(() { _consumption = 0; _electricityCharge = 0; _totalBill = 0; _paymentStatus = BillPaymentStatus.unpaid; });
    AppSnackbar.show(context, 'Bill saved for ${widget.unit.unitName}', type: SnackbarType.success);
  }

  Future<void> _selectBillingMonth() async {
    final picked = await showDatePicker(
      context: context, initialDate: DateTime.now(),
      firstDate: DateTime(2020), lastDate: DateTime(2030),
      initialDatePickerMode: DatePickerMode.year,
    );
    if (picked != null) setState(() => _billingMonth = DateFormat('MMMM yyyy').format(picked));
  }

  Future<void> _selectBillingDate() async {
    final picked = await showDatePicker(
      context: context, initialDate: _billingDate ?? DateTime.now(),
      firstDate: DateTime(2020), lastDate: DateTime(2030),
    );
    if (picked != null) setState(() => _billingDate = picked);
  }

  Future<void> _updatePaymentStatus(ElectricBill bill, BillPaymentStatus status) async {
    final updated = bill.copyWith(paymentStatus: status);
    await _service.updateBillRecord(updated);
    await _loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.unit.unitName),
        bottom: TabBar(
          controller: _tabController,
<<<<<<< HEAD
          labelColor: AppTheme.primaryGreen,
          unselectedLabelColor: context.textMuted,
          indicatorColor: AppTheme.primaryGreen,
=======
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white70,
          indicatorColor: Colors.white,
>>>>>>> 4dd908a849b3b51b9738ab984e1088d324c50337
          tabs: const [
            Tab(text: 'Calculator', icon: Icon(Icons.calculate_rounded)),
            Tab(text: 'History', icon: Icon(Icons.receipt_long_rounded)),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [_buildCalculatorTab(), _buildHistoryTab()],
      ),
    );
  }

  Widget _buildCalculatorTab() {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppTheme.spaceLg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (_history.isNotEmpty) ...[
            Row(children: [
              Expanded(child: _StatCard(label: 'Avg Consumption', value: '${_avgConsumption.toStringAsFixed(1)} kWh', icon: Icons.bolt_rounded, color: widget.color)),
              const SizedBox(width: AppTheme.spaceMd),
              Expanded(child: _StatCard(label: 'Total Spent', value: Helpers.formatCurrency(_totalSpent), icon: Icons.payments_rounded, color: Colors.orange)),
            ]),
            const SizedBox(height: AppTheme.spaceLg),
          ],
          Card(child: Padding(
            padding: const EdgeInsets.all(AppTheme.spaceLg),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(children: [
                Icon(Icons.electric_bolt_rounded, color: widget.color),
                const SizedBox(width: AppTheme.spaceSm),
                Text('Calculate Bill', style: AppTheme.headingMd),
              ]),
              const SizedBox(height: AppTheme.spaceLg),
              // Billing Period
              _label('Billing Period'),
              GestureDetector(
                onTap: _selectBillingMonth,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
                  decoration: BoxDecoration(
                    color: isDark ? Colors.grey.shade900 : Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(AppTheme.radiusMd),
                  ),
                  child: Row(children: [
                    Icon(Icons.calendar_month_rounded, color: widget.color, size: 20),
                    const SizedBox(width: 10),
                    Text(_billingMonth, style: AppTheme.bodyMd.copyWith(fontWeight: FontWeight.w500)),
                    const Spacer(),
                    Icon(Icons.edit_rounded, size: 16, color: context.textSecondary),
                  ]),
                ),
              ),
              const SizedBox(height: AppTheme.spaceMd),
              // Billing Date
              _label('Billing Date'),
              GestureDetector(
                onTap: _selectBillingDate,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
                  decoration: BoxDecoration(
                    color: isDark ? Colors.grey.shade900 : Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(AppTheme.radiusMd),
                  ),
                  child: Row(children: [
                    Icon(Icons.event_rounded, color: widget.color, size: 20),
                    const SizedBox(width: 10),
                    Text(_billingDate != null ? Helpers.formatDate(_billingDate!) : 'Select date',
                        style: AppTheme.bodyMd.copyWith(fontWeight: FontWeight.w500)),
                    const Spacer(),
                    Icon(Icons.edit_rounded, size: 16, color: context.textSecondary),
                  ]),
                ),
              ),
              const SizedBox(height: AppTheme.spaceMd),
              TextField(controller: _previousController,
                decoration: const InputDecoration(labelText: 'Previous Reading (kWh)', prefixIcon: Icon(Icons.speed_rounded)),
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                onChanged: (_) => _calculate()),
              const SizedBox(height: AppTheme.spaceMd),
              TextField(controller: _presentController,
                decoration: const InputDecoration(labelText: 'Present Reading (kWh)', prefixIcon: Icon(Icons.speed_rounded)),
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                onChanged: (_) => _calculate()),
              const SizedBox(height: AppTheme.spaceMd),
              TextField(controller: _rateController,
                decoration: const InputDecoration(labelText: 'Rate per kWh', prefixText: '₱ ', prefixIcon: Icon(Icons.attach_money_rounded)),
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                onChanged: (_) => _calculate()),
              const SizedBox(height: AppTheme.spaceMd),
              TextField(controller: _otherChargesController,
                decoration: const InputDecoration(labelText: 'Other Charges', prefixText: '₱ ', prefixIcon: Icon(Icons.add_circle_outline_rounded)),
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                onChanged: (_) => _calculate()),
              const SizedBox(height: AppTheme.spaceMd),
              TextField(controller: _notesController,
                decoration: const InputDecoration(labelText: 'Notes (optional)', prefixIcon: Icon(Icons.notes_rounded)),
                maxLines: 2),
              const SizedBox(height: AppTheme.spaceMd),
              // Payment Status
              _label('Payment Status'),
              SegmentedButton<BillPaymentStatus>(
                segments: const [
                  ButtonSegment(value: BillPaymentStatus.unpaid, label: Text('Unpaid'), icon: Icon(Icons.radio_button_unchecked, size: 16)),
                  ButtonSegment(value: BillPaymentStatus.partial, label: Text('Partial'), icon: Icon(Icons.timelapse_rounded, size: 16)),
                  ButtonSegment(value: BillPaymentStatus.paid, label: Text('Paid'), icon: Icon(Icons.check_circle_rounded, size: 16)),
                ],
                selected: {_paymentStatus},
                onSelectionChanged: (s) => setState(() => _paymentStatus = s.first),
                style: ButtonStyle(
                  foregroundColor: WidgetStateProperty.resolveWith((states) =>
                      states.contains(WidgetState.selected) ? Colors.white : null),
                  backgroundColor: WidgetStateProperty.resolveWith((states) =>
                      states.contains(WidgetState.selected) ? widget.color : null),
                ),
              ),
            ]),
          )),
          const SizedBox(height: AppTheme.spaceMd),
          if (_consumption > 0) _buildCalcResult(),
          if (_consumption < 0) Container(
            padding: const EdgeInsets.all(AppTheme.spaceMd),
            decoration: BoxDecoration(color: AppTheme.error.withOpacity(0.08), borderRadius: BorderRadius.circular(AppTheme.radiusMd)),
            child: Row(children: [
              const Icon(Icons.warning_rounded, color: AppTheme.error, size: 18),
              const SizedBox(width: AppTheme.spaceSm),
              Expanded(child: Text('Present reading must be greater than previous reading', style: AppTheme.caption.copyWith(color: AppTheme.error))),
            ]),
          ),
        ],
      ),
    );
  }

  Widget _label(String text) => Padding(
    padding: const EdgeInsets.only(bottom: 6),
    child: Text(text.toUpperCase(), style: AppTheme.caption.copyWith(color: context.textSecondary, letterSpacing: 0.6, fontWeight: FontWeight.w700)),
  );

  Widget _buildCalcResult() {
    final other = double.tryParse(_otherChargesController.text) ?? 0;
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [widget.color, widget.color.withOpacity(0.75)], begin: Alignment.topLeft, end: Alignment.bottomRight),
        borderRadius: BorderRadius.circular(AppTheme.radiusLg),
        boxShadow: [BoxShadow(color: widget.color.withOpacity(0.3), blurRadius: 16, offset: const Offset(0, 6))],
      ),
      padding: const EdgeInsets.all(AppTheme.spaceLg),
      child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Text('CALCULATION RESULT', style: AppTheme.caption.copyWith(color: Colors.white70, letterSpacing: 1)),
          Icon(Icons.electric_bolt_rounded, color: Colors.white70, size: 16),
        ]),
        const SizedBox(height: AppTheme.spaceMd),
        _calcRow('Consumption', '${_consumption.toStringAsFixed(2)} kWh'),
        _calcRow('Electricity Charge', Helpers.formatCurrency(_electricityCharge)),
        if (other > 0) _calcRow('Other Charges', Helpers.formatCurrency(other)),
        const Divider(color: Colors.white30, height: 24),
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Text('TOTAL AMOUNT', style: AppTheme.label.copyWith(color: Colors.white, letterSpacing: 0.5)),
          Text(Helpers.formatCurrency(_totalBill), style: AppTheme.headingLg.copyWith(color: Colors.white, fontSize: 26)),
        ]),
        const SizedBox(height: AppTheme.spaceLg),
        ElevatedButton.icon(
          onPressed: _saveRecord,
          style: ElevatedButton.styleFrom(backgroundColor: Colors.white, foregroundColor: widget.color, elevation: 0),
          icon: const Icon(Icons.save_rounded),
          label: const Text('Save Record'),
        ),
      ]),
    );
  }

  Widget _calcRow(String label, String value) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 4),
    child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Text(label, style: AppTheme.bodySm.copyWith(color: Colors.white70)),
      Text(value, style: AppTheme.bodyMd.copyWith(color: Colors.white, fontWeight: FontWeight.w600)),
    ]),
  );

  Widget _buildHistoryTab() {
    if (_isLoading) return const Center(child: CircularProgressIndicator());
    if (_history.isEmpty) {
      return const EmptyStateWidget(
        icon: Icons.receipt_long_rounded,
        title: 'No bill history yet',
        subtitle: 'Calculate and save your first bill',
      );
    }
    return RefreshIndicator(
      onRefresh: _loadData,
      color: widget.color,
      child: AnimationLimiter(
        child: ListView.builder(
          padding: const EdgeInsets.fromLTRB(AppTheme.spaceLg, AppTheme.spaceLg, AppTheme.spaceLg, AppTheme.space3xl),
          itemCount: _groupedHistory.keys.length,
          itemBuilder: (context, index) {
            final month = _groupedHistory.keys.elementAt(index);
            final bills = _groupedHistory[month]!;
            return AnimationConfiguration.staggeredList(
              position: index,
              duration: const Duration(milliseconds: 350),
              child: SlideAnimation(verticalOffset: 20, child: FadeInAnimation(child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: AppTheme.spaceMd),
                    child: Row(children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(colors: [widget.color, widget.color.withOpacity(0.7)]),
                          borderRadius: BorderRadius.circular(AppTheme.radiusFull),
                        ),
                        child: Text(month, style: AppTheme.label.copyWith(color: Colors.white)),
                      ),
                      const SizedBox(width: AppTheme.spaceSm),
                      Text('${bills.length} record(s)', style: AppTheme.caption.copyWith(color: context.textSecondary)),
                    ]),
                  ),
                  ...bills.map((bill) => Padding(
                    padding: const EdgeInsets.only(bottom: AppTheme.spaceMd),
                    child: _BillReceiptCard(bill: bill, color: widget.color, unitName: widget.unit.unitName,
                      onDelete: () => _confirmDelete(bill),
                      onPaymentChange: (status) => _updatePaymentStatus(bill, status)),
                  )),
                  const SizedBox(height: AppTheme.spaceSm),
                ]),
              )),
            );
          },
        ),
      ),
    );
  }

  void _confirmDelete(ElectricBill bill) async {
    final ok = await AppDialog.confirm(
      context: context,
      title: 'Delete Record',
      message: 'Delete this bill record for ${bill.billingMonth}?',
      icon: Icons.delete_rounded,
      confirmLabel: 'Delete',
      destructive: true,
    );
    if (!ok || !mounted) return;
    await _service.deleteBillRecord(bill.id!);
    await _loadData();
    if (mounted) AppSnackbar.show(context, 'Record deleted', type: SnackbarType.success);
  }
}

// ──────────────────────────────────────────────
// Receipt-style bill card
// ──────────────────────────────────────────────
class _BillReceiptCard extends StatelessWidget {
  final ElectricBill bill;
  final Color color;
  final String unitName;
  final VoidCallback onDelete;
  final ValueChanged<BillPaymentStatus> onPaymentChange;

  const _BillReceiptCard({
    required this.bill,
    required this.color,
    required this.unitName,
    required this.onDelete,
    required this.onPaymentChange,
  });

  Color get _statusColor {
    switch (bill.paymentStatus) {
      case BillPaymentStatus.paid: return AppTheme.success;
      case BillPaymentStatus.partial: return AppTheme.warning;
      case BillPaymentStatus.unpaid: return AppTheme.error;
    }
  }

  IconData get _statusIcon {
    switch (bill.paymentStatus) {
      case BillPaymentStatus.paid: return Icons.check_circle_rounded;
      case BillPaymentStatus.partial: return Icons.timelapse_rounded;
      case BillPaymentStatus.unpaid: return Icons.radio_button_unchecked;
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDark;
    final cardBg = isDark ? AppTheme.cardDark : Colors.white;
    final borderColor = isDark ? Colors.grey.shade800 : Colors.grey.shade200;

    return Container(
      decoration: BoxDecoration(
        color: cardBg,
        borderRadius: BorderRadius.circular(AppTheme.radiusLg),
        border: Border.all(color: borderColor, width: 1),
        boxShadow: isDark ? null : [
          BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 8, offset: const Offset(0, 2)),
        ],
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        // ── Receipt header ──
        Container(
          padding: const EdgeInsets.symmetric(horizontal: AppTheme.spaceLg, vertical: AppTheme.spaceMd),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [color.withOpacity(0.12), color.withOpacity(0.04)],
              begin: Alignment.topLeft, end: Alignment.bottomRight,
            ),
            borderRadius: const BorderRadius.vertical(top: Radius.circular(AppTheme.radiusLg)),
          ),
          child: Row(children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(color: color.withOpacity(0.15), shape: BoxShape.circle),
              child: Icon(Icons.electric_bolt_rounded, color: color, size: 18),
            ),
            const SizedBox(width: AppTheme.spaceMd),
            Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(unitName, style: AppTheme.bodyMd.copyWith(fontWeight: FontWeight.w700, color: context.textPrimary)),
              Text(bill.billingMonth, style: AppTheme.caption.copyWith(color: context.textSecondary)),
            ])),
            Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: _statusColor.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(AppTheme.radiusFull),
                  border: Border.all(color: _statusColor.withOpacity(0.3)),
                ),
                child: Row(mainAxisSize: MainAxisSize.min, children: [
                  Icon(_statusIcon, size: 11, color: _statusColor),
                  const SizedBox(width: 4),
                  Text(bill.paymentStatus.label, style: AppTheme.caption.copyWith(color: _statusColor, fontWeight: FontWeight.w700)),
                ]),
              ),
              PopupMenuButton<BillPaymentStatus?>(
                padding: EdgeInsets.zero,
                icon: Icon(Icons.more_vert_rounded, size: 18, color: context.textSecondary),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppTheme.radiusMd)),
                onSelected: (s) {
                  if (s == null) { onDelete(); return; }
                  onPaymentChange(s);
                },
                itemBuilder: (_) => [
                  ...BillPaymentStatus.values.where((s) => s != bill.paymentStatus).map((s) => PopupMenuItem<BillPaymentStatus?>(
                    value: s, child: Row(children: [
                      Icon(_statusIconFor(s), size: 16, color: _colorFor(s)),
                      const SizedBox(width: 8),
                      Text('Mark as ${s.label}'),
                    ]),
                  )),
                  const PopupMenuDivider(),
                  PopupMenuItem(
                    value: null,
                    child: const Row(children: [
                      Icon(Icons.delete_outline_rounded, size: 16, color: AppTheme.error),
                      SizedBox(width: 8),
                      Text('Delete', style: TextStyle(color: AppTheme.error)),
                    ]),
                  ),
                ],
              ),
            ]),
          ]),
        ),

        // ── Dashed divider ──
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppTheme.spaceLg),
          child: Row(children: List.generate(28, (i) => Expanded(
            child: Container(margin: const EdgeInsets.symmetric(horizontal: 2),
              height: 1, color: i.isEven ? borderColor : Colors.transparent),
          ))),
        ),

        // ── Receipt body ──
        Padding(
          padding: const EdgeInsets.all(AppTheme.spaceLg),
          child: Column(children: [
            _receiptRow(context, 'Billing Date', bill.billingDate != null ? Helpers.formatDate(bill.billingDate!) : '—'),
            _receiptRow(context, 'Previous Reading', '${bill.previousReading.toStringAsFixed(2)} kWh'),
            _receiptRow(context, 'Present Reading', '${bill.presentReading.toStringAsFixed(2)} kWh'),
            _receiptRow(context, 'Total Consumption', '${bill.consumption.toStringAsFixed(2)} kWh', highlight: true, highlightColor: color),
            _receiptRow(context, 'Rate per kWh', '₱ ${bill.ratePerKwh.toStringAsFixed(2)}'),
            const SizedBox(height: AppTheme.spaceSm),
            Divider(color: borderColor, height: 1),
            const SizedBox(height: AppTheme.spaceSm),
            _receiptRow(context, 'Electricity Charge', Helpers.formatCurrency(bill.electricityCharge)),
            if (bill.otherCharges > 0)
              _receiptRow(context, 'Other Charges', Helpers.formatCurrency(bill.otherCharges)),
          ]),
        ),

        // ── Total footer ──
        Container(
          padding: const EdgeInsets.symmetric(horizontal: AppTheme.spaceLg, vertical: AppTheme.spaceMd),
          decoration: BoxDecoration(
            color: color.withOpacity(0.07),
            borderRadius: const BorderRadius.vertical(bottom: Radius.circular(AppTheme.radiusLg)),
            border: Border(top: BorderSide(color: color.withOpacity(0.2))),
          ),
          child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Text('TOTAL AMOUNT', style: AppTheme.label.copyWith(color: color, letterSpacing: 0.5)),
              Text(Helpers.formatCurrency(bill.totalBill), style: AppTheme.headingMd.copyWith(color: color, fontSize: 22)),
            ]),
            if (bill.notes != null && bill.notes!.isNotEmpty) ...[
              const SizedBox(height: AppTheme.spaceSm),
              Text(bill.notes!, style: AppTheme.caption.copyWith(color: context.textSecondary, fontStyle: FontStyle.italic)),
            ],
            const SizedBox(height: AppTheme.spaceSm),
            Row(mainAxisAlignment: MainAxisAlignment.end, children: [
              Icon(Icons.access_time_rounded, size: 11, color: context.textMuted),
              const SizedBox(width: 4),
              Text('Recorded: ${Helpers.formatDateTime(bill.createdAt)}',
                style: AppTheme.caption.copyWith(color: context.textMuted, fontSize: 10)),
            ]),
          ]),
        ),
      ]),
    );
  }

  Widget _receiptRow(BuildContext context, String label, String value, {bool highlight = false, Color? highlightColor}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Text(label, style: AppTheme.bodySm.copyWith(color: context.textSecondary)),
        Text(value, style: AppTheme.bodySm.copyWith(
          fontWeight: highlight ? FontWeight.w700 : FontWeight.w600,
          color: highlight ? (highlightColor ?? context.textPrimary) : context.textPrimary,
        )),
      ]),
    );
  }

  IconData _statusIconFor(BillPaymentStatus s) {
    switch (s) {
      case BillPaymentStatus.paid: return Icons.check_circle_rounded;
      case BillPaymentStatus.partial: return Icons.timelapse_rounded;
      case BillPaymentStatus.unpaid: return Icons.radio_button_unchecked;
    }
  }

  Color _colorFor(BillPaymentStatus s) {
    switch (s) {
      case BillPaymentStatus.paid: return AppTheme.success;
      case BillPaymentStatus.partial: return AppTheme.warning;
      case BillPaymentStatus.unpaid: return AppTheme.error;
    }
  }
}

// ─── Summary stat card ───
class _StatCard extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;
  final Color color;

  const _StatCard({
    required this.label,
    required this.value,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppTheme.spaceMd),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Icon(icon, color: color, size: 20),
          const SizedBox(height: AppTheme.spaceSm),
          Text(value, style: AppTheme.bodyMd.copyWith(fontWeight: FontWeight.w700, color: color)),
          Text(label, style: AppTheme.caption.copyWith(color: context.textSecondary)),
        ]),
      ),
    );
  }
}
