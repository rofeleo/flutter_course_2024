import 'package:flutter/foundation.dart';
import 'dart:collection';
import '../models/habit.dart';

class HabitProvider extends ChangeNotifier {
  final List<Habit> _habits = [];

  UnmodifiableListView<Habit> get habits => UnmodifiableListView(_habits);

  void addHabit(Habit habit) {
    _habits.add(habit);
    notifyListeners();
  }

  void updateHabit(int index, Habit habit) {
    _habits[index] = habit;
    notifyListeners();
  }

  void deleteHabit(int index) {
    _habits.removeAt(index);
    notifyListeners();
  }
}