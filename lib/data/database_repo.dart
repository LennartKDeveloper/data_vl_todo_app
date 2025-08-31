abstract class DatabaseRepository {
  void loadAllItems();
  void addItem(String item);
  void deleteItem(int index);
  List<String> get items;
}
