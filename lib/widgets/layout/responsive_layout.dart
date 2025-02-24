import 'package:flutter/widgets.dart';

enum DeviceType { mobile, tablet, desktop }

class ResponsiveLayout extends StatelessWidget {
  final Widget Function(BuildContext context, ResponsiveInfo info) builder;
  final Map<DeviceType, double> breakpoints;
  final Map<String, dynamic> customData;

  const ResponsiveLayout({
    super.key,
    required this.builder,
    this.breakpoints = const {
      DeviceType.mobile: 0,
      DeviceType.tablet: 600,
      DeviceType.desktop: 1200,
    },
    this.customData = const {},
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final mediaQuery = MediaQuery.of(context);
        final info = ResponsiveInfo(
          deviceType: _getDeviceType(constraints.maxWidth),
          orientation: mediaQuery.orientation == Orientation.portrait
              ? Orientation.portrait
              : Orientation.landscape,
          screenSize: mediaQuery.size,
          localWidgetSize: Size(constraints.maxWidth, constraints.maxHeight),
          devicePixelRatio: mediaQuery.devicePixelRatio,
          customData: customData,
        );
        return builder(context, info);
      },
    );
  }

  DeviceType _getDeviceType(double width) {
    if (width >= breakpoints[DeviceType.desktop]!) {
      return DeviceType.desktop;
    } else if (width >= breakpoints[DeviceType.tablet]!) {
      return DeviceType.tablet;
    } else {
      return DeviceType.mobile;
    }
  }

  static ResponsiveInfo of(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final size = mediaQuery.size;
    return ResponsiveInfo(
      deviceType: _getDeviceTypeStatic(size.width),
      orientation: size.width > size.height
          ? Orientation.landscape
          : Orientation.portrait,
      screenSize: size,
      localWidgetSize: size,
      devicePixelRatio: mediaQuery.devicePixelRatio,
      customData: {},
    );
  }

  static DeviceType _getDeviceTypeStatic(double width) {
    if (width >= 1200) {
      return DeviceType.desktop;
    } else if (width >= 600) {
      return DeviceType.tablet;
    } else {
      return DeviceType.mobile;
    }
  }
}

class ResponsiveInfo {
  final DeviceType deviceType;
  final Orientation orientation;
  final Size screenSize;
  final Size localWidgetSize;
  final double devicePixelRatio;
  final Map<String, dynamic> customData;

  const ResponsiveInfo({
    required this.deviceType,
    required this.orientation,
    required this.screenSize,
    required this.localWidgetSize,
    required this.devicePixelRatio,
    required this.customData,
  });

  bool get isMobile => deviceType == DeviceType.mobile;
  bool get isTablet => deviceType == DeviceType.tablet;
  bool get isDesktop => deviceType == DeviceType.desktop;

  T responsiveValue<T>({
    required T mobile,
    T? tablet,
    required T desktop,
  }) {
    switch (deviceType) {
      case DeviceType.mobile:
        return mobile;
      case DeviceType.tablet:
        return tablet ?? desktop;
      case DeviceType.desktop:
        return desktop;
    }
  }
}

class ResponsiveConstrainedBox extends StatelessWidget {
  final Widget child;
  final double? maxWidthMobile;
  final double? maxWidthTablet;
  final double? maxWidthDesktop;

  const ResponsiveConstrainedBox({
    super.key,
    required this.child,
    this.maxWidthMobile,
    this.maxWidthTablet,
    this.maxWidthDesktop,
  });

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      builder: (context, info) {
        double? maxWidth = info.responsiveValue(
          mobile: maxWidthMobile,
          tablet: maxWidthTablet,
          desktop: maxWidthDesktop,
        );

        return ConstrainedBox(
          constraints: BoxConstraints(maxWidth: maxWidth ?? double.infinity),
          child: child,
        );
      },
    );
  }
}

class ResponsivePadding extends StatelessWidget {
  final Widget child;
  final EdgeInsets mobilePadding;
  final EdgeInsets? tabletPadding;
  final EdgeInsets desktopPadding;

  const ResponsivePadding({
    super.key,
    required this.child,
    required this.mobilePadding,
    this.tabletPadding,
    required this.desktopPadding,
  });

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      builder: (context, info) {
        final padding = info.responsiveValue(
          mobile: mobilePadding,
          tablet: tabletPadding,
          desktop: desktopPadding,
        );

        return Padding(
          padding: padding,
          child: child,
        );
      },
    );
  }
}

// class ResponsiveLayout extends StatelessWidget {
//   final Widget Function(BuildContext context, DeviceType deviceType) builder;
//   final Map<DeviceType, double> breakpoints;
//
//   const ResponsiveLayout({
//     Key? key,
//     required this.builder,
//     this.breakpoints = const {
//       DeviceType.mobile: 0,
//       DeviceType.tablet: 600,
//       DeviceType.desktop: 1200,
//     },
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return LayoutBuilder(
//       builder: (context, constraints) {
//         final deviceType = _getDeviceType(constraints.maxWidth);
//         return builder(context, deviceType);
//       },
//     );
//   }
//
//   DeviceType _getDeviceType(double width) {
//     if (width >= breakpoints[DeviceType.desktop]!) {
//       return DeviceType.desktop;
//     } else if (width >= breakpoints[DeviceType.tablet]!) {
//       return DeviceType.tablet;
//     } else {
//       return DeviceType.mobile;
//     }
//   }
//
//   static bool isMobile(BuildContext context) =>
//       MediaQuery.of(context).size.width < 600;
//
//   static bool isTablet(BuildContext context) =>
//       MediaQuery.of(context).size.width >= 600 &&
//           MediaQuery.of(context).size.width < 1200;
//
//   static bool isDesktop(BuildContext context) =>
//       MediaQuery.of(context).size.width >= 1200;
// }
