import 'package:flutter/material.dart';
import 'package:local_fx/src/extensions/iterable_extensions.dart';
import 'package:local_fx/src/features/common/presentation/styles.dart';
import 'package:local_fx/src/features/home/domain/models/exchange_rates/exchange_rates.dart';
import 'package:local_fx/src/features/home/presentation/widgets/currency_pair_tile.dart';
import 'package:skeletonizer/skeletonizer.dart';

class PairsSkeleton extends StatelessWidget {
  const PairsSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    final fakes = List.generate(8, (index) {
      return Pair.fake();
    });

    return Skeletonizer(
      child: Padding(
        padding: Styles.edgeInsetVertical16,
        child: Column(
          children: [
            ...fakes.map((e) {
              return CurrencyPairTile(pair: e);
            }),
          ].separatedBy(const SizedBox(height: 16)),
        ),
      ),
    );
  }
}
