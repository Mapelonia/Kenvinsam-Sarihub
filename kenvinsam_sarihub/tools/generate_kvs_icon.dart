// ignore_for_file: avoid_print
import 'dart:io';
import 'dart:math' as math;
import 'package:image/image.dart' as img;

// Color palette
const greenDark = 0xFF1B5E20;
const greenPrimary = 0xFF2E7D32;
const greenLight = 0xFF4CAF50;
const greenAccent = 0xFF66BB6A;
const goldAccent = 0xFFFFB300;
const white = 0xFFFFFFFF;
const black = 0xFF0F1419;
const darkBg = 0xFF111827;

const int size = 1024;
const int radius = 220; // rounded corner radius for adaptive icon visual reference

void main() async {
  final outDir = Directory('assets/images');
  if (!outDir.existsSync()) outDir.createSync(recursive: true);

  // Generate all variants
  await _saveImage(_buildGradientIcon(), 'app_icon.png');
  await _saveImage(_buildFlatIcon(), 'app_icon_flat.png');
  await _saveImage(_buildDarkIcon(), 'app_icon_dark.png');
  await _saveImage(_buildOutlineIcon(), 'app_icon_outline.png');
  await _saveImage(_buildAdaptiveForeground(), 'app_icon_foreground.png');

  print('✓ Generated KVS icon variants in assets/images/');
}

Future<void> _saveImage(img.Image image, String filename) async {
  final png = img.encodePng(image);
  await File('assets/images/$filename').writeAsBytes(png);
  print('  ✓ $filename');
}

// ────── Variant 1: Premium Gradient (main app icon) ──────
img.Image _buildGradientIcon() {
  final image = img.Image(width: size, height: size);

  // Background: diagonal green gradient
  _fillGradient(
    image,
    topLeft: img.ColorUint8.rgb(0x1B, 0x5E, 0x20),
    topRight: img.ColorUint8.rgb(0x2E, 0x7D, 0x32),
    bottomLeft: img.ColorUint8.rgb(0x2E, 0x7D, 0x32),
    bottomRight: img.ColorUint8.rgb(0x4C, 0xAF, 0x50),
  );

  // Subtle decorative circles
  _fillCircle(image, 800, 220, 180,
      img.ColorUint8.rgba(255, 255, 255, 18));
  _fillCircle(image, 200, 850, 160,
      img.ColorUint8.rgba(255, 255, 255, 12));

  // Center shine highlight
  _radialHighlight(image, 512, 380, 320, opacity: 30);

  // Draw KVS monogram in white
  _drawKvsMonogram(image, color: img.ColorUint8.rgba(255, 255, 255, 245));

  // Gold accent dot under the V
  _fillCircle(
    image,
    size ~/ 2,
    790,
    18,
    img.ColorUint8.rgb(0xFF, 0xB3, 0x00),
  );

  return image;
}

// ────── Variant 2: Flat Minimalist ──────
img.Image _buildFlatIcon() {
  final image = img.Image(width: size, height: size);
  _fillRect(image, 0, 0, size, size, img.ColorUint8.rgb(0x2E, 0x7D, 0x32));
  _drawKvsMonogram(image, color: img.ColorUint8.rgba(255, 255, 255, 255));
  _fillCircle(image, size ~/ 2, 790, 16,
      img.ColorUint8.rgba(255, 255, 255, 200));
  return image;
}

// ────── Variant 3: Dark Mode ──────
img.Image _buildDarkIcon() {
  final image = img.Image(width: size, height: size);
  _fillGradient(
    image,
    topLeft: img.ColorUint8.rgb(0x0B, 0x0F, 0x14),
    topRight: img.ColorUint8.rgb(0x14, 0x1B, 0x21),
    bottomLeft: img.ColorUint8.rgb(0x0E, 0x14, 0x18),
    bottomRight: img.ColorUint8.rgb(0x18, 0x22, 0x29),
  );
  _radialHighlight(image, 512, 380, 320, opacity: 18);
  _drawKvsMonogram(image, color: img.ColorUint8.rgb(0x66, 0xBB, 0x6A));
  _fillCircle(image, size ~/ 2, 790, 18, img.ColorUint8.rgb(0xFF, 0xB3, 0x00));
  return image;
}

// ────── Variant 4: Outline / Minimal ──────
img.Image _buildOutlineIcon() {
  final image = img.Image(width: size, height: size);
  _fillRect(image, 0, 0, size, size, img.ColorUint8.rgb(0xFF, 0xFF, 0xFF));
  _drawKvsMonogram(image,
      color: img.ColorUint8.rgb(0x2E, 0x7D, 0x32), strokeWidth: 50);
  _fillCircle(image, size ~/ 2, 790, 16, img.ColorUint8.rgb(0x2E, 0x7D, 0x32));
  return image;
}

