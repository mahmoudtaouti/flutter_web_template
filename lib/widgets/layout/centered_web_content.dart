import 'package:flutter/widgets.dart';

/// Used to center the content view,
/// with maximum default width of 1900 in case of large screens.
class CenteredWebContent extends StatelessWidget {
  final double sideMargin;
  final double verticalMargin;
  final Widget child;
  final double maxWidth;
  final double minWidth;
  const CenteredWebContent(
      {super.key,
      this.sideMargin = 0,
      required this.child,
      this.maxWidth = 1900,
      this.verticalMargin = 0,
      this.minWidth = 400});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: Container(
          padding: EdgeInsets.symmetric(
              horizontal: sideMargin, vertical: verticalMargin),
          constraints: BoxConstraints(
            maxWidth: maxWidth,
            minWidth: minWidth,
          ),
          alignment: Alignment.topCenter,
          child: child,
        ),
      ),
    );
  }
}
