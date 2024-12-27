import 'package:flutter/foundation.dart';
import 'dart:collection';
import '../models/habit.dart';

class HabitProvider extends ChangeNotifier {
  final List<Habit> _habits = []; // Локальное хранилище списка привычек.

  // Предоставляет только для чтения список привычек.
  UnmodifiableListView<Habit> get habits => UnmodifiableListView(_habits);

  // Добавляет новую привычку в список и уведомляет слушателей.
  void addHabit(Habit habit) {
    _habits.add(habit);
    notifyListeners();
  }

  // Обновляет существующую привычку по индексу.
  void updateHabit(int index, Habit habit) {
    _habits[index] = habit;
    notifyListeners();
  }

  // Удаляет привычку по индексу и уведомляет слушателей.
  void deleteHabit(int index) {
    _habits.removeAt(index);
    notifyListeners();
  }
}