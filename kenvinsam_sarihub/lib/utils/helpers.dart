import 'package:intl/intl.dart';

class Helpers {
  static String formatCurrency(double amount) {
    final formatter = NumberFormat.currency(symbol: '₱', decimalDigits: 2);
    return formatter.format(amount);
  }

  static String formatDate(DateTime date) {
    return DateFormat('MMM dd, yyyy').format(date);
  }

  static String formatDateTime(DateTime date) {
    return DateFormat('MMM dd, yyyy hh:mm a').format(date);
  }

  static double calculateProfit(double capitalPrice, double sellingPrice) {
    return sellingPrice - capitalPrice;
  }

  static double calculateProfitPercentage(double capitalPrice, double sellingPrice) {
    if (capitalPrice <= 0) return 0;
    return ((sellingPrice - capitalPrice) / capitalPrice) * 100;
  }

  static double suggestSellingPrice(double capitalPrice, double desiredProfitPercent) {
    return capitalPrice + (capitalPrice * desiredProfitPercent / 100);
  }

  static double calculateElectricBill(double previousReading, double presentReading, double ratePerKwh) {
    final consumption = presentReading - previousReading;
    return consumption * ratePerKwh;
  }

  static double calculateConsumption(double previousReading, double presentReading) {
    return presentReading - previousReading;
  }

  static String timeAgo(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inDays > 365) {
      return '${(difference.inDays / 365).floor()} year(s) ago';
    } else if (difference.inDays > 30) {
      return '${(difference.inDays / 30).floor()} month(s) ago';
    } else if (difference.inDays > 0) {
      return '${difference.inDays} day(s) ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours} hour(s) ago';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes} minute(s) ago';
    } else {
      return 'Just now';
    }
  }
}
