import 'package:flutter/material.dart';

class AnimateOnHover extends StatefulWidget {
  final Widget child;
  final double xTranslate;
  final double yTranslate;
  final double scale;
  final double rotation;
  final Color? hoverColor;
  final BoxShadow? hoverShadow;
  final Duration duration;
  final Curve curve;

  const AnimateOnHover({
    super.key,
    required this.child,
    this.xTranslate = 0,
    this.yTranslate = 0,
    this.scale = 1.0,
    this.rotation = 0,
    this.hoverColor,
    this.hoverShadow,
    this.duration = const Duration(milliseconds: 200),
    this.curve = Curves.easeInOut,
  });

  @override
  AnimateOnHoverState createState() => AnimateOnHoverState();
}

class AnimateOnHoverState extends State<AnimateOnHover> {
  bool _hovering = false;
  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (e) => _mouseEnter(true),
      onExit: (e) => _mouseEnter(false),
      child: AnimatedContainer(
        duration: widget.duration,
        curve: widget.curve,
        transform: _buildTransform(),
        decoration: BoxDecoration(
          color: _hovering ? widget.hoverColor : null,
          boxShadow: _hovering
              ? [if (widget.hoverShadow != null) widget.hoverShadow!]
              : null,
        ),
        child: widget.child,
      ),
    );
  }

  Matrix4 _buildTransform() {
    final transform = Matrix4.identity();
    if (_hovering) {
      transform
        ..translate(widget.xTranslate, widget.yTranslate, 0)
        ..scale(widget.scale)
        ..rotateZ(widget.rotation);
    }
    return transform;
  }

  void _mouseEnter(bool hover) {
    setState(() {
      _hovering = hover;
    });
  }
}

extension OnHoverAnimation on Widget {

  Widget get moveUpOnHover {
    return AnimateOnHover(
      yTranslate: -4,
      child: this,
    );
  }

  Widget get moveDownOnHover {
    return AnimateOnHover(
      yTranslate: 4,
      child: this,
    );
  }

  Widget get moveLeftOnHover {
    return AnimateOnHover(
      xTranslate: -4,
      child: this,
    );
  }

  Widget get moveRightOnHover {
    return AnimateOnHover(
      xTranslate: 4,
      child: this,
    );
  }

  Widget get scaleUpOnHover {
    return AnimateOnHover(
      scale: 1.02,
      xTranslate: -4,
      yTranslate: -2,
      child: this,
    );
  }

  Widget get scaleDownOnHover {
    return AnimateOnHover(
      scale: 0.98,
      xTranslate: 4,
      yTranslate: 2,
      child: this,
    );
  }

  Widget get rotateOnHover {
    return AnimateOnHover(
      rotation: 0.05, // Approximately 2.86 degrees
      child: this,
    );
  }

  Widget addShadowOnHover({
    Color shadowColor = Colors.black54,
    double blurRadius = 10,
    Offset offset = const Offset(0, 5),
  }) {
    return AnimateOnHover(
      hoverShadow: BoxShadow(
        color: shadowColor,
        blurRadius: blurRadius,
        offset: offset,
      ),
      child: this,
    );
  }

  Widget changeColorOnHover(Color hoverColor) {
    return AnimateOnHover(
      hoverColor: hoverColor,
      child: this,
    );
  }

  Widget get bounceOnHover {
    return AnimateOnHover(
      yTranslate: -2,
      scale: 1.02,
      duration: const Duration(milliseconds: 300),
      curve: Curves.elasticOut,
      child: this,
    );
  }

  Widget get pulseOnHover {
    return AnimateOnHover(
      scale: 1.03,
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeInOut,
      child: this,
    );
  }

  Widget get shakeOnHover {
    return AnimateOnHover(
      xTranslate: 2,
      rotation: 0.02,
      duration: const Duration(milliseconds: 100),
      curve: Curves.easeInOut,
      child: this,
    );
  }

  Widget glowOnHover({required Color color, double blurRadius = 12,double spreadRadius = 2}) {
    return AnimateOnHover(
      hoverShadow: BoxShadow(
        color: color,
        blurRadius: blurRadius,
        spreadRadius: 2,
      ),
      duration: const Duration(milliseconds: 300),
      curve: Curves.slowMiddle,
      child: this,
    );
  }

  Widget customHoverAnimation({
    double xTranslate = 0,
    double yTranslate = 0,
    double scale = 1,
    double rotation = 0,
    Color? hoverColor,
    BoxShadow? hoverShadow,
    Duration duration = const Duration(milliseconds: 200),
    Curve curve = Curves.easeInOut,
  }) {
    return AnimateOnHover(
      xTranslate: xTranslate,
      yTranslate: yTranslate,
      scale: scale,
      rotation: rotation,
      hoverColor: hoverColor,
      hoverShadow: hoverShadow,
      duration: duration,
      curve: curve,
      child: this,
    );
  }
}