import 'package:flutter/material.dart';

class ToDoItem extends StatelessWidget {
  final String text;
  final DismissDirectionCallback onDismissed;

  const ToDoItem({super.key, required this.text, required this.onDismissed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      child: Dismissible(
        key: ValueKey(text + DateTime.now().toString()),
        direction: DismissDirection.endToStart,
        onDismissed: onDismissed,
        background: Container(
          color: Colors.red,
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: const Icon(Icons.delete, color: Colors.white),
        ),
        child: Card(child: ListTile(title: Text(text))),
      ),
    );
  }
}
