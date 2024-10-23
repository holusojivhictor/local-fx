import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:local_fx/src/features/common/presentation/navigation_bar/navigation_bar_item.dart';
import 'package:vector_math/vector_math_64.dart' show Vector3;

enum NavigationBarType {
  /// The [NavigationBar]'s [NavigationBarItem]s have fixed width.
  fixed,

  /// The location and size of the [NavigationBar] [NavigationBarItem]s
  /// animate and labels fade in when they are tapped.
  shifting,
}

enum NavigationBarLandscapeLayout {
  /// If the enclosing [MediaQueryData.orientation] is
  /// [Orientation.landscape] then the navigation bar's items are
  /// evenly spaced and spread out across the available width. Each
  /// item's label and icon are arranged in a column.
  spread,

  /// If the enclosing [MediaQueryData.orientation] is
  /// [Orientation.landscape] then the navigation bar's items are
  /// evenly spaced in a row but only consume as much width as they
  /// would in portrait orientation. The row of items is centered within
  /// the available width. Each item's label and icon are arranged
  /// in a column.
  centered,

  /// If the enclosing [MediaQueryData.orientation] is
  /// [Orientation.landscape] then the navigation bar's items are
  /// evenly spaced and each item's icon and label are lined up in a
  /// row instead of a column.
  linear,
}

class NavigationTile extends StatelessWidget {
  const NavigationTile(
    this.type,
    this.item,
    this.animation,
    this.iconSize, {
    required this.selected,
    required this.selectedLabelStyle,
    required this.unselectedLabelStyle,
    required this.selectedIconTheme,
    required this.unselectedIconTheme,
    required this.showSelectedLabels,
    required this.showUnselectedLabels,
    required this.mouseCursor,
    required this.enableFeedback,
    required this.layout,
    super.key,
    this.flex,
    this.indexLabel,
    this.labelColorTween,
    this.iconColorTween,
    this.onTap,
  });

  final NavigationBarType type;
  final NavigationBarItem item;
  final Animation<double> animation;
  final double iconSize;
  final double? flex;
  final ColorTween? labelColorTween;
  final ColorTween? iconColorTween;
  final SvgTheme? selectedIconTheme;
  final SvgTheme? unselectedIconTheme;
  final TextStyle selectedLabelStyle;
  final TextStyle unselectedLabelStyle;
  final String? indexLabel;
  final VoidCallback? onTap;
  final MouseCursor mouseCursor;
  final NavigationBarLandscapeLayout layout;
  final bool enableFeedback;
  final bool showSelectedLabels;
  final bool showUnselectedLabels;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    // In order to use the flex container to grow the tile during animation, we
    // need to divide the changes in flex allotment into smaller pieces to
    // produce smooth animation. We do this by multiplying the flex value
    // (which is an integer) by a large number.
    final int size;

    final selectedFontSize = selectedLabelStyle.fontSize!;

    final selectedIconSize = selectedIconTheme?.xHeight ?? iconSize;
    final unselectedIconSize = unselectedIconTheme?.xHeight ?? iconSize;

    // The amount that the selected icon is bigger than the unselected icons,
    // (or zero if the selected icon is not bigger than the unselected icons).
    final double selectedIconDiff =
        math.max(selectedIconSize - unselectedIconSize, 0);
    // The amount that the unselected icons are bigger than the selected icon,
    // (or zero if the unselected icons are not any bigger than the selected icon).
    final double unselectedIconDiff =
        math.max(unselectedIconSize - selectedIconSize, 0);

    // The effective tool tip message to be shown on the BottomNavigationBarItem.
    final effectiveTooltip = item.tooltip == '' ? null : item.tooltip;

    double bottomPadding;
    double topPadding;
    if (showSelectedLabels && !showUnselectedLabels) {
      bottomPadding = Tween<double>(
        begin: selectedIconDiff / 2.0,
        end: selectedFontSize / 2.0 - unselectedIconDiff / 2.0,
      ).evaluate(animation);
      topPadding = Tween<double>(
        begin: selectedFontSize + selectedIconDiff / 2.0,
        end: selectedFontSize / 2.0 - unselectedIconDiff / 2.0,
      ).evaluate(animation);
    } else if (!showSelectedLabels && !showUnselectedLabels) {
      bottomPadding = Tween<double>(
        begin: selectedIconDiff / 2.0,
        end: unselectedIconDiff / 2.0,
      ).evaluate(animation);
      topPadding = Tween<double>(
        begin: selectedFontSize + selectedIconDiff / 2.0,
        end: selectedFontSize + unselectedIconDiff / 2.0,
      ).evaluate(animation);
    } else {
      bottomPadding = Tween<double>(
        begin: selectedFontSize / 2.0 + selectedIconDiff / 2.0,
        end: selectedFontSize / 2.0 + unselectedIconDiff / 2.0,
      ).evaluate(animation);
      topPadding = Tween<double>(
        begin: selectedFontSize / 2.0 + selectedIconDiff / 2.0,
        end: selectedFontSize / 2.0 + unselectedIconDiff / 2.0,
      ).evaluate(animation);
    }

    size = switch (type) {
      NavigationBarType.fixed => 1,
      NavigationBarType.shifting => (flex! * 1000.0).round(),
    };