// ────── Adaptive Icon Foreground (transparent BG) ──────
img.Image _buildAdaptiveForeground() {
  final image = img.Image(width: size, height: size, numChannels: 4);
  _drawKvsMonogram(image,
      color: img.ColorUint8.rgba(255, 255, 255, 245),
      offsetX: 0,
      offsetY: -40);
  return image;
}

// ────── Drawing helpers ──────

void _drawKvsMonogram(
  img.Image image, {
  required img.Color color,
  int strokeWidth = 80,
  int offsetX = 0,
  int offsetY = 0,
}) {
  // Layout: K, V, S centered horizontally
  // Letter area: vertical center ~520, height ~360 (340..700)
  // Each letter ~180 wide with ~25 gap
  // Total width: 3*180 + 2*25 = 590 → start x = (1024-590)/2 = 217

  final cx = size ~/ 2 + offsetX;
  final cy = 520 + offsetY;
  final letterHeight = 360;
  final top = cy - letterHeight ~/ 2;
  final bot = cy + letterHeight ~/ 2;
  final letterWidth = 180;
  final gap = 30;
  final totalWidth = letterWidth * 3 + gap * 2;
  final startX = cx - totalWidth ~/ 2;

  final kX = startX;
  final vX = startX + letterWidth + gap;
  final sX = startX + (letterWidth + gap) * 2;

  _drawLetterK(image, kX, top, letterWidth, letterHeight, strokeWidth, color);
  _drawLetterV(image, vX, top, letterWidth, letterHeight, strokeWidth, color);
  _drawLetterS(image, sX, top, letterWidth, letterHeight, strokeWidth, color);
}

/// Draw a stylized K with a vertical bar and two angled bars.
void _drawLetterK(img.Image image, int x, int y, int w, int h, int sw, img.Color color) {
  final mid = y + h ~/ 2;
  final halfSw = sw ~/ 2;

  // Vertical bar
  _fillRect(image, x, y, x + sw, y + h, color);

  // Upper diagonal bar from middle-of-vertical to top-right
  _drawThickLine(image, x + sw - halfSw, mid, x + w, y + halfSw, sw, color);

  // Lower diagonal bar from middle-of-vertical to bottom-right
  _drawThickLine(image, x + sw - halfSw, mid, x + w, y + h - halfSw, sw, color);

  // Add small circle at the joint for clean look
  _fillCircle(image, x + sw - halfSw, mid, halfSw - 4, color);
}

/// Draw a stylized V using two angled bars meeting at the bottom.
void _drawLetterV(img.Image image, int x, int y, int w, int h, int sw, img.Color color) {
  final halfSw = sw ~/ 2;
  final cxBottom = x + w ~/ 2;
  final yBottom = y + h - halfSw;

  // Left arm: top-left to bottom-center
  _drawThickLine(image, x + halfSw, y + halfSw, cxBottom, yBottom, sw, color);
  // Right arm: top-right to bottom-center
  _drawThickLine(image, x + w - halfSw, y + halfSw, cxBottom, yBottom, sw, color);

  // Round bottom point
  _fillCircle(image, cxBottom, yBottom, halfSw - 4, color);
}

/// Draw a modern angular S using horizontal bars and connecting strokes.
void _drawLetterS(img.Image image, int x, int y, int w, int h, int sw, img.Color color) {
  final halfSw = sw ~/ 2;
  final third = h ~/ 3;

  // Top horizontal bar
  _fillRect(image, x, y, x + w, y + sw, color);
  // Right vertical (top section, on the right)
  _fillRect(image, x + w - sw, y, x + w, y + third + halfSw, color);

  // Middle horizontal bar
  _fillRect(image, x, y + third, x + w, y + third + sw, color);

  // Left vertical (bottom section, on the left)
  _fillRect(image, x, y + third, x + sw, y + 2 * third + halfSw, color);

  // Bottom horizontal bar
  _fillRect(image, x, y + h - sw, x + w, y + h, color);
  // Right vertical short connector (bottom)
  _fillRect(image, x + w - sw, y + 2 * third, x + w, y + h, color);

  // Round corners with small circles
  _fillCircle(image, x + halfSw, y + halfSw, halfSw, color);
  _fillCircle(image, x + w - halfSw, y + halfSw, halfSw, color);
  _fillCircle(image, x + halfSw, y + h - halfSw, halfSw, color);
  _fillCircle(image, x + w - halfSw, y + h - halfSw, halfSw, color);
}

// ────── Primitive drawing helpers ──────

