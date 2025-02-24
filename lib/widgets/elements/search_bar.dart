import 'package:flutter/material.dart';

class SimpleSearchBar extends StatelessWidget {
  const SimpleSearchBar(
      {super.key,
      this.hintText = 'Search...',
      this.iconPadding = const EdgeInsets.only(left: 7, right: 7),
      this.icon = const Icon(Icons.search_rounded), this.controller});

  final String hintText;
  final EdgeInsets iconPadding;
  final Widget icon;
  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Theme(
      data: theme.copyWith(
        iconTheme:
            theme.iconTheme.copyWith(color: theme.colorScheme.onSurfaceVariant),
      ),
      child: TextFormField(
        style: theme.textTheme.titleMedium,
        controller: controller,
        decoration: InputDecoration(
          hintText: hintText,
          prefixIcon: Padding(
            padding: iconPadding,
            child: icon,
          ),
          filled: true,
          fillColor: Theme.of(context).scaffoldBackgroundColor,
          border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(12.0),
              ),
              borderSide: BorderSide.none),
          focusedBorder: OutlineInputBorder(
              borderRadius: const BorderRadius.all(
                Radius.circular(12.0),
              ),
              borderSide: BorderSide(
                  width: .9, color: Theme.of(context).colorScheme.primary)),
        ),
      ),
    );
  }
}
