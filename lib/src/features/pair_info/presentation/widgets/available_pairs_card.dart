import 'package:flutter/material.dart';
import 'package:local_fx/src/features/common/presentation/styles.dart';
import 'package:local_fx/src/features/pair_info/domain/models/symbol_pair.dart';
import 'package:local_fx/src/localization/generated/l10n.dart';

class AvailablePairsCard extends StatelessWidget {
  const AvailablePairsCard({
    required this.symbol,
    required this.currency,
    required this.availablePairs,
    super.key,
  });

  final String symbol;
  final String currency;
  final List<SymbolPair> availablePairs;

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    final theme = Theme.of(context);

    return Padding(
      padding: Styles.edgeInsetAll16,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text.rich(
            TextSpan(
              children: <TextSpan>[
                TextSpan(text: s.failedQuoteAndPriceFetch),
                TextSpan(text: ' ${s.forString.toLowerCase()} '),
                TextSpan(
                  text: '$symbol.',
                  style: const TextStyle(fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ),
          Text(s.weProvideTrendDataForPairs),
          Text.rich(
            TextSpan(
              children: <TextSpan>[
                TextSpan(text: s.availableCurrencyPairs),
                TextSpan(text: ' ${s.forString.toLowerCase()} '),
                TextSpan(
                  text: '$currency ',
                  style: const TextStyle(fontWeight: FontWeight.w500),
                ),
                TextSpan(text: '${s.areListedBelow}:'),
              ],
            ),
          ),
          const SizedBox(height: 16),
          const Divider(),
          if (availablePairs.isNotEmpty)
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: availablePairs.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
                childAspectRatio: 2.5,
              ),
              itemBuilder: (context, index) {
                return Text(
                  availablePairs[index].symbol,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
                );
              },
            )
          else
            Text(
              s.noPairFound,
              style: theme.textTheme.bodyLarge,
            ),
        ],
      ),
    );
  }
}
