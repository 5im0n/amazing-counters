import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../settings/settings_view.dart';
import 'count_down_timer.dart';

/// Displays a list of SampleItems.
class HomeView extends StatelessWidget {
  const HomeView({
    super.key,
  });

  static const routeName = '/';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.appTitle),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              // Navigate to the settings page. If the user leaves and returns
              // to the app after it has been killed while running in the
              // background, the navigation stack is restored.
              Navigator.restorablePushNamed(context, SettingsView.routeName);
            },
          ),
        ],
      ),
      body: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
        CountdownTimer(time: 100, title: AppLocalizations.of(context)!.countDown),
        const CountdownTimer(time: 30, autoStart: true),
        const CountdownTimer.amazing(time: 10),
      ])),
    );
  }
}
