import 'package:shared_preferences/shared_preferences.dart';
import 'database_repository.dart';

class SharedPreferencesRepository implements DatabaseRepository {
  static const String _key = 'checklist_items';

  Future<SharedPreferences> get _prefs async =>
      await SharedPreferences.getInstance();

  @override
  Future<int> getItemCount() async {
    final prefs = await _prefs;
    return prefs.getStringList(_key)?.length ?? 0;
  }

  @override
  Future<List<String>> getItems() async {
    final prefs = await _prefs;
    return prefs.getStringList(_key) ?? [];
  }

  @override
  Future<void> addItem(String item) async {
    final prefs = await _prefs;
    final items = prefs.getStringList(_key) ?? [];
    if (item.isNotEmpty && !items.contains(item)) {
      items.add(item);
      await prefs.setStringList(_key, items);
    }
  }

  @override
  Future<void> deleteItem(int index) async {
    final prefs = await _prefs;
    final items = prefs.getStringList(_key) ?? [];
    if (index >= 0 && index < items.length) {
      items.removeAt(index);
      await prefs.setStringList(_key, items);
    }
  }

  @override
  Future<void> editItem(int index, String newItem) async {
    final prefs = await _prefs;
    final items = prefs.getStringList(_key) ?? [];
    if (newItem.isNotEmpty &&
        index >= 0 &&
        index < items.length &&
        !items.contains(newItem)) {
      items[index] = newItem;
      await prefs.setStringList(_key, items);
    }
  }
}