void _fillRect(img.Image image, int x1, int y1, int x2, int y2, img.Color color) {
  final xa = math.min(x1, x2);
  final xb = math.max(x1, x2);
  final ya = math.min(y1, y2);
  final yb = math.max(y1, y2);
  for (int yy = ya; yy < yb; yy++) {
    for (int xx = xa; xx < xb; xx++) {
      if (xx >= 0 && xx < image.width && yy >= 0 && yy < image.height) {
        _blendPixel(image, xx, yy, color);
      }
    }
  }
}

void _fillCircle(img.Image image, int cx, int cy, int r, img.Color color) {
  for (int yy = cy - r; yy <= cy + r; yy++) {
    for (int xx = cx - r; xx <= cx + r; xx++) {
      if (xx >= 0 && xx < image.width && yy >= 0 && yy < image.height) {
        final dx = xx - cx;
        final dy = yy - cy;
        final dist = math.sqrt(dx * dx + dy * dy);
        if (dist <= r) {
          // Anti-alias the edge
          if (dist > r - 1) {
            final aa = (r - dist).clamp(0.0, 1.0);
            final blended = _scaleAlpha(color, aa);
            _blendPixel(image, xx, yy, blended);
          } else {
            _blendPixel(image, xx, yy, color);
          }
        }
      }
    }
  }
}

void _drawThickLine(img.Image image, int x1, int y1, int x2, int y2, int thickness, img.Color color) {
  final r = thickness ~/ 2;
  final dx = x2 - x1;
  final dy = y2 - y1;
  final length = math.sqrt(dx * dx + dy * dy);
  if (length == 0) {
    _fillCircle(image, x1, y1, r, color);
    return;
  }
  final steps = length.ceil() * 2;
  for (int i = 0; i <= steps; i++) {
    final t = i / steps;
    final cx = (x1 + dx * t).round();
    final cy = (y1 + dy * t).round();
    _fillCircle(image, cx, cy, r, color);
  }
}

void _fillGradient(
  img.Image image, {
  required img.Color topLeft,
  required img.Color topRight,
  required img.Color bottomLeft,
  required img.Color bottomRight,
}) {
  final w = image.width;
  final h = image.height;
  for (int yy = 0; yy < h; yy++) {
    final ty = yy / (h - 1);
    for (int xx = 0; xx < w; xx++) {
      final tx = xx / (w - 1);
      // Bilinear blend
      final r = _lerpComponent(
        _lerpComponent(topLeft.r.toInt(), topRight.r.toInt(), tx),
        _lerpComponent(bottomLeft.r.toInt(), bottomRight.r.toInt(), tx),
        ty,
      );
      final g = _lerpComponent(
        _lerpComponent(topLeft.g.toInt(), topRight.g.toInt(), tx),
        _lerpComponent(bottomLeft.g.toInt(), bottomRight.g.toInt(), tx),
        ty,
      );
      final b = _lerpComponent(
        _lerpComponent(topLeft.b.toInt(), topRight.b.toInt(), tx),
        _lerpComponent(bottomLeft.b.toInt(), bottomRight.b.toInt(), tx),
        ty,
      );
      image.setPixelRgba(xx, yy, r, g, b, 255);
    }
  }
}

void _radialHighlight(img.Image image, int cx, int cy, int radius, {int opacity = 25}) {
  for (int yy = cy - radius; yy <= cy + radius; yy++) {
    for (int xx = cx - radius; xx <= cx + radius; xx++) {
      if (xx < 0 || xx >= image.width || yy < 0 || yy >= image.height) continue;
      final dx = xx - cx;
      final dy = yy - cy;
      final dist = math.sqrt(dx * dx + dy * dy);
      if (dist >= radius) continue;
      final t = (1 - dist / radius);
      final alpha = (opacity * t * t).round().clamp(0, 255);
      _blendPixel(image, xx, yy, img.ColorUint8.rgba(255, 255, 255, alpha));
    }
  }
}

int _lerpComponent(int a, int b, double t) => (a + (b - a) * t).round();

img.Color _scaleAlpha(img.Color color, double factor) {
  return img.ColorUint8.rgba(
    color.r.toInt(),
    color.g.toInt(),
    color.b.toInt(),
    (color.a.toInt() * factor).round(),
  );
}

void _blendPixel(img.Image image, int x, int y, img.Color color) {
  final alpha = color.a.toInt();
  if (alpha == 0) return;
  if (alpha == 255) {
    image.setPixel(x, y, color);
    return;
  }
  final existing = image.getPixel(x, y);
  final a = alpha / 255.0;
  final r = (color.r.toInt() * a + existing.r.toInt() * (1 - a)).round();
  final g = (color.g.toInt() * a + existing.g.toInt() * (1 - a)).round();
  final b = (color.b.toInt() * a + existing.b.toInt() * (1 - a)).round();
  image.setPixelRgba(x, y, r, g, b, 255);
}
