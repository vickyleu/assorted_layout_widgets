import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Box extends StatelessWidget {
  /// Box is something between a Container and a SizedBox.
  /// Unlike a Container it can be made `const`, so it's good for creating colored boxes,
  /// with or without padding:
  ///
  /// ```
  /// const Box(color: Colors.red, width: 50, height:30, child: myChild);
  /// ```
  ///
  /// The padding is given by `top`, `right`, `bottom` and `left` values, but they
  /// are only applied if the child is NOT NULL. If the `child` is `null` and `width`
  /// and `height` are also `null`, this means the box will occupy no space (will be
  /// hidden). **Note:** This will be extended in the future, so that it ignores horizontal
  /// padding when the child has zero width, and ignores vertical padding when the child
  /// has zero height.
  ///
  /// `vertical` can be used instead of `top` and `bottom`.
  /// `horizontal` can be used instead of `left` and `right`.
  ///
  /// You can also hide the box by making the `show` parameter equal to `false`.
  ///
  /// # Debugging:
  /// * If need to quickly and temporarily add a color to your box so that you can see it,
  /// you can use the constructors `Box.r` for red, `Box.g` for green, and `Box.b` for blue.
  /// * If you want to see rebuilds, you can use the `Box.rand` constructor.
  /// It will then change its color to a random one, whenever its build method is called.
  ///
  const Box({
    Key key,
    bool show,
    this.color,
    double top,
    double right,
    double bottom,
    double left,
    double vertical,
    double horizontal,
    this.width,
    this.height,
    this.alignment,
    this.child,
  })  : assert(vertical == null || top == null, 'Cannot provide both vertical and top.'),
        assert(vertical == null || bottom == null, 'Cannot provide both vertical and bottom.'),
        assert(horizontal == null || right == null, 'Cannot provide both horizontal and right.'),
        assert(horizontal == null || left == null, 'Cannot provide both horizontal and left.'),
        top = top ?? vertical,
        bottom = bottom ?? vertical,
        right = right ?? horizontal,
        left = left ?? horizontal,
        show = show ?? true,
        _random = false,
        super(key: key);

  // Adding `.r` to the box will make it red.
  // Use this for debugging purposes only.
  const Box.r({
    Key key,
    bool show,
    Color color,
    double top,
    double right,
    double bottom,
    double left,
    double vertical,
    double horizontal,
    double width,
    double height,
    Alignment alignment,
    Widget child,
  }) : this(
          key: key,
          show: show,
          color: Colors.red,
          top: top,
          right: right,
          bottom: bottom,
          left: left,
          vertical: vertical,
          horizontal: horizontal,
          width: width,
          height: height,
          alignment: alignment,
          child: child,
        );

  // Adding `.g` to the box will make it green.
  // Use this for debugging purposes only.
  const Box.g({
    Key key,
    bool show,
    Color color,
    double top,
    double right,
    double bottom,
    double left,
    double vertical,
    double horizontal,
    double width,
    double height,
    Alignment alignment,
    Widget child,
  }) : this(
          key: key,
          show: show,
          color: Colors.green,
          top: top,
          right: right,
          bottom: bottom,
          left: left,
          vertical: vertical,
          horizontal: horizontal,
          width: width,
          height: height,
          alignment: alignment,
          child: child,
        );

  // Adding `.b` to the box will make it blue.
  // Use this for debugging purposes only.
  const Box.b({
    Key key,
    bool show,
    Color color,
    double top,
    double right,
    double bottom,
    double left,
    double vertical,
    double horizontal,
    double width,
    double height,
    Alignment alignment,
    Widget child,
  }) : this(
          key: key,
          show: show,
          color: Colors.blue,
          top: top,
          right: right,
          bottom: bottom,
          left: left,
          vertical: vertical,
          horizontal: horizontal,
          width: width,
          height: height,
          alignment: alignment,
          child: child,
        );

  // Adding `.y` to the box will make it yellow.
  // Use this for debugging purposes only.
  const Box.y({
    Key key,
    bool show,
    Color color,
    double top,
    double right,
    double bottom,
    double left,
    double vertical,
    double horizontal,
    double width,
    double height,
    Alignment alignment,
    Widget child,
  }) : this(
          key: key,
          show: show,
          color: Colors.yellow,
          top: top,
          right: right,
          bottom: bottom,
          left: left,
          vertical: vertical,
          horizontal: horizontal,
          width: width,
          height: height,
          alignment: alignment,
          child: child,
        );

  // Use the `Box.rand` constructor to see when the widget rebuilds.
  // It will change its color to a random one, whenever its build method is called.
  const Box.rand({
    Key key,
    bool show,
    this.color,
    double top,
    double right,
    double bottom,
    double left,
    double vertical,
    double horizontal,
    this.width,
    this.height,
    this.alignment,
    this.child,
  })  : assert(vertical == null || top == null, 'Cannot provide both vertical and top.'),
        assert(vertical == null || bottom == null, 'Cannot provide both vertical and bottom.'),
        assert(horizontal == null || right == null, 'Cannot provide both horizontal and right.'),
        assert(horizontal == null || left == null, 'Cannot provide both horizontal and left.'),
        top = top ?? vertical,
        bottom = bottom ?? vertical,
        right = right ?? horizontal,
        left = left ?? horizontal,
        show = show ?? true,
        _random = true,
        super(key: key);

  final Color color;
  final bool show;
  final double top;
  final double right;
  final double bottom;
  final double left;
  final double width;
  final double height;
  final AlignmentGeometry alignment;
  final Widget child;
  final bool _random;

  @override
  Widget build(BuildContext context) {
    if (!show) return const SizedBox();
    Widget current = child;

    if (alignment != null) current = Align(alignment: alignment, child: current);

    if (child != null && (top != null || bottom != null || left != null || right != null))
      current = Padding(
          padding: EdgeInsets.only(
              top: top ?? 0.0, bottom: bottom ?? 0.0, right: right ?? 0.0, left: left ?? 0.0),
          child: current);

    if (_random) {
      var rand = Random();
      int r = (color == null) ? (30 + rand.nextInt(196)) : (color.red + rand.nextInt(256)) ~/ 2;
      int g = (color == null) ? (30 + rand.nextInt(196)) : (color.green + rand.nextInt(256)) ~/ 2;
      int b = (color == null) ? (30 + rand.nextInt(196)) : (color.blue + rand.nextInt(256)) ~/ 2;
      current = DecoratedBox(
          decoration: BoxDecoration(color: Color.fromARGB(255, r, g, b)), child: current);
    } else if (color != null)
      current = DecoratedBox(decoration: BoxDecoration(color: color), child: current);

    if (width != null || height != null)
      current = ConstrainedBox(
        constraints: BoxConstraints.tightFor(width: width, height: height),
        child: current,
      );

    return current;
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<Color>('color', color, defaultValue: null));
    properties.add(DoubleProperty('top', top, defaultValue: null));
    properties.add(DoubleProperty('right', right, defaultValue: null));
    properties.add(DoubleProperty('bottom', bottom, defaultValue: null));
    properties.add(DoubleProperty('left', left, defaultValue: null));
    properties.add(DoubleProperty('width', width, defaultValue: null));
    properties.add(DoubleProperty('height', height, defaultValue: null));
    properties.add(DiagnosticsProperty<AlignmentGeometry>('alignment', alignment,
        showName: false, defaultValue: null));
  }
}
