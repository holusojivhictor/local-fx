import 'package:flutter/material.dart';
import 'package:local_fx/src/features/common/domain/assets.dart';
import 'package:local_fx/src/features/common/presentation/assets/svg_asset.dart';
import 'package:local_fx/src/features/common/presentation/extensions/context_extensions.dart';

class SettingsListTile extends StatelessWidget {
  const SettingsListTile({
    required this.title,
    this.hasTrailing = true,
    super.key,
    this.icon,
    this.onTap,
    this.tileColor,
    this.iconColor,
    this.trailing,
    this.contentPadding,
  });

  final String title;
  final String? icon;
  final Color? tileColor;
  final Color? iconColor;
  final Widget? trailing;
  final EdgeInsetsGeometry? contentPadding;
  final void Function()? onTap;
  final bool hasTrailing;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      dense: true,
      contentPadding: contentPadding ?? EdgeInsets.zero,
      leading: icon != null
          ? SvgAsset(
              icon!,
              color: iconColor ?? context.colorScheme.onSurface,
              height: 24,
            )
          : null,
      tileColor: tileColor,
      title: Text(
        title,
        style: context.textTheme.bodyLarge?.copyWith(
          color: iconColor,
          fontWeight: FontWeight.w500,
        ),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4),
      ),
      trailing: trailing ??
          (hasTrailing
              ? SvgAsset(
                  Assets.getSvgPath('ic_arrow_right.svg'),
                  color: context.colorScheme.onSurface,
                )
              : null),
      onTap: onTap,
    );
  }
}
