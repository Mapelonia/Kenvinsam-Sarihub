import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:kenvinsam_sarihub/models/electric_bill.dart';
import 'package:kenvinsam_sarihub/services/electric_bill_service.dart';
import 'package:kenvinsam_sarihub/screens/calculator/electric_unit_detail_screen.dart';
import 'package:kenvinsam_sarihub/utils/helpers.dart';
import 'package:kenvinsam_sarihub/utils/theme.dart';

class ElectricBillScreen extends StatefulWidget {
  const ElectricBillScreen({super.key});

  @override
  State<ElectricBillScreen> createState() => _ElectricBillScreenState();
}

class _ElectricBillScreenState extends State<ElectricBillScreen> {
  final _service = ElectricBillService();
  List<ElectricUnit> _units = [];
  Map<int, ElectricBill?> _latestBills = {};
  bool _isLoading = true;

  // Color palette for unit cards
  static const List<Color> _unitColors = [
    Color(0xFF2196F3), // Blue
    Color(0xFF4CAF50), // Green
    Color(0xFFFF9800), // Orange
    Color(0xFF9C27B0), // Purple
    Color(0xFFE91E63), // Pink
    Color(0xFF00BCD4), // Cyan
    Color(0xFFFF5722), // Deep Orange
    Color(0xFF607D8B), // Blue Grey
  ];

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    setState(() => _isLoading = true);
    _units = await _service.getAllUnits();

    // Load latest bill for each unit
    final Map<int, ElectricBill?> bills = {};
    for (final unit in _units) {
      bills[unit.id!] = await _service.getLatestBill(unit.id!);
    }
    _latestBills = bills;

    setState(() => _isLoading = false);
  }

  Color _getUnitColor(int index) {
    return _unitColors[index % _unitColors.length];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Electric Bill'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            tooltip: 'Add New Unit',
            onPressed: _showAddUnitDialog,
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              onRefresh: _loadData,
              child: _units.isEmpty
                  ? _buildEmptyState()
                  : _buildUnitGrid(),
            ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _showAddUnitDialog,
        icon: const Icon(Icons.add),
        label: const Text('New Unit'),
        backgroundColor: Colors.amber.shade700,
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.electric_bolt, size: 72, color: Colors.amber.shade300),
          const SizedBox(height: 16),
          const Text(
            'No Electric Units',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(
            'Add your first unit to start tracking bills',
            style: TextStyle(color: Colors.grey.shade600),
          ),
          const SizedBox(height: 24),
          ElevatedButton.icon(
            onPressed: _showAddUnitDialog,
            icon: const Icon(Icons.add),
            label: const Text('Create Unit'),
          ),
        ],
      ),
    );
  }

  Widget _buildUnitGrid() {
    return AnimationLimiter(
      child: GridView.builder(
        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: 0.85,
        ),
        itemCount: _units.length,
        itemBuilder: (context, index) {
          final unit = _units[index];
          final latestBill = _latestBills[unit.id];
          final color = _getUnitColor(index);

          return AnimationConfiguration.staggeredGrid(
            position: index,
            columnCount: 2,
            duration: const Duration(milliseconds: 375),
            child: ScaleAnimation(
              child: FadeInAnimation(
                child: _UnitCard(
                  unit: unit,
                  latestBill: latestBill,
                  color: color,
                  onTap: () async {
                    await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => ElectricUnitDetailScreen(
                          unit: unit,
                          color: color,
                        ),
                      ),
                    );
                    _loadData();
                  },
                  onLongPress: () => _showUnitOptions(unit),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void _showAddUnitDialog() {
    final controller = TextEditingController();

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Row(
          children: [
            Icon(Icons.electric_bolt, color: Colors.amber.shade700),
            const SizedBox(width: 8),
            const Text('Create New Unit'),
          ],
        ),
        content: TextField(
          controller: controller,
          autofocus: true,
          decoration: const InputDecoration(
            labelText: 'Unit Name',
            hintText: 'e.g. Unit F, Store, House',
            prefixIcon: Icon(Icons.label),
          ),
          textCapitalization: TextCapitalization.words,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () async {
              if (controller.text.trim().isEmpty) return;
              await _service.addUnit(ElectricUnit(unitName: controller.text.trim()));
              await _loadData();
              if (ctx.mounted) Navigator.pop(ctx);
            },
            child: const Text('Create'),
          ),
        ],
      ),
    );
  }

  void _showUnitOptions(ElectricUnit unit) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) => Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              unit.unitName,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            ListTile(
              leading: const Icon(Icons.edit),
              title: const Text('Rename Unit'),
              onTap: () {
                Navigator.pop(ctx);
                _showRenameDialog(unit);
              },
            ),
            ListTile(
              leading: const Icon(Icons.delete, color: Colors.red),
              title: const Text('Delete Unit', style: TextStyle(color: Colors.red)),
              subtitle: const Text('This will delete all bill history'),
              onTap: () {
                Navigator.pop(ctx);
                _confirmDeleteUnit(unit);
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showRenameDialog(ElectricUnit unit) {
    final controller = TextEditingController(text: unit.unitName);

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Rename Unit'),
        content: TextField(
          controller: controller,
          autofocus: true,
          decoration: const InputDecoration(labelText: 'Unit Name'),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancel')),
          ElevatedButton(
            onPressed: () async {
              if (controller.text.trim().isEmpty) return;
              await _service.updateUnit(unit.copyWith(unitName: controller.text.trim()));
              await _loadData();
              if (ctx.mounted) Navigator.pop(ctx);
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  void _confirmDeleteUnit(ElectricUnit unit) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Delete Unit'),
        content: Text(
          'Delete "${unit.unitName}" and all its bill history? This cannot be undone.',
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancel')),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            onPressed: () async {
              await _service.deleteUnit(unit.id!);
              await _loadData();
              if (ctx.mounted) Navigator.pop(ctx);
            },
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }
}

class _UnitCard extends StatelessWidget {
  final ElectricUnit unit;
  final ElectricBill? latestBill;
  final Color color;
  final VoidCallback onTap;
  final VoidCallback onLongPress;

  const _UnitCard({
    required this.unit,
    required this.latestBill,
    required this.color,
    required this.onTap,
    required this.onLongPress,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: InkWell(
        onTap: onTap,
        onLongPress: onLongPress,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Unit icon and name
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: color.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(Icons.electric_bolt, color: color, size: 22),
                  ),
                  const Spacer(),
                  Icon(Icons.arrow_forward_ios, size: 14, color: Colors.grey.shade400),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                unit.unitName,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const Spacer(),
              // Latest bill info
              if (latestBill != null) ...[
                Text(
                  Helpers.formatCurrency(latestBill!.totalBill),
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  '${latestBill!.consumption.toStringAsFixed(1)} kWh',
                  style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
                ),
                Text(
                  latestBill!.billingMonth,
                  style: TextStyle(fontSize: 11, color: Colors.grey.shade500),
                ),
              ] else ...[
                Text(
                  'No records yet',
                  style: TextStyle(fontSize: 12, color: Colors.grey.shade500),
                ),
                const SizedBox(height: 4),
                Text(
                  'Tap to add',
                  style: TextStyle(fontSize: 11, color: color),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
