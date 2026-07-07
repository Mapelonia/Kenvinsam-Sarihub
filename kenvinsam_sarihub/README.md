# Kenvinsam SariHub

A modern Android mobile application for sari-sari store price management. Built with Flutter, SQLite, and Riverpod.

---

## What This App Does

Kenvinsam SariHub is a **product price checker and business calculator** for a family-run sari-sari store. It helps you:

- Track product prices (capital vs selling)
- See profit and margin per product instantly
- Calculate per-piece pricing from bulk purchases
- Manage electric bill records per unit
- Sync prices across family phones over Wi-Fi (no internet needed)
- Backup and restore all data

---

## Features

### Product Price Management
- Add/edit/delete products with name, category, capital price, selling price
- Optional product description
- Upload product photos (camera or gallery)
- Replace or remove product images
- Automatic profit and margin calculation
- Price change history tracking
- Search and filter by name or category
<<<<<<< HEAD
- Product cards show full name and description in the list view
- **Inline Pricing Tools** — Per Piece Calculator and Price Suggester built into the Add/Edit Product form (no need to navigate away)
=======
>>>>>>> 4dd908a849b3b51b9738ab984e1088d324c50337

### Category Management (Dynamic)
- 16 default categories (Instant Foods, Canned Goods, Biscuits, Junk Foods, Beverages, Coffee & Powdered Drinks, Hygiene, Cooking Essentials, Frozen Foods, Cigarettes, Baby Products, Cleaning Supplies, Laundry, Personal Needs, Medicine, Candies)
- Admin can add custom categories
<<<<<<< HEAD
- **Icon picker** — choose from 40 Material Icons when adding or editing a category
=======
>>>>>>> 4dd908a849b3b51b9738ab984e1088d324c50337
- Admin can rename categories (updates all assigned products automatically)
- Admin can delete categories (blocked if products are assigned)

### Calculator Module
- **Basic Calculator** — arithmetic operations (+, −, ×, ÷), percentage, toggle sign, backspace
- Calculation history (saved locally, copy to clipboard, delete individual or clear all)
- **Profit Calculator** — enter capital and selling price, see profit and margin
- **Per Piece Calculator** — bulk capital price + quantity + selling price per piece
- **Price Suggester** — enter capital price + desired profit %, get suggested selling price

### Electric Bill Calculator
- Multiple billing units (Unit A–E + create custom units)
- Receipt-style bill cards with full breakdown:
  - Billing Date, Billing Period, Previous Reading, Present Reading
  - Total kWh, Rate per kWh, Other Charges, Total Amount
  - Payment Status (Paid / Partial / Unpaid)
  - Date Recorded, Notes
- Per-unit billing history grouped by month
- Mark bills as Paid/Partial/Unpaid
- Auto-calculate consumption and total
- Duplicate month detection

### Authentication & User Roles
- Offline local authentication with session persistence
- Auto-login on app restart
- Account lockout after 5 failed login attempts

| Role | Access |
|------|--------|
| **Admin** (Kenvinsam) | Full access — manage products, prices, categories, users, sync server, backup |
| **Family** (Razo) | Read-only — search products, browse categories, view prices, use calculators |

### LAN Sync (Wi-Fi)
- Admin device acts as server; Family devices connect as clients
- Real-time WebSocket sync — product changes push instantly to Family
- Electric bills sync bidirectionally (Razo → Admin and back)
- Auto-reconnect when Wi-Fi drops
- Pairing code system for security
- No internet required

### Backup & Restore
- Export full database to a `.json` file on device
<<<<<<< HEAD
- **Save to specific folder** — choose any folder on your device (Downloads, SD card, etc.)
=======
>>>>>>> 4dd908a849b3b51b9738ab984e1088d324c50337
- Import backup from any `.json` file
- File validation before restore (signature, version, required tables)
- Preview record counts before confirming restore
- Confirmation required before overwriting data
- Manage local backup files (restore, delete)
<<<<<<< HEAD
- **Weekly backup reminder** — auto-prompts every Sunday for admin users

