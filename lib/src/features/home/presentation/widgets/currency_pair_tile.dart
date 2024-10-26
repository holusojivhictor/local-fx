import 'package:flutter/material.dart';
import 'package:local_fx/src/extensions/date_time_extensions.dart';
import 'package:local_fx/src/extensions/num_extensions.dart';
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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    pair.pair,
                    style: theme.textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    '${pair.date.prettyUTC} UTC',
                    style: theme.textTheme.bodySmall?.copyWith(
                      fontSize: 11,
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 16),
              Flexible(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Flexible(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          Text(
                            '${pair.rate}',
                            style: theme.textTheme.bodyLarge?.copyWith(
                              fontWeight: FontWeight.w500,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text.rich(
                            TextSpan(
                              children: <TextSpan>[
                                TextSpan(
                                  text: pair.absolute.isNegative ? '-' : '+',
                                ),
                                TextSpan(
                                  text: pair.absolute.toStringWoutPadding(8),
                                ),
                              ],
                            ),
                            style: theme.textTheme.bodySmall,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 24),
                    ChangeTag(change: pair.change),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
