import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:collection';

void main() {
  runApp(ChangeNotifierProvider(
    create: (context) => HabitProvider(),
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Habit Control',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: HomeScreen(),
    );
  }
}

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

class Habit {
  final String category;
  final String name;
  final DateTime lastUsed;

  Habit({required this.category, required this.name, required this.lastUsed});
}

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
              return ListTile(
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

class EditHabitScreen extends StatefulWidget {
  final Habit? habit;
  final int? index;

  EditHabitScreen({this.habit, this.index});

  @override
  _EditHabitScreenState createState() => _EditHabitScreenState();
}

class _EditHabitScreenState extends State<EditHabitScreen> {
  final _formKey = GlobalKey<FormState>();
  String? _selectedCategory;
  String? _name;
  DateTime? _lastUsed;

  @override
  void initState() {
    super.initState();
    if (widget.habit != null) {
      _selectedCategory = widget.habit!.category;
      _name = widget.habit!.name;
      _lastUsed = widget.habit!.lastUsed;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.habit == null ? 'Add Habit' : 'Edit Habit'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              DropdownButtonFormField<String>(
                value: _selectedCategory,
                decoration: InputDecoration(labelText: 'Category'),
                items: ['Nicotine', 'Food', 'Alcohol']
                    .map((category) => DropdownMenuItem(
                  value: category,
                  child: Text(category),
                ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedCategory = value;
                  });
                },
                validator: (value) =>
                value == null ? 'Please select a category' : null,
              ),
              TextFormField(
                initialValue: _name,
                decoration: InputDecoration(labelText: 'Name'),
                onSaved: (value) => _name = value,
                validator: (value) =>
                value == null || value.isEmpty ? 'Please enter a name' : null,
              ),
              SizedBox(height: 16),
              TextButton(
                onPressed: () async {
                  final selectedDate = await showDatePicker(
                    context: context,
                    initialDate: _lastUsed ?? DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime.now(),
                  );
                  if (selectedDate != null) {
                    setState(() {
                      _lastUsed = selectedDate;
                    });
                  }
                },
                child: Text(_lastUsed == null
                    ? 'Select Last Used Date'
                    : 'Last Used: ${_lastUsed!.toLocal()}'.split(' ')[0]),
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    final habit = Habit(
                      category: _selectedCategory!,
                      name: _name!,
                      lastUsed: _lastUsed!,
                    );
                    final provider =
                    Provider.of<HabitProvider>(context, listen: false);
                    if (widget.index == null) {
                      provider.addHabit(habit);
                    } else {
                      provider.updateHabit(widget.index!, habit);
                    }
                    Navigator.pop(context);
                  }
                },
                child: Text('Save'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
