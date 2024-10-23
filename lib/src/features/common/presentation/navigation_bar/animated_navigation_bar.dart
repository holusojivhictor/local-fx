import 'dart:collection';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:local_fx/src/features/common/presentation/navigation_bar/navigation_bar.dart';

export 'navigation_tile.dart';

class AnimatedNavigationBar extends StatefulWidget {
  const AnimatedNavigationBar({
    required this.items,
    super.key,
    this.onItemSelected,
    this.iconSize = 30.0,
    this.currentIndex = 0,
    this.selectedFontSize = 14.0,
    this.unselectedFontSize = 12.0,
    this.useLegacyColorScheme = true,
    this.selectedItemColor,
    this.unselectedItemColor,
    this.selectedLabelStyle,
    this.unselectedLabelStyle,
    this.showSelectedLabels,
    this.showUnselectedLabels,
    this.selectedIconTheme,
    this.unselectedIconTheme,
    this.elevation,
    this.type,
    this.shape,
    this.backgroundColor,
    this.mouseCursor,
    this.enableFeedback,
    this.landscapeLayout,
  })  : assert(items.length >= 2, 'Length has to be greater than 1'),
        assert(
          0 <= currentIndex && currentIndex < items.length,
          'Invalid index',
        );

  final List<NavigationBarItem> items;
  final ValueChanged<int>? onItemSelected;
  final double iconSize;
  final Color? selectedItemColor;
  final Color? unselectedItemColor;
  final TextStyle? selectedLabelStyle;
  final TextStyle? unselectedLabelStyle;
  final SvgTheme? selectedIconTheme;
  final SvgTheme? unselectedIconTheme;
  final double selectedFontSize;
  final double unselectedFontSize;
  final bool? showUnselectedLabels;
  final bool? showSelectedLabels;
  final int currentIndex;
  final double? elevation;
  final NavigationBarType? type;
  final ShapeBorder? shape;
  final Color? backgroundColor;
  final MouseCursor? mouseCursor;
  final NavigationBarLandscapeLayout? landscapeLayout;
  final bool? enableFeedback;
  final bool useLegacyColorScheme;

  @override
  State<AnimatedNavigationBar> createState() => _AnimatedNavigationBarState();
}

