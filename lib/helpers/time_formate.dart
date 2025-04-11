import 'package:intl/intl.dart';
import '../utils/app_constants.dart';

class TimeFormatHelper {
  static String formatDate(DateTime date) {
    return DateFormat('dd MMM, yyyy').format(date);
  }

  static String dateMountFormat(DateTime date) {
    return DateFormat('dd\n MMM ').format(date);
  }

  static String timeFormat(DateTime date) {
    return DateFormat('hh:mm a').format(date);
  }

  static timeWithAMPM(String time) {
    DateTime parsedTime = DateFormat('HH:mm:ss').parse(time);
    String formattedTime = DateFormat('h:mm a').format(parsedTime);
    return formattedTime;
  }

  static timeAgo(DateTime dateTime) {
    final Duration difference = DateTime.now().difference(dateTime);

    if (difference.inSeconds < 60) {
      return '${difference.inSeconds} second${difference.inSeconds == 1 ? '' : 's'} ago';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes} minute${difference.inMinutes == 1 ? '' : 's'} ago';
    } else if (difference.inHours < 24) {
      return '${difference.inHours} hour${difference.inHours == 1 ? '' : 's'} ago';
    } else if (difference.inDays < 30) {
      return '${difference.inDays} day${difference.inDays == 1 ? '' : 's'} ago';
    } else {
      final int months = (difference.inDays / 30).floor();
      return '${months} month${months == 1 ? '' : 's'} ago';
    }
  }

 /* static Future<void> isFutureDate(String input) async {
    try {
      DateTime date = DateTime.parse(input);
      DateTime now = DateTime.now();
      await PrefsHelper.setBool(AppConstants.isFutureDate, date.isAfter(now));
    } catch (e) {
      PrefsHelper.setBool(AppConstants.isFutureDate, false);
    }
  }*/
  // static String formatDates(String dateString) {
  //   DateTime dateTime = DateTime.parse(dateString).toLocal(); // Converts from UTC to local time
  //
  //   String day = dateTime.day.toString().padLeft(2, '0');
  //   String month = dateTime.month.toString().padLeft(2, '0');
  //   String year = dateTime.year.toString();
  //
  //   return "$month-$day-$year"; // MM-DD-YYYY format
  // }

  static String formatDates(String dateString) {
    DateTime date = DateTime.parse(dateString).toLocal();
    String day = date.day.toString().padLeft(2, '0');
    String month = date.month.toString().padLeft(2, '0');
    String year = date.year.toString();
    return "$month-$day-$year"; // MM-DD-YYYY
  }


}