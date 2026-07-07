import 'package:flutter/material.dart';

class AppConstants {
  static const String appName = 'Kenvinsam SariHub';
  static const String appVersion = '1.0.0';

  // User Roles
  static const String roleAdmin = 'admin';
  static const String roleFamily = 'family';

  // Seed categories — used only for initial DB insert on fresh install.
  // Live category list always comes from the database via CategoryService.
  static const List<String> categories = [
    'Instant Foods',
    'Canned Goods',
    'Biscuits',
    'Junk Foods',
    'Beverages',
    'Coffee & Powdered Drinks',
    'Hygiene',
    'Cooking Essentials',
    'Frozen Foods',
    'Cigarettes',
    'Baby Products',
    'Cleaning Supplies',
    'Laundry',
    'Personal Needs',
    'Medicine',
    'Candies',
  ];

  // Icon map — known categories get a relevant icon.
  // Custom categories created by users fall back to defaultCategoryIcon.
  static const Map<String, IconData> categoryIcons = {
<<<<<<< HEAD
    'Instant Foods': Icons.lunch_dining_rounded,
    'Canned Goods': Icons.inventory_2_rounded,
    'Biscuits': Icons.breakfast_dining_rounded,
    'Junk Foods': Icons.fastfood_rounded,
    'Beverages': Icons.local_drink_rounded,
    'Coffee & Powdered Drinks': Icons.coffee_rounded,
    'Hygiene': Icons.sanitizer_rounded,
    'Cooking Essentials': Icons.restaurant_rounded,
    'Frozen Foods': Icons.ac_unit_rounded,
    'Cigarettes': Icons.smoking_rooms_rounded,
    'Baby Products': Icons.child_care_rounded,
    'Cleaning Supplies': Icons.cleaning_services_rounded,
    'Laundry': Icons.local_laundry_service_rounded,
    'Personal Needs': Icons.person_rounded,
    'Medicine': Icons.medical_services_rounded,
    'Candies': Icons.cake_rounded,
=======
    'Instant Foods': Icons.ramen_dining,
    'Canned Goods': Icons.takeout_dining,
    'Biscuits': Icons.cookie,
    'Junk Foods': Icons.fastfood,
    'Beverages': Icons.local_drink,
    'Coffee & Powdered Drinks': Icons.coffee,
    'Hygiene': Icons.soap,
    'Cooking Essentials': Icons.soup_kitchen,
    'Frozen Foods': Icons.severe_cold,
    'Cigarettes': Icons.smoking_rooms,
    'Baby Products': Icons.child_care,
    'Cleaning Supplies': Icons.cleaning_services,
    'Laundry': Icons.local_laundry_service,
    'Personal Needs': Icons.person_rounded,
    'Medicine': Icons.medication_rounded,
    'Candies': Icons.icecream_rounded,
>>>>>>> 4dd908a849b3b51b9738ab984e1088d324c50337
  };

  // Fallback icon for any user-created category
  static const IconData defaultCategoryIcon = Icons.category_rounded;

<<<<<<< HEAD
  /// All icons available for selection in the icon picker.
  /// Keys are stored in the DB `icon_name` column.
  static const Map<String, IconData> selectableIcons = {
    'lunch_dining': Icons.lunch_dining_rounded,
    'inventory_2': Icons.inventory_2_rounded,
    'breakfast_dining': Icons.breakfast_dining_rounded,
    'fastfood': Icons.fastfood_rounded,
    'local_drink': Icons.local_drink_rounded,
    'coffee': Icons.coffee_rounded,
    'sanitizer': Icons.sanitizer_rounded,
    'restaurant': Icons.restaurant_rounded,
    'ac_unit': Icons.ac_unit_rounded,
    'smoking_rooms': Icons.smoking_rooms_rounded,
    'child_care': Icons.child_care_rounded,
    'cleaning_services': Icons.cleaning_services_rounded,
    'local_laundry_service': Icons.local_laundry_service_rounded,
    'person': Icons.person_rounded,
    'medical_services': Icons.medical_services_rounded,
    'cake': Icons.cake_rounded,
    'category': Icons.category_rounded,
    'shopping_cart': Icons.shopping_cart_rounded,
    'shopping_bag': Icons.shopping_bag_rounded,
    'store': Icons.store_rounded,
    'local_grocery_store': Icons.local_grocery_store_rounded,
    'pets': Icons.pets_rounded,
    'sports_soccer': Icons.sports_soccer_rounded,
    'hardware': Icons.hardware_rounded,
    'electrical_services': Icons.electrical_services_rounded,
    'phone_android': Icons.phone_android_rounded,
    'headphones': Icons.headphones_rounded,
    'school': Icons.school_rounded,
    'auto_stories': Icons.auto_stories_rounded,
    'toys': Icons.toys_rounded,
    'brush': Icons.brush_rounded,
    'palette': Icons.palette_rounded,
    'local_florist': Icons.local_florist_rounded,
    'grass': Icons.grass_rounded,
    'water_drop': Icons.water_drop_rounded,
    'light': Icons.light_rounded,
    'bolt': Icons.bolt_rounded,
    'star': Icons.star_rounded,
    'favorite': Icons.favorite_rounded,
    'emoji_objects': Icons.emoji_objects_rounded,
  };

  // Convenience helper — resolves icon from stored iconName or category name.
  static IconData iconFor(String categoryName, {String? iconName}) {
    // First try to resolve from the stored iconName key
    if (iconName != null && selectableIcons.containsKey(iconName)) {
      return selectableIcons[iconName]!;
    }
    // Fall back to built-in category → icon map
=======
  // Convenience helper — safe to call with any category name
  static IconData iconFor(String categoryName) {
>>>>>>> 4dd908a849b3b51b9738ab984e1088d324c50337
    return categoryIcons[categoryName] ?? defaultCategoryIcon;
  }

  // Default admin credentials
  static const String defaultAdminUsername = 'Kenvinsam';
  static const String defaultAdminPassword = 'kenvinsam123';
  static const String defaultFamilyUsername = 'Razo';
  static const String defaultFamilyPassword = 'razo123';
}
