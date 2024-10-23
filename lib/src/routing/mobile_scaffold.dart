import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:local_fx/src/features/common/domain/assets.dart';
import 'package:local_fx/src/features/common/presentation/assets/svg_asset.dart';
import 'package:local_fx/src/features/common/presentation/colors.dart';
import 'package:local_fx/src/features/common/presentation/extensions/context_extensions.dart';
import 'package:local_fx/src/features/common/presentation/navigation_bar/navigation_bar.dart';
import 'package:local_fx/src/localization/generated/l10n.dart';

class MobileScaffold extends StatelessWidget {
  const MobileScaffold({required this.navigationShell, super.key});

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    final style = context.textTheme.bodySmall?.copyWith(
      fontWeight: FontWeight.w500,
    );

    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: AnimatedNavigationBar(
        selectedFontSize: 12,
        type: NavigationBarType.fixed,
        currentIndex: navigationShell.currentIndex,
        selectedItemColor: AppColors.tertiary,
        unselectedItemColor: AppColors.secondary,
        selectedLabelStyle: style,
        unselectedLabelStyle: style,
        backgroundColor: AppColors.white,
        shape: const Border(
          top: BorderSide(color: AppColors.secondary, width: 0.3),
        ),
        onItemSelected: _goBranch,
        items: [
          NavigationBarItem(
            icon: const _SvgAsset(path: 'ic_home_outline.svg'),
            activeIcon: const _SvgAsset(path: 'ic_home_fill.svg'),
            label: s.home,
          ),
          NavigationBarItem(
            icon: const _SvgAsset(path: 'ic_settings_outline.svg'),
            activeIcon: const _SvgAsset(path: 'ic_settings_fill.svg'),
            label: s.settings,
          ),
        ],
      ),
    );
  }

  void _goBranch(int index) {
    navigationShell.goBranch(
      index,
      initialLocation: index == navigationShell.currentIndex,
    );
  }
}

class _SvgAsset extends StatelessWidget {
  const _SvgAsset({required this.path});

  final String path;

  @override
  Widget build(BuildContext context) {
    return SvgAsset(
      Assets.getSvgPath(path),
      height: DefaultSvgTheme.of(context)?.theme.xHeight,
      color: DefaultSvgTheme.of(context)?.theme.currentColor,
    );
  }
}
