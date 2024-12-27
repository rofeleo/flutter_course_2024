class Habit {
  final String category; // Категория привычки (например, "Nicotine").
  final String name;     // Название привычки.
  final DateTime lastUsed; // Дата последнего использования привычки.

  Habit({required this.category, required this.name, required this.lastUsed});
}
