import 'package:data_vl_todo_app/data/mock_data.dart';
import 'package:flutter/material.dart';
import '../../widgets/todo_item.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final MockDatabase db = MockDatabase();
  List<String>? optimisticItems;

  @override
  void initState() {
    db.loadAllItems().then((loadedItems) {
      setState(() {
        optimisticItems = loadedItems;
      });
    });

    super.initState();
  }

  void _addNewItem() async {
    final controller = TextEditingController();

    final result = await showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Neue Aufgabe"),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(hintText: "Aufgabe eingeben"),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text(
              "Abbrechen",
              style: TextStyle(color: Colors.teal),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context, controller.text);
            },
            child: const Text(
              "Hinzufügen",
              style: TextStyle(color: Colors.teal),
            ),
          ),
        ],
      ),
    );

    if (result != null && result.trim().isNotEmpty) {
      setState(() {
        optimisticItems!.add(result.trim());
      });
      db.addItem(result.trim());
    }
  }

  void _deleteItem(int index) {
    setState(() {
      optimisticItems!.removeAt(index);
    });
    db.deleteItem(index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("ToDo App"),
        backgroundColor: Colors.white,
      ),
      body: optimisticItems == null
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: optimisticItems!.length,
              itemBuilder: (context, index) => ToDoItem(
                text: optimisticItems![index],
                onDismissed: (_) => _deleteItem(index),
              ),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addNewItem,
        backgroundColor: Colors.teal,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
