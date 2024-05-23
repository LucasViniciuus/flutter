import 'package:flutter/material.dart';
import 'add_task.dart';

class Task {
  final String title;
  bool isDone;

  Task({required this.title, this.isDone = false});
}

class TaskListScreen extends StatefulWidget {
  @override
  _TaskListScreenState createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> {
  List<Task> tasks = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Lista de Tarefas')),
      body: ListView.builder(
        itemCount: tasks.length,
        itemBuilder: (context, index) {
          return Dismissible(
            key: Key(tasks[index].title),
            onDismissed: (direction) {
              setState(() {
                tasks.removeAt(index);
              });
            },
            background: Container(color: Colors.red),
            child: ListTile(
              title: Text(
                tasks[index].title,
                style: TextStyle(
                  decoration: tasks[index].isDone ? TextDecoration.lineThrough : null,
                ),
              ),
              trailing: Checkbox(
                value: tasks[index].isDone,
                onChanged: (bool? value) {
                  setState(() {
                    tasks[index].isDone = value!;
                  });
                },
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () async {
          final newTaskTitle = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddTaskScreen(),
            ),
          );

          if (newTaskTitle != null) {
            setState(() {
              tasks.add(Task(title: newTaskTitle));
            });
          }
        },
      ),
    );
  }
}