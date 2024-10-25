import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:local_fx/src/features/common/application/app/app_bloc.dart';
import 'package:local_fx/src/features/common/presentation/styles.dart';
import 'package:local_fx/src/features/home/application/home_cubit.dart';
import 'package:local_fx/src/features/home/presentation/widgets/country_selection/country_selection.dart';
import 'package:local_fx/src/features/home/presentation/widgets/country_selection/country_selection_dialog.dart';
import 'package:local_fx/src/localization/generated/l10n.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        physics: const ClampingScrollPhysics(),
        headerSliverBuilder: (context, innerBoxIsScrolled) => <Widget>[
          SliverAppBar(
            pinned: true,
            leadingWidth: 100,
            backgroundColor: Colors.transparent,
            leading: BlocBuilder<HomeCubit, HomeState>(
              builder: (context, state) {
                return BlocBuilder<AppBloc, AppState>(
                  builder: (_, appState) {
                    return CountrySelection(
                      key: ValueKey(state.country?.isoCode),
                      languageCode: appState.language.code,
                      initialCountryCode: state.country?.isoCode,
                      dropdownDecoration: const BoxDecoration(
                        borderRadius: Styles.smallBorderRadius,
                      ),
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
          ),
        ],
        body: Container(),
      ),
    );
  }
}
