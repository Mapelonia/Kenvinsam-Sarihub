import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:kenvinsam_sarihub/services/backup_service.dart';
import 'package:kenvinsam_sarihub/widgets/app_dialog.dart';
import 'package:kenvinsam_sarihub/widgets/app_snackbar.dart';
import 'package:kenvinsam_sarihub/utils/theme.dart';

class BackupRestoreScreen extends StatefulWidget {
  const BackupRestoreScreen({super.key});

  @override
  State<BackupRestoreScreen> createState() => _BackupRestoreScreenState();
}

class _BackupRestoreScreenState extends State<BackupRestoreScreen> {
  final _service = BackupService();
  List<FileSystemEntity> _localBackups = [];
  bool _isExporting = false;
  bool _isImporting = false;
  bool _isLoadingBackups = true;

  @override
  void initState() {
    super.initState();
    _loadLocalBackups();
  }

  Future<void> _loadLocalBackups() async {
    setState(() => _isLoadingBackups = true);
    final files = await _service.getLocalBackups();
    setState(() {
      _localBackups = files;
      _isLoadingBackups = false;
    });
  }

  // ─── Export ───
  Future<void> _exportBackup() async {
    setState(() => _isExporting = true);
    final result = await _service.exportBackup();
    setState(() => _isExporting = false);

    if (!mounted) return;

    if (result.success) {
      await _loadLocalBackups();
      _showSuccessDialog(
        icon: Icons.download_done_rounded,
        title: 'Backup Created',
        message: result.message,
        color: AppTheme.success,
      );
    } else {
      AppSnackbar.show(context, result.message, type: SnackbarType.error);
    }
  }

<<<<<<< HEAD
  // ─── Export to specific folder ───
  Future<void> _exportToFolder() async {
    setState(() => _isExporting = true);
    final result = await _service.exportBackupToFolder();
    setState(() => _isExporting = false);

    if (!mounted) return;

    if (result.success) {
      await _loadLocalBackups();
      _showSuccessDialog(
        icon: Icons.folder_rounded,
        title: 'Backup Saved',
        message: result.message,
        color: AppTheme.success,
      );
    } else if (result.message != 'No folder selected') {
      AppSnackbar.show(context, result.message, type: SnackbarType.error);
    }
  }

=======
>>>>>>> 4dd908a849b3b51b9738ab984e1088d324c50337
  // ─── Import from file picker ───
  Future<void> _importFromFilePicker() async {
    setState(() => _isImporting = true);
    // Pre-validate by picking the file first and showing a preview
    final service = BackupService();

    // Pick file
    final result = await service.importBackup();
    setState(() => _isImporting = false);

    if (!mounted) return;

    if (!result.success) {
      AppSnackbar.show(context, result.message, type: SnackbarType.error);
      return;
    }

    await _loadLocalBackups();
    _showSuccessDialog(
      icon: Icons.restore_rounded,
      title: 'Restore Complete',
      message: result.message,
      color: AppTheme.primaryGreen,
    );
  }

