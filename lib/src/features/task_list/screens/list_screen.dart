import 'package:flutter/material.dart';
import 'package:simple_beautiful_checklist_exercise/data/database_repository.dart';
import 'package:simple_beautiful_checklist_exercise/src/features/task_list/widgets/empty_content.dart';
import 'package:simple_beautiful_checklist_exercise/src/features/task_list/widgets/item_list.dart';

class ListScreen extends StatefulWidget {
  const ListScreen({
    super.key,
    required this.repository,
  });

  final DatabaseRepository repository;

  @override
  State<ListScreen> createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  final List<String> _items = [];
  bool isLoading = true;
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _updateList();
  }

  void _updateList() async {
    _items.clear();
    _items.addAll(await widget.repository.getItems());
    isLoading = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Meine Checkliste'),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Expanded(
                  child: _items.isEmpty
                      ? const EmptyContent()
                      : ItemList(
                          repository: widget.repository,
                          items: _items,
                          updateOnChange: _updateList,
                        ),
                ),
                Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      hintText: 'Task hinzufügen',
                      filled: true,
                      fillColor: Theme.of(context).cardColor,
                      prefixIcon: const Icon(Icons.task_alt),
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.add_circle_outline),
                        onPressed: () {
                          if (_controller.text.isNotEmpty) {
                            widget.repository.addItem(_controller.text);
                            _controller.clear();
                            _updateList();
                          }
                        },
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 20.0,
                        horizontal: 20.0,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    onSubmitted: (value) {
                      if (value.isNotEmpty) {
                        widget.repository.addItem(value);
                        _controller.clear();
                        _updateList();
                      }
                    },
                  ),
                ),
              ],
            ),
    );
  }
}
