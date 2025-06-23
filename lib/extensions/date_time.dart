extension DateFormatting on DateTime {
  String format() {
    String twoDigit(int n) => n.toString().padLeft(2, '0');
    return '$year/${twoDigit(month)}/${twoDigit(day)}';
  }
}
