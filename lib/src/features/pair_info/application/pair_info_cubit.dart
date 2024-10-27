import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:local_fx/src/features/pair_info/domain/enums/interval.dart';
import 'package:local_fx/src/features/pair_info/domain/models/models.dart';
import 'package:local_fx/src/features/pair_info/infrastructure/twelve_data_service.dart';

part 'pair_info_state.dart';

class PairInfoCubit extends Cubit<PairInfoState> {
  PairInfoCubit(
    this._twelveDataService, {
    required String base,
    required String symbol,
  }) : super(PairInfoState.init(base: base, symbol: symbol));

  final TwelveDataService _twelveDataService;

  void init() {
    fetchQuoteForSymbol();
    fetchTimeSeriesDataForSymbol();
  }

  Future<void> fetchQuoteForSymbol() async {
    emit(state.copyWith(loadingQuote: true));

    try {
      final quote = await _twelveDataService.getQuoteFromSymbol(
        symbol: state.pair,
      );

      emit(state.copyWith(quote: quote, loadingQuote: false));
    } catch (_) {
      emit(state.copyWith(loadingQuote: false));
    }
  }

  Future<void> fetchTimeSeriesDataForSymbol() async {
    emit(state.copyWith(loadingTimeSeries: true));

    try {
      final candlesticks = await _twelveDataService.getTimeSeriesData(
        symbol: state.pair,
        interval: PointInterval.oneDay,
        outputSize: '200',
      );

      emit(
        state.copyWith(
          candlesticks: candlesticks,
          loadingTimeSeries: false,
        ),
      );
    } catch (_) {
      emit(state.copyWith(loadingTimeSeries: false));
    }
  }
}