    Widget result = InkResponse(
      onTap: onTap,
      mouseCursor: mouseCursor,
      enableFeedback: enableFeedback,
      child: Padding(
        padding: EdgeInsets.only(top: topPadding, bottom: bottomPadding),
        child: _Tile(
          layout: layout,
          icon: _TileIcon(
            colorTween: iconColorTween!,
            animation: animation,
            iconSize: iconSize,
            selected: selected,
            item: item,
            selectedIconTheme: selectedIconTheme,
            unselectedIconTheme: unselectedIconTheme,
          ),
          label: _Label(
            colorTween: labelColorTween!,
            animation: animation,
            item: item,
            selectedLabelStyle: selectedLabelStyle,
            unselectedLabelStyle: unselectedLabelStyle,
            showSelectedLabels: showSelectedLabels,
            showUnselectedLabels: showUnselectedLabels,
          ),
        ),
      ),
    );

    if (effectiveTooltip != null) {
      result = Tooltip(
        message: effectiveTooltip,
        preferBelow: false,
        verticalOffset: selectedIconSize + selectedFontSize,
        excludeFromSemantics: true,
        child: result,
      );
    }

    result = Semantics(
      selected: selected,
      container: true,
      child: Stack(
        children: <Widget>[
          result,
          Semantics(
            label: indexLabel,
          ),
        ],
      ),
    );

    return Expanded(
      flex: size,
      child: result,
    );
  }
}

// If the orientation is landscape and layout is
// NavigationBarLandscapeLayout.linear then return a
// icon-space-label row, where space is 8 pixels. Otherwise return a
// icon-label column.
class _Tile extends StatelessWidget {
  const _Tile({required this.layout, required this.icon, required this.label});

  final NavigationBarLandscapeLayout layout;
  final Widget icon;
  final Widget label;

  @override
  Widget build(BuildContext context) {
    if (MediaQuery.orientationOf(context) == Orientation.landscape &&
        layout == NavigationBarLandscapeLayout.linear) {
      return Align(
        heightFactor: 1,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            icon,
            const SizedBox(width: 8),
            // Flexible lets the overflow property of
            // label to work and IntrinsicWidth gives label a
            // reasonable width preventing extra space before it.
            Flexible(child: IntrinsicWidth(child: label)),
          ],
        ),
      );
    }
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[icon, label],
    );
  }
}

class _TileIcon extends StatelessWidget {
  const _TileIcon({
    required this.colorTween,
    required this.animation,
    required this.iconSize,
    required this.selected,
    required this.item,
    required this.selectedIconTheme,
    required this.unselectedIconTheme,
  });

  final ColorTween colorTween;
  final Animation<double> animation;
  final double iconSize;
  final bool selected;
  final NavigationBarItem item;
  final SvgTheme? selectedIconTheme;
  final SvgTheme? unselectedIconTheme;

  @override
  Widget build(BuildContext context) {
    final iconColor = colorTween.evaluate(animation);
    final svgTheme = SvgTheme(
      currentColor: iconColor!,
      xHeight: iconSize,
    );

    return Align(
      alignment: Alignment.topCenter,
      heightFactor: 1,
      child: DefaultSvgTheme(
        theme: svgTheme,
        child: selected ? item.activeIcon : item.icon,
      ),
    );
  }
}

class _Label extends StatelessWidget {
  const _Label({
    required this.colorTween,
    required this.animation,
    required this.item,
    required this.selectedLabelStyle,
    required this.unselectedLabelStyle,
    required this.showSelectedLabels,
    required this.showUnselectedLabels,
  });

  final ColorTween colorTween;
  final Animation<double> animation;
  final NavigationBarItem item;
  final TextStyle selectedLabelStyle;
  final TextStyle unselectedLabelStyle;
  final bool showSelectedLabels;
  final bool showUnselectedLabels;

  @override
  Widget build(BuildContext context) {
    final selectedFontSize = selectedLabelStyle.fontSize;
    final unselectedFontSize = unselectedLabelStyle.fontSize;

    final customStyle = TextStyle.lerp(
      unselectedLabelStyle,
      selectedLabelStyle,
      animation.value,
    )!;
    var text = DefaultTextStyle.merge(
      style: customStyle.copyWith(
        fontSize: selectedFontSize,
        color: colorTween.evaluate(animation),
      ),
      // The font size should grow here when active, but because of the way
      // font rendering works, it doesn't grow smoothly if we just animate
      // the font size, so we use a transform instead.
      child: Transform(
        transform: Matrix4.diagonal3(
          Vector3.all(
            Tween<double>(
              begin: unselectedFontSize! / selectedFontSize!,
              end: 1,
            ).evaluate(animation),
          ),
        ),
        alignment: Alignment.bottomCenter,
        child: FittedBox(child: Text(item.label!)),
      ),
    );

    if (!showUnselectedLabels && !showSelectedLabels) {
      // Never show any labels.
      text = Visibility.maintain(
        visible: false,
        child: text,
      );
    } else if (!showUnselectedLabels) {
      // Fade selected labels in.
      text = FadeTransition(
        alwaysIncludeSemantics: true,
        opacity: animation,
        child: text,
      );
    } else if (!showSelectedLabels) {
      // Fade selected labels out.
      text = FadeTransition(
        alwaysIncludeSemantics: true,
        opacity: Tween<double>(begin: 1, end: 0).animate(animation),
        child: text,
      );
    }

    text = Align(
      alignment: Alignment.bottomCenter,
      heightFactor: 1,
      child: Container(child: text),
    );

    if (item.label != null) {
      // Do not grow text in bottom navigation bar when we can show a tooltip
      // instead.
      text = MediaQuery.withClampedTextScaling(
        maxScaleFactor: 1,
        child: text,
      );
    }

    return text;
  }
}
