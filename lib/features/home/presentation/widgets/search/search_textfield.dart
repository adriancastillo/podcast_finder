import 'package:flutter/material.dart';
import 'package:podcast_finder/core/utils/debouncer.dart';

class SearchTextfield extends StatefulWidget {
  const SearchTextfield({required this.onSearch, super.key});

  final void Function(String value) onSearch;

  @override
  State<SearchTextfield> createState() => _SearchTextfieldState();
}

class _SearchTextfieldState extends State<SearchTextfield> {
  final _debouncer = Debouncer(duration: Durations.long2);

  @override
  void dispose() {
    _debouncer.dispose();
    super.dispose();
  }

  void _onSearchChanged(String value) {
    _debouncer(() {
      if (value.trim().isEmpty) return;

      widget.onSearch(value);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: TextField(
        onChanged: _onSearchChanged,
        decoration: const InputDecoration(
          hintText: 'Search podcasts...',
          prefixIcon: Icon(Icons.search),
        ),
      ),
    );
  }
}
