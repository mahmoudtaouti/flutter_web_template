export 'selectable_widget.dart';
export 'mouse_region.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

extension WebWidgetExtensions on Widget {

  Widget addTooltip(String message, {Color backgroundColor = Colors.black54, TextStyle? textStyle,double? offset}) {
    return Tooltip(
      message: message,
      decoration: BoxDecoration(color: backgroundColor,borderRadius: BorderRadius.circular(5)),
      textStyle: textStyle,
      padding: const EdgeInsets.all(8.0),
      verticalOffset: offset,
      child: this,
    );
  }

  Widget makeSelectable() {
    return SelectableRegion(
      selectionControls: materialTextSelectionControls,
      focusNode: FocusNode(),
      child: this,
    );
  }

  Widget addShadow({
    Color color = Colors.black12,
    Offset offset = const Offset(1, 1),
    double blurRadius = 12.0,
  }) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: color,
            offset: offset,
            blurRadius: blurRadius,
          ),
        ],
      ),
      child: this,
    );
  }

  Widget addBorder({
    Color color = Colors.black,
    double width = 1.0,
    BorderRadius borderRadius = BorderRadius.zero,
  }) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: color, width: width),
        borderRadius: borderRadius,
      ),
      child: this,
    );
  }

  Widget makeResponsive({
    required Widget mobile,
    required Widget tablet,
    required Widget desktop,
  }) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < 600) {
          return mobile;
        } else if (constraints.maxWidth < 1200) {
          return tablet;
        } else {
          return desktop;
        }
      },
    );
  }

  Widget addExternalLink(String url) {
    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: () async {
        if (await canLaunchUrl(Uri.parse(url))) {
          await launchUrl(Uri.parse(url));
        } else {
          throw 'Could not launch $url';
        }
      },
      child: this,
    );
  }

  Widget addPopup({required BuildContext context, required Widget popupContent}) {
    return GestureDetector(
      child: this,
      onTap: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              content: popupContent,
              actions: <Widget>[
                TextButton(
                  child: const Text('Close'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      },
    );
  }

}

