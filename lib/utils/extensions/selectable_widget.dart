import 'package:flutter/material.dart';

class CustomSelectableWidget extends StatelessWidget {
  final Widget widget;
  final FocusNode focusNode = FocusNode();
  CustomSelectableWidget({required this.widget, super.key});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        SelectableRegion(
          focusNode: focusNode,
          selectionControls: MaterialTextSelectionControls(),
          child: widget,
        )
      ],
    );
  }
}

extension SelectableWidgetExtension on Widget {
  /// Wraps the widget with a SelectableText widget.
  Widget selectableWidget() {
    return CustomSelectableWidget(
      widget: this,
    );
  }
}
