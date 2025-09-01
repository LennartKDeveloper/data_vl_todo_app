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

  @override
  void initState() {
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
        db.addItem(result.trim());
      });
    }
  }

  void _deleteItem(int index) {
    setState(() {
      db.deleteItem(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("ToDo App"),
        backgroundColor: Colors.white,
      ),
      body: FutureBuilder(
        future: db.loadAllItems(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(
                color: Colors.teal,
                strokeWidth: 10,
              ),
            );
          } else if (snapshot.connectionState == ConnectionState.done &&
              snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) => ToDoItem(
                text: snapshot.data![index],
                onDismissed: (_) => _deleteItem(index),
              ),
            );
          } else {
            return Text("Error${snapshot.error}");
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addNewItem,
        backgroundColor: Colors.teal,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
