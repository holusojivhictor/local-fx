import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:local_fx/src/features/pair_info/application/pair_info_cubit.dart';
import 'package:local_fx/src/features/pair_info/domain/models/quote.dart';
import 'package:local_fx/src/features/pair_info/presentation/widgets/available_pairs_card.dart';
import 'package:local_fx/src/features/pair_info/presentation/widgets/price_chart.dart';
import 'package:local_fx/src/features/pair_info/presentation/widgets/quote_data_card.dart';
import 'package:skeletonizer/skeletonizer.dart';

class PairInfoPage extends StatelessWidget {
  const PairInfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        titleSpacing: 0,
        title: BlocBuilder<PairInfoCubit, PairInfoState>(
          builder: (context, state) {
            return Text(
              state.pair,
              style: theme.textTheme.titleMedium?.copyWith(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            );
          },
        ),
      ),
      body: BlocBuilder<PairInfoCubit, PairInfoState>(
        builder: (context, state) {
          return ListView(
            children: <Widget>[
              const SizedBox(height: 8),
              if (state.failedDataFetch)
                AvailablePairsCard(
                  symbol: state.pair,
                  currency: state.base,
                  availablePairs: state.availablePairs,
                )
              else ...[
                if (state.loadingTimeSeries)
                  const SizedBox(
                    height: 500,
                    child: Center(child: CircularProgressIndicator.adaptive()),
                  )
                else if (state.candlesticks.isNotEmpty)
                  PriceChart(candlesticks: state.candlesticks),
                const SizedBox(height: 16),
                if (state.loadingQuote)
                  const Skeletonizer(
                    child: QuoteDataCard(
                      quote: Quote.fake(),
                    ),
                  )
                else
                  QuoteDataCard(quote: state.quote),
              ],
            ],
          );
        },
      ),
    );
  }
}
