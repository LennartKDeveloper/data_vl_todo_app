import 'package:data_vl_todo_app/data/database_repo.dart';

class MockDatabase implements DatabaseRepository {
  final List<String> _items = ["Einkaufen", "Flutter lernen", "Sport machen"];

  @override
  Future<List<String>> loadAllItems() async {
    await Future.delayed(
      Duration(milliseconds: 500),
    ); // Simuliere Datenbank wartezeit
    return _items;
  }

  @override
  Future<void> addItem(String item) async {
    await Future.delayed(
      Duration(milliseconds: 500),
    ); // Simuliere Datenbank wartezeit
    _items.add(item);
  }

  @override
  Future<void> deleteItem(int index) async {
    await Future.delayed(
      Duration(milliseconds: 500),
    ); // Simuliere Datenbank wartezeit
    _items.removeAt(index);
  }
}
