import 'package:flutter/material.dart';

class CustomSearchBar extends StatelessWidget {
  final void Function(String) onChanged;
  final void Function() onTap;
  final bool autoFocus;
  final String hintText;
  final TextEditingController searchController;
  CustomSearchBar({
    @required this.onChanged,
    @required this.autoFocus,
    @required this.onTap,
    @required this.hintText,
    this.searchController,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.grey[200], borderRadius: BorderRadius.circular(20)),
      child: TextFormField(
        controller: searchController,
        onTap: onTap,
        autofocus: autoFocus,
        onChanged: onChanged,
        decoration: InputDecoration(
          border: InputBorder.none,
          prefixIcon: Icon(
            Icons.search,
            color: Colors.grey,
          ),
          hintText: hintText,
        ),
      ),
    );
  }
}
