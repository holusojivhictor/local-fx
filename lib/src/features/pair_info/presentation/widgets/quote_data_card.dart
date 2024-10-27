import 'package:flutter/material.dart';
import 'package:local_fx/src/extensions/extensions.dart';
import 'package:local_fx/src/extensions/num_extensions.dart';
import 'package:local_fx/src/features/common/presentation/styles.dart';
import 'package:local_fx/src/features/pair_info/domain/models/quote.dart';
import 'package:local_fx/src/localization/generated/l10n.dart';

class QuoteDataCard extends StatelessWidget {
  const QuoteDataCard({required this.quote, super.key});

  final Quote? quote;

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    final theme = Theme.of(context);

    return Padding(
      padding: Styles.edgeInsetAll16,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Flexible(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                if (quote?.name != null) ...[
                  Text(
                    s.viewingDailyChangesFor,
                    style: theme.textTheme.bodySmall,
                  ),
                  Text(
                    quote!.name,
                    style: theme.textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
                if (quote?.date != null)
                  Text(
                    quote!.date.fullUS,
                    style: theme.textTheme.bodySmall,
                  ),
                if (quote?.change != null)
                  Text.rich(
                    TextSpan(
                      children: <TextSpan>[
                        TextSpan(
                          text: double.parse(quote!.change).isNegative
                              ? '-'
                              : '+',
                        ),
                        TextSpan(
                          text: double.parse(quote!.change)
                              .toStringWoutPadding(4),
                        ),
                        const TextSpan(text: '%'),
                      ],
                    ),
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: double.parse(quote!.change).isNegative
                          ? const Color.fromRGBO(208, 79, 91, 1)
                          : const Color.fromRGBO(94, 186, 137, 1),
                    ),
                  ),
              ].separatedBy(const SizedBox(height: 1)),
            ),
          ),
          const SizedBox(width: 6),
          Row(
            children: <Widget>[
              Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  _InfoTile(
                    title: s.dailyHigh,
                    subtitle: quote?.high,
                  ),
                  const SizedBox(height: 6),
                  _InfoTile(
                    title: s.dailyLow,
                    subtitle: quote?.low,
                  ),
                ],
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  _InfoTile(
                    title: s.open,
                    subtitle: quote?.open,
                  ),
                  const SizedBox(height: 6),
                  _InfoTile(
                    title: s.close,
                    subtitle: quote?.close,
                  ),
                ],
              ),
            ].separatedBy(const SizedBox(width: 16)),
          ),
        ],
      ),
    );
  }
}

class _InfoTile extends StatelessWidget {
  const _InfoTile({required this.title, required this.subtitle});

  final String title;
  final String? subtitle;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Flexible(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text.rich(
            TextSpan(text: title),
            style: theme.textTheme.bodySmall?.copyWith(
              fontSize: 11,
              fontWeight: FontWeight.w500,
              color: theme.colorScheme.outline,
            ),
          ),
          if (subtitle != null)
            Text(
              double.parse(subtitle!).toStringAsFixed(4),
              style: theme.textTheme.bodyMedium?.copyWith(fontSize: 13),
            ),
        ],
      ),
    );
  }
}
