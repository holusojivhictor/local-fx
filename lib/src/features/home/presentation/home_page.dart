import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:local_fx/src/features/common/application/app/app_bloc.dart';
import 'package:local_fx/src/features/common/presentation/bloc_presentation/bloc_presentation_listener.dart';
import 'package:local_fx/src/features/common/presentation/styles.dart';
import 'package:local_fx/src/features/home/application/home_cubit.dart';
import 'package:local_fx/src/features/home/domain/models/exchange_rates/exchange_rates.dart';
import 'package:local_fx/src/features/home/presentation/widgets/country_selection/country_selection.dart';
import 'package:local_fx/src/features/home/presentation/widgets/country_selection/country_selection_dialog.dart';
import 'package:local_fx/src/features/home/presentation/widgets/currency_pair_tile.dart';
import 'package:local_fx/src/features/home/presentation/widgets/info_dialog.dart';
import 'package:local_fx/src/features/home/presentation/widgets/pairs_skeleton.dart';
import 'package:local_fx/src/features/pair_info/domain/models/args/pair_info_page_args.dart';
import 'package:local_fx/src/localization/generated/l10n.dart';
import 'package:local_fx/src/utils/toast_utils.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return BlocPresentationListener<HomeCubit, HomeCubitEvent>(
      listener: (context, event) {
        return switch (event) {
          LocaleFetchError(:final error) => onLocaleError(error),
        };
      },
      child: Scaffold(
        body: NestedScrollView(
          physics: const ClampingScrollPhysics(),
          headerSliverBuilder: (context, innerBoxIsScrolled) => <Widget>[
            SliverAppBar(
              pinned: true,
              centerTitle: false,
              titleSpacing: 6,
              title: BlocBuilder<HomeCubit, HomeState>(
                builder: (context, state) {
                  return BlocBuilder<AppBloc, AppState>(
                    builder: (_, appState) {
                      return CountrySelection(
                        key: ValueKey(state.country.isoCode),
                        languageCode: appState.language.code,
                        initialCountryCode: state.country.isoCode,
                        dropdownDecoration: const BoxDecoration(
                          borderRadius: Styles.smallBorderRadius,
                        ),
                        onCountryChanged: (country) {
                          context.read<HomeCubit>().refreshLocalRates(
                                country: country,
                                silent: false,
                              );
                        },
                        selectionDialogStyle: SelectionDialogStyle(
                          searchFieldInputDecoration: Styles.appInputDecoration(
                            context,
                            suffix: const Icon(Icons.search),
                            hint: S.of(context).searchCountry,
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
              actions: <Widget>[
                IconButton(
                  tooltip: 'Information',
                  icon: const Icon(Icons.info_outline_rounded, size: 22),
                  onPressed: _showInfoDialog,
                ),
              ],
            ),
          ],
          body: BlocBuilder<HomeCubit, HomeState>(
            builder: (context, state) {
              return state.loadingRates
                  ? const PairsSkeleton()
                  : RefreshIndicator(
                      onRefresh: context.read<HomeCubit>().refreshLocalRates,
                      child: ListView.separated(
                        itemCount: state.currencyPairs.length,
                        padding: Styles.edgeInsetVertical16,
                        separatorBuilder: (_, index) {
                          return const SizedBox(height: 16);
                        },
                        itemBuilder: (ctx, index) {
                          return CurrencyPairTile(
                            pair: state.currencyPairs[index],
                            onPressed: onPairTapped,
                          );
                        },
                      ),
                    );
            },
          ),
        ),
      ),
    );
  }

  void onPairTapped(Pair pair) {
    final args = PairInfoPageArgs(base: pair.base, symbol: pair.quote);

    context.pushNamed('pair-info', extra: args);
  }

  void onLocaleError(String error) {
    final fToast = ToastUtils.of(context);
    ToastUtils.showInfoToast(
      fToast,
      error,
      autoCloseDuration: const Duration(seconds: 5),
    );
  }

  Future<void> _showInfoDialog() async {
    final s = S.of(context);
    final explanations = [
      s.explanationOne,
      s.explanationTwo,
      s.explanationThree,
    ];
    await showDialog<void>(
      context: context,
      builder: (context) => InfoDialog(explanations: explanations),
    );
  }
}
