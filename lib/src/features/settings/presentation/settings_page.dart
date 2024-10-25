import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:local_fx/src/features/common/application/preference/preference_bloc.dart';
import 'package:local_fx/src/features/common/domain/assets.dart';
import 'package:local_fx/src/features/common/domain/enums/enums.dart';
import 'package:local_fx/src/features/common/presentation/styles.dart';
import 'package:local_fx/src/features/settings/presentation/widgets/settings_list_tile.dart';
import 'package:local_fx/src/localization/generated/l10n.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          s.settings,
          style: theme.textTheme.titleLarge?.copyWith(
            fontSize: 22,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: Styles.edgeInsetAll16,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                BlocBuilder<PreferenceBloc, PreferenceState>(
                  builder: (ctx, state) => SettingsListTile(
                    title: s.syncWithDeviceTheme,
                    icon: Assets.getSvgPath('ic_show.svg'),
                    trailing: Transform.scale(
                      scale: 0.7,
                      alignment: Alignment.centerRight,
                      child: Switch.adaptive(
                        activeColor: theme.colorScheme.onSurface,
                        value: state.themeMode.system,
                        onChanged: (v) {
                          final event = PreferenceAutoThemeModeChanged(
                            newValue: AutoThemeModeType.translate(
                              value: v,
                            ),
                          );
                          context.read<PreferenceBloc>().add(event);
                        },
                      ),
                    ),
                  ),
                ),
                BlocBuilder<PreferenceBloc, PreferenceState>(
                  builder: (ctx, state) => SettingsListTile(
                    title: s.darkMode,
                    icon: Assets.getSvgPath('ic_show.svg'),
                    trailing: Transform.scale(
                      scale: 0.7,
                      alignment: Alignment.centerRight,
                      child: Switch.adaptive(
                        activeColor: theme.colorScheme.onSurface,
                        value: state.currentTheme.darkMode,
                        onChanged: state.themeMode == AutoThemeModeType.off
                            ? (v) {
                                final event = PreferenceThemeChanged(
                                  newValue: AppThemeType.translate(value: v),
                                );
                                context.read<PreferenceBloc>().add(event);
                              }
                            : null,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