  // ─── Restore from local backup ───
  Future<void> _restoreFromLocal(String filePath) async {
    // Get preview before confirming
    final counts = await _service.getBackupPreview(filePath);
    if (!mounted) return;

    final fileName = filePath.split('/').last;

    // Show preview dialog
    final confirmed = await showDialog<bool>(
      context: context,
      barrierColor: Colors.black.withOpacity(0.45),
      builder: (ctx) => Dialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppTheme.radiusLg)),
        child: Padding(
          padding: const EdgeInsets.all(AppTheme.spaceLg),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Icon
              Container(
                width: 56, height: 56,
                margin: const EdgeInsets.only(bottom: AppTheme.spaceMd),
                decoration: BoxDecoration(
                  color: AppTheme.warning.withOpacity(0.12),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.restore_rounded,
                    color: AppTheme.warning, size: 28),
              ),
              Text('Restore Backup', style: AppTheme.headingMd,
                  textAlign: TextAlign.center),
              const SizedBox(height: AppTheme.spaceSm),
              Text(
                'This will OVERWRITE all current data with the backup.\nThis cannot be undone.',
                style: AppTheme.bodySm.copyWith(color: AppTheme.textSecondary, height: 1.5),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppTheme.spaceLg),
              // Backup info
              Container(
                padding: const EdgeInsets.all(AppTheme.spaceMd),
                decoration: BoxDecoration(
                  color: AppTheme.paleGreen,
                  borderRadius: BorderRadius.circular(AppTheme.radiusMd),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(children: [
                      const Icon(Icons.folder_zip_rounded,
                          size: 14, color: AppTheme.primaryGreen),
                      const SizedBox(width: 6),
                      Expanded(
                        child: Text(fileName,
                            style: AppTheme.caption.copyWith(
                                color: AppTheme.primaryGreen,
                                fontWeight: FontWeight.w700),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis),
                      ),
                    ]),
                    const SizedBox(height: AppTheme.spaceSm),
                    if (counts.isNotEmpty)
                      ...counts.entries
                          .where((e) => e.value > 0)
                          .map((e) => Padding(
                                padding: const EdgeInsets.only(top: 2),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(e.key,
                                        style: AppTheme.caption.copyWith(
                                            color: AppTheme.primaryGreen)),
                                    Text('${e.value} records',
                                        style: AppTheme.caption.copyWith(
                                            color: AppTheme.primaryGreen,
                                            fontWeight: FontWeight.w600)),
                                  ],
                                ),
                              )),
                  ],
                ),
              ),
              const SizedBox(height: AppTheme.spaceLg),
              Row(children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.pop(ctx, false),
                    child: const Text('Cancel'),
                  ),
                ),
                const SizedBox(width: AppTheme.spaceMd),
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: AppTheme.warning),
                    onPressed: () => Navigator.pop(ctx, true),
                    child: const Text('Restore'),
                  ),
                ),
              ]),
            ],
          ),
        ),
      ),
    );

    if (confirmed != true || !mounted) return;

    setState(() => _isImporting = true);
<<<<<<< HEAD
    final result = await _service.restoreFromFile(filePath);
=======
    final result = await _service.importBackup();
