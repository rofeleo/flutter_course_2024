import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../data/providers/habit_provider.dart';
import '../../data/models/habit.dart';
import 'edit_habit_screen.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Habit Control'),
      ),
      body: Consumer<HabitProvider>(
        builder: (context, habitProvider, child) {
          return ListView.builder(
            itemCount: habitProvider.habits.length,
            itemBuilder: (context, index) {
              final habit = habitProvider.habits[index];
              final daysSinceLastUsed = DateTime.now().difference(habit.lastUsed).inDays;
              final congratulationDays = {
                'Nicotine': 2,
                'Food': 5,
                'Alcohol': 3,
              }[habit.category] ?? 7;

              return Column(
                children: [
                  if (daysSinceLastUsed >= congratulationDays)
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Поздравляем! Вы не употребляете ${habit.name} уже $congratulationDays ${congratulationDays == 1 ? 'день' : 'дней'}, так держать!',
                        style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ListTile(
                    title: Text(habit.name),
                    subtitle: Text('${habit.category} - Last used: ${habit.lastUsed.toLocal()}'.split(' ')[0]),
                    trailing: IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () {
                        habitProvider.deleteHabit(index);
                      },
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EditHabitScreen(
                            habit: habit,
                            index: index,
                          ),
                        ),
                      );
                    },
                  ),
                ],
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => EditHabitScreen(),
            ),
          );
        },
      ),
    );
  }
}