### Dark Mode
- Full dark mode support, toggle from app bar
- Improved light mode contrast and visibility

---

## UI/UX Design

### Design System
- **Color Palette:** Teal-emerald gradient palette (primary #0D9373)
- **Typography:** Poppins (UI) + JetBrains Mono (monospace)
- **Components:** Material 3 with custom styling
- **Inputs:** Borderless filled fields with visible backgrounds (#E8ECF0 light / cardDarkElevated dark)
- **Cards:** Defined shadows, rounded corners (18px), visible borders
- **Animations:** Smooth page transitions, staggered list animations, scale/fade effects
- **Light Mode:** High-contrast scaffold (#F1F5F9) with white cards, stronger shadows and borders for visibility
- **Dark Mode:** Deep dark surfaces with subtle light borders

### Navigation
- Custom bottom navigation bar with pill-style selection indicators
- PageView for smooth tab switching
- SliverAppBar with greeting and profile menu on home tab
- Chip-based tab selectors for calculator tools

### Key Screens
- **Splash:** Gradient background with animated logo and pulse loading
- **Login:** Glass-style card on gradient, labeled inputs, gradient button
- **Home:** Time-based greeting, quick actions, featured products carousel
- **Categories:** Color-coded grid tiles with icons and item counts
- **Calculator:** Expandable chip tabs, form cards with live results
- **Admin Dashboard:** Gradient banner, 3-column management grid, price alerts
- **Product Detail:** Rounded hero image, full name, description card, pricing breakdown
- **Category Management:** Add/edit dialogs with icon picker grid
=======

### Dark Mode
- Full dark mode support, toggle from app bar
>>>>>>> 4dd908a849b3b51b9738ab984e1088d324c50337

---

## Login Credentials

| Account | Username | Password |
|---------|----------|----------|
| Admin | `Kenvinsam` | `kenvinsam123` |
| Family | `Razo` | `razo123` |

---

## Tech Stack

- **Flutter** — Cross-platform UI
- **SQLite (sqflite)** — Local offline database with migrations
- **Riverpod** — State management
<<<<<<< HEAD
- **SharedPreferences** — Session, theme, & reminder persistence
- **Material 3** — Design system
- **Google Fonts (Poppins, JetBrains Mono)** — Typography
- **Dart HttpServer + WebSocket** — LAN real-time sync
- **file_picker** — Backup file/folder selection
- **image_picker** — Camera and gallery access
- **flutter_staggered_animations** — List/grid animations
- **shimmer** — Skeleton loading states
- **fl_chart** — Charts and analytics
=======
- **SharedPreferences** — Session & theme persistence
- **Material 3** — Design system
- **Google Fonts (Poppins)** — Typography
- **Dart HttpServer + WebSocket** — LAN real-time sync
- **file_picker** — Backup file selection
- **image_picker** — Camera and gallery access
>>>>>>> 4dd908a849b3b51b9738ab984e1088d324c50337

---

## Project Structure

```
lib/
├── main.dart
├── database/
│   └── database_helper.dart       # SQLite v7 with full migration history
├── models/
│   ├── user.dart
│   ├── product.dart               # Includes description field
<<<<<<< HEAD
│   ├── category.dart              # Includes iconName field
=======
│   ├── category.dart
>>>>>>> 4dd908a849b3b51b9738ab984e1088d324c50337
│   ├── electric_bill.dart         # Includes otherCharges, billingDate, paymentStatus
│   ├── calc_history.dart
│   ├── price_history.dart
│   └── connected_device.dart
├── services/
│   ├── auth_service.dart
│   ├── session_service.dart
│   ├── product_service.dart
<<<<<<< HEAD
│   ├── category_service.dart      # addCategory/updateCategory with iconName
│   ├── electric_bill_service.dart
│   ├── calc_history_service.dart
│   ├── backup_service.dart        # Export to folder, restore from path
=======
│   ├── category_service.dart
│   ├── electric_bill_service.dart
│   ├── calc_history_service.dart
│   ├── backup_service.dart
>>>>>>> 4dd908a849b3b51b9738ab984e1088d324c50337
│   ├── lan_server_service.dart
│   ├── lan_client_service.dart
│   ├── realtime_sync_server.dart
│   └── realtime_sync_client.dart
├── providers/
│   ├── auth_provider.dart
│   ├── product_provider.dart
│   ├── category_provider.dart
│   ├── sync_provider.dart
│   └── theme_provider.dart
├── screens/
│   ├── auth/
│   │   ├── splash_screen.dart
│   │   ├── login_screen.dart
│   │   └── change_password_screen.dart
│   ├── home/
<<<<<<< HEAD
│   │   ├── home_screen.dart       # Includes weekly backup reminder
=======
│   │   ├── home_screen.dart
>>>>>>> 4dd908a849b3b51b9738ab984e1088d324c50337
│   │   └── home_tab.dart
│   ├── products/
│   │   ├── product_search_screen.dart
│   │   ├── product_detail_screen.dart
<<<<<<< HEAD
│   │   └── add_product_screen.dart  # Inline per-piece & price suggester tools
=======
│   │   └── add_product_screen.dart
>>>>>>> 4dd908a849b3b51b9738ab984e1088d324c50337
│   ├── categories/
│   │   └── categories_screen.dart
│   ├── calculator/
│   │   ├── basic_calculator_screen.dart
│   │   ├── calculator_screen.dart
│   │   ├── electric_bill_screen.dart
│   │   └── electric_unit_detail_screen.dart
│   ├── admin/
│   │   ├── admin_dashboard.dart
│   │   ├── user_management_screen.dart
<<<<<<< HEAD
│   │   ├── category_management_screen.dart  # Icon picker in add/edit dialogs
│   │   └── backup_restore_screen.dart  # Save to folder option
=======
│   │   ├── category_management_screen.dart
│   │   └── backup_restore_screen.dart
>>>>>>> 4dd908a849b3b51b9738ab984e1088d324c50337
│   └── sync/
│       ├── lan_server_screen.dart
│       └── lan_client_screen.dart
├── widgets/           # Reusable UI components
<<<<<<< HEAD
└── utils/
    ├── theme.dart     # Light/dark themes, extensions, design tokens
    ├── constants.dart # Categories, selectableIcons (40), iconFor resolver
    ├── helpers.dart
    └── page_transitions.dart
=======
└── utils/             # Theme, constants, helpers, page transitions
>>>>>>> 4dd908a849b3b51b9738ab984e1088d324c50337
```

---

## Database Tables

| Table | Description |
|-------|-------------|
| users | User accounts with roles |
| sessions | Login session tracking |
| products | Product prices, descriptions, images |
<<<<<<< HEAD
| categories | Dynamic product categories with icon_name |
=======
| categories | Dynamic product categories |
>>>>>>> 4dd908a849b3b51b9738ab984e1088d324c50337
| price_history | Price change audit log |
| electric_units | Electric billing units |
| electric_bill_history | Per-unit bills with payment status |
| calc_history | Basic calculator history |
| connected_devices | LAN-paired devices |
| sync_log | Sync operation log |

**Database version:** 7

### Migration History
| v | Change |
|---|--------|
| 1 | Initial schema |
| 2 | Removed sales table, removed stock tracking |
| 3 | Added Personal Needs, Medicine, Candies categories |
| 4 | Added description column to products |
| 5 | Added other_charges, billing_date, payment_status to electric bills |
| 6 | Added calc_history table |
| 7 | Removed suppliers table and supplier fields from products |

---

## Building the APK

```bash
cd kenvinsam_sarihub
flutter pub get
flutter build apk --release --no-tree-shake-icons
# APK: build/app/outputs/flutter-apk/app-release.apk
```

## Installing

Transfer `app-release.apk` to your Android phone and install.
**To update:** Install the new APK directly — do NOT uninstall first or you will lose all data.

## Regenerate Icon

```bash
dart run tools/generate_kvs_icon.dart
dart run flutter_launcher_icons -f flutter_launcher_icons.yaml
```

---

## License

Private — for personal/family use by Kenvinsam.