>>>>>>> 4dd908a849b3b51b9738ab984e1088d324c50337
    setState(() => _isImporting = false);

    if (!mounted) return;
    if (result.success) {
      _showSuccessDialog(
        icon: Icons.restore_rounded,
        title: 'Restore Complete',
        message: result.message,
        color: AppTheme.primaryGreen,
      );
    } else {
      AppSnackbar.show(context, result.message, type: SnackbarType.error);
    }
  }

  Future<void> _deleteLocalBackup(FileSystemEntity file) async {
    final ok = await AppDialog.confirm(
      context: context,
      title: 'Delete Backup',
      message: 'Delete this backup file? It cannot be recovered.',
      icon: Icons.delete_rounded,
      confirmLabel: 'Delete',
      destructive: true,
    );
    if (!ok || !mounted) return;
    await _service.deleteBackup(file.path);
    await _loadLocalBackups();
    if (mounted) AppSnackbar.show(context, 'Backup deleted', type: SnackbarType.success);
  }

  void _showSuccessDialog({
    required IconData icon,
    required String title,
    required String message,
    required Color color,
  }) {
    showDialog(
      context: context,
      builder: (ctx) => Dialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppTheme.radiusLg)),
        child: Padding(
          padding: const EdgeInsets.all(AppTheme.space2xl),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 72, height: 72,
                decoration: BoxDecoration(
                  color: color.withOpacity(0.12),
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, color: color, size: 36),
              ),
              const SizedBox(height: AppTheme.spaceLg),
              Text(title, style: AppTheme.headingMd, textAlign: TextAlign.center),
              const SizedBox(height: AppTheme.spaceSm),
              Text(
                message,
                style: AppTheme.bodySm.copyWith(
                    color: AppTheme.textSecondary, height: 1.5),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppTheme.spaceLg),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: color),
                  onPressed: () => Navigator.pop(ctx),
                  child: const Text('Done'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Backup & Restore')),
      body: RefreshIndicator(
        onRefresh: _loadLocalBackups,
        color: AppTheme.primaryGreen,
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.all(AppTheme.spaceLg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // ── Info banner ──
              Container(
                padding: const EdgeInsets.all(AppTheme.spaceMd),
                decoration: BoxDecoration(
                  color: AppTheme.info.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(AppTheme.radiusMd),
                  border: Border.all(color: AppTheme.info.withOpacity(0.25)),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.info_outline_rounded,
                        color: AppTheme.info, size: 20),
                    const SizedBox(width: AppTheme.spaceMd),
                    Expanded(
                      child: Text(
                        'Backups include all products, categories, users, electric bills, and calculator history.',
                        style: AppTheme.bodySm.copyWith(color: AppTheme.info, height: 1.4),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: AppTheme.space2xl),

              // ── Export section ──
              _sectionHeader('Create Backup', Icons.backup_rounded, AppTheme.primaryGreen),
              const SizedBox(height: AppTheme.spaceMd),
              _ActionCard(
                icon: Icons.download_rounded,
                title: 'Export Backup',
                subtitle: 'Save a backup file to this device',
                color: AppTheme.primaryGreen,
                isLoading: _isExporting,
                onTap: _exportBackup,
              ),
<<<<<<< HEAD
              const SizedBox(height: AppTheme.spaceMd),
              _ActionCard(
                icon: Icons.folder_rounded,
                title: 'Save to Folder',
                subtitle: 'Choose a specific folder on your device',
                color: const Color(0xFF8B5CF6),
                isLoading: _isExporting,
                onTap: _exportToFolder,
              ),
=======
>>>>>>> 4dd908a849b3b51b9738ab984e1088d324c50337
              const SizedBox(height: AppTheme.space2xl),

              // ── Import section ──
              _sectionHeader('Restore Backup', Icons.restore_rounded, AppTheme.warning),
              const SizedBox(height: AppTheme.spaceMd),
              _ActionCard(
                icon: Icons.upload_file_rounded,
                title: 'Import from File',
                subtitle: 'Select a .json backup file from your device',
                color: AppTheme.warning,
                isLoading: _isImporting,
                onTap: _importFromFilePicker,
              ),
              const SizedBox(height: AppTheme.space2xl),

              // ── Local backups ──
              Row(children: [
                _sectionHeaderInline('Saved Backups', Icons.folder_open_rounded, AppTheme.info),
                const Spacer(),
                if (_localBackups.isNotEmpty)
                  Text('${_localBackups.length} file(s)',
                      style: AppTheme.caption.copyWith(color: context.textSecondary)),
              ]),
              const SizedBox(height: AppTheme.spaceMd),

              if (_isLoadingBackups)
                const Center(child: Padding(
                  padding: EdgeInsets.all(AppTheme.space2xl),
                  child: CircularProgressIndicator(),
                ))
              else if (_localBackups.isEmpty)
                Container(
                  padding: const EdgeInsets.all(AppTheme.space2xl),
                  decoration: BoxDecoration(
                    color: context.isDark ? AppTheme.cardDark : Colors.grey.shade50,
                    borderRadius: BorderRadius.circular(AppTheme.radiusLg),
                    border: Border.all(color: context.borderColor),
                  ),
                  child: Column(children: [
                    Icon(Icons.folder_off_rounded, size: 40, color: Colors.grey.shade400),
                    const SizedBox(height: AppTheme.spaceMd),
                    Text('No saved backups yet',
                        style: AppTheme.bodyMd.copyWith(color: context.textSecondary)),
                    const SizedBox(height: 4),
                    Text('Create a backup using "Export Backup" above',
                        style: AppTheme.caption.copyWith(color: context.textMuted),
                        textAlign: TextAlign.center),
                  ]),
                )
              else
                AnimationLimiter(
                  child: ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: _localBackups.length,
                    separatorBuilder: (_, __) => const SizedBox(height: AppTheme.spaceSm),
                    itemBuilder: (context, index) {
                      final file = _localBackups[index];
                      final name = file.path.split('/').last;
                      final stat = FileStat.statSync(file.path);
                      final size = '${(stat.size / 1024).toStringAsFixed(1)} KB';

                      return AnimationConfiguration.staggeredList(
                        position: index,
                        duration: const Duration(milliseconds: 300),
                        child: SlideAnimation(
                          verticalOffset: 15,
                          child: FadeInAnimation(
                            child: _BackupFileCard(
                              name: name,
                              size: size,
                              modified: stat.modified,
                              onRestore: () => _restoreFromLocal(file.path),
                              onDelete: () => _deleteLocalBackup(file),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _sectionHeader(String title, IconData icon, Color color) {
    return Row(children: [
      Container(
        padding: const EdgeInsets.all(7),
        decoration: BoxDecoration(
          color: color.withOpacity(0.12),
          borderRadius: BorderRadius.circular(AppTheme.radiusSm),
        ),
        child: Icon(icon, size: 16, color: color),
      ),
      const SizedBox(width: AppTheme.spaceMd),
      Text(title, style: AppTheme.headingMd),
    ]);
  }

  Widget _sectionHeaderInline(String title, IconData icon, Color color) {
    return Row(mainAxisSize: MainAxisSize.min, children: [
      Container(
        padding: const EdgeInsets.all(7),
        decoration: BoxDecoration(
          color: color.withOpacity(0.12),
          borderRadius: BorderRadius.circular(AppTheme.radiusSm),
        ),
        child: Icon(icon, size: 16, color: color),
      ),
      const SizedBox(width: AppTheme.spaceMd),
      Text(title, style: AppTheme.headingMd),
    ]);
  }
}

// ─── Action card ───
class _ActionCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final Color color;
  final bool isLoading;
  final VoidCallback onTap;

  const _ActionCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.color,
    required this.isLoading,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: isLoading ? null : onTap,
        borderRadius: BorderRadius.circular(AppTheme.radiusLg),
        child: Container(
          padding: const EdgeInsets.all(AppTheme.spaceLg),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [color.withOpacity(0.10), color.withOpacity(0.04)],
              begin: Alignment.topLeft, end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(AppTheme.radiusLg),
            border: Border.all(color: color.withOpacity(0.2)),
          ),
          child: Row(children: [
            Container(
              width: 48, height: 48,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [color, color.withOpacity(0.75)],
                  begin: Alignment.topLeft, end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(AppTheme.radiusMd),
                boxShadow: [BoxShadow(color: color.withOpacity(0.3), blurRadius: 8, offset: const Offset(0, 3))],
              ),
              child: isLoading
                  ? const Padding(
                      padding: EdgeInsets.all(12),
                      child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                    )
                  : Icon(icon, color: Colors.white, size: 24),
            ),
            const SizedBox(width: AppTheme.spaceMd),
            Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(title, style: AppTheme.bodyLg.copyWith(fontWeight: FontWeight.w700, color: color)),
              const SizedBox(height: 2),
              Text(subtitle, style: AppTheme.caption.copyWith(color: context.textSecondary)),
            ])),
            Icon(Icons.arrow_forward_ios_rounded, size: 14, color: color.withOpacity(0.6)),
          ]),
        ),
      ),
    );
  }
}

// ─── Backup file card ───
class _BackupFileCard extends StatelessWidget {
  final String name;
  final String size;
  final DateTime modified;
  final VoidCallback onRestore;
  final VoidCallback onDelete;

  const _BackupFileCard({
    required this.name,
    required this.size,
    required this.modified,
    required this.onRestore,
    required this.onDelete,
  });

  String _formatDate(DateTime dt) {
    return '${dt.day}/${dt.month}/${dt.year}  ${dt.hour.toString().padLeft(2, '0')}:${dt.minute.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDark;
    return Container(
      padding: const EdgeInsets.symmetric(
          horizontal: AppTheme.spaceLg, vertical: AppTheme.spaceMd),
      decoration: BoxDecoration(
        color: isDark ? AppTheme.cardDark : Colors.white,
        borderRadius: BorderRadius.circular(AppTheme.radiusLg),
        border: Border.all(color: context.borderColor),
      ),
      child: Row(children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: AppTheme.info.withOpacity(0.1),
            borderRadius: BorderRadius.circular(AppTheme.radiusMd),
          ),
          child: const Icon(Icons.description_rounded, color: AppTheme.info, size: 22),
        ),
        const SizedBox(width: AppTheme.spaceMd),
        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(name,
              style: AppTheme.bodyMd.copyWith(fontWeight: FontWeight.w600),
              maxLines: 1, overflow: TextOverflow.ellipsis),
          const SizedBox(height: 2),
          Text('$size  •  ${_formatDate(modified)}',
              style: AppTheme.caption.copyWith(color: context.textSecondary)),
        ])),
        IconButton(
          icon: const Icon(Icons.restore_rounded, color: AppTheme.primaryGreen, size: 22),
          tooltip: 'Restore',
          splashRadius: 20,
          onPressed: onRestore,
        ),
        IconButton(
          icon: Icon(Icons.delete_outline_rounded, color: AppTheme.error, size: 22),
          tooltip: 'Delete',
          splashRadius: 20,
          onPressed: onDelete,
        ),
      ]),
    );
  }
}
