import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'presentation/screens/home_screen.dart';
import 'data/providers/habit_provider.dart';

void main() {
  // Точка входа в приложение. Здесь подключается Provider для управления состоянием.
  runApp(ChangeNotifierProvider(
    create: (context) => HabitProvider(),
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Основной виджет приложения, задающий тему и начальный экран.
    return MaterialApp(
      title: 'Habit Control',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: HomeScreen(),
    );
  }
}