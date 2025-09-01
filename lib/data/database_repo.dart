abstract class DatabaseRepository {
  Future<void> loadAllItems();
  Future<void> addItem(String item);
  Future<void> deleteItem(int index);
}
