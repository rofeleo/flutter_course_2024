import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../data/models/habit.dart';
import '../../data/providers/habit_provider.dart';

class EditHabitScreen extends StatefulWidget {
  final Habit? habit; // Привычка для редактирования (если null, создаётся новая).
  final int? index;   // Индекс редактируемой привычки (если null, создаётся новая).

  EditHabitScreen({this.habit, this.index});

  @override
  _EditHabitScreenState createState() => _EditHabitScreenState();
}

class _EditHabitScreenState extends State<EditHabitScreen> {
  final _formKey = GlobalKey<FormState>(); // Ключ формы для валидации.
  String? _selectedCategory; // Выбранная категория привычки.
  String? _name;             // Название привычки.
  DateTime? _lastUsed;       // Дата последнего использования привычки.

  @override
  void initState() {
    super.initState();
    // Инициализация полей, если привычка передана для редактирования.
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
        title: Text(widget.habit == null ? 'Add Habit' : 'Edit Habit'), // Заголовок экрана.
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
                  // Открытие диалога выбора даты.
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
                    final provider = Provider.of<HabitProvider>(context, listen: false);
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

