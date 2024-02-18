import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class AppSearchBar extends StatefulWidget {
  final void Function(String searchValue) onChanged;

  const AppSearchBar({
    super.key,
    required this.onChanged,
  });

  @override
  State<AppSearchBar> createState() => _AppSearchBarState();
}

class _AppSearchBarState extends State<AppSearchBar> {
  final _searchSubject = BehaviorSubject<String>();
  String _searchValue = '';

  @override
  void initState() {
    super.initState();
    _searchSubject.stream
        .debounceTime(const Duration(milliseconds: 750))
        .where((event) => event.isNotEmpty)
        .listen((String query) => widget.onChanged(query));
  }

  @override
  void dispose() {
    _searchSubject.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SearchBar(
      padding: const MaterialStatePropertyAll<EdgeInsets>(
        EdgeInsets.symmetric(horizontal: 16.0),
      ),
      leading: const Icon(Icons.search),
      onChanged: (value) {
        _searchValue = value;
        _searchSubject.add(_searchValue);
      },
    );
  }
}
