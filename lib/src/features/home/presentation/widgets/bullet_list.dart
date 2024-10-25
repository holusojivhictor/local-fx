import 'package:flutter/material.dart';
import 'package:local_fx/src/extensions/iterable_extensions.dart';

class BulletList extends StatelessWidget {
  const BulletList({
    required this.items,
    super.key,
    this.icon = const Icon(Icons.fiber_manual_record, size: 15),
    this.iconResolver,
  });

  final List<String> items;
  final Widget icon;
  final Widget Function(int)? iconResolver;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: items.mapIndex((e, index) {
        var leading = icon;
        if (iconResolver != null) {
          leading = iconResolver!(index);
        }

        return ListTile(
          dense: true,
          contentPadding: const EdgeInsets.only(left: 10),
          visualDensity: const VisualDensity(vertical: -4),
          leading: leading,
          title: Transform.translate(
            offset: const Offset(-15, 0),
            child: Tooltip(
              message: e,
              child: Text(
                e,
                style: theme.textTheme.bodyMedium?.copyWith(fontSize: 13),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}
