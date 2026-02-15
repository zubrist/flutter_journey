// Import Flutter material design package
import 'package:flutter/material.dart';

// Main function – entry point of the Flutter application
void main() => runApp(const TodoApp());

// Root widget of the app (stateless)
class TodoApp extends StatelessWidget {
  const TodoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Todo List App',
      home: TodoHomePage(),                // Home screen widget
      debugShowCheckedModeBanner: true,
    );
  }
}

// Main screen – stateful widget because todo list changes dynamically
class TodoHomePage extends StatefulWidget {
  const TodoHomePage({super.key});

  @override
  State<TodoHomePage> createState() => _TodoHomePageState();
}

// State class holding list of tasks and logic for add/edit/delete
class _TodoHomePageState extends State<TodoHomePage> {
  // List to store todo tasks
  final List<String> _tasks = <String>[];

  // Controller for the task input TextField
  final TextEditingController _taskController = TextEditingController();

  // Function to add a new task
  void _addTask() {
    final String text = _taskController.text.trim();

    if (text.isNotEmpty) {
      setState(() {
        _tasks.add(text);        // Add new task to the list
        _taskController.clear(); // Clear input field after adding
      });
    }
  }

  // Function to delete a task at a specific index
  void _deleteTask(int index) {
    setState(() {
      _tasks.removeAt(index);
    });
  }

  // Function to show dialog for editing a task
  void _editTask(int index) {
    // Temporary controller initialized with current task text
    final TextEditingController editController =
        TextEditingController(text: _tasks[index]);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Edit Task'),
          content: TextField(
            controller: editController,
            decoration: const InputDecoration(
              labelText: 'Update task',
              border: OutlineInputBorder(),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                // Close dialog without saving
                Navigator.of(context).pop();
              },
              child: const Text('CANCEL'),
            ),
            TextButton(
              onPressed: () {
                final String updatedText = editController.text.trim();
                if (updatedText.isNotEmpty) {
                  setState(() {
                    _tasks[index] = updatedText; // Update task text
                  });
                }
                Navigator.of(context).pop();     // Close dialog
              },
              child: const Text('SAVE'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // Scaffold provides app structure with AppBar and body
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo List App'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0), // Outer padding
        child: Column(
          children: [
            // Row containing TextField and Add button
            Row(
              children: [
                // Expanded TextField to input new task
                Expanded(
                  child: TextField(
                    controller: _taskController,
                    decoration: const InputDecoration(
                      labelText: 'Enter a task',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                // ElevatedButton to add task
                ElevatedButton(
                  onPressed: _addTask,
                  child: const Text('Add'),
                ),
              ],
            ),

            const SizedBox(height: 16),

            // Expanded widget so ListView takes remaining space
            Expanded(
              child: _tasks.isEmpty
                  ? const Center(
                      child: Text(
                        'No tasks yet. Add some!',
                        style: TextStyle(fontSize: 16),
                      ),
                    )
                  : ListView.builder(
                      itemCount: _tasks.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Card(
                          child: ListTile(
                            title: Text(_tasks[index]),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                // Edit icon button
                                IconButton(
                                  icon: const Icon(Icons.edit),
                                  onPressed: () => _editTask(index),
                                ),
                                // Delete icon button
                                IconButton(
                                  icon: const Icon(Icons.delete),
                                  onPressed: () => _deleteTask(index),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