class _AnimatedNavigationBarState extends State<AnimatedNavigationBar>
    with TickerProviderStateMixin {
  List<AnimationController> _controllers = <AnimationController>[];
  late List<CurvedAnimation> _animations;

  // A queue of color splashes currently being animated.
  final Queue<_Circle> _circles = Queue<_Circle>();

  // Last splash circle's color, and the final color of the control after
  // animation is complete.
  Color? _backgroundColor;

  static final Animatable<double> _flexTween =
      Tween<double>(begin: 1, end: 1.5);

  void _resetState() {
    for (final controller in _controllers) {
      controller.dispose();
    }
    for (final circle in _circles) {
      circle.dispose();
    }
    _circles.clear();

    _controllers =
        List<AnimationController>.generate(widget.items.length, (int index) {
      return AnimationController(
        duration: kThemeAnimationDuration,
        vsync: this,
      )..addListener(_rebuild);
    });
    _animations =
        List<CurvedAnimation>.generate(widget.items.length, (int index) {
      return CurvedAnimation(
        parent: _controllers[index],
        curve: Curves.fastOutSlowIn,
        reverseCurve: Curves.fastOutSlowIn.flipped,
      );
    });
    _controllers[widget.currentIndex].value = 1.0;
  }

  // Computes the default value for the [type] parameter.
  //
  // If type is provided, it is returned. Next, if the bottom navigation bar
  // theme provides a type, it is used. Finally, the default behavior will be
  // [NavigationBarType.fixed] for 3 or fewer items, and
  // [NavigationBarType.shifting] is used for 4+ items.
  NavigationBarType get _effectiveType {
    return widget.type ??
        (widget.items.length <= 3
            ? NavigationBarType.fixed
            : NavigationBarType.shifting);
  }

  // Computes the default value for the [showUnselected] parameter.
  //
  // Unselected labels are shown by default for [NavigationBarType.fixed],
  // and hidden by default for [NavigationBarType.shifting].
  bool get _defaultShowUnselected {
    return switch (_effectiveType) {
      NavigationBarType.shifting => false,
      NavigationBarType.fixed => true,
    };
  }

  @override
  void initState() {
    super.initState();
    _resetState();
  }

  void _rebuild() {
    setState(() {});
  }

  @override
  void dispose() {
    for (final controller in _controllers) {
      controller.dispose();
    }
    for (final circle in _circles) {
      circle.dispose();
    }
    super.dispose();
  }

  double _evaluateFlex(Animation<double> animation) =>
      _flexTween.evaluate(animation);

  void _pushCircle(int index) {
    if (widget.items[index].backgroundColor != null) {
      _circles.add(
        _Circle(
          state: this,
          index: index,
          color: widget.items[index].backgroundColor!,
          vsync: this,
        )..controller.addStatusListener(
            (AnimationStatus status) {
              switch (status) {
                case AnimationStatus.completed:
                  setState(() {
                    final circle = _circles.removeFirst();
                    _backgroundColor = circle.color;
                    circle.dispose();
                  });
                case AnimationStatus.dismissed:
                case AnimationStatus.forward:
                case AnimationStatus.reverse:
                  break;
              }
            },
          ),
      );
    }
  }

  @override
  void didUpdateWidget(AnimatedNavigationBar oldWidget) {
    super.didUpdateWidget(oldWidget);

    // No animated segue if the length of the items list changes.
    if (widget.items.length != oldWidget.items.length) {
      _resetState();
      return;
    }

    if (widget.currentIndex != oldWidget.currentIndex) {
      switch (_effectiveType) {
        case NavigationBarType.fixed:
          break;
        case NavigationBarType.shifting:
          _pushCircle(widget.currentIndex);
      }
      _controllers[oldWidget.currentIndex].reverse();
      _controllers[widget.currentIndex].forward();
    } else {
      if (_backgroundColor !=
          widget.items[widget.currentIndex].backgroundColor) {
        _backgroundColor = widget.items[widget.currentIndex].backgroundColor;
      }
    }
  }

  // If the given [TextStyle] has a non-null `fontSize`, it should be used.
  // Otherwise, the [selectedFontSize] parameter should be used.
  static TextStyle _effectiveTextStyle(
    double fontSize, {
    TextStyle? textStyle,
  }) {
    textStyle ??= const TextStyle();
    // Prefer the font size on textStyle if present.
    return textStyle.fontSize == null
        ? textStyle.copyWith(fontSize: fontSize)
        : textStyle;
  }

  List<Widget> _createTiles(NavigationBarLandscapeLayout layout) {
    final themeData = Theme.of(context);
    final bottomTheme = BottomNavigationBarTheme.of(context);

    final Color themeColor;
    switch (themeData.brightness) {
      case Brightness.light:
        themeColor = themeData.colorScheme.primary;
      case Brightness.dark:
        themeColor = themeData.colorScheme.secondary;
    }

    final effectiveSelectedLabelStyle = _effectiveTextStyle(
      widget.selectedFontSize,
      textStyle: widget.selectedLabelStyle ?? bottomTheme.selectedLabelStyle,
    );

    final effectiveUnselectedLabelStyle = _effectiveTextStyle(
      widget.unselectedFontSize,
      textStyle:
          widget.unselectedLabelStyle ?? bottomTheme.unselectedLabelStyle,
    );

    final ColorTween colorTween;
    switch (_effectiveType) {
      case NavigationBarType.fixed:
        colorTween = ColorTween(
          begin: widget.unselectedItemColor ??
              bottomTheme.unselectedItemColor ??
              themeData.unselectedWidgetColor,
          end: widget.selectedItemColor ??
              bottomTheme.selectedItemColor ??
              themeColor,
        );
      case NavigationBarType.shifting:
        colorTween = ColorTween(
          begin: widget.unselectedItemColor ??
              bottomTheme.unselectedItemColor ??
              themeData.colorScheme.surface,
          end: widget.selectedItemColor ??
              bottomTheme.selectedItemColor ??
              themeData.colorScheme.surface,
        );
    }

    final ColorTween labelColorTween;
    switch (_effectiveType) {
      case NavigationBarType.fixed:
        labelColorTween = ColorTween(
          begin: effectiveUnselectedLabelStyle.color ??
              widget.unselectedItemColor ??
              bottomTheme.unselectedItemColor ??
              themeData.unselectedWidgetColor,
          end: effectiveSelectedLabelStyle.color ??
              widget.selectedItemColor ??
              bottomTheme.selectedItemColor ??
              themeColor,
        );
      case NavigationBarType.shifting:
        labelColorTween = ColorTween(
          begin: effectiveUnselectedLabelStyle.color ??
              widget.unselectedItemColor ??
              bottomTheme.unselectedItemColor ??
              themeData.colorScheme.surface,
          end: effectiveSelectedLabelStyle.color ??
              widget.selectedItemColor ??
              bottomTheme.selectedItemColor ??
              themeColor,
        );
    }

    final ColorTween iconColorTween;
    switch (_effectiveType) {
      case NavigationBarType.fixed:
        iconColorTween = ColorTween(
          begin: widget.selectedIconTheme?.currentColor ??
              widget.unselectedItemColor ??
              bottomTheme.unselectedItemColor ??
              themeData.unselectedWidgetColor,
          end: widget.unselectedIconTheme?.currentColor ??
              widget.selectedItemColor ??
              bottomTheme.selectedItemColor ??
              themeColor,
        );
      case NavigationBarType.shifting:
        iconColorTween = ColorTween(
          begin: widget.unselectedIconTheme?.currentColor ??
              widget.unselectedItemColor ??
              bottomTheme.unselectedItemColor ??
              themeData.colorScheme.surface,
          end: widget.selectedIconTheme?.currentColor ??
              widget.selectedItemColor ??
              bottomTheme.selectedItemColor ??
              themeColor,
        );
    }

    final tiles = <Widget>[];

    for (var i = 0; i < widget.items.length; i++) {
      final states = <WidgetState>{
        if (i == widget.currentIndex) WidgetState.selected,
      };

      final effectiveMouseCursor = WidgetStateProperty.resolveAs<MouseCursor?>(
            widget.mouseCursor,
            states,
          ) ??
          bottomTheme.mouseCursor?.resolve(states) ??
          WidgetStateMouseCursor.clickable.resolve(states);

      tiles.add(
        NavigationTile(
          _effectiveType,
          widget.items[i],
          _animations[i],
          widget.iconSize,
          key: widget.items[i].key,
          onTap: () {
            widget.onItemSelected?.call(i);
          },
          selectedIconTheme: widget.selectedIconTheme,
          unselectedIconTheme: widget.unselectedIconTheme,
          selected: i == widget.currentIndex,
          selectedLabelStyle: effectiveSelectedLabelStyle,
          unselectedLabelStyle: effectiveUnselectedLabelStyle,
          enableFeedback:
              widget.enableFeedback ?? bottomTheme.enableFeedback ?? true,
          labelColorTween:
              widget.useLegacyColorScheme ? colorTween : labelColorTween,
          iconColorTween:
              widget.useLegacyColorScheme ? colorTween : iconColorTween,
          showSelectedLabels: widget.showSelectedLabels ??
              bottomTheme.showSelectedLabels ??
              true,
          showUnselectedLabels: widget.showUnselectedLabels ??
              bottomTheme.showUnselectedLabels ??
              _defaultShowUnselected,
          flex: _evaluateFlex(_animations[i]),
          mouseCursor: effectiveMouseCursor,
          layout: layout,
        ),
      );
    }

    return tiles;
  }

  @override
  Widget build(BuildContext context) {
    final bottomTheme = BottomNavigationBarTheme.of(context);
    final layout =
        widget.landscapeLayout ?? NavigationBarLandscapeLayout.spread;
    final additionalBottomPadding = MediaQuery.of(context).viewPadding.bottom;

    final backgroundColor = switch (_effectiveType) {
      NavigationBarType.fixed =>
        widget.backgroundColor ?? bottomTheme.backgroundColor,
      NavigationBarType.shifting => _backgroundColor,
    };

    return Semantics(
      explicitChildNodes: true,
      child: _Bar(
        layout: layout,
        shape: widget.shape,
        elevation: widget.elevation ?? bottomTheme.elevation ?? 8.0,
        color: backgroundColor,
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: kBottomNavigationBarHeight + additionalBottomPadding,
          ),
          child: CustomPaint(
            painter: _RadialPainter(
              circles: _circles.toList(),
              textDirection: Directionality.of(context),
            ),
            child: Material(
              type: MaterialType.transparency,
              child: Padding(
                padding: EdgeInsets.only(
                  bottom: additionalBottomPadding,
                ),
                child: MediaQuery.removePadding(
                  context: context,
                  removeBottom: true,
                  child: DefaultTextStyle.merge(
                    overflow: TextOverflow.ellipsis,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: _createTiles(layout),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _Bar extends StatelessWidget {
  const _Bar({
    required this.child,
    required this.elevation,
    required this.shape,
    required this.color,
    required this.layout,
  });

  final Widget child;
  final double elevation;
  final ShapeBorder? shape;
  final Color? color;
  final NavigationBarLandscapeLayout layout;

  @override
  Widget build(BuildContext context) {
    var alignedChild = child;
    if (MediaQuery.orientationOf(context) == Orientation.landscape &&
        layout == NavigationBarLandscapeLayout.centered) {
      alignedChild = Align(
        alignment: Alignment.bottomCenter,
        heightFactor: 1,
        child: SizedBox(
          width: MediaQuery.sizeOf(context).height,
          child: child,
        ),
      );
    }

    return Material(
      elevation: elevation,
      shape: shape,
      color: color,
      child: alignedChild,
    );
  }
}

// Describes an animating color splash circle.
class _Circle {
  _Circle({
    required this.state,
    required this.index,
    required this.color,
    required TickerProvider vsync,
  }) {
    controller = AnimationController(
      duration: kThemeAnimationDuration,
      vsync: vsync,
    );
    animation = CurvedAnimation(
      parent: controller,
      curve: Curves.fastOutSlowIn,
    );
    controller.forward();
  }

  final _AnimatedNavigationBarState state;
  final int index;
  final Color color;
  late AnimationController controller;
  late CurvedAnimation animation;

  double get horizontalLeadingOffset {
    double weightSum(Iterable<Animation<double>> animations) {
      // We're adding flex values instead of animation values to produce correct
      // ratios.
      return animations
          .map<double>(state._evaluateFlex)
          .fold<double>(0, (double sum, double value) => sum + value);
    }

    final allWeights = weightSum(state._animations);
    // These weights sum to the start edge of the indexed item.
    final leadingWeights = weightSum(state._animations.sublist(0, index));

    // Add half of its flex value in order to get to the center.
    return (leadingWeights +
            state._evaluateFlex(state._animations[index]) / 2.0) /
        allWeights;
  }

  void dispose() {
    controller.dispose();
  }
}

// Paints the animating color splash circles.
class _RadialPainter extends CustomPainter {
  _RadialPainter({
    required this.circles,
    required this.textDirection,
  });

  final List<_Circle> circles;
  final TextDirection textDirection;

  // Computes the maximum radius attainable such that at least one of the
  // bounding rectangle's corners touches the edge of the circle. Drawing a
  // circle larger than this radius is not needed, since there is no perceivable
  // difference within the cropped rectangle.
  static double _maxRadius(Offset center, Size size) {
    final double maxX = math.max(center.dx, size.width - center.dx);
    final double maxY = math.max(center.dy, size.height - center.dy);
    return math.sqrt(maxX * maxX + maxY * maxY);
  }

  @override
  bool shouldRepaint(_RadialPainter oldPainter) {
    if (textDirection != oldPainter.textDirection) {
      return true;
    }
    if (circles == oldPainter.circles) {
      return false;
    }
    if (circles.length != oldPainter.circles.length) {
      return true;
    }
    for (var i = 0; i < circles.length; i += 1) {
      if (circles[i] != oldPainter.circles[i]) {
        return true;
      }
    }
    return false;
  }

  @override
  void paint(Canvas canvas, Size size) {
    for (final circle in circles) {
      final paint = Paint()..color = circle.color;
      final rect = Rect.fromLTWH(0, 0, size.width, size.height);
      canvas.clipRect(rect);
      final leftFraction = switch (textDirection) {
        TextDirection.rtl => 1.0 - circle.horizontalLeadingOffset,
        TextDirection.ltr => circle.horizontalLeadingOffset,
      };
      final center = Offset(leftFraction * size.width, size.height / 2.0);
      final radiusTween = Tween<double>(
        begin: 0,
        end: _maxRadius(center, size),
      );
      canvas.drawCircle(
        center,
        radiusTween.transform(circle.animation.value),
        paint,
      );
    }
  }
}
