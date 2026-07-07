import 'package:flutter/material.dart';
import 'package:kenvinsam_sarihub/utils/theme.dart';

/// In-app rendering of the KVS monogram logo.
<<<<<<< HEAD
=======
/// Use this widget anywhere you'd want to show the brand mark.
>>>>>>> 4dd908a849b3b51b9738ab984e1088d324c50337
class AppLogo extends StatelessWidget {
  final double size;
  final Color? color;
  final bool showBackground;

  const AppLogo({
    super.key,
    this.size = 80,
    this.color,
    this.showBackground = true,
  });

  @override
  Widget build(BuildContext context) {
    final fg = color ?? Colors.white;

    final logo = CustomPaint(
      size: Size(size, size),
      painter: _KvsLogoPainter(color: fg),
    );

    if (!showBackground) return logo;

    return Container(
      width: size * 1.4,
      height: size * 1.4,
      decoration: BoxDecoration(
<<<<<<< HEAD
        gradient: AppTheme.primaryGradient,
        borderRadius: BorderRadius.circular(size * 0.3),
        boxShadow: [
          BoxShadow(
            color: AppTheme.primaryGreen.withOpacity(0.25),
            blurRadius: 20,
            offset: const Offset(0, 8),
=======
        gradient: const LinearGradient(
          colors: [AppTheme.primaryGreen, AppTheme.lightGreen],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(size * 0.32),
        boxShadow: [
          BoxShadow(
            color: AppTheme.primaryGreen.withOpacity(0.3),
            blurRadius: 16,
            offset: const Offset(0, 6),
>>>>>>> 4dd908a849b3b51b9738ab984e1088d324c50337
          ),
        ],
      ),
      child: Center(child: logo),
    );
  }
}

class _KvsLogoPainter extends CustomPainter {
  final Color color;

  _KvsLogoPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;
    final scale = w / 1024.0;

<<<<<<< HEAD
=======
    // Layout matches the generator script
>>>>>>> 4dd908a849b3b51b9738ab984e1088d324c50337
    final letterHeight = 360 * scale;
    final letterWidth = 180 * scale;
    final gap = 30 * scale;
    final stroke = 80 * scale;
    final totalWidth = letterWidth * 3 + gap * 2;
    final cx = w / 2;
    final cy = 520 * scale;
    final top = cy - letterHeight / 2;
    final bot = cy + letterHeight / 2;
    final startX = cx - totalWidth / 2;

    final fillPaint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final strokePaint = Paint()
      ..color = color
      ..strokeWidth = stroke
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    // ─── K ───
    final kX = startX;
    final mid = top + letterHeight / 2;
<<<<<<< HEAD
=======
    // Vertical bar
>>>>>>> 4dd908a849b3b51b9738ab984e1088d324c50337
    canvas.drawRRect(
      RRect.fromLTRBR(kX, top, kX + stroke, bot, Radius.circular(stroke / 2)),
      fillPaint,
    );
<<<<<<< HEAD
=======
    // Upper diagonal
>>>>>>> 4dd908a849b3b51b9738ab984e1088d324c50337
    canvas.drawLine(
      Offset(kX + stroke / 2, mid),
      Offset(kX + letterWidth, top + stroke / 2),
      strokePaint,
    );
<<<<<<< HEAD
=======
    // Lower diagonal
>>>>>>> 4dd908a849b3b51b9738ab984e1088d324c50337
    canvas.drawLine(
      Offset(kX + stroke / 2, mid),
      Offset(kX + letterWidth, bot - stroke / 2),
      strokePaint,
    );

    // ─── V ───
    final vX = startX + letterWidth + gap;
    final vCx = vX + letterWidth / 2;
    canvas.drawLine(
      Offset(vX + stroke / 2, top + stroke / 2),
      Offset(vCx, bot - stroke / 2),
      strokePaint,
    );
    canvas.drawLine(
      Offset(vX + letterWidth - stroke / 2, top + stroke / 2),
      Offset(vCx, bot - stroke / 2),
      strokePaint,
    );

    // ─── S ───
    final sX = startX + (letterWidth + gap) * 2;
    final third = letterHeight / 3;
    final r = Radius.circular(stroke / 2);

<<<<<<< HEAD
=======
    // Top bar
>>>>>>> 4dd908a849b3b51b9738ab984e1088d324c50337
    canvas.drawRRect(
      RRect.fromLTRBR(sX, top, sX + letterWidth, top + stroke, r),
      fillPaint,
    );
<<<<<<< HEAD
    canvas.drawRect(
      Rect.fromLTRB(sX + letterWidth - stroke, top + stroke / 2,
          sX + letterWidth, top + third + stroke / 2),
      fillPaint,
    );
    canvas.drawRRect(
      RRect.fromLTRBR(
          sX, top + third, sX + letterWidth, top + third + stroke, r),
      fillPaint,
    );
    canvas.drawRect(
      Rect.fromLTRB(
          sX, top + third + stroke / 2, sX + stroke, top + 2 * third + stroke / 2),
      fillPaint,
    );
=======
    // Top-right vertical
    canvas.drawRect(
      Rect.fromLTRB(sX + letterWidth - stroke, top + stroke / 2, sX + letterWidth, top + third + stroke / 2),
      fillPaint,
    );
    // Middle bar
    canvas.drawRRect(
      RRect.fromLTRBR(sX, top + third, sX + letterWidth, top + third + stroke, r),
      fillPaint,
    );
    // Bottom-left vertical
    canvas.drawRect(
      Rect.fromLTRB(sX, top + third + stroke / 2, sX + stroke, top + 2 * third + stroke / 2),
      fillPaint,
    );
    // Bottom bar
>>>>>>> 4dd908a849b3b51b9738ab984e1088d324c50337
    canvas.drawRRect(
      RRect.fromLTRBR(sX, bot - stroke, sX + letterWidth, bot, r),
      fillPaint,
    );
<<<<<<< HEAD
    canvas.drawRect(
      Rect.fromLTRB(sX + letterWidth - stroke, top + 2 * third,
          sX + letterWidth, bot - stroke / 2),
=======
    // Bottom-right vertical (short)
    canvas.drawRect(
      Rect.fromLTRB(sX + letterWidth - stroke, top + 2 * third, sX + letterWidth, bot - stroke / 2),
>>>>>>> 4dd908a849b3b51b9738ab984e1088d324c50337
      fillPaint,
    );

    // Gold accent dot
    final dotPaint = Paint()..color = const Color(0xFFFFB300);
    canvas.drawCircle(
      Offset(cx, 790 * scale),
      18 * scale,
      dotPaint,
    );
  }

  @override
  bool shouldRepaint(_KvsLogoPainter oldDelegate) => oldDelegate.color != color;
}
