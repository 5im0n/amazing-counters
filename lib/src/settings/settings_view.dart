import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'settings_controller.dart';

/// Displays the various settings that can be customized by the user.
///
/// When a user changes a setting, the SettingsController is updated and
/// Widgets that listen to the SettingsController are rebuilt.
class SettingsView extends StatelessWidget {
  const SettingsView({super.key, required this.controller});

  static const routeName = '/settings';

  final SettingsController controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(AppLocalizations.of(context)!.settingsTitle),
        ),
        body: ListView(
          children: [
            ListTile(
              leading: const Icon(Icons.sunny),
              title: const Text('Theme'),
              trailing: DropdownButtonHideUnderline(
                child: DropdownButton<ThemeMode>(
                  // Read the selected themeMode from the controller
                  value: controller.themeMode,
                  // Call the updateThemeMode method any time the user selects a theme.
                  onChanged: controller.updateThemeMode,
                  items: [
                    DropdownMenuItem(
                      value: ThemeMode.system,
                      child: Row(
                        children: const [
                          Icon(Icons.phone_android, size: 18),
                          SizedBox(width: 5),
                          Text('System Theme'),
                        ],
                      ),
                    ),
                    DropdownMenuItem(
                      value: ThemeMode.light,
                      child: Row(
                        children: const [
                          Icon(Icons.sunny, size: 18),
                          SizedBox(width: 5),
                          Text('Light Theme'),
                        ],
                      ),
                    ),
                    DropdownMenuItem(
                      value: ThemeMode.dark,
                      child: Row(
                        children: const [
                          Icon(Icons.brightness_2, size: 18),
                          SizedBox(width: 5),
                          Text('Dark Theme'),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ));
  }
}
