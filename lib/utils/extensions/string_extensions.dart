extension DateFormatter on String {
  String toDDMMYYYY() {
    try {
      final parsedDate = DateTime.parse(this);
      return "${parsedDate.day.toString().padLeft(2, '0')}.${parsedDate.month.toString().padLeft(2, '0')}.${parsedDate.year}";
    } catch (e) {
      return 'Invalid Date';
    }
  }
}
