import 'package:data_vl_todo_app/data/database_repo.dart';

class MockDatabase implements DatabaseRepository {
  final List<String> _items = ["Einkaufen", "Flutter lernen", "Sport machen"];

  @override
  List<String> loadAllItems() {
    return _items;
  }

  @override
  void addItem(String item) {
    _items.add(item);
  }

  @override
  void deleteItem(int index) {
    _items.removeAt(index);
  }
}
