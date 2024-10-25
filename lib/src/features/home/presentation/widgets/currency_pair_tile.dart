import 'package:flutter/material.dart';
import 'package:local_fx/src/features/home/domain/models/exchange_rates/exchange_rates.dart';
import 'package:local_fx/src/features/home/presentation/widgets/change_tag.dart';

class CurrencyPairTile extends StatelessWidget {
  const CurrencyPairTile({
    required this.pair,
    super.key,
    this.onPressed,
  });

  final Pair pair;
  final void Function(Pair pair)? onPressed;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Material(
      type: MaterialType.transparency,
      child: InkWell(
        onTap: () => onPressed?.call(pair),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 10,
            horizontal: 16,
          ),
          child: Row(
            children: <Widget>[
              Text(
                pair.pair,
                style: theme.textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              const Spacer(),
              Text(
                '${pair.rate}',
                style: theme.textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(width: 24),
              ChangeTag(change: pair.change),
            ],
          ),
        ),
      ),
    );
  }
}
