import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
    refreshQuoteFomSymbol();
  }

  Future<void> refreshQuoteFomSymbol() async {
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
}
