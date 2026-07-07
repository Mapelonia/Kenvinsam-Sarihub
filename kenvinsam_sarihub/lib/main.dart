import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kenvinsam_sarihub/database/database_helper.dart';
import 'package:kenvinsam_sarihub/utils/theme.dart';
import 'package:kenvinsam_sarihub/screens/auth/splash_screen.dart';
import 'package:kenvinsam_sarihub/providers/theme_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
<<<<<<< HEAD
  try {
    await DatabaseHelper.instance.database;
  } catch (e) {
    debugPrint('Database initialization error: $e');
  }
=======
  await DatabaseHelper.instance.database;
>>>>>>> 4dd908a849b3b51b9738ab984e1088d324c50337
  runApp(const ProviderScope(child: KenvinsamSariHub()));
}

class KenvinsamSariHub extends ConsumerWidget {
  const KenvinsamSariHub({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(themeProvider);

    return MaterialApp(
      title: 'Kenvinsam SariHub',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: isDarkMode ? ThemeMode.dark : ThemeMode.light,
      home: const SplashScreen(),
    );
  }
}
